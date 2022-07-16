RegisterNUICallback('bennys/checkout', function(data, cb)

    TriggerServerEvent('jl-laptop:server:BuyShit', data["cart"])
end)