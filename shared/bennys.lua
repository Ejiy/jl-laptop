Config.Bennys = {}


Config.Bennys.Location = {
    ped = "s_m_y_airworker",
    coords = vector4(1183.37, -3322.16, 6.03, 95.27),
    sprite = 473,
    colour = 28,
    text = "Bennys Warehouse"
}


-- NAME = Spawn code how you spawn in the item
-- PRICE = How much it costs to buy the item
-- TYPE = "bank" or "crypto" or "gne"
-- stock = How many items there's available a restart
Config.Bennys.Items = {
    ["side_skirt"] = {
        name = "elaptop", -- didnt have the side skirt up there so just used this for testing
        price = 100,
        stock = 100,
        type = "bank"
    },
}
