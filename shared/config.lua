Config = {}

Config.LaptopDevice = "laptop"

Config.PoliceJobs = {
    "police",
    "bcso"
}

Config.Apps = {
    ['boosting'] = {
        app = 'boosting',
        name = 'Boosting',
        icon = 'boosting',
        useimage = true,
        color = '#fff',
        background = '#1d2029',
        job = {},
        bannedJobs = { "police" }, -- can be a table or a string
        gang = {}, -- it can be boolean or a table {'ballas'}
        item = { "vpn" },
        default = false -- if true, it will be added by default
    },
    ['setting'] = {
        app = 'setting',
        name = 'Setting',
        icon = 'fa-solid fa-cog',
        useimage = false,
        color = '#fff',
        background = "#4B5D67",
        job = {},
        gang = {}, -- it can be boolean or a table {'ballas'}
        item = {},
        default = true -- if true, it will be added by default
    },
    ['bennys'] = {
        app = 'bennys',
        name = "Bennys Shop",
        icon = "fa-solid fa-shopping-cart",
        useimage = false,
        color = '#fff',
        background = "#352968",
        job = {},
        gang = {},
        item = {},
        default = true
    }
}
