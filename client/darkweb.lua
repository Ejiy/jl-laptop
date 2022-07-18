local QBCore = exports['qb-core']:GetCoreObject()

RegisterNUICallback('darkweb/items', function(_, cb)
    local translated = {}
    for _, v in pairs(Config.DarkWeb.Items) do
        translated[#translated + 1] = {
            name = v.name,
            label = QBCore.Shared.Items[v.name].label,
            image = Config.Inventory .. "/html/images/" .. QBCore.Shared.Items[v.name].image,
            price = v.price,
            stock = v.stock,
            category = v.category,
        }
    end
    cb(translated)
end)
