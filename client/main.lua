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


RegisterNetEvent('tnj-laptop:client:openlaptop', function ()
    SetDisplay(true)
end)

RegisterNUICallback('close', function ()
    SetDisplay(false)
end)

RegisterNUICallback('loadapps', function(data, cb)
    
end)