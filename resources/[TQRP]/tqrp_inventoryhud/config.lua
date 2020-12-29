Config = {}
Config.Locale = "en"
Config.IncludeCash = true -- Include cash in inventory?
Config.IncludeWeapons = false -- Include weapons in inventory?
Config.IncludeAccounts = true -- Include accounts (bank, black money, ...)?
Config.ExcludeAccountsList = {"bank"} -- List of accounts names to exclude from inventory
Config.MaxWeight = 80

-- List of item names that will close ui when used
Config.CloseUiItems = {}

Config.ShopBlipID = 52
Config.LiquorBlipID = 93
Config.YouToolBlipID = 402
Config.PrisonShopBlipID = 52
Config.WeedStoreBlipID = 140
Config.WeaponShopBlipID = 110
Config.PoliceShopShopBlipID = 110

Config.ShopLength = 14
Config.LiquorLength = 10
Config.YouToolLength = 2
Config.PrisonShopLength = 2
Config.PoliceShopLength = 2

Config.Color = 2
Config.WeaponColor = 1

Config.WeaponLiscence = {x = 12.47, y = -1105.5, z = -29.8}
Config.LicensePrice = 22500

Config.Shops = {
    RegularShop = {
        Locations = {
            { x = 373.875, y = 325.896, z = 102.566 },
            { x = -1104.52, y = -821.67, z = 13.28 },
            { x = 2557.458, y = 382.282, z = 107.622 },
            { x = -3038.939, y = 585.954, z = 6.908 },
            { x = -3241.927, y = 1001.462, z = 11.830 },
            { x = 547.431, y = 2671.710, z = 41.156 },
            { x = 1961.464, y = 3740.672, z = 31.343 },
            { x = 2678.916, y = 3280.671, z = 54.241 },
            { x = 1729.216, y = 6414.131, z = 34.037 },
            { x = -48.519, y = -1757.514, z = 28.421 },
            { x = 1163.373, y = -323.801, z = 68.205 },
            { x = -707.501, y = -914.260, z = 18.215 },
            { x = -1820.523, y = 792.518, z = 137.118 },
            { x = 1698.388, y = 4924.404, z = 41.063 },
            { x = 25.723, y = -1346.966, z = 28.497 },
            { x = 268.26, y = -979.44, z = 28.37 },
        },
        Items = {
            { name = 'bread' },
            { name = 'water' },
            { name = 'blindfold' },
            { name = 'anchor' },
            { name = 'dopebag' },
            { name = 'fishbait' },
            { name = 'fishingrod' },
            { name = 'jager' },
            { name = 'lithium' },
            { name = 'notepad' },
            { name = 'sickle' },
            { name = 'oxygen_mask' },
            { name = 'radio' },
            { name = 'cigarett' },
            { name = 'lighter' },
            { name = 'rolpaper' },
            { name = 'filter' },
            { name = 'phone' }

        }
    },

    IlegalShop = {
        Locations = {
            { x = 468.58, y = -3205.64, z = 9.79 },
        },
        Items = {
            { name = 'arma_cao' },
            { name = 'arma_gatilho' },
            { name = 'arma_mola' },
            { name = 'arma_percurssor' },
            { name = 'tec9_body' },
            { name = 'arma_tambor' },
            { name = 'arma_armacaopistola' },
            { name = 'WEAPON_MACHINEPISTOL' }

        }
    },

    RobsLiquor = {
        Locations = {
            { x = 1135.808, y = -982.281, z = 45.415 },
            { x = -1222.915, y = -906.983, z = 11.326 },
            { x = -1487.553, y = -379.107, z = 39.163 },
            { x = -2968.243, y = 390.910, z = 14.043 },
            { x = 1166.024, y = 2708.930, z = 37.157 },
            { x = 1392.562, y = 3604.684, z = 33.980 },
            { x = -1393.409, y = -606.624, z = 29.319 }
        },
        Items = {
            { name = 'bread' },
            { name = 'water' },
            { name = 'radio' },
            { name = 'absinthe' },
            { name = 'absolut-vodka' },
            { name = 'bolchips' },
            { name = 'gym_membership' }

        }
    },

    YouTool = {
        Locations = {
            { x = 2748.0, y = 3473.0, z = 55.68 },
        },
        Items = {
            { name = 'antifreeze' },
            { name = 'WEAPON_CROWBAR' },
            { name = 'simcard' },
            { name = 'fabric' },
            { name = 'fixkit' },
            { name = 'WEAPON_HAMMER' },
            { name = 'WEAPON_FIREEXTINGUISHER' },
            { name = 'acetone' },
            { name = 'binoculos' },
            { name = 'lithium' },
            { name = 'WEAPON_WRENCH' },
            { name = 'recipe_screw' },
            { name = 'recipe_nail' },
            { name = 'ducttape' },
            { name = 'screwdriver' },
            { name = 'blowtorch' },
            { name = 'radio' }
        }
    },

    PrisonShop = {
        Locations = {
            { x = 1774.95, y = 2590.22, z = 45.72 },
        },
        Items = {
            { name = 'bread' },
            { name = 'water' }
        }
    },

    WeaponShop = {
        Locations = {
            --[[{ x = -662.180, y = -934.961, z = 20.829 },
            { x = 810.25, y = -2157.60, z = 28.62 },
            { x = 1693.44, y = 3760.16, z = 33.71 },
            { x = -330.24, y = 6083.88, z = 30.45 },
            { x = 252.63, y = -50.00, z = 68.94 },]]
            { x = 22.09, y = -1107.28, z = 28.80 }
            --[[{ x = 2567.69, y = 294.38, z = 107.73 },
            { x = -1117.58, y = 2698.61, z = 17.55 },
            { x = 842.44, y = -1033.42, z = 27.19 },]]
        },
        Weapons = {
            { name = "WEAPON_BAT", ammo = 1 },
            { name = "WEAPON_KNUCKLE", ammo = 1 },
            { name = "WEAPON_SNSPISTOL", ammo = 0 },
            { name = "WEAPON_PISTOL", ammo = 0 }
        },
        Ammo = {
        },
        Items = {
            { name = 'disc_ammo_pistol' },
            { name = "WEAPON_FLARE" }
        }
    },

    PoliceShop = {
       Locations = {
            { x = 461.5, y = -981.09, z = 29.69 },
            { x = 1862.28, y = 3688.72, z = 33.26 },

        },
        Items = {
            { name = "WEAPON_FLASHLIGHT"},
            { name = "WEAPON_NIGHTSTICK"},
            { name = "WEAPON_STUNGUN"},
            { name = "WEAPON_COMBATPISTOL"},
            { name = 'WEAPON_SPECIALCARBINE'},
            { name = 'WEAPON_HEAVYPISTOL'},
            { name = 'WEAPON_SMG'},
            { name = 'flashlight'},
            { name = 'bandage'},
            { name = 'adrenaline'},
            { name = 'disc_ammo_smg_large'},
            { name = "cuffs"},
            { name = "cuff_keys"},
            { name = 'disc_ammo_pistol_large'},
            { name = 'HeavyArmor'}
        }
    },

    Hunt = {
        Locations = {
             { x = 20.08, y = -1106.68, z = 28.8 },
 
         },
         Items = {
             { name = "WEAPON_MUSKET"},
             { name = "disc_ammo_musket"}
         }
     },

    FoodMachine = {
        Locations = {},
        Items = {
            {name = 'bread'}
        }
    },

    DrinkMachine = {
        Locations = {},
        Items = {
            {name = 'water'}
        }
    }
}

