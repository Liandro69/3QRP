--Drugz
Recipes = {
  ["bagofdope"] = {
    "weed",        "weed",  "dopebag",
     false,  "drugscales",      false,
     false,         false,      false,
  },
  ["advancedlockpick"] = { -- 17.07.2020
    "WEAPON_HAMMER",        "bobbypin",  "nail",
    "nail",  "lockpick",      "nail",
    "blowtorch",         "nail",      "nail",
  },
  ["plantpot"] = { -- 01.06.2020
    "fertilizer_25",        "fertilizer_25",  "fertilizer_25",
    "stone",  "terra",      "stone",
    "full_waterBottle",         "terra",      "full_waterBottle",
  },
  ["WEAPON_SWITCHBLADE"] = { -- 17.07.2020
    "blowtorch",        "screw",  "lamina",
    "screwdriver",  "screw",      "lingot_iron",
    "cabplastico",         "screwdriver",      "blowtorch",
  },
  ["WEAPON_PISTOL"] = { -- 17.07.2020
    "arma_armacaopistola",        "arma_percurssor",  "arma_cano",
    "arma_tambor",  "arma_mola",      "arma_gatilho",
    "arma_cao",         "screwdriver",      "WEAPON_HAMMER",
  },
  ["lockpick"] = { -- 17.07.2020
    "WEAPON_HAMMER",        "blowtorch",  "scrapmetal",
    "screw",  "lingot_iron",      "screw",
    "scrapmetal",         "scrapmetal",      "screwdriver",
  },
  ["lamina"] = { -- 01.06.2020
    "scrapmetal",        "scrapmetal",  "scrapmetal",
    "scrapmetal",  "scrapmetal",      "scrapmetal",
    "scrapmetal",         "WEAPON_HAMMER",      "blowtorch",
  },
  ["WEAPON_MACHETE"] = { -- 17.07.2020
    "screw",        "screwdriver",  "blowtorch",
    "screw",  "lingot_iron",      "lamina",
    "cabplastico",         "screw",      "lamina",
  },
  ["WEAPON_MACHINEPISTOL"] = { -- 17.07.2020
    "blowtorch",        "massademira",  "arma_cano",
    "arma_gatilho",  "arma_mola",      "tec9_body",
    "arma_cao",         "WEAPON_HAMMER",      "arma_percurssor",
  },
  ["WEAPON_DBSHOTGUN"] = {  --17.07.2020
    "armacaodb",        "arma_cao",  "arma_cao",
    "arma_cano",  "arma_gatilho",      "arma_mola",
    "WEAPON_WRENCH",         "armacaodb",      "WEAPON_HAMMER",
  },
  ["WEAPON_WRENCH"] = { -- 17.07.2020
    "lingot_iron",        "scrapmetal",  "scrapmetal",
    "lingot_iron",  "lingot_iron",      "lingot_iron",
    "lingot_iron",         "blowtorch",      "WEAPON_HAMMER",
  },
  ["arma_cano"] = { -- 17.07.2020
    "scrapmetal",        "scrapmetal",  "copper",
    "scrapmetal",  "scrapmetal",      "lingot_iron",
    "scrapmetal",         "blowtorch",      "WEAPON_HAMMER",
  },
  ["cabomadeira"] = { -- 17.07.2020
    "nail",        "pine_processed",  "WEAPON_HAMMER",
    "pine_processed",  "nail",      "pine_processed",
    "pine_processed",         "pine_processed",      "pine_processed",
  },
  ["WEAPON_HAMMER"] = { -- 17.07.2020
    "screw",        "cabomadeira",  "blowtorch",
    "screw",  "rope",      "lingot_iron",
    "screw",         "screwdriver",      "lingot_iron",
  },
  ["nail"] = { -- 17.07.2020
    "iron_piece",        "iron_piece",  "blowtorch",
    "iron_piece",  "WEAPON_HAMMER",      "iron_piece",
    "iron_piece",         "iron_piece",      "iron_piece",
  },
  ["screw"] = { -- 28.05.2020
    "iron_piece",        "iron_piece",  "iron_piece",
    "iron_piece",  "iron_piece",      "iron_piece",
    "iron_piece",         "blowtorch",      "WEAPON_HAMMER",
  },
  ["recipe_massademira"] = { -- 28.05.2020
    "borracha",        "borracha",  "borracha",
    "borracha",  "screw",      "borracha",
    "borracha",         "fishingknife",      "borracha",
  },
  ["recipe_armacaodb"] = { -- 17.07.2020
    "WEAPON_WRENCH",        "lingot_gold",  "cabomadeira",
    "lingot_iron",  "lingot_iron",      "lingot_gold",
    "WEAPON_HAMMER",         "bobbypin",      "cabomadeira",
  },
  ["WEAPON_MINISMG"] = { -- 17.07.2020
    "WEAPON_WRENCH",        "WEAPON_MACHINEPISTOL",  "arma_armacaopistola",
    "cabomadeira",  "arma_cano",      "lingot_gold",
    "WEAPON_HAMMER",         "bobbypin",      "cabomadeira",
  },
  ["WEAPON_HEAVYPISTOL"] = { -- 17.07.2020
    "arma_armacaopistola",        "arma_armacaopistola",  "arma_armacaopistola",
    "arma_gatilho",  "arma_mola",      "massademira",
    "WEAPON_HAMMER",         "arma_cao",      "cabomadeira",
  },
  ["arma_armacaopistola"] = { -- 17.07.2020
    "iron_piece",        "iron_piece",  "scrapmetal",
    "iron_piece",  "iron_piece",      "scrapmetal",
    "WEAPON_HAMMER",         "blowtorch",      "scrapmetal",
  },
}

