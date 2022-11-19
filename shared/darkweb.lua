Config.DarkWeb = {}

Config.DarkWeb.Police = 2 -- Maybe we need this? just remove it if we don't need it Zoo

Config.DarkWeb.CrateBlip = true -- Shows a radius around the dark web crate

Config.DarkWeb.CrateSpawn = {
    [1] = {
        coords = vector3(1546.62, 3821.22, 30.94),
        isbusy = false
    },
    [2] = {
        coords = vector3(2126.4, 3345.57, 45.64),
        isbusy = false
    },
    [3] = {
        coords = vector3(2149.96, 2246.62, 107.37),
        isbusy = false
    }
}

-- NAME = Spawn code how you spawn in the item
-- PRICE = How much it costs to buy the item
-- stock = How many items there's available a restart
-- Category = hacking, guns, or drugs (CASE SENSITIVE)
Config.DarkWeb.Items = {
    ["laptop"] = {
        name = "laptop",
        price = 100,
        stock = 100,
        category = "hacking",
    }
}
