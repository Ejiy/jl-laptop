local QBCore = exports['qb-core']:GetCoreObject()
local crates = {}

local function openCrate(crate)
    local crateID = NetworkGetNetworkIdFromEntity(crate)
    QBCore.Functions.TriggerCallback('jl-laptop:server:getCrateStatus', function(data)
        if data.isOpened then
            openCrate(data.crate)
        end
    end, crateID)

    local CID = QBCore.Functions.GetPlayerData().citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "DarkWebCrate_" .. crateID, {
        maxweight = 100000,
        slots = 25,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "DarkWebCrate_" .. crateID)
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
        if Config.Thermite == "memorygame" then
            exports["memorygame"]:thermiteminigame(10, 3, 3, 10, function()
                TriggerServerEvent('jl-laptop:server:crateOpened', NetworkGetNetworkIdFromEntity(entity))
            end,function()-- Time, Gridsize (5, 6, 7, 8, 9, 10), IncorrectBlocks
                QBCore.Functions.Notify("You don't have the appropriate tools")
            end)
        elseif Config.Thermite == "ps-ui" then
            exports['ps-ui']:Thermite(function(success)
                if success then
                    TriggerServerEvent('jl-laptop:server:crateOpened', NetworkGetNetworkIdFromEntity(entity))
                end
            end, 10, 3, 3) -- Time, Gridsize (5, 6, 7, 8, 9, 10), IncorrectBlocks
        else
            QBCore.Functions.Notify("You don't have the appropriate tools")
        end
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
                        label = "Break Open Crate",
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
                        label = "Open Crate",
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

    exports['qb-target']:AddTargetEntity(obj, {
        options = {
            {
                label = "Break Open Crate",
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
                label = "Open Crate",
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