Config.Throwables = {
    WEAPON_MOLOTOV = 615608432,
    WEAPON_GRENADE = -1813897027,
    WEAPON_STICKYBOMB = 741814745,
    WEAPON_PROXMINE = -1420407917,
    WEAPON_SMOKEGRENADE = -37975472,
    WEAPON_PIPEBOMB = -1169823560,
    WEAPON_FLARE = 1233104067,
    WEAPON_SNOWBALL = 126349499
}

Config.FuelCan = 883325847

Config.PropList = {
    cash = {["model"] = 'prop_cash_pile_02', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    HeavyArmor = {["model"] = 'prop_bodyarmour_03', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    MedArmor = {["model"] = 'prop_bodyarmour_03', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    MountedScope = {["model"] = 'w_at_scope_medium', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    SmallArmor = {["model"] = 'prop_bodyarmour_03', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    Suppressor = {["model"] = 'w_at_sr_supp', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    bagofdope = {["model"] = 'prop_drug_package_02', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    trimmedweed = {["model"] = 'bkr_prop_weed_bud_pruned_01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    bankkey = {["model"] = 'hei_prop_heist_card_hack_02', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    binoculos = {["model"] = 'v_serv_ct_binoculars', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    blowtorch = {["model"] = 'prop_tool_blowtorch', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    blueberry_package = {["model"] = 'ng_proc_box_02a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    bottleWater_package = {["model"] = 'ng_proc_box_01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0}, -- NEED WORK
    bread = {["model"] = 'v_ret_247_bread1', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    water = {["model"] = 'prop_ld_flow_bottle', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0}, -- NEED WORK
    bulletproof = {["model"] = 'prop_bodyarmour_03', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    cigarett = {["model"] = 'ng_proc_cigarette01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    coffee = {["model"] = 'p_amb_coffeecup_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    cokeburn = {["model"] = 'hei_prop_hst_usb_drive', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    cuff_keys = {["model"] = 'prop_cuff_keys_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    cuffs = {["model"] = 'prop_cs_cuffs_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    dia_box = {["model"] = 'hei_prop_hei_security_case', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    disc_ammo_pistol = {["model"] = 'prop_box_ammo07a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    disc_ammo_pistol_large = {["model"] = 'prop_box_ammo07a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    disc_ammo_rifle = {["model"] = 'prop_box_ammo01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    disc_ammo_rifle_large = {["model"] = 'prop_box_ammo01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    disc_ammo_shotgun = {["model"] = 'prop_box_ammo01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    disc_ammo_shotgun_large = {["model"] = 'prop_box_ammo01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    disc_ammo_smg = {["model"] = 'prop_box_ammo01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    disc_ammo_smg_large = {["model"] = 'prop_box_ammo01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    disc_ammo_snp = {["model"] = 'prop_box_ammo01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    disc_ammo_snp_large = {["model"] = 'prop_box_ammo01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    drugscales = {["model"] = 'bkr_prop_coke_scale_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    ducttape = {["model"] = 'prop_ducktape_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    energy = {["model"] = 'prop_energy_drink', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    fabric = {["model"] = 'prop_sewing_fabric', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    fertilizer_25 = {["model"] = 'bkr_prop_weed_bucket_01d', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0}, -- NEED WORK
    firstaid = {["model"] = 'v_ret_ta_firstaid', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    firstaidkit = {["model"] = 'v_ret_ta_firstaid', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    fishingknife = {["model"] = 'prop_w_me_knife_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    fishingrod = {["model"] = 'prop_fishing_rod_02', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    flashlight = {["model"] = 'w_at_ar_flsh', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    gold_bar = {["model"] = 'hei_prop_heist_gold_bar', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    grapperaisin = {["model"] = 'prop_grapes_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    highgradefert = {["model"] = 'bkr_prop_weed_bucket_01d', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    holografik = {["model"] = 'w_at_scope_macro', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    hqscale = {["model"] = 'bkr_prop_coke_scale_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    id_card = {["model"] = 'hei_prop_heist_card_hack_02', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    idcard = {["model"] = 'hei_prop_heist_card_hack_02', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    key = {["model"] = 'prop_cuff_keys_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    laptop_h = {["model"] = 'gr_prop_gr_laptop_01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    largescope = {["model"] = 'w_at_scope_max', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    lighter = {["model"] = 'p_cs_lighter_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    lingot_gold = {["model"] = 'hei_prop_heist_gold_bar', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    lingot_iron = {["model"] = 'ex_office_swag_silver', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    lingot_silver = {["model"] = 'ex_office_swag_silver', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    livrocul = {["model"] = 'prop_cs_stock_book', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    mckey = {["model"] = 'prop_cuff_keys_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    medikit = {["model"] = 'v_ret_ta_firstaid', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    mediumscope = {["model"] = 'w_at_scope_medium', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    medkit = {["model"] = 'v_ret_ta_firstaid', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    meth = {["model"] = 'bkr_prop_meth_smallbag_01a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    methburn = {["model"] = 'hei_prop_hst_usb_drive', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    note = {["model"] = 'prop_notepad_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    notepad = {["model"] = 'prop_notepad_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    pacificidcard = {["model"] = 'hei_prop_heist_card_hack_02', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    phone = {["model"] = 'prop_npc_phone_02', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    plantpot = {["model"] = 'bkr_prop_weed_plantpot_stack_01b', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0}, -- NEED WORK
    playersafe = {["model"] = 'p_v_43_safe_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    powiekszonymagazynek = {["model"] = 'w_ar_advancedrifle_mag1', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    radio = {["model"] = 'prop_cs_walkie_talkie', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_WEAPON_CROWBAR = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_WEAPON_PISTOL = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_WEAPON_SWITCHBLADE = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_WEAPON_WRENCH = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_advancedlockpick = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_arma_armacaopistola = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_arma_cao = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_arma_cano = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_arma_gatilho = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_arma_mola = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_arma_percurssor = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_arma_tambor = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_cabplastico = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_cebmartelo = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_lamina = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_lockpick = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_molafaca = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_nail = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    recipe_plantpot = {["model"] = 'p_blueprints_01_s', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    rolex = {["model"] = 'p_watch_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    scrapmetal = {["model"] = 'prop_rub_scrap_06', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    screwdriver = {["model"] = 'prop_tool_screwdvr01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    silencieux = {["model"] = 'w_at_sr_supp', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    thermal_charge = {["model"] = 'hei_prop_heist_thermite', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    tomato_package = {["model"] = 'ng_proc_box_02a', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    usbhack = {["model"] = 'hei_prop_hst_usb_drive', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    water_50 = {["model"] = 'prop_water_bottle', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0}, -- NEED WORK
    wateringcan = {["model"] = 'prop_wateringcan', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0}, -- NEED WORK
    weed_100 = {["model"] = 'hei_prop_heist_weed_block_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    weed_brick = {["model"] = 'hei_prop_heist_weed_block_01', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0},
    weedburn = {["model"] = 'hei_prop_hst_usb_drive', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0}
}