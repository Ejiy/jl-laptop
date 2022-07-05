local QBCore = exports['qb-core']:GetCoreObject()

-- QBCore.Functions.CreateUseableItem('laptop')

QBCore.Functions.CreateUseableItem('slothylaptop', function(source, item)
    local src = source
    TriggerClientEvent('ps-laptop:client:openlaptop', src)
end)


