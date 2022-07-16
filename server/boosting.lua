local QBCore = exports['qb-core']:GetCoreObject()
local MaxPools = { -- Contains all the the amount of contracts avaible every restart, once a contract has started or declined it gets back into the pool
    ["D"] = 25,
    ["C"] = 20,
    ["B"] = 15,
    ["A"] = 10,
    ["A+"] = 5,
    ["S"] = 3,
    ["S+"] = 1,
}

local cars = {
    ["D"] = {},
    ["C"] = {},
    ["B"] = {},
    ["A"] = {},
    ["A+"] = {},
    ["S"] = {},
    ["S+"] = {},
}


CreateThread(function()
    Wait(12500)
    for k, v in pairs(QBCore.Shared.Vehicles) do
        if v['tier'] and cars[v['tier']] then
            cars[v['tier']][#cars[v['tier']]+1] = k
        end
    end
end)

local currentRuns = {}
local ActivePlates = {} -- Handle all the active plates and syncs all the data shit
local currentContracts = {}
local LookingForContracts = {}

local function generateName()
    return Config.Boosting.RandomNames[math.random(1, #Config.Boosting.RandomNames)]
end

local function ResetShit(Tier, location)
    SetTimeout(5 * 60000, function()
        Config.Boosting.Locations[Tier][location].isBusy = false
    end)
end

local function GerRandomLocation(Tier)
    local Locations = {}
    for i = 1, #Config.Boosting.Locations[Tier] do
        print(Config.Boosting.Locations[Tier][i].isBusy)
        if not Config.Boosting.Locations[Tier][i].isBusy then
            Locations[#Locations+1] = i
        end
    end
    local location = Locations[math.random(1, #Locations)]
    Config.Boosting.Locations[Tier][location].isBusy = true
    return Config.Boosting.Locations[Tier][location], location
end

local function ResetAnotherShit(Tier)
    SetTimeout(5 * 60000, function()
        Config.Boosting.ReturnLocation[Tier].isBusy = false
    end)
end

local function GetRandomDropOff()
    local Locations = {}
    for i = 1, #Config.Boosting.ReturnLocation do
        if not Config.Boosting.ReturnLocation[i].isBusy then
            Locations[#Locations+1] = i
        end
    end
    local location = Locations[math.random(1, #Locations)]
    return Config.Boosting.ReturnLocation[Locations[location]].coords, location
end

local function canScratch()
    local scratch = false

    if math.random() <= 100 then
        scratch = true
    end

    return scratch
end

local function GeneratePlate() -- Just makes sure we generate plates noone owns.
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local result = MySQL.Sync.fetchScalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result or ActivePlates[plate] then
        return GeneratePlate()
    else
        return plate:upper()
    end
end

local function SpawnCar(src)
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    local carModel = currentRuns[CID].car
    local coords = currentRuns[CID].Location.carCoords

    local CreateAutomobile = joaat('CREATE_AUTOMOBILE')
    local car = Citizen.InvokeNative(CreateAutomobile, joaat(carModel), coords, true, false)

    while not DoesEntityExist(car) do
        Wait(10)
    end

    if DoesEntityExist(car) then
        SetVehicleDoorsLocked(car, 2)

        local plate = GeneratePlate()
        ActivePlates[plate] = math.random(3, 10)
        SetVehicleNumberPlateText(car, plate)
        currentRuns[CID].NetID = NetworkGetNetworkIdFromEntity(car)


        TriggerClientEvent('jl-laptop:client:SyncPlates', -1, ActivePlates)
        TriggerClientEvent('jl-laptop:client:MissionStarted', src, currentRuns[CID].NetID, coords)
    end
end

QBCore.Functions.CreateUseableItem(Config.Boosting.HackingDevice, function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(Config.Boosting.HackingDevice) ~= nil then
        TriggerClientEvent('jl-laptop:client:HackCar', source)
    end
end)


RegisterNetEvent('jl-laptop:server:FinalDestination', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    if currentRuns[CID] and not currentRuns[CID].dropOff and not currentRuns[CID].vinscratch then
        local place, id = GetRandomDropOff()

        TriggerClientEvent('jl-laptop:client:ReturnCar', src, place)
        ResetAnotherShit(id)
    elseif currentRuns[CID] and not currentRuns[CID].dropOff and currentRuns[CID].vinscratch then
        TriggerClientEvent('jl-laptop:client:ReturnCar', src, GetRandomDropOff(), true) -- true and the GetVinscratchLocation gives them the final vinscratch location
    end
end)

RegisterNetEvent('jl-laptop:server:StartBoosting', function(id, currentCops)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    local amount = 0

    if currentCops == 2 then
        amount = 1
    elseif currentCops > 2 then
        amount = math.floor(currentCops / 2)
    else
        amount = 2
    end

    if #currentRuns >= amount then return end
    if currentRuns[CID] then return end
    if not currentContracts[CID][id] then return end
    local location, place = GerRandomLocation(currentContracts[CID][id].contract)
    if location then
        currentRuns[CID] = {
            Location = location,
            vinscratch = currentContracts[CID][id].vinscratch,
            car = currentContracts[CID][id].car,
            contract = currentContracts[CID][id].contract,
            dropOff = nil,
            Plate = nil,
            NetID = nil,
            PedSpawned = false,
        }
        print("works")
        MaxPools[currentContracts[CID][id].contract] += 1
        ResetShit(currentContracts[CID][id].contract, place)
        table.remove(currentContracts[CID], id)
        TriggerClientEvent('jl-laptop:client:recieveContract', src, currentContracts[CID], false)
        SpawnCar(src)
    end
end)

local function DeletePeds(netIds)
    SetTimeout(2.5 * 60000, function()
        for i = 1, #netIds do
            if DoesEntityExist(NetworkGetEntityFromNetworkId(netIds[i])) then
                DeleteEntity(NetworkGetEntityFromNetworkId(netIds[i]))
            end
        end
    end)
end

RegisterNetEvent('jl-laptop:server:SpawnPed', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    if currentRuns[CID].PedSpawned then return end
    currentRuns[CID].PedSpawned = true
    local netIds = {}
    for k, v in pairs(currentRuns[CID].Location.peds) do
        local netId
        local pedstuff = CreatePed(30, joaat(v.model), v.coords, true, false)
        while not DoesEntityExist(pedstuff) do Wait(25) end
        netId = NetworkGetNetworkIdFromEntity(pedstuff)
        netIds[k] = netId
    end
    Wait(300)

    TriggerClientEvent('jl-laptop:client:SpawnPeds', src, netIds, currentRuns[CID].Location)
    DeletePeds(netIds)
end)


RegisterNetEvent('jl-laptop:server:SyncBlips', function(coords, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid


    if currentRuns[CID] and currentRuns[CID].PedSpawned and currentRuns[CID].NetID then
        TriggerClientEvent('jl-laptop:client:SyncBlips', -1, coords, plate)
    end
end)

RegisterNetEvent('jl-laptop:server:SyncPlates', function(success)
    local src = source
    local ped = GetPlayerPed(src)
    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, false))

    if ActivePlates[plate] and ActivePlates[plate] >= 1 and success then
        ActivePlates[plate] = ActivePlates[plate] - 1
        TriggerClientEvent('jl-laptop:client:SyncPlates', -1, ActivePlates)
    end
end)




----- ** Generate Contract things ** -----

RegisterNetEvent('jl-laptop:server:JoinQueue', function(status)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    if status then
        if not LookingForContracts[CID] then LookingForContracts[CID] = {} end
        if not currentContracts[CID] then currentContracts[CID] = {} end
        LookingForContracts[CID] = {
            src = src,
            skipped = 0,
            activeContracts = {}
        }
    else
        LookingForContracts[CID] = nil
    end
end)


RegisterNetEvent('jl-laptop:server:CancelBoost', function(netId, Plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    if not currentRuns[CID] then return end
    if not (currentRuns[CID].NetID == netId) then return end

    if DoesEntityExist(NetworkGetEntityFromNetworkId(currentRuns[CID].NetID)) then return end

    ActivePlates[Plate] = 0
    currentRuns[CID] = nil
    TriggerClientEvent('jl-laptop:client:SyncPlates', -1, ActivePlates)
    TriggerClientEvent('jl-laptop:client:finishContract', src)
    TriggerClientEvent('QBCore:Notify', src, "You failed to deliver the vehicle and contract has been terminated.", "error")
end)

RegisterNetEvent('jl-laptop:server:finishBoost', function(netId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid

    if not currentRuns[CID] then return end
    if not (currentRuns[CID].NetID == netId) then return end

    local boostData = Player.PlayerData.metadata["carboostrep"] or 0
    boostData += 1
    Player.Functions.SetMetaData('carboostrep', boostData)
    exports['qb-phone']:AddCrypto(src, "gne", math.random(1,5))


    if DoesEntityExist(NetworkGetEntityFromNetworkId(currentRuns[CID].NetID)) then
        DeleteEntity(NetworkGetEntityFromNetworkId(currentRuns[CID].NetID))
    end
    currentRuns[CID] = nil
    TriggerClientEvent('jl-laptop:client:finishContract', src)
end)

local function generateTier(src)
    local chance = math.random(1,100)
    local Player = QBCore.Functions.GetPlayer(src)
    local boostData = Player.PlayerData.metadata["carboostrep"] or 0
    local tier

    -- We should also get their current metadata and based on their metadata increase this luck or even cap it so they cant get s+ if they just startedt/
    if chance >= 99 then -- 2%
        if boostData >= Config.Boosting.TiersPerRep["S+"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "S+"
        else
            generateTier(src)
        end
    elseif chance >= 95 then -- 3%
        if boostData >= Config.Boosting.TiersPerRep["S"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "S"
        else
            generateTier(src)
        end

    elseif chance >= 90 then -- 5%
        if boostData >= Config.Boosting.TiersPerRep["A+"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "A+"
        else
            generateTier(src)
        end

    elseif chance >= 80 then -- 10%
        if boostData >= Config.Boosting.TiersPerRep["A"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "A"
        else
            generateTier(src)
        end

    elseif chance >= 60 then -- 20%
        if boostData >= Config.Boosting.TiersPerRep["B"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "B"
        else
            generateTier(src)
        end
    elseif chance >= 35 then -- 25%
        if boostData >= Config.Boosting.TiersPerRep["C"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "C"
        else
            generateTier(src)
        end
    else -- 35%
        tier = "D"
    end

    Wait(0)

    if MaxPools[tier] and MaxPools[tier] > 0 then
        MaxPools[tier] -= 1
        return tier
    else
        return nil
    end
end

local function generateCar(tier)
    return cars[tier][math.random(1, #cars[tier])]
end

function GetHoursFromNow(hours)
    local time = os.date("%c", os.time() + hours * 60 * 60)
    return time
 end

local function generateContract(src)
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    if not currentContracts[CID] then currentContracts[CID] = {} end

    local contract = generateTier(src)
    if contract then
        currentContracts[CID][#currentContracts[CID]+1] = {
            id = #currentContracts[CID]+1,
            contract = contract,
            car = generateCar(contract),
            expire = GetHoursFromNow(6),
            owner = generateName(),
            vinscratch = canScratch()
        }
        LookingForContracts[CID].skipped = 0
        TriggerClientEvent('jl-laptop:client:recieveContract', src, currentContracts[CID], true)
    else
        LookingForContracts[CID].skipped += 1
    end
end

CreateThread(function()
    while true do
        if LookingForContracts then
            for k, v in pairs(LookingForContracts) do
                if currentContracts[k] then
                    if #currentContracts[k] < 5 then
                        local ContractChance = math.random()

                        if v.skipped >= 25 or ContractChance >= 0.90 then -- 10% chance of getting a contract
                            generateContract(v.src)
                        else
                            v.skipped += 1
                        end
                    end
                end
            end
        end
        Wait(2 * 60000) -- Once every 2 minutes
    end
end)

QBCore.Functions.CreateCallback('jl-laptop:server:GetContracts', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local CID = Player.PlayerData.citizenid

    cb(currentContracts[CID], ActivePlates)
end)

QBCore.Functions.CreateCallback('ps-laptop:server:CanStartBoosting', function(source, cb, cops)
    local amount = 0
    if cops == 2 then
        amount = 1
    elseif cops > 2 then
        amount = math.floor(cops / 2)
    else
        amount = 2
    end
    if #currentRuns >= amount then
        cb(false)
    else
        cb(true)
    end
end)