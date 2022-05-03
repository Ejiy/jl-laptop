local QBCore = exports['qb-core']:GetCoreObject()

-- QBCore.Functions.CreateUseableItem('laptop')

QBCore.Functions.CreateUseableItem('laptop' , function(source, item)
    local src = source
    TriggerClientEvent('tnj-laptop:client:openlaptop', src)
end)