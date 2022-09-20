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


---- Notify functions ----

local function Notify(text, type, time)
    if Config.Boosting.Notifications == "phone" then
        TriggerEvent('qb-phone:client:CustomNotification',
            Lang:t('boosting.info.phonenotify'),
            text,
            "fas fa-user-secret",
            "#00008B",
            time
        )
    else
        QBCore.Functions.Notify(text, type, time)
    end
end



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
                    local pos = GetEntityCoords(car)
                    TriggerServerEvent('jl-laptop:server:SyncBlips', pos, Plate)
                else
                    checks = checks + 1
                    if checks >= 3 and not DoesEntityExist(car) then
                        TriggerServerEvent('jl-laptop:server:CancelBoost', NetID, Plate)
                    end -- additional safety check JUST incase, make a cancel events cancelling everything
                end


                Wait(10000 / ActivePlates[Plate]) -- Max 10 seconds, the more times hacked the less time it updates
            end

            TriggerServerEvent('jl-laptop:server:SyncBlips', nil, Plate)
            Notify(Lang:t("boosting.success.disable_tracker"), 'success', 7500)
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

    --print(coords)

    if PZone then PZone:destroy() PZone = nil end

    if missionBlip then RemoveBlip(missionBlip) end

    if coords then
        missionBlip = AddBlipForRadius(coords.x + math.random(20, 100), coords.y + math.random(20, 100), coords.z, 250.0)
        SetBlipAlpha(missionBlip, 150)
        SetBlipHighDetail(missionBlip, true)
        SetBlipColour(missionBlip, 1)
        SetBlipAsShortRange(missionBlip, true)
    end
end)

RegisterNUICallback('boosting/start', function(data, cb)
    QBCore.Functions.TriggerCallback('jl-laptop:server:CanStartBoosting', function(result)
        if result == "success" then
            --TriggerServerEvent('jl-laptop:server:StartBoosting', data.id, currentCops)
            cb({
                status = 'success',
                message = Lang:t('boosting.laptop.boosting.success')
            })
        elseif result == "cops" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.boosting.cops')
            })
        elseif result == "running" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.boosting.running')
            })
        elseif result == "notfound" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.boosting.notfound')
            })
        elseif result == "notenough" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.boosting.notenough')
            })
        elseif result == "busy" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.boosting.busy')
            })
        elseif result == "error" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.boosting.error')
            })
        end
    end, currentCops, data.id)
end)








