local QBCore = exports['qb-core']:GetCoreObject()
local Contracts = {}
local ActivePlates = {} -- Just using this for a quick check to see if a plate is already active on the client side to prevent server spam.
local PZone = nil
local NetID = nil
local missionBlip = nil
local inZone = false
local canHack = true


RegisterCommand('boost', function()

    TriggerServerEvent('ps-laptop:server:StartBoosting', 1)

end, false)

RegisterCommand('queue', function()

    TriggerServerEvent('ps-laptop:server:JoinQueue')

end, false)


---- ** Local functions ** ----

local function HackDelay(seconds)
    canHack = false
    Wait(seconds)
    canHack = true
end

local function AlertPoPo(coords)


end

local function UpdateBlips()
    local car = NetworkGetEntityFromNetworkId(NetID)
    local Plate = GetVehicleNumberPlateText(car)
    if ActivePlates[Plate] then
        CreateThread(function()
            while ActivePlates[Plate] > 0 do
                if DoesEntityExist(car) then
                    Wait(10000 / ActivePlates[Plate]) -- Max 10 seconds, the more times hacked the less time it updates
                    local pos = GetEntityCoords(car)

                    TriggerServerEvent('ps-laptop:server:SyncBlips', pos, Plate)
                else
                    Wait(25)

                    -- return and cancel job as they failed and pd got them
                end
            end

            TriggerServerEvent('ps-laptop:server:SyncBlips', nil, Plate)
            TriggerServerEvent('ps-laptop:server:FinalDestination')
            QBCore.Functions.Notify('Successfully removed tracker', 'success', 7500)
        end)
    end
end

---- ** Register Net Events ** ----

-- Sends information from server to client that it will start now
RegisterNetEvent('ps-laptop:client:MissionStarted', function(netID, coords) -- Pretty much just resets every boolean to make sure no issues will occour.
    NetID = netID
    AntiSpam = false
    canHack = true
    inZone = false

    if PZone then PZone:destroy() PZone = nil end

    if missionBlip then RemoveBlip(missionBlip) end

    if coords then
        missionBlip = AddBlipForRadius(coords.x, coords.y, coords.z, 35.0)
        SetBlipHighDetail(missionBlip, true)
        SetBlipColour(missionBlip, 1)
        SetBlipAsShortRange(missionBlip, true)
    end
end)

-- sends information from server to client that we found the car and we started lockpicking
local AntiSpam = false -- Just a true / false boolean to not spam the shit out of the server.
RegisterNetEvent('lockpicks:UseLockpick', function()
    if AntiSpam then return end
    if NetID and DoesEntityExist(NetworkGetEntityFromNetworkId(NetID)) then
        local carSpawned = NetworkGetEntityFromNetworkId(NetID)
        local dist = #(GetEntityCoords(carSpawned) - GetEntityCoords(PlayerPedId()))
        if dist <= 2.5 then -- 2.5 is the distance in qbcore vehiclekeys if you use more or less then please edit this.
            TriggerServerEvent('ps-laptop:server:SpawnPed')
            AntiSpam = true
            RemoveBlip(missionBlip)
            AlertPoPo(GetEntityCoords(carSpawned))
            UpdateBlips()
        end
    end
end)

-- Creates the PolyZone for when you return the car.
RegisterNetEvent('ps-laptop:client:ReturnCar', function(coords)
    PZone = CircleZone:Create(coords, 5, {
        name = "NewChopShopWhoDis",
        debugPoly = true,
    })

    PZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inZone = true
        else
            inZone = false
        end
    end)
end)

-- The event where you can start to hack the vehicle
RegisterNetEvent('ps-laptop:client:HackCar', function()
    local ped = PlayerPedId()
    --if haveItem(Config.Boosting.HackingDevice) then
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        local plate = GetVehicleNumberPlateText(vehicle)
        print(ActivePlates[plate])
        if ActivePlates[plate] and ActivePlates[plate] > 0 and canHack then
            local success = exports['boostinghack']:StartHack()
            if success then
                TriggerServerEvent('ps-laptop:server:SyncPlates', true)
            else
                QBCore.Functions.Notify('You failed nuub :)', 'error', 7500)
            end
        end
    end
    --end
end)

