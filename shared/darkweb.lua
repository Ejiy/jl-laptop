Config.DarkWeb = {}

Config.DarkWeb.Police = 2 -- Maybe we need this? just remove it if we don't need it Zoo

Config.DarkWeb.CrateSpawn = vector3(1173.82, -3335.0, 5.8) -- This is where the bennys ped is at [needs changing/more locations]

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
