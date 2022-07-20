local QBCore = exports['qb-core']:GetCoreObject()
local Contracts = {}
local ActivePlates = {} -- Just using this for a quick check to see if a plate is already active on the client side to prevent server spam.
local PZone = nil
local PZone2 = nil
local NetID = nil
local missionBlip = nil
local inZone = false
local dropoffBlip = nil

local inQueue = false

local currentCops = 0

-- ALL THE BLIP FUNCTIONS --
local function DelayDelivery()
    SetTimeout(math.random(10, 30 * 1000), function()
        TriggerServerEvent('jl-laptop:server:FinalDestination')
    end)
end

local function UpdateBlips()
    local car = NetworkGetEntityFromNetworkId(NetID)
    local Plate = GetVehicleNumberPlateText(car)

    if ActivePlates[Plate] then
        CreateThread(function()
            while ActivePlates[Plate] > 0 do
                local checks = 0
                if DoesEntityExist(car) then
                    Wait(10000 / ActivePlates[Plate]) -- Max 10 seconds, the more times hacked the less time it updates
                    local pos = GetEntityCoords(car)
                    TriggerServerEvent('jl-laptop:server:SyncBlips', pos, Plate)
                else
                    Wait(2500)
                    checks = checks + 1
                    if checks >= 3 and not DoesEntityExist(car) then
                        TriggerServerEvent('jl-laptop:server:CancelBoost', NetID, Plate)
                    end -- additional safety check JUST incase, make a cancel events cancelling everything
                end
            end

            TriggerServerEvent('jl-laptop:server:SyncBlips', nil, Plate)
            QBCore.Functions.Notify('Successfully removed tracker', 'success', 7500)
            DelayDelivery()
        end)
    end
end

local AntiSpam = false -- Just a true / false boolean to not spam the shit out of the server.
local carCoords = nil
-- sends information from server to client that we found the car and we started lockpicking
RegisterNetEvent('lockpicks:UseLockpick', function()
    if AntiSpam then return end
    if NetID and DoesEntityExist(NetworkGetEntityFromNetworkId(NetID)) then
        local carSpawned = NetworkGetEntityFromNetworkId(NetID)
        local dist = #(GetEntityCoords(carSpawned) - GetEntityCoords(PlayerPedId()))
        if dist <= 3.5 then -- 2.5 is the distance in qbcore vehiclekeys if you use more or less then please edit this.
            if #(vector3(carCoords.x, carCoords.y, carCoords.z) - GetEntityCoords(carSpawned)) <= 6.9 then
                AntiSpam = true
                TriggerServerEvent('jl-laptop:server:SpawnPed')
                RemoveBlip(missionBlip)
                UpdateBlips()
                exports['qb-dispatch']:VehicleBoost()
            else
                TriggerServerEvent('jl-laptop:server:CancelBoost', NetID, Plate)
            end
        end
    end
end)



-- MISSION STARTER --

-- Sends information from server to client that it will start now
RegisterNetEvent('jl-laptop:client:MissionStarted', function(netID, coords) -- Pretty much just resets every boolean to make sure no issues will occour.
    NetID = netID
    carCoords = coords
    AntiSpam = false
    inZone = false

    print(coords)

    if PZone then PZone:destroy() PZone = nil end

    if missionBlip then RemoveBlip(missionBlip) end

    if coords then
        missionBlip = AddBlipForRadius(coords.x, coords.y, coords.z, 150.0)
        SetBlipAlpha(missionBlip, 150)
        SetBlipHighDetail(missionBlip, true)
        SetBlipColour(missionBlip, 1)
        SetBlipAsShortRange(missionBlip, true)
    end
end)

RegisterNUICallback('boosting/start', function(data, cb)
    QBCore.Functions.TriggerCallback('lj-laptop:server:CanStartBoosting', function(result)
        if result == "success" then
            TriggerServerEvent('jl-laptop:server:StartBoosting', data.id, currentCops)
            cb({
                status = 'success',
                message = "You started a boost!"
            })
        elseif result == "cops" then
            cb({
                status = 'error',
                message = "Not enough cops on Duty!"
            })
        elseif result == "running" then
            cb({
                status = 'error',
                message = "You already have a contract running!"
            })
        elseif result == "notfound" then
            cb({
                status = 'error',
                message = "Contract not found!"
            })
        elseif result == "notenough" then
            cb({
                status = 'error',
                message = "Not enough GNE to start the contract!"
            })
        end
    end, currentCops, data.id)
end)








