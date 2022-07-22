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
    if QBCore then
        for k, v in pairs(QBCore.Shared.Vehicles) do
            if v['tier'] and cars[v['tier']] then
                cars[v['tier']][#cars[v['tier']]+1] = k
            end
        end
    else
        Wait(20000)
        for k, v in pairs(QBCore.Shared.Vehicles) do
            if v['tier'] and cars[v['tier']] then
                cars[v['tier']][#cars[v['tier']]+1] = k
            end
        end
    end
end)

local currentRuns = {}
local ActivePlates = {} -- Handle all the active plates and syncs all the data shit
local currentContracts = {}
local LookingForContracts = {}










-- ** EVERYTHING TO DO WITH DROP OFFS AND VINSCRATCH ** --
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

RegisterNetEvent('jl-laptop:server:FinalDestination', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid
    if currentRuns[CID] and not currentRuns[CID].dropOff and currentRuns[CID].type == "boosting" then
        local place, id = GetRandomDropOff()

        TriggerClientEvent('jl-laptop:client:ReturnCar', src, place)
        ResetAnotherShit(id)
    elseif currentRuns[CID] and not currentRuns[CID].dropOff and currentRuns[CID].type == "vinscratch" then

    end
end)












-- EVERYTHING TO DO WITH STARTING THE BOOST --

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
    local carModel = currentRuns[CID].car:lower()
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

local function ResetShit(Tier, location)
    SetTimeout(5 * 60000, function()
        Config.Boosting.Locations[Tier][location].isBusy = false
    end)
end

RegisterNetEvent('jl-laptop:server:StartBoosting', function(id, cops)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid

    if currentRuns[CID] then return end
    if not currentContracts[CID][id] then return end

    local amount = 0
    if cops == Config.Boosting.MinCops then
        amount = 1
    elseif cops > Config.Boosting.MinCops then
        amount = math.floor(cops / Config.Boosting.MinCops)
    end


    if not exports['qb-phone']:RemoveCrypto(src, "gne", currentContracts[CID][id].cost) then return end

    if amount < 1 then return end
    local location, place = GerRandomLocation(currentContracts[CID][id].contract)
    if location then
        currentRuns[CID] = {
            Location = location,
            type = currentContracts[CID][id].type,
            car = currentContracts[CID][id].car,
            contract = currentContracts[CID][id].contract,
            cost = currentContracts[CID][id].cost,
            dropOff = nil,
            Plate = nil,
            NetID = nil,
            PedSpawned = false,
        }
        MaxPools[currentContracts[CID][id].contract] += 1
        ResetShit(currentContracts[CID][id].contract, place)
        table.remove(currentContracts[CID], id) -- has to be table.remove for some dumb ass reason
        TriggerClientEvent('jl-laptop:client:ContractHandler', src, currentContracts[CID])
        SpawnCar(src)
    end
end)

QBCore.Functions.CreateCallback('lj-laptop:server:CanStartBoosting', function(source, cb, cops, id)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid

    if currentRuns[CID] then return cb("running") end
    if not currentContracts[CID][id] then return cb("notfound") end
    if not exports['qb-phone']:hasEnough(src, "gne", currentContracts[CID][id].cost) then return cb("notenough") end
    local amount = 0
    if cops == Config.Boosting.MinCops then
        amount = 1
    elseif cops > Config.Boosting.MinCops then
        amount = math.floor(cops / Config.Boosting.MinCops)
    end

    if amount < 1 or #currentRuns >= amount then
        cb("cops")
    else
        cb("success")
    end
end)









-- EVERYTHING TO DO WITH PEDS SPAWNING --
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










-- EVERYTHING TO DO WITH BLIPS SYNCING --
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
        if Config.Boosting.Debug then
            ActivePlates[plate] = 0
        else
            ActivePlates[plate] = ActivePlates[plate] - 1
        end
        TriggerClientEvent('jl-laptop:client:SyncPlates', -1, ActivePlates)
    end
end)







