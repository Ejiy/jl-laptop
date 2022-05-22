local QBCore = exports['qb-core']:GetCoreObject()
local display = false
local PlayerData = {}
local onDuty = false


---- ** Globalized Varaibles if we need them other parts of the client ** ----
CurrentCops = 0





local function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "toggle",
        status = bool
    })
end

local function GetApps()
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

CreateThread(function()
    while display do
        Wait(0)
        DisableAllControlActions()
    end
end)



---- ** Globalized functions if we need them other parts of the client ** ----

-- A generic function that checks if a player has a item client side, good for faster queries for non damaging events
function haveItem(item) -- Trigger this like if haveItem("bread") then whatever end
    local hasItem = false

    for _, v in pairs(PlayerData.items) do
        if v.name == item then
            hasItem = true
            break
        end
    end

    return hasItem
end

function isPolice()
    local isPolice = false

    local job = PlayerData.job.name
    for i = 1, #Config.PoliceJobs do
        if job == Config.PoliceJobs[i] then -- and onDuty didnt add this cuz testing
            isPolice = true
            break
        end
    end

    return isPolice
end





-- Handles state right when the player selects their character and location.
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

-- Resets state on logout, in case of character change.
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = nil
end)

-- Handles state when PlayerData is changed. We're just looking for inventory updates.
RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

-- Everytime a cop goes on or off duty the cop count is updated.
RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

-- Handles state if resource is restarted live.
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        if LocalPlayer.state.isLoggedIn then
            PlayerData = QBCore.Functions.GetPlayerData()
        end
    end
end)