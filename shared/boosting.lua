Config.Boosting = {}

Config.Boosting.HackingDevice = "HackingDevice" -- Whatever item you use to hack a car with


Config.Boosting.MinusOne = true -- true or false, detmains wheather the Z is minus 1 or not.
Config.Boosting.Locations = {
    ["D"] = {
        [1] = {
            carCoords = vector4(722.49, -603.78, 27.65, 212.7),

            peds = {
                [1] = {coords = vector4(733.44, -600.73, 27.92, 287.04), health = 100, armor = 100, model = 'a_m_m_genfat_01', weapon = "weapon_bat"},
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(-322.16, -752.79, 52.62, 162.03),

            peds = {
                [1] = {coords = vector4(-322.32, -775.02, 53.25, 42.39), health = 100, armor = 100, model = 'a_m_m_genfat_01', weapon = "weapon_bat"},
                [2] = {coords = vector4(-324.21, -776.72, 53.25, 45.48), health = 100, armor = 100, model = 'a_m_m_genfat_01', weapon = "weapon_bat"},
            },

            isBusy = false
        },
    },

    ["C"] = {

    },

    ["B"] = {

    },

    ["A"] = {

    },

    ["A+"] = {

    },

    ["S"] = {

    },

    ["S+"] = {

    },
}

Config.Boosting.MaxPools = {
    ["D"] = 5,
    ["C"] = 1,
    ["B"] = 1,
    ["A"] = 1,
    ["A+"] = 1,
    ["S"] = 1,
    ["S+"] = 1,
}

Config.Boosting.TiersPerRep = {
    ["D"] = 0,
    ["C"] = 10,
    ["B"] = 20,
    ["A"] = 30,
    ["A+"] = 40,
    ["S"] = 50,
    ["S+"] = 60,
}

Config.Boosting.RandomNames = {
    "Peter Parker",
    "XgamerX",
    "Justin Bieber",
    "Just Lazzy",
    "Drake",
    "Zooster"
}

Config.Boosting.Vehicles = {
    ["D"] = {
        "sultan",
        "sultanrs",
        "banshee",
    },

    ["C"] = {
        'blista',
        'casco', 
        'virgo', 
        'sadler', 
        'ratloader'
    },

    ["B"] = {
        'primo', 
        'chino', 
        'baller3', 
        'guardian'
    },

    ["A"] = {
        'infernus2', 
        'massacro', 
        'felon', 
        'oracle2', 
        'jackal'
    },

    ["A+"] = {
        'schafter2', 
        'kuruma', 
        'brioso', 
        'infernus'
    },

    ["S"] = {
        't20', 
        'zentorno', 
        'turismor', 
        'massacro2', 
        'raptor'
    },

    ["S+"] = {
        'nero', 
        'paragon', 
        'mamba', 
        'ztype',
    },
}

Config.Boosting.ReturnLocation = {
    {coords = vector3(724.0, -579.48, 26.96), isBusy = false}
}