----- ** EVERYTHING TO DO QUEUE ** -----

QBCore.Functions.CreateCallback('jl-laptop:server:joinQueue', function(source, cb, status)
    print(status)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return cb("error") end
    if not HasAppAccess(src, "boosting") then return cb("error") end
    local CID = Player.PlayerData.citizenid
    if status then
        if LookingForContracts[CID] and LookingForContracts[CID].active and LookingForContracts[CID].online and LookingForContracts[CID].src == src then return cb("inqueue") end
        if currentRuns[CID] then return cb("running") end
        if not LookingForContracts[CID] then LookingForContracts[CID] = {} end
        if not currentContracts[CID] then currentContracts[CID] = {} end
        if LookingForContracts[CID] and LookingForContracts[CID].skipped then
            LookingForContracts[CID] = {
                src = src,
                skipped = LookingForContracts[CID].skipped,
                online = true,
                active = true
            }
        else
            LookingForContracts[CID] = {
                src = src,
                online = true,
                skipped = 0,
                active = true
            }
        end
        cb("success")
    else
        if not LookingForContracts[CID] then return cb("error") end
        LookingForContracts[CID].active = false
        LookingForContracts[CID].online = true
        cb("success")
    end

    if LookingForContracts[CID].online then
        TriggerClientEvent('jl-laptop:client:QueueHandler', src, LookingForContracts[CID].active)
    end
end)


RegisterNetEvent('jl-laptop:server:QuitQueue', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local CID = Player.PlayerData.citizenid
    if not LookingForContracts[CID] or not LookingForContracts[CID].skipped then return end
    LookingForContracts[CID].active = false

    if LookingForContracts[CID].online then
        TriggerClientEvent('jl-laptop:client:QueueHandler', src, LookingForContracts[CID].active)
    end
end)















-- ** EVERYTHING TO DO WITH REWARDS ** --

RegisterNetEvent('jl-laptop:server:finishBoost', function(netId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CID = Player.PlayerData.citizenid

    if not currentRuns[CID] then return end
    if not (currentRuns[CID].NetID == netId) then return end

    local boostData = Player.PlayerData.metadata["carboostrep"] or 0
    boostData += math.random(Config.Boosting.MetaReward[currentRuns[CID].contract].min , Config.Boosting.MetaReward[currentRuns[CID].contract].max)
    Player.Functions.SetMetaData('carboostrep', boostData)

    if currentRuns[CID].cost == 0 then
        currentRuns[CID].cost = math.random(1,2) -- makes it so they can actually get GNE when the boost is Free
    end

    exports['qb-phone']:AddCrypto(src, "gne", math.ceil(currentRuns[CID].cost * math.random(2,3)))


    if DoesEntityExist(NetworkGetEntityFromNetworkId(currentRuns[CID].NetID)) then
        DeleteEntity(NetworkGetEntityFromNetworkId(currentRuns[CID].NetID))
    end
    currentRuns[CID] = nil
    TriggerClientEvent('jl-laptop:client:finishContract', src, currentContracts[CID])
end)







-- ** EVERYTHING TO DO WITH CANCELLING ** --
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
    TriggerClientEvent('jl-laptop:client:finishContract', src, currentContracts[CID])
    TriggerClientEvent('QBCore:Notify', src, "You failed to deliver the vehicle and contract has been terminated.", "error")
end)









-- ** CONTRACTS ** --
RegisterNetEvent('jl-laptop:server:DeclineBoost', function(contract)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local CID = Player.PlayerData.citizenid
    if not currentContracts[CID] then return end
    if not currentContracts[CID][contract] then return end

    MaxPools[currentContracts[CID][contract].contract] += 1
    table.remove(currentContracts[CID], contract)
end)