-- DELIVERING VEHICLE --
local function DeliverCar()
    QBCore.Functions.Notify('Get away before anyone sees you!', 'error', 7500)
    local car = NetworkGetEntityFromNetworkId(NetID)
    FreezeEntityPosition(car, true)
    if PZone then
        PZone:destroy()
        PZone = nil
    end

    Wait(5000)
    QBCore.Functions.Notify('You will be paid when I sucessfully retracted the vehicle', 'success', 7500)
    while #QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(car), 100.0) > 0 do
        Wait(7500)
    end
    TriggerServerEvent('jl-laptop:server:finishBoost', NetID)
    RemoveBlip(dropoffBlip)
end


local function VehicleCheck()
    CreateThread(function()
        local inCar = false
        while inZone do
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                inCar = true
            end

            if inCar and not IsPedInAnyVehicle(ped, false) then
                local veh = GetVehiclePedIsIn(ped, true)
                if veh == NetworkGetEntityFromNetworkId(NetID) then
                    if not GetIsVehicleEngineRunning(veh) then
                        inZone = false
                        DeliverCar()
                    end
                end
            end
            Wait(100)
        end
    end)
end


RegisterNetEvent('jl-laptop:client:ReturnCar', function(coords)
    PZone = CircleZone:Create(coords, 5, {
        name = "NewReturnWhoDis",
        debugPoly = true,
    })

    local info = {
        ['blip'] = {
            ['Text'] = 'Boost Drop-off',
            ['Coords'] = coords
        },
        Notification = 'GPS updated with the drop-off location. Bring the car there.'
    }

    PZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inZone = true
            VehicleCheck()
        else
            inZone = false
        end
    end)
    QBCore.Functions.Notify(info.Notification)

    dropoffBlip = AddBlipForCoord(info['blip'].Coords.x, info['blip'].Coords.y, info['blip'].Coords.z)
    SetBlipSprite(dropoffBlip, 326)
    SetBlipScale(dropoffBlip, 1.0)
    SetBlipColour(dropoffBlip, 40)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info['blip'].Text)
    EndTextCommandSetBlipName(dropoffBlip)
    SetBlipFlashTimer(dropoffBlip, 5000)
end)

-- Just a netevent that retracts all the booleans and properly resets the client --
RegisterNetEvent('jl-laptop:client:finishContract', function()
    if PZone then PZone:destroy() PZone = nil end
    if PZone2 then PZone2:destroy() PZone2 = nil end
    NetID = nil
    if missionBlip then RemoveBlip(missionBlip) missionBlip = nil end
    if dropoffBlip then RemoveBlip(dropoffBlip) dropoffBlip = nil end
    inZone = false
    SendNUIMessage({ action = 'booting/delivered' })
end)





-- ** HACKING THE VEHICLE ** --
local psUI = {
    "numeric",
    "alphabet",
    "alphanumeric",
    "greek",
    "braille",
    "runes"
}

