local QBCore = exports['qb-core']:GetCoreObject()
local Contracts = {}
local PZone = nil
local PZone2 = nil
local NetID = nil
local missionBlip = nil
local inZone = false
local inVin = false
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
    elseif Config.Boosting.Notifications == "npwd" then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Lang:t('boosting.info.phonenotify'),
            subject = 'Boosting',
            message = text,
            button = {}
        })
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
    local State = Entity(car).state.Boosting
    if State and State.boostHacks then
        CreateThread(function()

            while State and State.boostHacks > 0 do

                local checks = 0
                if DoesEntityExist(car) then
                    local pos = GetEntityCoords(car)
                    TriggerServerEvent('jl-laptop:server:SyncBlips', pos, NetID)
                else
                    checks = checks + 1
                    if checks >= 3 and not DoesEntityExist(car) then
                        TriggerServerEvent('jl-laptop:server:CancelBoost', NetID, Plate)
                    end -- additional safety check JUST incase, make a cancel events cancelling everything
                end


                Wait((Config.Boosting.Frequency * 1000) / State.boostHacks) -- Max 10 seconds, the more times hacked the less time it updates
                State = Entity(car).state.Boosting -- Makes it so that it dosnt get the state from the car twice on first run
            end

            if DoesEntityExist(car) then
                TriggerServerEvent('jl-laptop:server:SyncBlips', nil, NetID)
                Notify(Lang:t("boosting.success.disable_tracker"), 'success', 7500)
                DelayDelivery()
            end
        end)
    end
end

local function CheckVin(NetworkID)
    if IsCheckingVin then return end
    IsCheckingVin = true
    local entity = NetworkGetEntityFromNetworkId(NetworkID)
    if DoesEntityExist(entity) then
        QBCore.Functions.Progressbar('checking_vin', 'Checking VIN', 10000, false, true,
            { -- Name | Label | Time | useWhileDead | canCancel
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = '"anim@amb@clubhouse@tutorial@bkr_tut_ig3@"@',
                anim = 'machinic_loop_mechandplayer',
                flags = 1,
            }, {}, {}, function() -- Play When Done
                local reply

                if not Entity(entity).state.vinchecked then
                    local res = promise:new()
                    QBCore.Functions.TriggerCallback('jl-laptop:server:checkVin', function(cb)
                        res:resolve(cb)
                    end, NetworkID)
                    reply = Citizen.Await(res)
                else
                    reply = Entity(entity).state.vinchecked.reply
                end
                Wait(100)
                if reply == "failed" then
                    QBCore.Functions.Notify("The vin number is " ..
                        Entity(entity).state.vinchecked.vinnumber)
                elseif reply == "found" then
                    QBCore.Functions.Notify("The vin number is scratched!", "error")
                end
                IsCheckingVin = false
                ClearPedTasks(PlayerPedId())
            end, function() -- Play When Cancel
            ClearPedTasks(PlayerPedId())
            IsCheckingVin = false
        end)
    end
end

local AntiSpam = false -- Just a true / false boolean to not spam the shit out of the server.
local carCoords = nil
-- sends information from server to client that we found the car and we started lockpicking
RegisterNetEvent('lockpicks:UseLockpick', function()
    if AntiSpam then return end
    if not NetID then return end
    local car = NetworkGetEntityFromNetworkId(NetID)
    if DoesEntityExist(car) then
        local dist = #(GetEntityCoords(car) - GetEntityCoords(PlayerPedId()))
        if dist <= 3.5 then -- 2.5 is the distance in qbcore vehiclekeys if you use more or less then please edit this.
            if #(vector3(carCoords.x, carCoords.y, carCoords.z) - GetEntityCoords(car)) <= 6.9 then
                AntiSpam = true
                TriggerServerEvent('jl-laptop:server:SpawnPed')
                RemoveBlip(missionBlip)
                UpdateBlips()
                SendNUIMessage({
                    action = "boosting/setcancel",
                    data = {
                        status = false
                    }
                })
                exports['ps-dispatch']:CarBoosting(vehicle)
            else
                TriggerServerEvent('jl-laptop:server:CancelBoost', NetID, Plate)
            end
        end
    end
end)

-- MISSION STARTER --

-- Sends information from server to client that it will start now

RegisterNetEvent('jl-laptop:client:MissionStarted',
    function(netID, coords, plate) -- Pretty much just resets every boolean to make sure no issues will occour.
        NetID = netID
        carCoords = coords
        AntiSpam = false
        inZone = false

        -- send plate number
        SendNUIMessage({
            action = "boosting/horseboosting",
            data = {
                plate = plate or "Unknown?"
            }
        })
        --print(coords)

        if PZone then PZone:destroy() PZone = nil end

        if missionBlip then RemoveBlip(missionBlip) end

        if coords then
            if Config.Boosting.Debug then SetNewWaypoint(coords.x, coords.y) end

            missionBlip = AddBlipForRadius(coords.x + math.random(-100, 100), coords.y + math.random(-100, 100), coords.z
                , 250.0)
            SetBlipAlpha(missionBlip, 150)
            SetBlipHighDetail(missionBlip, true)
            SetBlipColour(missionBlip, 1)
            SetBlipAsShortRange(missionBlip, true)
        end
    end)

