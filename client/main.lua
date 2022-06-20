local QBCore = exports['qb-core']:GetCoreObject()
local display = false
local PlayerData = {}
local onDuty = false


---- ** Globalized Varaibles if we need them other parts of the client ** ----
CurrentCops = 0





local function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    print(display)
    SendNUIMessage({
        action = "toggle",
        status = bool,
    })
end

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

-- A function which returns the applications that the player should have access to.
function GetPlayerAppPerms()
    local apps = {}
    local playerJob, playerGang = PlayerData.job.name, PlayerData.gang.name
    for _, app in pairs(Config.Apps) do
        local hasAccess = false
        local converted = {
            name = app.app,
            icon = app.icon,
            text = app.name,
            color = app.color,
            background = app.background,
            useimage = app.useimage
        }
        if app.default and not hasAccess then
            apps[#apps + 1] = converted
            hasAccess = true
        end
        if app.job then
            if type(app.job) == 'table' then
                for i = 1, #app.job do
                    if app.job[i] == playerJob then
                        apps[#apps + 1] = converted
                        hasAccess = true
                    end
                end
            else
                if app.job == playerJob then
                    apps[#apps + 1] = converted
                    hasAccess = true
                end
            end
        end
        if app.gang and not hasAccess then
            if type(app.gang) == 'table' then
                for i = 1, #app.gang do
                    if app.gang[i] == playerGang then
                        apps[#apps + 1] = converted
                        hasAccess = true
                    end
                end
            else
                if app.gang == playerGang then
                    apps[#apps + 1] = converted
                    hasAccess = true
                end
            end
        end
        if app.item and not hasAccess then
            if type(app.item) == 'table' then
                for i = 1, #app.item do
                    if haveItem(app.item[i]) then
                        apps[#apps + 1] = converted
                        hasAccess = true
                    end
                end
            else
                if haveItem(app.item) then
                    apps[#apps + 1] = converted
                    hasAccess = true
                end
            end
        end
    end
    return apps
end

RegisterCommand('openlaptop', function()
    SetDisplay(not display)
end)

RegisterNetEvent('ps-laptop:client:openlaptop', function()
    SetDisplay(true)
end)

RegisterNUICallback('close', function(_, cb)
    print("TRIGGERED")
    SetDisplay(false)
    cb("ok")
end)

RegisterNUICallback('loadapps', function(data, cb)

end)




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

-- NUI Callback
RegisterNUICallback('getapp', function(_, cb)
    return cb(GetPlayerAppPerms())
end)

-- Handles state if resource is restarted live.
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        if LocalPlayer.state.isLoggedIn then
            PlayerData = QBCore.Functions.GetPlayerData()
        end
    end
end)

function CalculateTimeToDisplay()
    local hour = GetClockHours()
    local minute = GetClockMinutes()

    local data = {}

    data.hour = hour
    data.minute = minute

    return data
end

CreateThread(function()
    while true do
        if display then
            SendNUIMessage({
                action = "time",
                time = CalculateTimeToDisplay()
            })
        end
        Wait(1000)
    end
end)
