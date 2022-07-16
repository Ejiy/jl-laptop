local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('jl-laptop:server:BuyShit', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Saved = data
    local Shop = {
        totalBank = 0,
        totalGNE = 0,
        totalCrypto = 0,
        items = {}
    }
    if Saved then
        for _, v in pairs(Saved) do
            Shop.items[v.name] = v.quantity
            if Config.Bennys.Items[v.name].type == "bank" then
                Shop.totalBank = Shop.totalBank + (Config.Bennys.Items[v.name].price * v.quantity)
            elseif Config.Bennys.Items[v.name].type == "crypto" then
                Shop.totalCrypto = Shop.totalCrypto + (Config.Bennys.Items[v.name].price * v.quantity)
            else
                Shop.totalGNE = Shop.totalGNE + (Config.Bennys.Items[v.name].price * v.quantity)
            end
        end

        if Player.PlayerData.money.bank and Player.PlayerData.money.crypto then
            if Player.PlayerData.money.bank >= Shop.totalBank and Player.PlayerData.money.crypto >= Shop.totalCrypto then
                for k, v in pairs(Shop.items) do
                    -- just doing this for now --
                    Player.Functions.AddItem(k, v)
                end
            end
        end
    end
end)