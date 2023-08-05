local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateUseableItem(Config.LaptopDevice, function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(Config.LaptopDevice) then
        TriggerClientEvent('jl-laptop:client:openlaptop', source)
    end
end)

local function haveItem(items, item)
    if not items or not item then return false end

    for _, v in pairs(items) do
        if v.name == item then
            return true
        end
    end

    return false
end

function HasAppAccess(src, app)
    if not app or not src then return false end

    local v = Config.Apps[app]

    if not v then return false end

    local PlayerData = QBCore.Functions.GetPlayer(src).PlayerData

    if not PlayerData then return false end

    if not haveItem(PlayerData.items, Config.LaptopDevice) then return false end

    if v.default then return true end

    local playerJob, playerGang = PlayerData.job.name, PlayerData.gang.name
    local searches = 0
    if (#v.job > #v.gang and #v.job > #v.bannedJobs) then
        searches = #v.job
    elseif (#v.gang > #v.bannedJobs) then
        searches = #v.gang
    else
        searches = #v.bannedJobs
    end
    local count = #v.item
    if count == 0 then count = 1 end
    for i = 1, count do
        if not v.item[i] or haveItem(PlayerData.items, v.item[i]) then
            if searches > 0 then
                for k = 1, searches do
                    if v.bannedJobs[k] == playerJob then
                        return false
                    elseif (v.job[k] and v.job[k] == playerJob) or (v.gang[k] and v.gang[k] == playerGang) then
                        return true
                    elseif (not v.job[k] and not v.gang[k]) then
                        return true
                    else
                        return false
                    end
                end
            else
                return true
            end
        else
            return false
        end
    end
end

RegisterNetEvent('jl-laptop:server:LostAccess', function(app)
    local src = source
    if app == "boosting" then
        TriggerEvent("jl-laptop:server:QuitQueue", src)
    end
end)


RegisterNetEvent('jl-laptop:server:settings:set', function(setting)
    local src = source
    if not setting then return end
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    if not HasAppAccess(src, "setting") then return end
    Player.Functions.SetMetaData("laptop", setting)
end)

RegisterNetEvent('jl-laptop:server:RemoveItem', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player and item then
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "remove")
        Player.Functions.RemoveItem(item, 1)
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    lib.versionCheck('Ejiy/jl-laptop')
end)
