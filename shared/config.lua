Config = {}

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
        job = {}, -- MUST be a table {'police'}
        usevpn = true,
        gang = {}, -- MUST be a table {'ballas'}
        item = { "lockpick" }, -- MUST be a table {'lockpick'}
        default = false -- if true, it will be added by default
    },
    ['browser'] = {
        app = 'browser',
        name = 'Browser',
        icon = 'fa-solid fa-globe',
        useimage = false,
        color = '#fff',
        background = "#aa2e25",
        job = {},
        usevpn = true,
        gang = {},
        item = {},
        default = true
    }
}
