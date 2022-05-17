local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local Contracts = {}
local ActivePlates = {} -- Just using this for a quick check to see if a plate is already active on the client side to prevent server spam.
local canHack = true
local PZone = nil
local AntiSpam = false
local NetID = nil
local inZone = false


local function isPolice()
    local job = PlayerData.job.name
    for i = 1, #Config.PoliceJobs do
        if job == Config.PoliceJobs[i] then
            return true
        end
    end
end

RegisterCommand('boost', function()

TriggerServerEvent('tnj-laptop:server:StartBoosting', 1)

end, false)

RegisterCommand('queue', function()
    
    TriggerServerEvent('tnj-laptop:server:JoinQueue')
    
end, false)

RegisterNetEvent('tnj-laptop:client:MissionStarted', function(netID) -- Pretty much just resets every boolean to make sure no issues will occour.
    NetID = netID
    AntiSpam = false
    canHack = true
    PZone = nil
    inZone = false
end)

RegisterNetEvent('tnj-laptop:client:ReturnCar', function(coords)
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

                    TriggerServerEvent('tnj-laptop:server:SyncBlips', pos, Plate)
                else
                    Wait(25)

                    -- return and cancel job as they failed and pd got them
                end
            end
            TriggerServerEvent('tnj-laptop:server:SyncBlips', nil, Plate)
            TriggerServerEvent('tnj-laptop:server:FinalDestination')
            QBCore.Functions.Notify('Successfully removed tracker', 'success', 7500)
        end)
    end
end

RegisterNetEvent('lockpicks:UseLockpick', function()
    if NetID and DoesEntityExist(NetworkGetEntityFromNetworkId(NetID)) and not AntiSpam then
        local carSpawned = NetworkGetEntityFromNetworkId(NetID)
        local dist = #(GetEntityCoords(carSpawned) - GetEntityCoords(PlayerPedId()))
        if dist <= 3 then
            TriggerServerEvent('tnj-laptop:server:SpawnPed')
            AntiSpam = true
            AlertPoPo(GetEntityCoords(carSpawned))
            UpdateBlips()
        end
    end
end)

RegisterNetEvent('tnj-laptop:client:HackCar', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        local plate = GetVehicleNumberPlateText(vehicle)
        print(ActivePlates[plate])
        if ActivePlates[plate] and ActivePlates[plate] > 0 and canHack then
            local success = exports['boostinghack']:StartHack()
            if success then
                TriggerServerEvent('tnj-laptop:server:SyncPlates', true)
            else
                QBCore.Functions.Notify('You failed nuub :)', 'error', 7500)
            end
        end
    end
end)

RegisterNetEvent('tnj-laptop:client:SpawnPeds', function(netIds, Location)
    print(json.encode(netIds))
    for i = 1, #netIds do
        print(netIds[i])
        print(Location.carCoords.x, Location.carCoords.y, Location.carCoords.z)
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


---- ALL THE SYNCS ----

RegisterNetEvent('tnj-laptop:client:SyncPlates', function(data)
    ActivePlates = data
end)

RegisterNetEvent('tnj-laptop:client:recieveContract', function(table)
    QBCore.Functions.Notify('You recieved a new contract!', 'success', 7500)
    Contracts = table

    print(json.encode(Contracts))

end)

--RegisterNetEvent()

local blips = {}
RegisterNetEvent('tnj-laptop:client:SyncBlips', function(coords, plate)
    if blips[plate] then
        RemoveBlip(blips[plate])
    end
    if coords then
        blips[plate] = AddBlipForRadius(coords.x, coords.y, coords.z, 35.0)
        SetBlipHighDetail(blips[plate], true)
        SetBlipColour(blips[plate], 1)
        SetBlipAsShortRange(blips[plate], true)
    end
end)

RegisterNetEvent('tnj-laptop:client:DeliverVehicle', function()
    local car = NetworkGetEntityFromNetworkId(NetID)
    FreezeEntityPosition(car, true)
    PZone:destroy()
    Wait(5000)
    QBCore.Functions.DeleteVehicle(car)
end)

CreateThread(function()
    exports['qb-target']:AddGlobalVehicle({
    options = {
        {
        type = "client",
        event = "tnj-laptop:client:DeliverVehicle",
        icon = 'fas fa-example',
        label = 'Turn in Vehicle',
        canInteract = function(entity, distance, data)
            if inZone and entity == NetworkGetEntityFromNetworkId(NetID) then return true end
        end,
        }
    },
    distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
    })
end)




----- ** all the playerdata shit ** -----


-- Sets the playerdata when spawned
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

-- Sets the playerdata to an empty table when the player has quit or did /logout
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

-- When the players job gets updated this will trigger and update the playerdata
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)