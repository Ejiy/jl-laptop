local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('jl-laptop:server:crateOpened', function(crateID)
    local _s = source
    QBCore.Functions.GetPlayer(_s).Functions.RemoveItem('drill', 1)
    crates[crateID].isOpened = true
    TriggerClientEvent('jl-laptop:client:updateCrates', -1, crates)
end)

QBCore.Functions.CreateCallback('jl-laptop:server:getCrateStatus', function(source, cb, crateNetID, crateentity)
    crates[crateNetID].isOpened = false

    local data = {
        isOpened = crates[crateNetID].isOpened,
        crateID = crates[crateNetID].id,
        crate = crateentity
    }
    cb(data)
end)

QBCore.Functions.CreateCallback('jl-laptop:server:getAllCrates', function(source, cb)
    cb(crates)
end)