RegisterNUICallback('boosting/start', function(data, cb)
    QBCore.Functions.TriggerCallback('jl-laptop:server:CanStartBoosting', function(result)
        print(result)
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
    SetVehicleDoorsLocked(car, 2)
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

local function StartVin()
    QBCore.Functions.Progressbar('vin_scratching', 'Scratching VIN', 7000, false, true,
        { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = '"anim@amb@clubhouse@tutorial@bkr_tut_ig3@"@',
            anim = 'machinic_loop_mechandplayer',
            flags = 1,
        }, {}, {}, function() -- Play When Done
            local car = NetworkGetEntityFromNetworkId(NetID)
            local model = GetDisplayNameFromVehicleModel(GetEntityModel(car)):lower()
            local mods = QBCore.Functions.GetVehicleProperties(car)
            TriggerServerEvent("jl-laptop:server:fuckvin", NetID, model, mods)
            TriggerServerEvent('jl-laptop:server:finishBoost', NetID, true)
            Entity(car).state.isvinCar = false
            exports['qb-target']:RemoveTargetEntity(car, "Scratch Vin")
            ClearPedTasks(PlayerPedId())
        end, function() -- Play When Cancel
        ClearPedTasks(PlayerPedId())
    end)
end

local function MeVinYeah()
    local car = NetworkGetEntityFromNetworkId(NetID)
    if not DoesEntityExist(car) then return end

    local state = Entity(car).state
    if state.isvinCar then
        exports['qb-target']:AddTargetEntity(car, {
            options = {
                {
                    action = function()
                        StartVin()
                    end,
                    canInteract = function()
                        return inVin and state.isvinCar
                    end,
                    label = "Scratch Vin",
                    icon = "fas fa-mask"
                },
            },
            distance = 2.0
        })
    else
        TriggerServerEvent('jl-laptop:server:finishBoost', NetID, true)
    end
end

local function VehicleCheck(isvin)
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
                        if isvin then
                            inZone = false
                            MeVinYeah()
                        else
                            inZone = false
                            DeliverCar()
                        end
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

RegisterNetEvent("jl-laptop:client:ToVinScratch", function(coords)
    PZone = CircleZone:Create(coords, 15, {
        name = "VinGoesBrum",
        debugPoly = Config.Boosting.Debug
    })
    local info = {
        blip = {
            text = Lang:t('boosting.blip.vinscratch'),
            coords = coords
        }
    }
    PZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inZone = true
            inVin = true
            VehicleCheck(true)
        else
            inVin = false
            inZone = false
        end
    end)
    Notify(Lang:t('boosting.success.vin_dropoff'), "success", 7000)
    dropoffBlip = AddBlipForCoord(info.blip.coords.x, info.blip.coords.y, info.blip.coords.z)
    SetBlipSprite(dropoffBlip, 326)
    SetBlipScale(dropoffBlip, 1.0)
    SetBlipColour(dropoffBlip, 40)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.blip.text)
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

local currentHacking = false

RegisterNetEvent('jl-laptop:client:HackCar', function()
    -- Makes it so if they are doing hacking or whatever it will not let them do it again, as people could hard spam before the delay was added --
    if currentHacking then return end
    currentHacking = true
    local ped = PlayerPedId()
    if haveItem(Config.Boosting.HackingDevice) then
        if IsPedInAnyVehicle(ped, false) then
            local car = GetVehiclePedIsIn(ped, false)
            local State = Entity(car).state.Boosting
            if State and State.boostHacks > 0 and not State.boostCooldown then
                local pushingP = promise.new()
                exports['ps-ui']:Scrambler(function(cb)
                    pushingP:resolve(cb)
                end, psUI[math.random(1, #psUI)], 30, 0)
                local success = Citizen.Await(pushingP)

                TriggerServerEvent('jl-laptop:server:SyncPlates', success)
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
end)


if Config.Boosting.Debug then
    RegisterCommand('hackcar', function()
        if not Config.Boosting.Debug then return end

        TriggerEvent('jl-laptop:client:HackCar')
    end, false)
end





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
local blips = {} -- Stores all the blips in a table so that PD can see multiple blips at the same time

-- The event that does everything for the blips, checks if the client is police then checks if the blip is active and if it is then remove it and spawn a new
RegisterNetEvent('jl-laptop:client:SyncBlips', function(coords, newNet)
    if not Config.Boosting.Debug and not isPolice() then print("Not police") return end
    print(coords, newNet)
    if blips[newNet] then RemoveBlip(blips[newNet]) end

    if coords then
        blips[newNet] = AddBlipForRadius(coords.x + math.random(-5, 5), coords.y + math.random(-5, 5), coords.z, 35.0)
        SetBlipHighDetail(blips[newNet], true)
        SetBlipColour(blips[newNet], 1)
        SetBlipAsShortRange(blips[newNet], true)
    end
end)







-- ** CONTRACT HANDLER ** --

-- Sends the information to client when their contracts update
RegisterNetEvent('jl-laptop:client:ContractHandler', function(table, currentdate)
    if not table then return end
    Contracts = table
    if not display then return end

    SendNUIMessage({
        action = 'receivecontracts',
        contracts = table,
        serverdate = currentdate
    })
end)

-- Handles state right when the player selects their character and location.
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('jl-laptop:server:GetContracts', function(result)
        Contracts = result
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
                message = Lang:t('boosting.laptop.transfer.success', { id = id })
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
RegisterNUICallback("boosting/cancel", function(data, cb)
    TriggerServerEvent('jl-laptop:server:CancelBoost', NetID, nil, true)
    cb("success")
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


RegisterNetEvent('jl-laptop:client:setvehicleFuel', function(veh)
    exports['LegacyFuel']:SetFuel(car, 100.0)
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

CreateThread(function()
    exports['qb-target']:AddGlobalVehicle({
        options = {
            {
                label = "Check Vin",
                icon = "fas fa-car-rear",
                action = function(entity)
                    CheckVin(NetworkGetNetworkIdFromEntity(entity))
                end,
                canInteract = function(entity)
                    return isPolice() and IsThisModelACar(GetEntityModel(entity))
                end
            }
        },
        distance = 1.5
    })
end)
