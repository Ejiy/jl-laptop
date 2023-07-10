Config = {}

Config.Inventory = "qb-inventory"
Config.LaptopDevice = "laptop"

Config.RenewedPhone = false

Config.Linux = true

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
        job = {},                  -- Must be a table
        bannedJobs = { "police" }, -- Must be a table { 'police' }
        gang = {},                 -- Must be a table { 'ballas' }
        item = { "vpn" },          -- Must be a table { 'vpn' }
        default = false            -- if true, it will be added by default, ignoring all the previously set parameters
    },
    ['setting'] = {
        app = 'setting',
        name = 'Setting',
        icon = 'fa-solid fa-cog',
        useimage = false,
        color = '#fff',
        background = "#4B5D67",
        job = {},
        bannedJobs = {},
        gang = {},
        item = {},
        default = true
    },
    ['bennys'] = {
        app = 'bennys',
        name = "Bennys Shop",
        icon = "fa-solid fa-shopping-cart",
        useimage = false,
        color = '#fff',
        background = "#352968",
        job = {},
        bannedJobs = {},
        gang = {},
        item = {},
        default = true
    },
    ['darkweb'] = {
        app = 'darkweb',
        name = "Unknown",
        icon = "fa-solid fa-skull",
        useimage = false,
        color = '#fff',
        background = "black",
        job = {},
        bannedJobs = { "police" },
        gang = {},
        item = { "vpn" },
        default = false
    }
}
