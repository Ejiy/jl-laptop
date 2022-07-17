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
end

function HasAppAccess(src, app)
    if not app or not src then return false end

    local v = Config.Apps[app]

    if not v then return false end

    if v.default then return true end

    local PlayerData = QBCore.Functions.GetPlayer(src).PlayerData

    if not PlayerData then return false end

    local playerJob, playerGang = PlayerData.job.name, PlayerData.gang.name
    local searches = 0
    if (#v.job > #v.gang and #v.job > #v.bannedJobs) then
        searches = #v.job
    elseif (#v.gang > #v.bannedJobs) then
        searches = #v.gang
    else
        searches = #v.bannedJobs
    end
    for i = 1, #v.item do
        if haveItem(PlayerData.items, v.item[i]) or not v.item[i] then
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
    print(app)
    if app == "boosting" then
        TriggerEvent("jl-laptop:server:QuitQueue", src)
    end
end)