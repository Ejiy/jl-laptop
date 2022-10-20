Config.Bennys = {}



Config.Bennys.Location = {
    ped = "s_m_y_airworker",
    coords = vector4(1183.37, -3322.16, 6.03, 95.27),
    sprite = 473,
    colour = 28,
    text = "Bennys Warehouse",
    scenario = "WORLD_HUMAN_CLIPBOARD",
}


-- NAME = Spawn code how you spawn in the item
-- PRICE = How much it costs to buy the item
-- TYPE = "bank" or "crypto" or "gne"
-- stock = How many items there's available a restart
-- Category = Cosmetic Parts, Performance Parts, or Consumable Parts
Config.Bennys.Items = {
    ["laptop"] = {
        name = "laptop", -- didnt have the side skirt up there so just used this for testing
        price = 100,
        stock = 100,
        type = "bank",
        category = "Cosmetic Parts"
    },
}
