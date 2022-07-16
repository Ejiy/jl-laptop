local QBCore = exports['qb-core']:GetCoreObject()

RegisterNUICallback('bennys/checkout', function(data, cb)
    local newData = data["cart"]
    QBCore.Functions.TriggerCallback('jl-laptop:server:BuyBennyShit', function(result)
        if result == "bank" then
            cb({
                status = 'error',
                message = "You do not have enough money in your bank account!!"
            })
        elseif result == "full" then
            cb({
                status = 'error',
                message = "You have unclaimed items at the Warehouse already!"
            })
        elseif result == "crypto" then
            cb({
                status = 'error',
                message = "You do not have enough crypto!"
            })
        elseif result == "done" then
            cb({
                status = 'success',
                message = "You can now pickup the items at the warehouse"
            })
        end
    end, newData)
end)

local function openStash()
    local CID = QBCore.Functions.GetPlayerData().citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash","BennyShop_"..CID, {
        maxweight = 100000,
        slots = 25,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "BennyShop_"..CID)
end

local ped = nil
local blip = nil
CreateThread(function()

    local v = Config.Bennys.Location

    RequestModel(v.ped)

    while not HasModelLoaded(v.ped) do
        Wait(0)
    end

    ped = CreatePed(0, v.ped, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
    PlaceObjectOnGroundProperly(ped)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports['qb-target']:AddTargetEntity(ped, {
        options = {
            {
                label = "View Warehouse Stock",
                icon = "fa-solid fa-warehouse",
                action = function()
                    openStash()
                end,
            }
        },
        distance = 2.0
    })


    blip = AddBlipForCoord(v["coords"].x, v["coords"].y, v["coords"].z)
    SetBlipSprite(blip, v.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, v.colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(v.text)
    EndTextCommandSetBlipName(blip)

end)