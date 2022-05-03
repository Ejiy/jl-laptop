local QBCore = exports['qb-core']:GetCoreObject()
local display = false

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "open",
        status = bool
    })
end


RegisterNetEvent('tnj-laptop:client:openlaptop', function ()
    SetDisplay(true)
end)

RegisterNUICallback('close', function ()
    SetDisplay(false)
end)

RegisterNUICallback('loadapps', function(data, cb)
    
end)