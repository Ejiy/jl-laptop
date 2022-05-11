local QBCore = exports['qb-core']:GetCoreObject()
local display = false

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "toggle",
        status = bool
    })
end

function GetApps()
    local apps = {}
    for i = 1, #Config.Apps, 1 do
        local app = Config.Apps[i]
        if app.items then
            if type(app.items) == "table" then
                
            end
        end
    end
end

RegisterCommand('openlaptop', function ()
    SetDisplay(not display)
end)

RegisterNetEvent('tnj-laptop:client:openlaptop', function ()
    SetDisplay(true)
end)

RegisterNUICallback('close', function ()
    print("TRIGGERED")
    SetDisplay(false)
end)

RegisterNUICallback('loadapps', function(data, cb)
    
end)

CreateThread(function ()
    while display do
        Wait(0)
        DisableAllControlActions()
    end
end)