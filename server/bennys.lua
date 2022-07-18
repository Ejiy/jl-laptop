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
