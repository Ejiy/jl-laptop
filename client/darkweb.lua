local QBCore = exports['qb-core']:GetCoreObject()
local crates = {}
local crateBlip = nil

local function openCrate(crate)
    local crateID = NetworkGetNetworkIdFromEntity(crate)
    QBCore.Functions.TriggerCallback('jl-laptop:server:getCrateStatus', function(data)
        if data.isOpened then
            openCrate(data.crate)
        else
            if GetResourceState("ox_inventory"):match("start") then
                exports.ox_inventory:openInventory('stash', 'DarkWebCrate_' .. data.crateID)
            else
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "DarkWebCrate_" .. data.crateID, {
                    maxweight = 100000,
                    slots = 25,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "DarkWebCrate_" .. data.crateID)
            end
        end
    end, crateID, crate)
end

RegisterNUICallback('darkweb/items', function(_, cb)
    local translated = {}
    for _, v in pairs(Config.DarkWeb.Items) do
        translated[#translated + 1] = {
            name = v.name,
            label = QBCore.Shared.Items[v.name].label,
            image = Config.Inventory .. "/html/images/" .. QBCore.Shared.Items[v.name].image,
            price = v.price,
            stock = v.stock,
            category = v.category,
        }
    end
    cb(translated)
end)

-- Prolly a better minigame for this and needs a drilling anim
local function breakCrate(entity)
    if haveItem('drill') then
        exports['ps-ui']:Thermite(function(success)
            if success then
                TriggerServerEvent('jl-laptop:server:crateOpened', NetworkGetNetworkIdFromEntity(entity))
                if crateBlip then RemoveBlip(crateBlip) end
            end
        end, 10, 3, 3) -- Time, Gridsize (5, 6, 7, 8, 9, 10), IncorrectBlocks
    else
        QBCore.Functions.Notify(Lang:t('darkweb.need_drill'))
    end
end

-- Creates the crates interactable for players who just joined
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('jl-laptop:server:getAllCrates', function(crateInfo)
        crates = crateInfo

        for netID, _ in pairs(crates) do
            local obj = NetworkGetEntityFromNetworkId(netID)
            exports['qb-target']:AddTargetEntity(obj, {
                options = {
                    {
                        label = Lang:t('darkweb.target.breakcrateopen'),
                        icon = "fas fa-box-open",
                        action = function(entity)
                            breakCrate(entity)
                        end,
                        canInteract = function(entity)
                            local netID = NetworkGetNetworkIdFromEntity(entity)
                            if crates[netID].isOpened then return false end
                            return true
                        end,
                    },
                    {
                        label = Lang:t('darkweb.target.opencrate'),
                        icon = "fas fa-box-open",
                        action = function(entity)
                            openCrate(entity)
                        end,
                        canInteract = function(entity)
                            local netID = NetworkGetNetworkIdFromEntity(entity)
                            if not crates[netID].isOpened then return false end
                            return true
                        end,
                    }
                },
                distance = 2.0
            })
        end
    end)
end)

RegisterNetEvent('darkweb:client:cratedrop', function(netID)
    local obj = NetworkGetEntityFromNetworkId(netID)
    PlaceObjectOnGroundProperly(obj)

    if PZone then
        PZone:destroy()
        PZone = nil
    end

    if crateBlip then RemoveBlip(crateBlip) end

    local crateCoords = GetEntityCoords(obj)

    if Config.Boosting.Debug then SetNewWaypoint(crateCoords.x, crateCoords.y) end

    if Config.DarkWeb.CrateBlip then
        crateBlip = AddBlipForRadius(crateCoords.x + math.random(-100, 100), crateCoords.y + math.random(-100, 100),
            crateCoords.z, 250.0)
        SetBlipAlpha(crateBlip, 150)
        SetBlipHighDetail(crateBlip, true)
        SetBlipColour(crateBlip, 1)
        SetBlipAsShortRange(crateBlip, true)
    end

    exports['qb-target']:AddTargetEntity(obj, {
        options = {
            {
                label = Lang:t('darkweb.target.breakcrateopen'),
                icon = "fas fa-box-open",
                action = function(entity)
                    breakCrate(entity)
                end,
                canInteract = function(entity)
                    local netID = NetworkGetNetworkIdFromEntity(entity)
                    if crates[netID].isOpened then return false end
                    return true
                end,
            },
            {
                label = Lang:t('darkweb.target.opencrate'),
                icon = "fas fa-box-open",
                action = function(entity)
                    openCrate(entity)
                end,
                canInteract = function(entity)
                    local netID = NetworkGetNetworkIdFromEntity(entity)
                    if not crates[netID].isOpened then return false end
                    return true
                end,
            }
        },
        distance = 2.0
    })
end)

-- Just so the client knows the info about the boxes
RegisterNetEvent('jl-laptop:client:updateCrates', function(crateInfo)
    crates = crateInfo
end)
