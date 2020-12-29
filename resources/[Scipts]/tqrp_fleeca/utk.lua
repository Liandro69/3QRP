UTK = {}
UTK.maxcash = 700 -- maximum amount of cash a pile can hold
UTK.mincash = 250 -- minimum amount of cash a pile holds
UTK.black = false -- enable this if you want blackmoney as a reward
UTK.cooldown = 600 -- amount of time to do the heist again in seconds (15min)
UTK.vaultdoor = "v_ilev_gb_vauldr"
UTK.door = "v_ilev_gb_vaubar"
UTK.office = "v_ilev_gb_teldr"
UTK.Banks = {
--[[     F1 = {
        doors = {
            startloc = {x = 310.93, y = -284.44, z = 54.16, h = -90.00, animcoords = {x = 311.05, y = -284.00, z = 53.16, h = 248.60}},
            secondloc = {x = 312.93, y = -284.45, z = 54.16, h = 160.91, animcoords = {x = 313.41, y = -284.42, z = 53.16, h = 160.91}},
            --lockpick = {x = , y = , z = , h = , animcoords = {x = , y = , z = }}
        },
        prop = {
            first = {coords = vector3(311.5481, -284.5114, 54.285), rot = vector3(90.0, 180.0, 21.0)},
            second = {coords = vector3(312.90, -284.95, 54.285), rot = vector3(90.0, 180.0, 110.0)}
        },
        trolley1 = {x = 313.45, y = -289.24, z = 53.14, h = -15},
        trolley2 = {x = 311.51, y = -288.54, z = 53.14, h = -15},
        trolley3 = {x = 314.49, y = -283.65, z = 53.14, h = 160},
        object = vector3(314.49, -283.65, 53.14),
        loot1 = false,
        loot2 = false,
        loot3 = false,
        loot4 = false,
        loot5 = false,
        loot6 = false,
        loot7 = false,
        onaction = false,
        lastrobbed = 0
    },
    F2 = {
        doors = {
            startloc = {x = 146.61, y = -1046.02, z = 29.37, h = 244.20, animcoords = {x = 146.75, y = -1045.60, z = 28.37, h = 244.20}},
            secondloc = {x = 148.76, y = -1045.89, z = 29.37, h = 158.54, animcoords = {x = 149.10, y = -1046.08, z = 28.37, h = 158.54}}
        },
        prop = {
            first = {coords = vector3(147.22, -1046.148, 29.487), rot = vector3(90.0, 180.0, 20.0)},
            second = {coords = vector3(148.57, -1046.578, 29.487), rot = vector3(90.0, 180.0, 110.0)}
        },
        trolley1 = {x = 147.25, y = -1050.38, z = 28.35, h = -15},
        trolley2 = {x = 149.21, y = -1051.07, z = 28.35, h = -15},
        trolley3 = {x = 150.23, y = -1045.40, z = 28.35, h = 160},
        drill1 = {x = 150.54, y = -1049.38, z = 29.35, h = -70},
        drill2 = {x = 149.21, y = -1050.77, z = 28.35, h = -70},
        drill3 = {x = 150.23, y = -1045.40, z = 28.35, h = 160},
        drill4 = {x = 150.23, y = -1045.40, z = 28.35, h = 160},
        object = vector3(150.23, -1045.40, 28.35),
        loot1 = false,
        loot2 = false,
        loot3 = false,
        loot4 = false,
        loot5 = false,
        loot6 = false,
        loot7 = false,
        onaction = false,
        lastrobbed = 0
    },
    F3 = {
        doors = {
            startloc = {x = -1211.07, y = -336.68, z = 37.78, h = 296.76, animcoords = {x = -1211.25, y = -336.37, z = 36.78, h = 296.76}}, 
            secondloc = {x = -1209.66, y = -335.15, z = 37.78, h = 213.67, animcoords = {x = -1209.40, y = -335.05, z = 36.78, h = 213.67}}
        },
        prop = {
            first = {coords = vector3(-1210.50, -336.37, 37.901), rot = vector3(-90.0, 0.0, 25.0)},
            second = {coords = vector3(-1209.27, -335.68, 37.90), rot = vector3(90.0, 180.0, 65.0)}
        },
        trolley1 = {x = -1207.50, y = -339.20, z = 36.76, h = 30},
        trolley2 = {x = -1205.61, y = -338.24, z = 36.76, h = 30},
        trolley3 = {x = -1209.10, y = -333.59, z = 36.76, h = 210},
        object = vector3(-1209.10, -333.59, 36.76),
        loot1 = false,
        loot2 = false,
        loot3 = false,
        loot4 = false,
        loot5 = false,
        loot6 = false,
        loot7 = false,
        onaction = false,
        lastrobbed = 0
    }, ]]
    F1 = {
        hash = 4231427725, -- exception
        doors = {
            startloc = {x = -2956.47, y = 481.61, z = 15.7, h = 353.97, animcoords = {x = -2956.17, y = 482.01, z = 15.35, h = 353.97}}
        },
        prop = {
            first = {coords = vector3(-2956.59, 482.05, 15.815), rot = vector3(90.0, 180.0, -88.0)},
            second = {coords = vector3(-2956.60, 483.46, 15.815), rot = vector3(90.0, 180.0, 3.0)}
        },
        drill1 = {x = -2952.69, y = 483.34, z = 14.68, h = 260},
        drill2 = {x = -2952.57, y = 485.18, z = 14.68, h = 260},
        drill3 = {x = -2954.15, y =  482.39, z = 14.68, h = 175.03},
        drill4 = {x = -2954.09, y= 486.29, z = 14.68, h = 3.34},
        trolley3 = {x = -2958.35, y = 484.69, z = 14.68, h = 270},
        object = vector3(-2958.35, 484.69, 14.68),
        loot1 = false,
        loot2 = false,
        loot3 = false,
        loot4 = false,
        loot5 = false,
        loot6 = false,
        loot7 = false,
        onaction = false,
        lastrobbed = 0
    },
--[[     F5 = {
        doors = {
            startloc = {x = -354.15, y = -55.11, z = 49.04, h = 251.05, animcoords = {x = -354.15, y = -55.11, z = 48.04, h = 251.05}},
            secondloc = {x = -351.97, y = -55.18, z = 49.04, h = 159.79, animcoords = {x = -351.97, y = -55.18, z = 48.04, h = 159.79}}
        },
        prop = {
            first = {coords = vector3(-353.50, -55.37, 49.157), rot = vector3(90.0, 180.0, 20.0)},
            second = {coords = vector3(-352.15, -55.77, 49.157), rot = vector3(90.0, 180.0, 110.0)}
        },
        trolley1 = {x = -353.34, y = -59.48, z = 48.01, h = -15},
        trolley2 = {x = -351.57, y = -60.09, z = 48.01, h = -15},
        trolley3 = {x = -350.57, y = -54.45, z = 48.01, h = 160},
        object = vector3(-350.57, -54.45, 48.01),
        loot1 = false,
        loot2 = false,
        loot3 = false,
        loot4 = false,
        loot5 = false,
        loot6 = false,
        loot7 = false,
        onaction = false,
        lastrobbed = 0
    }, ]]
    F2 = {
        doors = {
            startloc = {x = 1176.33, y = 2712.83, z = 38.09, h = 90.83, animcoords = {x = 1175.33, y = 2712.95, z = 39.29, h = 90.52}}
           --[[  secondloc = {x = 1174.24, y = 2712.47, z = 38.09, h = 359.05, animcoords = {x = 1174.33, y = 2712.09, z = 37.09, h = 359.05}} ]]
        },
        prop = {
            first = {coords = vector3(1175.70, 2712.82, 38.207), rot = vector3(90.0, 180.0, 180.0)},
            second = {coords = vector3(1174.267, 2712.736, 38.207), rot = vector3(90.0, 180.0, -90.0)}
        },
        drill1 = {x = 1174.24, y = 2716.69, z = 37.07, h = 2},
        drill2 = {x = 1172.27, y = 2716.67, z = 37.07, h = 2},
        drill3 = {x = 1171.34, y= 2715.00, z = 37.07, h = 90},
        drill4 = {x = 1175.34, y= 2715.00, z = 37.07, h = 265},
        trolley3 = {x = 1173.23, y = 2711.02, z = 37.07, h = 0},
        object = vector3(1173.23, 2711.02, 37.07),
        loot1 = false,
        loot2 = false,
        loot3 = false,
        loot4 = false,
        loot5 = false,
        loot6 = false,
        loot7 = false,
        onaction = false,
        lastrobbed = 0
    }
}