-- DELIVERING VEHICLE --
local function DeliverCar()
    Notify(Lang:t('boosting.error.get_away'), 'error', 7500)
    local car = NetworkGetEntityFromNetworkId(NetID)
    FreezeEntityPosition(car, true)
    if PZone then
        PZone:destroy()
        PZone = nil
    end

    Wait(7500)
    Notify(Lang:t('boosting.success.youllbepaid'), 'success', 7500)
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
    PZone = CircleZone:Create(coords, 15, {
        name = "NewReturnWhoDis",
        debugPoly = Config.Boosting.Debug,
    })

    local info = {
        ['blip'] = {
            ['Text'] = Lang:t('boosting.blip.dropoff'),
            ['Coords'] = coords
        },
    }

    PZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inZone = true
            VehicleCheck()
        else
            inZone = false
        end
    end)

    Notify(Lang:t('boosting.success.gps_dropoff'), 'success', 7500)

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
RegisterNetEvent('jl-laptop:client:finishContract', function(table)
    if PZone then PZone:destroy() PZone = nil end
    if PZone2 then PZone2:destroy() PZone2 = nil end
    NetID = nil
    if missionBlip then RemoveBlip(missionBlip) missionBlip = nil end
    if dropoffBlip then RemoveBlip(dropoffBlip) dropoffBlip = nil end
    inZone = false

    Contracts = table

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

local clientHack = true

local function ClientDelay(time)
    SetTimeout(time * 1000, function()
        clientHack = true
        Notify(Lang:t("boosting.info.tracker_backon"), 'primary', 7500)
    end)
end

local currentHacking = false

RegisterNetEvent('jl-laptop:client:HackCar', function()
    -- Makes it so if they are doing hacking or whatever it will not let them do it again, as people could hard spam before the delay was added --
    if currentHacking then return end
    currentHacking = true
    local randomSeconds = math.random(Config.Boosting.HackDelayMin, Config.Boosting.HackDelayMax)

    local ped = PlayerPedId()
    if clientHack then
        if haveItem(Config.Boosting.HackingDevice) then
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local plate = GetVehicleNumberPlateText(vehicle)
                if ActivePlates[plate] and ActivePlates[plate] > 0 then
                    local pushingP = promise.new()
                    exports['ps-ui']:Scrambler(function(cb)
                        pushingP:resolve(cb)
                    end, psUI[math.random(1, #psUI)], 30, 0)
                    local success = Citizen.Await(pushingP)
                    if success then
                        TriggerServerEvent('jl-laptop:server:SyncPlates', true, randomSeconds)
                        ActivePlates[plate] -= 1
                        local newThing = ActivePlates[plate] - 1
                        if newThing >= 1 then
                            Notify(Lang:t('boosting.success.tracker_off', {tracker_left = newThing, time = randomSeconds}), 'success', 7500)
                        end

                        if not Config.Boosting.Debug then
                            clientHack = false
                            ClientDelay(randomSeconds)
                        end
                    else
                        QBCore.Functions.Notify(Lang:t('boosting.error.disable_fail'), "error")
                        if math.random(0, 1) <= 0.5 then
                            TriggerServerEvent("jl-laptop:server:RemoveItem", Config.Boosting.HackingDevice)
                        end
                    end
                    currentHacking = false
                else
                    Notify(Lang:t("boosting.error.no_tracker"), 'error', 7500)
                    currentHacking = false
                end
            else
                currentHacking = false
            end
        else
            currentHacking = false
        end
    else
        currentHacking = false
    end
end)








-- ** EVERYTHING TO DO WITH PEDS ATTACKING YOU ** --

-- Gets the ped from the server side and then gives them tasks and weapons on the client side.
RegisterNetEvent('jl-laptop:client:SpawnPeds', function(netIds, Location)
    for i = 1, #netIds do
        -- Get the Ped --
        local APed = NetworkGetEntityFromNetworkId(netIds[i])

        -- health and armor --
        SetEntityMaxHealth(APed, Location.peds[i].health)
        SetEntityHealth(APed, Location.peds[i].health)
        SetPedArmour(APed, Location.peds[i].armor)

        -- Relationship --
        SetPedAsCop(APed, true)
        SetPedRelationshipGroupHash(APed, joaat("HATES_PLAYER"))

        -- Weapon Stuff --
        GiveWeaponToPed(APed, joaat(Location.peds[i].weapon), 250, false, true)

        -- combat stuff --
        SetCanAttackFriendly(APed, false, true)
        SetPedCombatMovement(APed, 3)
        SetPedCombatRange(APed, 2)
        SetPedCombatAttributes(APed, 46, true)
        SetPedCombatAttributes(APed, 0, false)
        SetPedAccuracy(APed, 60)
        SetPedCombatAbility(APed, 100)
        TaskCombatPed(APed, PlayerPedId(), 0, 16)
        SetPedKeepTask(APed, true)
        SetPedSeeingRange(APed, 150.0)
        SetPedHearingRange(APed, 150.0)
        SetPedAlertness(APed, 3)


        -- other shit --
        SetPedDropsWeaponsWhenDead(APed, false)
        SetPedFleeAttributes(APed, 0, 0)
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
        blips[plate] = AddBlipForRadius(coords.x + math.random(5, 15), coords.y + math.random(5, 15), coords.z, 35.0)
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

    if not display then return end
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
            message = Lang:t('boosting.laptop.must_wait')
        })
        return
    end

    QBCore.Functions.TriggerCallback('jl-laptop:server:DeclineContract', function(result)
        if result == "success" then
            cb({
                status = 'success',
                message = Lang:t('boosting.laptop.declinedboost')
            })
        else
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.try_again')
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
                message = Lang:t('boosting.laptop.transfer.success', {id = id})
            })
        elseif result == "self" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.transfer.self')
            })
        elseif result == "notfound" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.transfer.notfound')
            })
        elseif result == "full" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.transfer.full')
            })
        elseif result == "error" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.transfer.error')
            })
        end
    end, id, contract)
end)

-- Cancel Contract --
-- Todo: add the logic, Zoo's work 🙂 --
RegisterNUICallback("boosting/cancel", function (data, cb)
    print(data.id)
    cb(true)
end)


-- Queue Functions --
RegisterNUICallback('boosting/queue', function(data, cb)
    QBCore.Functions.TriggerCallback('jl-laptop:server:joinQueue', function(result)
        if result == "success" then
            if data.status then
                cb({
                    status = 'success',
                    message = Lang:t('boosting.laptop.queue.success')
                })
            else
                cb({
                    status = 'success',
                    message = Lang:t('boosting.laptop.queue.successquit')
                })
            end
        elseif result == "running" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.queue.running')
            })
        elseif result == "inqueue" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.queue.inqueue')
            })
        elseif result == "error" then
            cb({
                status = 'error',
                message = Lang:t('boosting.laptop.queue.error')
            })
        end
    end, data.status)
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