QBCore.Functions.CreateCallback('jl-laptop:server:DeclineContract', function(source, cb, contract)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return cb("error") end

    if not contract then return cb("error") end
    local CID = Player.PlayerData.citizenid
    if not currentContracts[CID] then return cb("error") end
    if not currentContracts[CID][contract] then return cb("error") end

    MaxPools[currentContracts[CID][contract].contract] += 1
    table.remove(currentContracts[CID], contract)
    cb("success")
end)






-- ** TRANSFER BOOSTS ** --

QBCore.Functions.CreateCallback('jl-laptop:server:TransferContracts', function(source, cb, playerID, contractID)
    local src = source

    if src == tonumber(playerID) then return cb("self") end

    if not HasAppAccess(src, "boosting") then return cb("error") end

    if not playerID or not contractID then return cb("notfound") end

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return cb("error") end

    local CID = Player.PlayerData.citizenid
    local Contract = currentContracts[CID][contractID]
    if not Contract then return cb("error") end

    local Reciever = QBCore.Functions.GetPlayer(tonumber(playerID))
    if not Reciever then return cb("notfound") end
    local RecieveCID = Reciever.PlayerData.citizenid
    print(RecieveCID, Reciever.PlayerData.source)
    if not currentContracts[RecieveCID] then currentContracts[RecieveCID] = {} end
    if #currentContracts[RecieveCID]+1 > Config.Boosting.MaxBoosts then return cb("full") end

    -- refreshes the contracts for the source --
    table.remove(currentContracts[CID], contractID) -- has to be table.remove for some dumb ass reason
    TriggerClientEvent('jl-laptop:client:ContractHandler', src, currentContracts[CID])
    -- refreshes the contracts for the reciever --
    currentContracts[RecieveCID][#currentContracts[RecieveCID]+1] = Contract
    TriggerClientEvent('jl-laptop:client:ContractHandler', Reciever.PlayerData.source, currentContracts[RecieveCID])
    cb("success")
end)








QBCore.Functions.CreateCallback('jl-laptop:server:GetContracts', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local CID = Player.PlayerData.citizenid
    if not currentContracts[CID] then currentContracts[CID] = {} end

    cb(currentContracts[CID], ActivePlates)
end)



-- ** Hacking Cars ** --
local Cooldowns = {}

local function removeCooldown(plate)
    SetTimeout(Config.Boosting.HackDelay * 1000, function()
        Cooldowns[plate] = false
    end)
end

QBCore.Functions.CreateCallback('jl-laptop:server:CanHackCar', function(source, cb, plate)
    if ActivePlates and ActivePlates[plate] then
        if not Cooldowns then Cooldowns[plate] = false end

        if Cooldowns[plate] then
            cb(false)
        else
            Cooldowns[plate] = true
            if not Config.Boosting.Debug then removeCooldown(plate) else Cooldowns[plate] = false end
            cb(true)
        end
    else
        cb(false)
    end
end)

QBCore.Functions.CreateUseableItem(Config.Boosting.HackingDevice, function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(Config.Boosting.HackingDevice) ~= nil then
        TriggerClientEvent('jl-laptop:client:HackCar', source)
    end
end)









-- ** EVERYTHING TO DO WITH GENERATING CONTRACTS ** --

local function generateTier(src)
    local chance = math.random(1,100)
    local Player = QBCore.Functions.GetPlayer(src)
    local boostData = Player.PlayerData.metadata["carboostrep"] or 0
    local tier

    -- We should also get their current metadata and based on their metadata increase this luck or even cap it so they cant get s+ if they just startedt/
    if chance >= 99 then -- 2%
        if boostData >= Config.Boosting.TiersPerRep["S"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "S+"
        else
            generateTier(src)
        end
    elseif chance >= 95 then -- 3%
        if boostData >= Config.Boosting.TiersPerRep["A+"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "S"
        else
            generateTier(src)
        end

    elseif chance >= 90 then -- 5%
        if boostData >= Config.Boosting.TiersPerRep["A"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "A+"
        else
            generateTier(src)
        end

    elseif chance >= 80 then -- 10%
        if boostData >= Config.Boosting.TiersPerRep["B"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "A"
        else
            generateTier(src)
        end

    elseif chance >= 60 then -- 20%
        if boostData >= Config.Boosting.TiersPerRep["C"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "B"
        else
            generateTier(src)
        end
    elseif chance >= 35 then -- 25%
        if boostData >= Config.Boosting.TiersPerRep["D"] then -- You can jump 1 tier above the current tier you are at so someone at D can't get a S+ Contract
            tier = "C"
        else
            generateTier(src)
        end
    else -- 35%
        tier = "D"
    end

    Wait(0)

    if not tier then return generateTier(src) end

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

local function missionType(Player, tier)
    local boostData = Player.PlayerData.metadata["carboostrep"] or 0
    if tier == "D" or tier == "C" or tier == "B" or tier == "A" then return "boosting" end -- Only A+, S and S+ Can be vinscratched

    if boostData >= Config.Boosting.TiersPerRep[tier] then
        if math.random() <= 0.05 then
            return "vinscratch"
        end
    else
        return "boosting"
    end
end

function GetHoursFromNow(hours)
    local time = os.date("%c", os.time() + hours * 60 * 60)
    return time
end

local function generateName()
    return Config.Boosting.RandomNames[math.random(1, #Config.Boosting.RandomNames)]
end

local function calcPrice(tier, type)
    if not tier or not type then return end
    local price = math.random(Config.Boosting.Price[tier].min, Config.Boosting.Price[tier].max)
    if type == "boosting" then price = price else price = price * math.random(2,5) end
    print(price)
    return price
end

local function generateContract(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local CID = Player.PlayerData.citizenid
    if not currentContracts[CID] then currentContracts[CID] = {} end

    local contract = generateTier(src)
    local vehicle = generateCar(contract)
    local mission = missionType(Player, contract)
    if contract and vehicle and mission then
        currentContracts[CID][#currentContracts[CID]+1] = {
            id = #currentContracts[CID]+1,
            contract = contract,
            car = vehicle,
            carName = QBCore.Shared.Vehicles[vehicle]["name"],
            expire = GetHoursFromNow(6),
            owner = generateName(),
            type = mission,
            cost = calcPrice(contract, mission),
        }
        LookingForContracts[CID].skipped = 0
        TriggerClientEvent('jl-laptop:client:ContractHandler', src, currentContracts[CID])
    else
        LookingForContracts[CID].skipped += 1
    end
end














-- QUEUE LOOP --
CreateThread(function()
    while true do
        if LookingForContracts then
            for k, v in pairs(LookingForContracts) do
                if currentContracts[k] then
                    if #currentContracts[k] < Config.Boosting.MaxBoosts and v.active then
                        local ContractChance = math.random()
                        if v.skipped >= 25 or (v.skipped >= 2 and ContractChance >= 0.85) then -- 15% chance of getting a contract
                            generateContract(v.src)
                        else
                            v.skipped += 1
                        end
                    elseif #currentContracts[k] >= Config.Boosting.MaxBoosts then
                        v.active = false
                        if v.online then
                            TriggerClientEvent('jl-laptop:client:QueueHandler', v.src, false)
                        end
                    end
                end
            end
        end
        Wait(2 * 100) -- Once every 2 minutes
    end
end)


-- Player dropped functions --
local function GetCID(src)
    if LookingForContracts then
        for k, v in pairs(LookingForContracts) do
            if v.src == src then
                return k
            end
        end
    end
end

AddEventHandler('playerDropped', function(reason)
	local src = source
    local CID = GetCID(src)
    if not CID then return end
    LookingForContracts[CID].active = false
    LookingForContracts[CID].online = false

    if currentRuns[CID] then
        currentRuns[CID] = nil
    end
end)

