local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateUseableItem(Config.LaptopDevice, function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(Config.LaptopDevice) ~= nil then
        TriggerClientEvent('jl-laptop:client:openlaptop', source)
    end
end)
