local QBCore = exports['qb-core']:GetCoreObject()

local function AddItems(stash, Items)
    local items = {}

    for k, v in pairs(Items) do
        local itemInfo = QBCore.Shared.Items[k:lower()]
        items[#items+1] = {
            name = itemInfo["name"],
            amount = tonumber(v),
            info = "",
            label = itemInfo["label"],
            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
            weight = itemInfo["weight"],
            type = itemInfo["type"],
            unique = itemInfo["unique"],
            useable = itemInfo["useable"],
            image = itemInfo["image"],
            slot = #items+1,
        }
    end

    MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', {
        ['stash'] = stash,
        ['items'] = json.encode(items)
    })

end

local function HasStashItems(stashId)
	local result = MySQL.Sync.fetchScalar('SELECT items FROM stashitems WHERE stash = ?', {stashId})
	if not result then return end
    local stashItems = json.decode(result)
    if not stashItems then return end

    return true, #stashItems
end

QBCore.Functions.CreateCallback('jl-laptop:server:BuyBennyShit', function(source, cb, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Saved = data
    local Shop = {
        totalBank = 0,
        totalGNE = 0,
        totalCrypto = 0,
        items = {}
    }
    if Saved then
        for _, v in pairs(Saved) do
            Shop.items[Config.Bennys.Items[v.name].name] = v.quantity
            if Config.Bennys.Items[v.name].type == "bank" then
                Shop.totalBank = Shop.totalBank + (Config.Bennys.Items[v.name].price * v.quantity)
            elseif Config.Bennys.Items[v.name].type == "crypto" then
                Shop.totalCrypto = Shop.totalCrypto + (Config.Bennys.Items[v.name].price * v.quantity)
            else
                Shop.totalGNE = Shop.totalGNE + (Config.Bennys.Items[v.name].price * v.quantity)
            end
        end

        print(json.encode(Saved))
        local hasItem, amount = HasStashItems("BennyShop_"..Player.PlayerData.citizenid)
        if hasItem and amount > 0 then return cb("full") end
        local checks = 0
        local bank = false
        local crypto = false
        if Shop.totalBank > 0 then
            checks = checks + 1
            if Player.PlayerData.money.bank >= Shop.totalBank then
                checks = checks - 1
                bank = true
            else
                return cb("bank")
            end
        end

        if Shop.totalCrypto > 0 then
            checks = checks + 1
            if Player.PlayerData.money.crypto >= Shop.totalCrypto then
                checks = checks - 1
                crypto = true
            else
                return cb("crypto")
            end
        end

        if checks == 0 then
            if bank then Player.Functions.RemoveMoney("bank", Shop.totalBank) end
            if crypto then Player.Functions.RemoveMoney("crypto", Shop.totalCrypto) end
            AddItems("BennyShop_"..Player.PlayerData.citizenid, Shop.items)
            cb("done")
        end
    end
end)