local QBCore = exports['qb-core']:GetCoreObject()

RegisterNUICallback('bennys/getitems', function(_, cb)
    local translated = {}
    for _, v in pairs(Config.Bennys.Items) do

        translated[#translated + 1] = {
            name = v.name,
            label = QBCore.Shared.Items[v.name].label,
            image = Config.Inventory .. "/html/images/" .. QBCore.Shared.Items[v.name].image,
            price = v.price,
            stock = v.stock,
            category = v.category,
        }
    end
    print(json.encode(translated))
    cb(translated)
end)

local function openStash()
    local CID = QBCore.Functions.GetPlayerData().citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "BennyShop_" .. CID, {
        maxweight = 100000,
        slots = 25,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "BennyShop_" .. CID)
end

local ped = nil
local blip = nil
CreateThread(function()

    local v = Config.Bennys.Location

    RequestModel(v.ped)

    while not HasModelLoaded(v.ped) do
        Wait(0)
    end

    ped = CreatePed(0, joaat(v.ped), v.coords.x, v.coords.y, v.coords.z - 1, v.coords.w, false, false)
    TaskStartScenarioInPlace(ped, v.scenario, 0, true)
    PlaceObjectOnGroundProperly(ped)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports['qb-target']:AddTargetEntity(ped, {
        options = {
            {
                label = Lang:t('bennys.warehouse'),
                icon = "fa-solid fa-warehouse",
                action = function()
                    openStash()
                end,
            }
        },
        distance = 2.0
    })


    blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
    SetBlipSprite(blip, v.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, v.colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(v.text)
    EndTextCommandSetBlipName(blip)
end)