-- Gets the ped from the server side and then gives them tasks and weapons on the client side.
RegisterNetEvent('ps-laptop:client:SpawnPeds', function(netIds, Location)
    for i = 1, #netIds do
        local APed = NetworkGetEntityFromNetworkId(netIds[i])
        SetPedDropsWeaponsWhenDead(APed, false)
        GiveWeaponToPed(APed, joaat(Location.peds[i].weapon), 250, false, true)
        SetPedMaxHealth(APed, 500)
        SetPedArmour(APed, 200)
        SetCanAttackFriendly(APed, false, true)
        TaskCombatPed(APed, PlayerPedId(), 0, 16)
        SetPedCombatAttributes(APed, 46, true)
        SetPedCombatAttributes(APed, 0, false)
        SetPedCombatAbility(APed, 100)
        SetPedAsCop(APed, true)
        SetPedRelationshipGroupHash(APed, joaat("HATES_PLAYER"))
        SetPedAccuracy(APed, 60)
        SetPedFleeAttributes(APed, 0, 0)
        SetPedKeepTask(APed, true)
        TaskGoStraightToCoord(APed, Location.carCoords.x, Location.carCoords.y, Location.carCoords.z, 1, -1, 0.0, 0.0)
    end
end)


-- Sennds a event from target to client to say now the vehicle has been delivered.
RegisterNetEvent('ps-laptop:client:DeliverVehicle', function()
    local car = NetworkGetEntityFromNetworkId(NetID)
    FreezeEntityPosition(car, true)
    PZone:destroy()
    PZone = nil
    Wait(5000)
    QBCore.Functions.DeleteVehicle(car)
end)

exports['qb-target']:AddGlobalVehicle({
    options = {
        {
            type = "client",
            event = "ps-laptop:client:DeliverVehicle",
            icon = 'fas fa-example',
            label = 'Turn in Vehicle',
            canInteract = function(entity)
                if inZone and entity == NetworkGetEntityFromNetworkId(NetID) then return true end
            end,
        }
    },
    distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
})


---- ALL THE SYNCS ----
-- This sync just makes it so anyone can hack a vehicle, that is hackable from boosting
RegisterNetEvent('ps-laptop:client:SyncPlates', function(data)
    ActivePlates = data
end)

-- Sends the information to client when their contracts update
RegisterNetEvent('ps-laptop:client:recieveContract', function(table, recieved)
    if recieved then
        QBCore.Functions.Notify('You recieved a new contract!', 'success', 7500)
    else
        QBCore.Functions.Notify('Contract started!', 'success', 7500)
    end

    Contracts = table
    print(json.encode(Contracts))
    SendNUIMessage({
        type = 'receivecontracts',
        contracts = table
    })
end)

local blips = {} -- Stores all the blips in a table so that PD can see multiple blips at the same time

-- The event that does everything for the blips, checks if the client is police then checks if the blip is active and if it is then remove it and spawn a new
RegisterNetEvent('ps-laptop:client:SyncBlips', function(coords, plate)
    if not isPolice() then return end
    if blips[plate] then RemoveBlip(blips[plate]) end
    if coords then
        blips[plate] = AddBlipForRadius(coords.x, coords.y, coords.z, 35.0)
        SetBlipHighDetail(blips[plate], true)
        SetBlipColour(blips[plate], 1)
        SetBlipAsShortRange(blips[plate], true)
    end
end)


---- ** NUI CALLBACKS ** ----
RegisterNUICallback('boosting/queue', function(cb)
    TriggerServerEvent('ps-laptop:server:JoinQueue', cb.status)
end)

RegisterNUICallback('boosting/start', function(data, cb)
    print(data.id)
    TriggerServerEvent('ps-laptop:server:StartBoosting', data.id)
    cb("ok")
end)
