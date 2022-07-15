Config.Boosting = {}

Config.Boosting.HackingDevice = "trackerdisabler" -- Whatever item you use to hack a car with

Config.Boosting.HackDelay = 45 -- 180 seconds delay

Config.Boosting.MinusOne = true -- true or false, detmains wheather the Z is minus 1 or not.

Config.Boosting.PedSettings = {
    ["D"] = { weapons = { "weapon_bat", "weapon_pistol" } },
    ["C"] = { weapons = {}, health = {}, armor = {} },
    ["B"] = { weapons = {}, health = {}, armor = {} },
    ["A"] = { weapons = {}, health = {}, armor = {} },
    ["A+"] = { weapons = {}, health = {}, armor = {} },
    ["S"] = { weapons = {}, health = {}, armor = {} },
    ["S+"] = { weapons = {}, health = {}, armor = {} },
}
Config.Boosting.Locations = {
    ["D"] = {
        [1] = {
            carCoords = vector4(722.49, -603.78, 27.65, 212.7),

            peds = {
                [1] = { coords = vector4(733.44, -600.73, 27.92, 287.04), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(1, #Config.Boosting.PedSettings["D"].weapons)] },
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(-322.16, -752.79, 52.62, 162.03),

            peds = {
                [1] = { coords = vector4(-322.32, -775.02, 53.25, 42.39), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(1, #Config.Boosting.PedSettings["D"].weapons)] },
                [2] = { coords = vector4(-324.21, -776.72, 53.25, 45.48), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(1, #Config.Boosting.PedSettings["D"].weapons)] },
            },

            isBusy = false
        },
    },

    ["C"] = {
        [1] = {
            carCoords = vector4(-815.58, -1098.29, 10.47, 119.79),

            peds = {
                [1] = { coords = vector4(-815.58, -1120.26, 10.55, 307.23), health = 100, armor = 100,
                    model = 'a_m_m_genfat_01', weapon = "weapon_bat" },
                [2] = { coords = vector4(-819.82, -1122.39, 10.43, 307.23), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01', weapon = "weapon_pistol" }
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(-685.11, -882.85, 24.08, 226.07),

            peds = {
                [1] = { coords = vector4(-676.03, -885.04, 24.45, 30.43), health = 100, armor = 100,
                    model = 'a_m_m_genfat_01', weapon = "weapon_bat" },
                [2] = { coords = vector4(-690.7, -877.44, 24.5, 245.86), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01', weapon = "weapon_pistol" },
            },

            isBusy = false
        },
    },

    ["B"] = {
        [1] = {
            carCoords = vector4(426.85, -1826.11, 27.98, 221.63),

            peds = {
                [1] = { coords = vector4(434.15, -1818.08, 27.98, 63.36), health = 100, armor = 100,
                    model = 'a_m_m_soucent_01', weapon = "weapon_bat" },
                [2] = { coords = vector4(429.26, -1819.76, 28.37, 63.36), health = 100, armor = 50,
                    model = 'a_m_m_soucent_01', weapon = "weapon_pistol" },
                [3] = { coords = vector4(440.5, -1829.61, 28.36, 170.73), health = 100, armor = 100,
                    model = 'a_m_m_soucent_01', weapon = "weapon_bat" },
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(311.52, -1939.38, 24.64, 232.74),

            peds = {
                [1] = { coords = vector4(312.41, -1928.9, 25.0, 56.04), health = 100, armor = 100,
                    model = 'a_m_m_soucent_01', weapon = "weapon_bat" },
                [2] = { coords = vector4(327.16, -1933.06, 24.67, 217.47), health = 100, armor = 50,
                    model = 'a_m_m_soucent_01', weapon = "weapon_pistol" },
                [3] = { coords = vector4(324.16, -1937.2, 25.02, 196.93), health = 100, armor = 100,
                    model = 'a_m_m_soucent_01', weapon = "weapon_bat" },
            },

            isBusy = false
        },
    },


    ["A"] = {
        [1] = {
            carCoords = vector4(497.18, -1968.98, 24.89, 116.5),

            peds = {
                [1] = { coords = vector4(434.15, -1818.08, 27.98, 63.36), health = 100, armor = 100,
                    model = 'a_m_y_hasjew_01', weapon = "weapon_bat" },
                [2] = { coords = vector4(429.26, -1819.76, 28.37, 63.36), health = 100, armor = 50,
                    model = 'a_m_y_hasjew_01', weapon = "weapon_pistol" },
                [3] = { coords = vector4(470.86, -1983.8, 24.77, 221.76), health = 100, armor = 50,
                    model = 'a_m_y_hasjew_01', weapon = "weapon_pistol" },
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(238.7, 3165.12, 42.64, 98.68),

            peds = {
                [1] = { coords = vector4(247.54, 3169.51, 42.79, 101.66), health = 100, armor = 100,
                    model = 'a_m_y_hasjew_01', weapon = "weapon_bat" },
                [2] = { coords = vector4(260.74, 3163.95, 42.86, 95.18), health = 100, armor = 50,
                    model = 'a_m_y_hasjew_01', weapon = "weapon_pistol" },
                [3] = { coords = vector4(256.15, 3183.9, 42.74, 120.36), health = 100, armor = 50,
                    model = 'a_m_y_hasjew_01', weapon = "weapon_pistol" },
            },

            isBusy = false
        },
    },

    ["A+"] = {
        [1] = {
            carCoords = vector4(-1152.39, 2679.7, 18.09, 127.14),

            peds = {
                [1] = { coords = vector4(-1134.33, 2682.71, 18.51, 127.36), health = 100, armor = 50,
                    model = 'a_m_y_smartcaspat_01', weapon = "weapon_pistol" },
                [2] = { coords = vector4(-1128.29, 2691.96, 18.8, 44.39), health = 100, armor = 50,
                    model = 'a_m_y_smartcaspat_01', weapon = "weapon_pistol" },
                [3] = { coords = vector4(-1129.62, 2699.89, 18.8, 143.96), health = 100, armor = 50,
                    model = 'a_m_y_smartcaspat_01', weapon = "weapon_pistol" },
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(-703.37, -1138.95, 10.61, 27.03),

            peds = {
                [1] = { coords = vector4(-700.21, -1143.23, 10.81, 34.16), health = 100, armor = 50,
                    model = 'a_m_y_smartcaspat_01', weapon = "weapon_pistol" },
                [2] = { coords = vector4(-696.28, -1143.61, 10.82, 308.39), health = 100, armor = 50,
                    model = 'a_m_y_smartcaspat_01', weapon = "weapon_pistol" },
                [3] = { coords = vector4(-699.15, -1152.89, 10.81, 17.03), health = 100, armor = 50,
                    model = 'a_m_y_smartcaspat_01', weapon = "weapon_pistol" },
            },

            isBusy = false
        },
    },

    ["S"] = {
        [1] = {
            carCoords = vector4(-889.75, 364.65, 85.03, 348.74),

            peds = {
                [1] = { coords = vector4(-881.33, 363.67, 85.36, 46.03), health = 100, armor = 25,
                    model = 'cs_siemonyetarian', weapon = "weapon_pumpshotgun" },
                [2] = { coords = vector4(-888.51, 350.33, 85.29, 94.16), health = 100, armor = 50,
                    model = 'cs_siemonyetarian', weapon = "weapon_pistol" },
                [3] = { coords = vector4(-871.59, 353.25, 85.29, 310.53), health = 100, armor = 50,
                    model = 'cs_siemonyetarian', weapon = "weapon_pistol" },
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(-448.03, 372.01, 104.77, 78.19),

            peds = {
                [1] = { coords = vector4(-429.63, 365.07, 106.55, 100.37), health = 100, armor = 25,
                    model = 'cs_siemonyetarian', weapon = "weapon_pumpshotgun" },
                [2] = { coords = vector4(-450.86, 395.46, 104.78, 92.64), health = 100, armor = 50,
                    model = 'cs_siemonyetarian', weapon = "weapon_pistol" },
                [3] = { coords = vector4(-463.43, 397.61, 102.26, 279.72), health = 100, armor = 50,
                    model = 'cs_siemonyetarian', weapon = "weapon_pistol" },
            },

            isBusy = false
        },
    },

    ["S+"] = {
        [1] = {
            carCoords = vector4(-908.27, 191.02, 69.45, 151.57),

            peds = {
                [1] = { coords = vector4(-917.34, 200.56, 69.43, 178.0), health = 100, armor = 25,
                    model = 'a_m_m_hasjew_01', weapon = "weapon_pumpshotgun" },
                [2] = { coords = vector4(-902.09, 191.7, 69.6, 85.47), health = 100, armor = 0, model = 'a_m_m_hasjew_01',
                    weapon = "weapon_appistol" },
                [3] = { coords = vector4(-898.84, 177.01, 69.45, 155.49), health = 100, armor = 50,
                    model = 'a_m_m_hasjew_01', weapon = "weapon_pistol" },
                [4] = { coords = vector4(-911.34, 203.14, 69.61, 80.1), health = 100, armor = 50,
                    model = 'a_m_m_hasjew_01', weapon = "weapon_pistol" },
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(-810.91, 187.75, 72.48, 109.67),

            peds = {
                [1] = { coords = vector4(-805.12, 181.09, 72.36, 30.99), health = 100, armor = 25,
                    model = 'a_m_m_hasjew_01', weapon = "weapon_pumpshotgun" },
                [2] = { coords = vector4(-815.9, 178.62, 72.15, 119.29), health = 100, armor = 0,
                    model = 'a_m_m_hasjew_01', weapon = "weapon_appistol" },
                [3] = { coords = vector4(-804.23, 190.78, 72.84, 61.46), health = 100, armor = 50,
                    model = 'a_m_m_hasjew_01', weapon = "weapon_pistol" },
                [4] = { coords = vector4(-838.62, 174.11, 70.32, 273.05), health = 100, armor = 50,
                    model = 'a_m_m_hasjew_01', weapon = "weapon_pistol" },
            },

            isBusy = false
        }
    },

}

Config.Boosting.TiersPerRep = {
    ["D"] = 0,
    ["C"] = 50,
    ["B"] = 100,
    ["A"] = 150,
    ["A+"] = 200,
    ["S"] = 250,
    ["S+"] = 300,
}

Config.Boosting.RandomNames = {
    "Peter Parker",
    "XgamerX",
    "Justin Bieber",
    "Just Lazzy",
    "Drake",
    "Zooster",
    "Hype Squad",
    "Slothy",
    "Logan Paul",
    "Tom Cruise"
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
    { coords = vector3(724.0, -579.48, 26.96), isBusy = false },
    { coords = vector3(-2320.39, 309.08, 169.47), isBusy = false },
    { coords = vector3(-130.79, 1923.0, 197.33), isBusy = false },
}