RegisterNetEvent('jl-laptop:client:HackCar', function()
    local ped = PlayerPedId()
    if haveItem(Config.Boosting.HackingDevice) then
        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            local plate = GetVehicleNumberPlateText(vehicle)
            if ActivePlates[plate] and ActivePlates[plate] > 0 then
                QBCore.Functions.TriggerCallback('jl-laptop:server:CanHackCar', function(canHack)
                    if canHack then
                        local pushingP = promise.new()
                        exports['ps-ui']:Scrambler(function(cb)
                            pushingP:resolve(cb)
                        end, psUI[math.random(1, #psUI)], 30, 0)
                        local success = Citizen.Await(pushingP)
                        if success then
                            QBCore.Functions.Notify('You delayed the police Tracker', 'success', 7500)
                            TriggerServerEvent('jl-laptop:server:SyncPlates', true)
                        else
                            QBCore.Functions.Notify('You failed nuub :)', 'error', 7500)
                        end
                    else
                        QBCore.Functions.Notify("You must wait atleast " .. Config.Boosting.HackDelay .. " Seconds", 'error', 7500)
                    end
                end, plate)
            else
                QBCore.Functions.Notify("There's no tracker here!", 'error', 7500)
            end
        end
    end
end)








-- ** EVERYTHING TO DO WITH PEDS ATTACKING YOU ** --

-- Gets the ped from the server side and then gives them tasks and weapons on the client side.
RegisterNetEvent('jl-laptop:client:SpawnPeds', function(netIds, Location)
    for i = 1, #netIds do
        local APed = NetworkGetEntityFromNetworkId(netIds[i])
        SetPedDropsWeaponsWhenDead(APed, false)
        GiveWeaponToPed(APed, joaat(Location.peds[i].weapon), 250, false, true)
        SetEntityMaxHealth(APed, Location.peds[i].health)
        SetEntityHealth(APed, Location.peds[i].health)
        SetPedArmour(APed, Location.peds[i].armor)
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


---- ALL THE BLIP SYNCS ----
-- This sync just makes it so anyone can hack a vehicle, that is hackable from boosting
RegisterNetEvent('jl-laptop:client:SyncPlates', function(data)
    ActivePlates = data
end)

local blips = {} -- Stores all the blips in a table so that PD can see multiple blips at the same time

-- The event that does everything for the blips, checks if the client is police then checks if the blip is active and if it is then remove it and spawn a new
RegisterNetEvent('jl-laptop:client:SyncBlips', function(coords, plate)
    if not isPolice() then return end
    if blips[plate] then RemoveBlip(blips[plate]) end
    if coords then
        blips[plate] = AddBlipForRadius(coords.x, coords.y, coords.z, 35.0)
        SetBlipHighDetail(blips[plate], true)
        SetBlipColour(blips[plate], 1)
        SetBlipAsShortRange(blips[plate], true)
    end
end)







-- ** CONTRACT HANDLER ** --

-- Sends the information to client when their contracts update
RegisterNetEvent('jl-laptop:client:ContractHandler', function(table)
    if not table then return end
    Contracts = table
    SendNUIMessage({
        action = 'receivecontracts',
        contracts = table
    })
end)

-- Handles state right when the player selects their character and location.
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('jl-laptop:server:GetContracts', function(result, plates)
        Contracts = result
        ActivePlates = plates
        if Contracts and #Contracts > 0 then
            SendNUIMessage({
                action = 'receivecontracts',
                contracts = result
            })
        end
    end)
end)

RegisterNUICallback('boosting/getcontract', function(_, cb)
    cb({
        contracts = Contracts,
    })
end)




-- ** DENY CONTRACTS ** --
local canDeny = true

local function DelayRQ()
    SetTimeout(10000, function()
        canDeny = true
    end)
end

RegisterNUICallback('boosting/deny', function(data, cb)
    local contract = data.contractID
    if not canDeny then
        cb({
            status = 'error',
            message = "You must wait 10 seconds to deny another contract!"
        })
        return
    end

    QBCore.Functions.TriggerCallback('jl-laptop:server:DeclineContract', function(result)
        if result == "success" then
            cb({
                status = 'success',
                message = "You declined the boost!"
            })
        else
            cb({
                status = 'error',
                message = "Error! Try Again"
            })
        end
        canDeny = false
        DelayRQ()
    end, contract)
end)


-- ** TRANSFER CONTRACTS ** --

-- Transfer Boosts between players --
RegisterNUICallback('boosting/transfer', function(data, cb)
    local id = data.playerid
    local contract = data.contractID
    QBCore.Functions.TriggerCallback('jl-laptop:server:TransferContracts', function(result)
        if result == "success" then
            cb({
                status = 'success',
                message = "Transferred Contract to State ID: " .. id
            })
        elseif result == "self" then
            cb({
                status = 'error',
                message = "You cannot transfer the contract to yourself!"
            })
        elseif result == "notfound" then
            cb({
                status = 'error',
                message = "Player not found!"
            })
        elseif result == "full" then
            cb({
                status = 'error',
                message = "State ID has too many contracts!"
            })
        elseif result == "error" then
            cb({
                status = 'error',
                message = "Error 404 Try again!"
            })
        end
    end, id, contract)
end)


-- Queue Functions --
RegisterNUICallback('boosting/queue', function(cb)
    TriggerServerEvent('jl-laptop:server:JoinQueue', cb.status)
end)

RegisterNetEvent('jl-laptop:client:QueueHandler', function(value)
    inQueue = value
end)

RegisterNUICallback("boosting/getqueue", function(_, cb)
    cb(inQueue)
end)



-- Gets all the reps --
-- Getters for when you open the boost app --
RegisterNUICallback("boosting/getrep", function(_, cb)
    local data = {
        rep = PlayerData.metadata['carboostrep'] or 0,
        repconfig = Config.Boosting.TiersPerRep
    }
    cb(data)
end)



RegisterNUICallback("boosting/expire", function(data, cb)
    print(data["id"])
    cb("ok")
end)
