Config.Boosting = {}

Config.Boosting.MinCops = 0

Config.Boosting.Notifications = "phone" -- Use this for qb // renewed phone intergration, use "notify" for normal QBCore Notifications // NWPD for New Phone Who Dis

Config.Boosting.Debug = true -- Make this true to make boosting faster lmao

Config.Boosting.HackingDevice = "phone" -- Whatever item you use to hack a car with

Config.Boosting.HackDelayMin = 30 -- Seconds
Config.Boosting.HackDelayMax = 60 -- Seconds


Config.Boosting.Frequency = 60 -- Whats the max time for a boost ping for cops? - Standard 30 seconds

Config.Boosting.MaxBoosts = 5 -- The amount of boosts a player can hold in their laptop at any given time.

Config.Boosting.MinusOne = true -- true or false, detmains wheather the Z is minus 1 or not.

Config.Boosting.PedSettings = {
    ["D"] = { weapons = { "weapon_bat", "weapon_pistol" } },
    ["C"] = { weapons = { "weapon_pistol_mk2", "weapon_pistol" } },
    ["B"] = { weapons = { "weapon_pistol_mk2", "weapon_pistol" } },
    ["A"] = { weapons = { "weapon_pistol_mk2", "weapon_gusenberg" } },
    ["A+"] = { weapons = { "weapon_combatpistol", "weapon_machinepistol" } },
    ["S"] = { weapons = { "weapon_microsmg", "weapon_minismg" } },
    ["S+"] = { weapons = { "weapon_assaultrifle", "weapon_combatmg" } },
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
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
                [2] = { coords = vector4(755.68, -600.18, 28.42, 85.65), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
                [3] = { coords = vector4(726.18, -610.2, 28.11, 290.07), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
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
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
                [2] = { coords = vector4(-324.21, -776.72, 53.25, 45.48), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
                [3] = { coords = vector4(-319.25, -760.5, 53.25, 357.19), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
            },

            isBusy = false
        },

        [3] = {
            carCoords = vector4(-1173.44, -1742.16, 4.03, 217.43),

            peds = {
                [1] = { coords = vector4(-1179.62, -1767.8, 3.89, 29.54), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
                [2] = { coords = vector4(-1189.89, -1760.43, 3.93, 308.68), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
                [3] = { coords = vector4(-1166.88, -1759.95, 3.95, 54.74), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
            },

            isBusy = false
        },

        [4] = {
            carCoords = vector4(-3001.01, 79.41, 11.61, 326.77),

            peds = {
                [1] = { coords = vector4(-2989.79, 69.94, 11.61, 348.9), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
                [2] = { coords = vector4(-2989.23, 69.98, 11.61, 13.69), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
                [3] = { coords = vector4(-2988.25, 70.61, 11.61, 23.03), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
            },

            isBusy = false
        },

        [5] = {
            carCoords = vector4(907.54, -1732.26, 30.59, 168.88),

            peds = {
                [1] = { coords = vector4(903.09, -1722.67, 32.16, 200.43), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
                [2] = { coords = vector4(899.22, -1722.38, 32.16, 183.03), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
                [3] = { coords = vector4(907.91, -1722.48, 32.16, 207.4), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
            },

            isBusy = false
        },

        [6] = {
            carCoords = vector4(2726.44, 2770.44, 36.1, 128.16),

            peds = {
                [1] = { coords = vector4(2745.52, 2787.82, 35.55, 115.66), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
                [2] = { coords = vector4(2744.2, 2787.84, 35.52, 56.0), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
                [3] = { coords = vector4(2705.41, 2766.31, 37.01, 297.86), health = math.random(200, 500),
                    armor = math.random(100, 200),
                    model = 'a_m_y_bevhills_01',
                    weapon = Config.Boosting.PedSettings["D"].weapons[
                        math.random(#Config.Boosting.PedSettings["D"].weapons)] },
            },

            isBusy = false
        },

    },

    ["C"] = {
        [1] = {
            carCoords = vector4(-815.58, -1098.29, 10.47, 119.79),

            peds = {
                [1] = { coords = vector4(-815.58, -1120.26, 10.55, 307.23), health = 100, armor = 100,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] },
                [2] = { coords = vector4(-819.82, -1122.39, 10.43, 307.23), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] },
                [3] = { coords = vector4(-828.19, -1089.89, 11.14, 303.55), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] }
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(-775.62, -193.86, 37.28, 118.52),

            peds = {
                [1] = { coords = vector4(-780.23, -204.89, 37.28, 26.09), health = 100, armor = 100,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] },
                [2] = { coords = vector4(-789.27, -193.07, 37.28, 241.49), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] },
                [3] = { coords = vector4(-781.21, -186.89, 37.25, 129.09), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] }
            },

            isBusy = false
        },

        [3] = {
            carCoords = vector4(-1661.3, -294.97, 51.75, 245.46),

            peds = {
                [1] = { coords = vector4(-1674.39, -297.31, 51.81, 299.96), health = 100, armor = 100,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] },
                [2] = { coords = vector4(-1674.34, -298.03, 51.81, 200.0), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] },
                [3] = { coords = vector4(-1675.18, -296.32, 51.84, 299.48), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] }
            },

            isBusy = false
        },

        [4] = {
            carCoords = vector4(66.63, 122.68, 79.14, 154.45),

            peds = {
                [1] = { coords = vector4(69.2, 127.57, 79.21, 144.82), health = 100, armor = 100,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] },
                [2] = { coords = vector4(77.73, 110.06, 79.16, 33.37), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] },
                [3] = { coords = vector4(53.47, 108.9, 79.15, 325.01), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] }
            },

            isBusy = false
        },

        [5] = {
            carCoords = vector4(-43.76, 1879.59, 196.12, 131.33),

            peds = {
                [1] = { coords = vector4(-52.31, 1887.43, 195.37, 197.03), health = 100, armor = 100,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] },
                [2] = { coords = vector4(-53.17, 1886.42, 195.37, 278.47), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] },
                [3] = { coords = vector4(-36.11, 1892.2, 195.41, 200.87), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] }
            },

            isBusy = false
        },

        [6] = {
            carCoords = vector4(1484.88, 3586.05, 35.37, 23.36),

            peds = {
                [1] = { coords = vector4(1497.13, 3574.8, 35.32, 46.81), health = 100, armor = 100,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] },
                [2] = { coords = vector4(1495.06, 3573.27, 35.33, 90.46), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] },
                [3] = { coords = vector4(1499.32, 3576.13, 35.32, 77.22), health = 100, armor = 50,
                    model = 'a_m_m_genfat_01',
                    weapon = Config.Boosting.PedSettings["C"].weapons[
                        math.random(#Config.Boosting.PedSettings["C"].weapons)] }
            },

            isBusy = false
        },
    },

    ["B"] = {
        [1] = {
            carCoords = vector4(426.85, -1826.11, 27.98, 221.63),

            peds = {
                [1] = { coords = vector4(434.15, -1818.08, 27.98, 63.36), health = 100, armor = 100,
                    model = 'a_m_m_soucent_01',
                    weapon = Config.Boosting.PedSettings["B"].weapons[
                        math.random(#Config.Boosting.PedSettings["B"].weapons)] },
                [2] = { coords = vector4(429.26, -1819.76, 28.37, 63.36), health = 100, armor = 50,
                    model = 'a_m_m_soucent_01',
                    weapon = Config.Boosting.PedSettings["B"].weapons[
                        math.random(#Config.Boosting.PedSettings["B"].weapons)] },
                [3] = { coords = vector4(440.5, -1829.61, 28.36, 170.73), health = 100, armor = 100,
                    model = 'a_m_m_soucent_01',
                    weapon = Config.Boosting.PedSettings["B"].weapons[
                        math.random(#Config.Boosting.PedSettings["B"].weapons)] },
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(311.52, -1939.38, 24.64, 232.74),

            peds = {
                [1] = { coords = vector4(312.41, -1928.9, 25.0, 56.04), health = 100, armor = 100,
                    model = 'a_m_m_soucent_01',
                    weapon = Config.Boosting.PedSettings["B"].weapons[
                        math.random(#Config.Boosting.PedSettings["B"].weapons)] },
                [2] = { coords = vector4(327.16, -1933.06, 24.67, 217.47), health = 100, armor = 50,
                    model = 'a_m_m_soucent_01',
                    weapon = Config.Boosting.PedSettings["B"].weapons[
                        math.random(#Config.Boosting.PedSettings["B"].weapons)] },
                [3] = { coords = vector4(324.16, -1937.2, 25.02, 196.93), health = 100, armor = 100,
                    model = 'a_m_m_soucent_01',
                    weapon = Config.Boosting.PedSettings["B"].weapons[
                        math.random(#Config.Boosting.PedSettings["B"].weapons)] },
            },

            isBusy = false
        },

        [3] = {
            carCoords = vector4(-754.19, -1038.42, 12.78, 290.51),

            peds = {
                [1] = { coords = vector4(-758.76, -1047.17, 13.5, 308.96), health = 100, armor = 100,
                    model = 'a_m_m_soucent_01',
                    weapon = Config.Boosting.PedSettings["B"].weapons[
                        math.random(#Config.Boosting.PedSettings["B"].weapons)] },
                [2] = { coords = vector4(-759.07, -1046.59, 13.51, 335.65), health = 100, armor = 50,
                    model = 'a_m_m_soucent_01',
                    weapon = Config.Boosting.PedSettings["B"].weapons[
                        math.random(#Config.Boosting.PedSettings["B"].weapons)] },
                [3] = { coords = vector4(-761.88, -1035.37, 14.13, 276.39), health = 100, armor = 100,
                    model = 'a_m_m_soucent_01',
                    weapon = Config.Boosting.PedSettings["B"].weapons[
                        math.random(#Config.Boosting.PedSettings["B"].weapons)] },
            },

            isBusy = false
        },
    },


    ["A"] = {
        [1] = {
            carCoords = vector4(497.18, -1968.98, 24.89, 116.5),

            peds = {
                [1] = { coords = vector4(434.15, -1818.08, 27.98, 63.36), health = 100, armor = 100,
                    model = 'a_m_y_hasjew_01',
                    weapon = Config.Boosting.PedSettings["A"].weapons[
                        math.random(#Config.Boosting.PedSettings["A"].weapons)] },
                [2] = { coords = vector4(429.26, -1819.76, 28.37, 63.36), health = 100, armor = 50,
                    model = 'a_m_y_hasjew_01',
                    weapon = Config.Boosting.PedSettings["A"].weapons[
                        math.random(#Config.Boosting.PedSettings["A"].weapons)] },
                [3] = { coords = vector4(470.86, -1983.8, 24.77, 221.76), health = 100, armor = 50,
                    model = 'a_m_y_hasjew_01',
                    weapon = Config.Boosting.PedSettings["A"].weapons[
                        math.random(#Config.Boosting.PedSettings["A"].weapons)] },
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(238.7, 3165.12, 42.64, 98.68),

            peds = {
                [1] = { coords = vector4(247.54, 3169.51, 42.79, 101.66), health = 100, armor = 100,
                    model = 'a_m_y_hasjew_01',
                    weapon = Config.Boosting.PedSettings["A"].weapons[
                        math.random(#Config.Boosting.PedSettings["A"].weapons)] },
                [2] = { coords = vector4(260.74, 3163.95, 42.86, 95.18), health = 100, armor = 50,
                    model = 'a_m_y_hasjew_01',
                    weapon = Config.Boosting.PedSettings["A"].weapons[
                        math.random(#Config.Boosting.PedSettings["A"].weapons)] },
                [3] = { coords = vector4(256.15, 3183.9, 42.74, 120.36), health = 100, armor = 50,
                    model = 'a_m_y_hasjew_01',
                    weapon = Config.Boosting.PedSettings["A"].weapons[
                        math.random(#Config.Boosting.PedSettings["A"].weapons)] },
            },

            isBusy = false
        },
    },

    ["A+"] = {
        [1] = {
            carCoords = vector4(-1152.39, 2679.7, 18.09, 127.14),

            peds = {
                [1] = { coords = vector4(-1134.33, 2682.71, 18.51, 127.36), health = 100, armor = 50,
                    model = 'a_m_y_smartcaspat_01',
                    weapon = Config.Boosting.PedSettings["A+"].weapons[
                        math.random(#Config.Boosting.PedSettings["A+"].weapons)] },
                [2] = { coords = vector4(-1128.29, 2691.96, 18.8, 44.39), health = 100, armor = 50,
                    model = 'a_m_y_smartcaspat_01',
                    weapon = Config.Boosting.PedSettings["A+"].weapons[
                        math.random(#Config.Boosting.PedSettings["A+"].weapons)] },
                [3] = { coords = vector4(-1129.62, 2699.89, 18.8, 143.96), health = 100, armor = 50,
                    model = 'a_m_y_smartcaspat_01',
                    weapon = Config.Boosting.PedSettings["A+"].weapons[
                        math.random(#Config.Boosting.PedSettings["A+"].weapons)] },
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(-703.37, -1138.95, 10.61, 27.03),

            peds = {
                [1] = { coords = vector4(-700.21, -1143.23, 10.81, 34.16), health = 100, armor = 50,
                    model = 'a_m_y_smartcaspat_01',
                    weapon = Config.Boosting.PedSettings["A+"].weapons[
                        math.random(#Config.Boosting.PedSettings["A+"].weapons)] },
                [2] = { coords = vector4(-696.28, -1143.61, 10.82, 308.39), health = 100, armor = 50,
                    model = 'a_m_y_smartcaspat_01',
                    weapon = Config.Boosting.PedSettings["A+"].weapons[
                        math.random(#Config.Boosting.PedSettings["A+"].weapons)] },
                [3] = { coords = vector4(-699.15, -1152.89, 10.81, 17.03), health = 100, armor = 50,
                    model = 'a_m_y_smartcaspat_01',
                    weapon = Config.Boosting.PedSettings["A+"].weapons[
                        math.random(#Config.Boosting.PedSettings["A+"].weapons)] },
            },

            isBusy = false
        },
    },

    ["S"] = {
        [1] = {
            carCoords = vector4(-889.75, 364.65, 85.03, 348.74),

            peds = {
                [1] = { coords = vector4(-881.33, 363.67, 85.36, 46.03), health = 100, armor = 25,
                    model = 'cs_siemonyetarian',
                    weapon = Config.Boosting.PedSettings["S"].weapons[
                        math.random(#Config.Boosting.PedSettings["S"].weapons)] },
                [2] = { coords = vector4(-888.51, 350.33, 85.29, 94.16), health = 100, armor = 50,
                    model = 'cs_siemonyetarian',
                    weapon = Config.Boosting.PedSettings["S"].weapons[
                        math.random(#Config.Boosting.PedSettings["S"].weapons)] },
                [3] = { coords = vector4(-871.59, 353.25, 85.29, 310.53), health = 100, armor = 50,
                    model = 'cs_siemonyetarian',
                    weapon = Config.Boosting.PedSettings["S"].weapons[
                        math.random(#Config.Boosting.PedSettings["S"].weapons)] },
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(-448.03, 372.01, 104.77, 78.19),

            peds = {
                [1] = { coords = vector4(-429.63, 365.07, 106.55, 100.37), health = 100, armor = 25,
                    model = 'cs_siemonyetarian',
                    weapon = Config.Boosting.PedSettings["S"].weapons[
                        math.random(#Config.Boosting.PedSettings["S"].weapons)] },
                [2] = { coords = vector4(-450.86, 395.46, 104.78, 92.64), health = 100, armor = 50,
                    model = 'cs_siemonyetarian',
                    weapon = Config.Boosting.PedSettings["S"].weapons[
                        math.random(#Config.Boosting.PedSettings["S"].weapons)] },
                [3] = { coords = vector4(-463.43, 397.61, 102.26, 279.72), health = 100, armor = 50,
                    model = 'cs_siemonyetarian',
                    weapon = Config.Boosting.PedSettings["S"].weapons[
                        math.random(#Config.Boosting.PedSettings["S"].weapons)] },
            },

            isBusy = false
        },
    },

    ["S+"] = {
        [1] = {
            carCoords = vector4(-908.27, 191.02, 69.45, 151.57),

            peds = {
                [1] = { coords = vector4(-917.34, 200.56, 69.43, 178.0), health = 100, armor = 25,
                    model = 'a_m_m_hasjew_01',
                    weapon = Config.Boosting.PedSettings["S+"].weapons[
                        math.random(#Config.Boosting.PedSettings["S+"].weapons)] },
                [2] = { coords = vector4(-902.09, 191.7, 69.6, 85.47), health = 100, armor = 0,
                    model = 'a_m_m_hasjew_01',
                    weapon = Config.Boosting.PedSettings["S+"].weapons[
                        math.random(#Config.Boosting.PedSettings["S+"].weapons)] },
                [3] = { coords = vector4(-898.84, 177.01, 69.45, 155.49), health = 100, armor = 50,
                    model = 'a_m_m_hasjew_01',
                    weapon = Config.Boosting.PedSettings["S+"].weapons[
                        math.random(#Config.Boosting.PedSettings["S+"].weapons)] },
                [4] = { coords = vector4(-911.34, 203.14, 69.61, 80.1), health = 100, armor = 50,
                    model = 'a_m_m_hasjew_01',
                    weapon = Config.Boosting.PedSettings["S+"].weapons[
                        math.random(#Config.Boosting.PedSettings["S+"].weapons)] },
            },

            isBusy = false
        },

        [2] = {
            carCoords = vector4(-810.91, 187.75, 72.48, 109.67),

            peds = {
                [1] = { coords = vector4(-805.12, 181.09, 72.36, 30.99), health = 100, armor = 25,
                    model = 'a_m_m_hasjew_01',
                    weapon = Config.Boosting.PedSettings["S+"].weapons[
                        math.random(#Config.Boosting.PedSettings["S+"].weapons)] },
                [2] = { coords = vector4(-815.9, 178.62, 72.15, 119.29), health = 100, armor = 0,
                    model = 'a_m_m_hasjew_01',
                    weapon = Config.Boosting.PedSettings["S+"].weapons[
                        math.random(#Config.Boosting.PedSettings["S+"].weapons)] },
                [3] = { coords = vector4(-804.23, 190.78, 72.84, 61.46), health = 100, armor = 50,
                    model = 'a_m_m_hasjew_01',
                    weapon = Config.Boosting.PedSettings["S+"].weapons[
                        math.random(#Config.Boosting.PedSettings["S+"].weapons)] },
                [4] = { coords = vector4(-838.62, 174.11, 70.32, 273.05), health = 100, armor = 50,
                    model = 'a_m_m_hasjew_01',
                    weapon = Config.Boosting.PedSettings["S+"].weapons[
                        math.random(#Config.Boosting.PedSettings["S+"].weapons)] },
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

Config.Boosting.Price = {
    ["D"] = { min = 0, max = 3 },
    ["C"] = { min = 5, max = 10 },
    ["B"] = { min = 10, max = 20 },
    ["A"] = { min = 15, max = 30 },
    ["A+"] = { min = 20, max = 45 },
    ["S"] = { min = 30, max = 50 },
    ["S+"] = { min = 40, max = 80 },
}

Config.Boosting.RandomNames = {
    "XgamerX",
    "Just Lazzy",
    "Zooster",
    "Hype Squad",
    "Lowkey Paul",
    "Jimathy yorass",
    "Paul Zac",
    "Gov",
    "Kareem",
}

Config.Boosting.MetaReward = {
    ["D"] = { min = 1, max = 1 },
    ["C"] = { min = 1, max = 2 },
    ["B"] = { min = 1, max = 3 },
    ["A"] = { min = 2, max = 4 },
    ["A+"] = { min = 2, max = 5 },
    ["S"] = { min = 2, max = 6 },
    ["S+"] = { min = 3, max = 7 },
}

Config.Boosting.ReturnLocation = {
    { coords = vector3(724.0, -579.48, 26.96), isBusy = false },
    { coords = vector3(-2320.39, 309.08, 169.47), isBusy = false },
    { coords = vector3(-130.79, 1923.0, 197.33), isBusy = false },
    { coords = vector3(2931.34, 4630.9, 48.55), isBusy = false },
    { coords = vector3(2341.06, 2613.95, 46.67), isBusy = false },
    { coords = vector3(165.94, 6359.3, 31.41), isBusy = false },
    { coords = vector3(1455.67, -2618.46, 48.6), isBusy = false },
    { coords = vector3(-116.19, -2660.76, 6.01), isBusy = false },
    { coords = vector3(-1131.4, 2697.01, 18.8), isBusy = false },
}

Config.Boosting.VinScratch = {
    { coords = vector3(932.81, -3272.76, 5.9), isBusy = false },
    { coords = vector3(940.02, -2542.75, 28.3), isBusy = false },
    { coords = vector3(573.26, -2339.11, 5.9), isBusy = false }
}
