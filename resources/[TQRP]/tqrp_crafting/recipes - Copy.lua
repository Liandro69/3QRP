--Drugz
Recipes = {
  ["bagofdope"] = {
    "weed",        "weed",  "dopebag",
     false,  "drugscales",      false,
     false,         false,      false,
  },
  ["advancedlockpick"] = { -- 01.06.2018
    "nail",        "lingot_iron",  "nail",
    "nail",  "lockpick",      "nail",
    "blowtorch",         "bobbypin",      "WEAPON_HAMMER",
  },
  ["plantpot"] = { -- 01.06.2018
    "fertilizer_25",        "fertilizer_25",  "fertilizer_25",
    "stone",  "terra",      "stone",
    "full_waterBottle",         "terra",      "full_waterBottle",
  },
  ["WEAPON_SWITCHBLADE"] = { -- 01.06.2018
    "screw",        "screw",  "lamina",
    "screw",  "lingot_iron",      "screw",
    "cabplastico",         "screwdriver",      "blowtorch",
  },
  ["WEAPON_PISTOL"] = { -- 01.06.2018
    "arma_cao",        "arma_percurssor",  "arma_cano",
    "arma_mola",  "arma_tambor",      "arma_gatilho",
    "arma_armacaopistola",         "screwdriver",      "blowtorch",
  },
  ["lockpick"] = { -- 28.05.2018
    "scrapmetal",        "scrapmetal",  "scrapmetal",
    "screw",  "lingot_iron",      "screw",
    "WEAPON_HAMMER",         "screwdriver",      "blowtorch",
  },
  ["lamina"] = { -- 01.06.2018
    "scrapmetal",        "scrapmetal",  "scrapmetal",
    "scrapmetal",  "scrapmetal",      "scrapmetal",
    "scrapmetal",         "WEAPON_HAMMER",      "blowtorch",
  },
  ["WEAPON_MACHETE"] = { -- 01.06.2018
    "screw",        "screwdriver",  "lamina",
    "screw",  "lamina",      "lingot_iron",
    "cabplastico",         "screw",      "blowtorch",

  },
  ["WEAPON_MACHINEPISTOL"] = { -- 01.06.2018
    "massademira",        "arma_percurssor",  "arma_cano",
    "arma_cao",  "arma_mola",      "arma_gatilho",
    "tec9_body",         "screwdriver",      "blowtorch",
  },
  ["WEAPON_DBSHOTGUN"] = {  --28.05.2018
    "armacaodb",        "arma_cano",  "arma_cao",
    "arma_cano",  "arma_mola",      "arma_gatilho",
    "WEAPON_HAMMER",         "armacaodb",      "WEAPON_WRENCH",
  },
  ["WEAPON_WRENCH"] = { -- 28.05.2018
    "lingot_iron",        "lingot_iron",  "lingot_iron",
    "lingot_iron",  "scrapmetal",      "scrapmetal",
    "lingot_iron",         "WEAPON_HAMMER",      "blowtorch",
  },
  ["arma_cano"] = { -- 01.06.2018
    "scrapmetal",        "scrapmetal",  "lingot_iron",
    "scrapmetal",  "scrapmetal",      "copper",
    "scrapmetal",         "WEAPON_HAMMER",      "blowtorch",
  },
  ["cabomadeira"] = { -- 01.06.2018
    "pine_processed",        "nail",  "pine_processed",
    false,  "nail",      false,
    false,         "WEAPON_HAMMER",      false,
  },
  ["WEAPON_HAMMER"] = { -- 28.05.2018
    "screw",        "screwdriver",  "lingot_iron",
    "screw",  "rope",      "lingot_iron",
    "screw",         "cabomadeira",      "blowtorch",
  },
  ["nail"] = { -- 28.05.2018
    "iron_piece",        "iron_piece",  "iron_piece",
    "iron_piece",  "iron_piece",      "iron_piece",
    "iron_piece",         "WEAPON_HAMMER",      "blowtorch",
  },
  ["screw"] = { -- 28.05.2018
    "iron_piece",        "iron_piece",  "iron_piece",
    "iron_piece",  "iron_piece",      "iron_piece",
    "iron_piece",         "blowtorch",      "WEAPON_HAMMER",
  },
  ["recipe_massademira"] = { -- 28.05.2018
    "borracha",        "borracha",  "borracha",
    "borracha",  "screw",      "borracha",
    "borracha",         "fishingknife",      "borracha",
  },
  ["recipe_armacaodb"] = { -- 28.05.2018
    "cabomadeira",        "lingot_iron",  "cabomadeira",
    "lingot_gold",  "lingot_gold",      "lingot_gold",
    "WEAPON_HAMMER",         "bobbypin",      "WEAPON_WRENCH",
  },
}

KeepItems = {
  ["bagofdope"] = {
     false,         false,      false,
     false,          true,      false,
     false,         false,      false,
  },
  ["advancedlockpick"] = {
    false,         false,      false,
    false,          false,      false,
    true,         false,      true,
 },
  ["plantpot"] = {
    false,         false,      false,
    false,          false,      false,
    false,         false,      false,
 },
  ["WEAPON_SWITCHBLADE"] = {
    false,         false,      false,
    false,          false,      false,
    false,         true,      false,
 },
  ["WEAPON_PISTOL"] = {
    false,         false,      false,
    false,          false,      false,
    false,         false,      false,
 },
  ["lockpick"] = {
    false,         false,      false,
    false,          false,      false,
    true,         false,      true,
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
    false,         false,      false,
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
    false,         false,      false,
    false,          false,      false,
    false,         true,      false,
 },
  ["WEAPON_HAMMER"] = {
    false,         true,      false,
    false,          false,      false,
    false,         false,      true,
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
    ["recipe_massademira"] = {
    false,         false,      false,
    false,          false,      false,
    false,         false,      false,
 },
     ["recipe_armacaodb"] = {
    false,         false,      false,
    false,          false,      false,
    false,         false,      false,
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
  ["cabomadeira"] = 1,
  ["WEAPON_HAMMER"] = 1,
  ["nail"] = 80,
  ["screw"] = 80,
  ["massademira"] = 1,
  ["armacaodb"] = 1,
}

CraftTime = {
  ["bagofdope"] = 1.0,
  ["advancedlockpick"] = 60.0,
  ["plantpot"] = 15.0,
  ["WEAPON_SWITCHBLADE"] = 60.0,
  ["WEAPON_PISTOL"] = 120.0,
  ["lockpick"] = 30.0,
  ["lamina"] = 15.0,
  ["WEAPON_MACHETE"] = 60.0,
  ["WEAPON_MACHINEPISTOL"] = 120.0,
  ["WEAPON_DBSHOTGUN"] = 120.0,
  ["WEAPON_WRENCH"] = 60.0,
  ["arma_cano"] = 30.0,
  ["cabomadeira"] = 15.0,
  ["WEAPON_HAMMER"] = 30.0,
  ["nail"] = 35.0,
  ["screw"] = 35.0,
  ["massademira"] = 30.0,
  ["armacaodb"] = 60.0,
}