KeepItems = {
  ["bagofdope"] = {
     false,         false,      false,
     false,          true,      false,
     false,         false,      false,
  },
  ["advancedlockpick"] = {
    true,         false,      false,
    false,          false,      false,
    true,         false,      false,
 },
  ["plantpot"] = {
    false,         false,      false,
    false,          false,      false,
    false,         false,      false,
 },
  ["WEAPON_SWITCHBLADE"] = {
    true,         false,      false,
    false,          false,      false,
    false,         false,      false,
 },
  ["WEAPON_PISTOL"] = {
    false,         false,      false,
    false,          false,      false,
    false,         false,      false,
 },
  ["lockpick"] = {
    true,         true,      false,
    false,          false,      false,
    false,         false,      true,
 },
  ["lamina"] = {
    false,         false,      false,
    false,          false,      false,
    false,         true,      true,
 },
  ["WEAPON_MACHETE"] = {
    false,         true,      false,
    false,          false,      false,
    false,         false,      false,
 },
  ["WEAPON_MACHINEPISTOL"] = {
    false,         false,      false,
    false,          false,      false,
    false,         false,      false,
 },
  ["WEAPON_DBSHOTGUN"] = {
    false,         false,      false,
    false,          false,      false,
    true,         false,      true,
 },
  ["WEAPON_WRENCH"] = {
    false,         false,      false,
    false,          false,      false,
    false,         true,      false,
 },
  ["arma_cano"] = {
    false,         false,      false,
    false,          false,      false,
    false,         true,      true,
 },
  ["cabomadeira"] = {
    false,         false,      true,
    false,          false,      false,
    false,         false,      false,
 },
  ["WEAPON_HAMMER"] = {
    false,         false,      true,
    false,          false,      false,
    false,         true,      false,
 },
  ["nail"] = {
    false,         false,      false,
    false,          false,      false,
    false,         false,      true,
 },
  ["screw"] = {
    false,         false,      false,
    false,          false,      false,
    false,         true,      false,
 },
    ["massademira"] = {
    false,         false,      false,
    false,          false,      false,
    false,         false,      false,
 },
     ["armacaodb"] = {
    false,         false,      false,
    false,          false,      false,
    false,         false,      false,
 },
     ["WEAPON_MINISMG"] = {
    true,         false,      false,
    false,          false,      false,
    true,         false,      false,
 },
     ["arma_armacaopistola"] = {
    false,         false,      false,
    false,          false,      false,
    true,         false,      false,
 },
}

RecipeRewards = {
  ["bagofdope"] = 5,
  ["advancedlockpick"] = 1,
  ["plantpot"] = 1,
  ["WEAPON_SWITCHBLADE"] = 1,
  ["WEAPON_PISTOL"] = 1,
  ["lockpick"] = 1,
  ["lamina"] = 1,
  ["WEAPON_MACHETE"] = 1,
  ["WEAPON_MACHINEPISTOL"] = 1,
  ["WEAPON_DBSHOTGUN"] = 1,
  ["WEAPON_WRENCH"] = 1,
  ["arma_cano"] = 1,
  ["cabomadeira"] = 5,
  ["WEAPON_HAMMER"] = 1,
  ["nail"] = 80,
  ["screw"] = 80,
  ["massademira"] = 1,
  ["armacaodb"] = 1,
  ["WEAPON_MINISMG"] = 1,
  ["WEAPON_HEAVYPISTOL"] = 1,
  ["arma_armacaopistola"] = 1,
}

CraftTime = {
  ["bagofdope"] = 1.0,
  ["advancedlockpick"] = 30.0,
  ["plantpot"] = 15.0,
  ["WEAPON_SWITCHBLADE"] = 60.0,
  ["WEAPON_PISTOL"] = 60.0,
  ["lockpick"] = 15.0,
  ["lamina"] = 15.0,
  ["WEAPON_MACHETE"] = 60.0,
  ["WEAPON_MACHINEPISTOL"] = 120.0,
  ["WEAPON_DBSHOTGUN"] = 120.0,
  ["WEAPON_WRENCH"] = 30.0,
  ["arma_cano"] = 15.0,
  ["cabomadeira"] = 5.0,
  ["WEAPON_HAMMER"] = 15.0,
  ["nail"] = 30.0,
  ["screw"] = 30.0,
  ["massademira"] = 15.0,
  ["armacaodb"] = 30.0,
  ["WEAPON_MINISMG"] = 60.0,
  ["WEAPON_HEAVYPISTOL"] = 60.0,
  ["arma_armacaopistola"] = 30.0,
}