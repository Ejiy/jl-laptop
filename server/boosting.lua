local QBCore = exports['qb-core']:GetCoreObject()
local MaxPools = Config.Boosting.MaxPools -- When the server starts it needs to fetch the config, then fetches all the boosts later and then sets the remaining pool.

local currentRuns = {}
local ActivePlates = {} -- Handle all the active plates and syncs all the data shit
local currentContracts = {}
local LookingForContracts = {}

local function generateName()
    return Config.Boosting.RandomNames[math.random(1, #Config.Boosting.RandomNames)]
end

local function GerRandomLocation(Tier)
    local Locations = {}
    for i = 1, #Config.Boosting.Locations[Tier] do
        if not Config.Boosting.Locations[Tier].isBusy then
            Locations[#Locations+1] = i
        end
    end

    return Config.Boosting.Locations[Tier][Locations[math.random(1, #Locations)]]
end

local function GetRandomDropOff()
    local Locations = {}
    for i = 1, #Config.Boosting.ReturnLocation do
        if not Config.Boosting.ReturnLocation.isBusy then
            Locations[#Locations+1] = i
        end
    end

    return Config.Boosting.ReturnLocation[Locations[math.random(1, #Locations)]].coords
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
        ActivePlates[plate] = math.random(3,5)
        SetVehicleNumberPlateText(car, plate)
        currentRuns[CID].NetID = NetworkGetNetworkIdFromEntity(car)


        TriggerClientEvent('ps-laptop:client:SyncPlates', -1, ActivePlates)
        TriggerClientEvent('ps-laptop:client:MissionStarted', src, currentRuns[CID].NetID, coords)
    end
end

QBCore.Functions.CreateUseableItem("hack", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("hack") ~= nil then
        print("ok?")
        TriggerClientEvent('ps-laptop:client:HackCar', source)
    end
end)

RegisterNetEvent('ps-laptop:server:FinalDestination', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    if currentRuns[CID] and not currentRuns[CID].dropOff then
        TriggerClientEvent('ps-laptop:client:ReturnCar', src, GetRandomDropOff())
    end
end)

RegisterNetEvent('ps-laptop:server:StartBoosting', function(id)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    if currentRuns[CID] then return end
    if not currentContracts[CID][id] then return end


    currentRuns[CID] = {
        Location = GerRandomLocation(currentContracts[CID][id].contract),
        car = currentContracts[CID][id].car,
        dropOff = nil,
        Plate = nil,
        NetID = nil,
        PedSpawned = false,
    }


    --table.remove(currentContracts[CID], id) If i remove the contract the laptop errors out please fix this JustLazzy :sadge:
    --TriggerClientEvent('ps-laptop:client:recieveContract', src, currentContracts[CID], false)



    SpawnCar(src)
end)


RegisterNetEvent('ps-laptop:server:SpawnPed', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    print("ok")
    if currentRuns[CID].PedSpawned then return end
    currentRuns[CID].PedSpawned = true
    local netIds = {}
    print(json.encode(currentRuns[CID].Location.peds))
    for k, v in pairs(currentRuns[CID].Location.peds) do
        local netId
        local pedstuff = CreatePed(30, joaat(v.model), v.coords, true, false)
        while not DoesEntityExist(pedstuff) do Wait(25) end
        netId = NetworkGetNetworkIdFromEntity(pedstuff)
        netIds[k] = netId
    end
    Wait(300)
    print(json.encode(netIds))

    TriggerClientEvent('ps-laptop:client:SpawnPeds', src, netIds, currentRuns[CID].Location)
end)


RegisterNetEvent('ps-laptop:server:SyncBlips', function(coords, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid


    if currentRuns[CID] and currentRuns[CID].PedSpawned and currentRuns[CID].NetID then
        TriggerClientEvent('ps-laptop:client:SyncBlips', -1, coords, plate)
    end
end)


----- ** Generate Contract things ** -----

RegisterNetEvent('ps-laptop:server:JoinQueue', function(status)
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


local function generateTier(src)
    local chance = math.random(1,100)
    local Player = QBCore.Functions.GetPlayer(src)
    local boostData = Player.PlayerData.metadata["carboostrep"]
    print(boostData)
    local tier

    print("stuck in loop")

    -- We should also get their current metadata and based on their metadata increase this luck or even cap it so they cant get s+ if they just startedt/
    if chance >= 99 then
        if boostData >= Config.Boosting.TiersPerRep["S"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "S+"
        else
            generateTier(src)
        end
    elseif chance >= 95 and chance < 99 then
        if boostData >= Config.Boosting.TiersPerRep["A+"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "S"
        else
            generateTier(src)
        end
    else
        tier = "D"
    end
    print(MaxPools["D"], MaxPools["S"], MaxPools["S+"])
    if MaxPools[tier] and MaxPools[tier] > 0 then
        MaxPools[tier] -= 1
        return tier
    else
        print("big fail")
        return nil
    end
end

local function generateCar(tier)
    return Config.Boosting.Vehicles[tier][math.random(1, #Config.Boosting.Vehicles[tier])]
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
            expire = os.time(),
            owner = generateName(),
            vinscratch = canScratch()
        }
        LookingForContracts[CID].skipped = 0
        TriggerClientEvent('ps-laptop:client:recieveContract', src, currentContracts[CID], true)
    else
        LookingForContracts[CID].skipped += 1
    end
end

CreateThread(function()
    while true do
        if LookingForContracts then
            for k, v in pairs(LookingForContracts) do
                if currentContracts[k] then
                    if #currentContracts[k] < 1 then
                        print(json.encode(currentContracts[k]))
                        local ContractChance = math.random()

                        if v.skipped >= 15 or ContractChance < 0.80 then -- 80% chance of getting a contract
                            generateContract(v.src)
                        else
                            v.skipped += 1
                        end
                    end
                end
            end
        end
        Wait(5 * 1000) -- Once every minute
    end
end)

CreateThread(function()
    while true do
        if currentContracts then
            for k, v in pairs(currentContracts) do
                -- look for shit that has expired and delete them
            end
        end
        Wait(60*1000) -- Once a hour
    end
end)