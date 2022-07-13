local QBCore = exports['qb-core']:GetCoreObject()
local display = false
PlayerData = {}
local onDuty = false

-- **  LOCALIZED FUNCTIONS WE USE ONLY IN THIS FILE

-- A function which returns the applications that the player should have access to.
local function GetPlayerAppPerms()
    local apps = {}
    local playerJob, playerGang = PlayerData.job.name, PlayerData.gang.name
    local searches = 0
    for _, app in pairs(Config.Apps) do
        local converted = {
            name = app.app,
            icon = app.icon,
            text = app.name,
            color = app.color,
            background = app.background,
            useimage = app.useimage
        }

        if app.default then
            apps[#apps + 1] = converted
            goto skip
        end

        if (#app.job > #app.gang and #app.job > #app.bannedJobs) then
            searches = #app.job
        elseif (#app.gang > #app.bannedJobs) then
            searches = #app.gang
        else
            searches = #app.bannedJobs
        end

        for i = 1, #app.item do
            if haveItem(app.item[i]) then
                if searches > 0 then
                    for k = 1, searches do
                        if app.bannedJobs[k] == playerJob then
                            goto skip
                        elseif (app.job[k] and app.job[k] == playerJob) or (app.gang[k] and app.gang[k] == playerGang) then
                            apps[#apps + 1] = converted
                            goto skip
                        else
                            apps[#apps + 1] = converted
                            goto skip
                        end
                    end
                else
                    apps[#apps + 1] = converted
                    goto skip
                end
            end
        end
        ::skip::
    end

    return apps
end

---- Animation for opening the laptop ----
local function Animation()

    local tabletDict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
    local tabletAnim = "base"
    local tabletProp = 'prop_cs_tablet'
    local tabletBone = 60309
    local tabletOffset = vector3(0.03, 0.002, -0.0)
    local tabletRot = vector3(10.0, 160.0, 0.0)

    if not display then return end
    -- Animation
    if not HasAnimDictLoaded(tabletDict) then
        RequestAnimDict(tabletDict)
        while not HasAnimDictLoaded(tabletDict) do Citizen.Wait(100) end
    end

    -- Model
    if not HasModelLoaded(tabletProp) then
        RequestModel(tabletProp)
        while not HasModelLoaded(tabletProp) do Citizen.Wait(100) end
    end

    local plyPed = PlayerPedId()

    local tabletObj = CreateObject(tabletProp, 0.0, 0.0, 0.0, true, true, false)

    local tabletBoneIndex = GetPedBoneIndex(plyPed, tabletBone)

    AttachEntityToEntity(tabletObj, plyPed, tabletBoneIndex, tabletOffset.x, tabletOffset.y, tabletOffset.z, tabletRot.x
        , tabletRot.y, tabletRot.z, true, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(tabletProp)

    CreateThread(function()
        while display do
            Wait(0)
            if not IsEntityPlayingAnim(plyPed, tabletDict, tabletAnim, 3) then
                TaskPlayAnim(plyPed, tabletDict, tabletAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end
        ClearPedSecondaryTask(plyPed)
        Wait(250)
        DetachEntity(tabletObj, true, false)
        DeleteEntity(tabletObj)
    end)
end

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

    Animation()
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

RegisterNetEvent('jl-laptop:client:openlaptop', function()
    if haveItem(Config.LaptopDevice) then
        SetDisplay(true)
    end
end)

RegisterNUICallback('close', function(_, cb)
    SetDisplay(false)
    cb("ok")
end)

RegisterNUICallback('loadapps', function(data, cb)

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
