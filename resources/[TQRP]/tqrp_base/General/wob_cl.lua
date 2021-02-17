ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

PlayerData = ESX.GetPlayerData()
Settings = {
  rifles = {
    bone = 24816,
    x = 0.27,
    y = -0.17,
    z = -0.02,
    x_rotation = 0.0,
    y_rotation = 165.0,
    z_rotation = 0.0
  },
  pistols = {
    bone = 11816,
    x = 0.0,
    y = 0.0,
    z = 0.21,
    x_rotation = 270.0,
    y_rotation = 0.0,
    z_rotation = 0.0
  },
  melee = {
    bone = 24816,
    x = 0.13,
    y = -0.17,
    z = -0.02,
    x_rotation = 0.0,
    y_rotation = 90.0,
    z_rotation = 0.0
  },
  compatable_weapon_hashes = {
    -- Assault Rifles
    ["w_ar_advancedrifle"] = "WEAPON_ADVANCEDRIFLE",
    ["w_ar_assaultrifle"] = "WEAPON_ASSAULTRIFLE",
    ["w_ar_assaultriflemk2"] = "WEAPON_ASSAULTRIFLE_MK2",
    ["w_ar_bullpuprifle"] = "WEAPON_BULLPUPRIFLE",
    ["w_ar_bullpupriflemk2"] = "WEAPON_BULLPUPRIFLE_MK2",
    ["w_ar_carbinerifle"] = "WEAPON_CARBINERIFLE",
    ["w_ar_carbineriflemk2"] = "WEAPON_CARBINERIFLE_MK2",
    ["w_ar_assaultrifle_smg"] = "WEAPON_COMPACTRIFLE",
    ["w_ar_specialcarbine"] = "WEAPON_SPECIALCARBINE",
    ["w_ar_specialcarbinemk2"] = "WEAPON_SPECIALCARBINE_MK2",

    -- Melee
    ["p_cs_bbbat_01"] = "WEAPON_BAT",
    ["w_me_crowbar"] = "WEAPON_CROWBAR",
    ["w_me_wrench"] = "WEAPON_WRENCH",

    -- Shotguns
    ["w_sg_assaultshotgun"] = "WEAPON_ASSAULTSHOTGUN",
    ["w_sg_sweeper"] = "WEAPON_AUTOSHOTGUN",
    ["w_sg_bullpupshotgun"] = "WEAPON_BULLPUPSHOTGUN",
    ["w_sg_doublebarrel"] = "WEAPON_DBSHOTGUN",
    ["w_sg_heavyshotgun"] = "WEAPON_HEAVYSHOTGUN",
    ["w_ar_musket"] = "WEAPON_MUSKET",
    ["w_sg_pumpshotgun"] = "WEAPON_PUMPSHOTGUN",
    ["w_sg_pumpshotgunmk2"] = "WEAPON_PUMPSHOTGUN_MK2",
    ["w_sg_sawnoff"] = "WEAPON_SAWNOFFSHOTGUN",

    -- Sniper Rifles
    ["w_sr_heavysniper"] = "WEAPON_HEAVYSNIPER",
    ["w_sr_heavysnipermk2"] = "WEAPON_HEAVYSNIPER_MK2",
    ["w_sr_marksmanrifle"] = "WEAPON_MARKSMANRIFLE",
    ["w_sr_marksmanriflemk2"] = "WEAPON_MARKSMANRIFLE_MK2",
    ["w_sr_sniperrifle"] = "WEAPON_SNIPERRIFLE",

    -- Submachines Guns & Light Machine Guns
    ["w_sb_assaultsmg"] = "WEAPON_ASSAULTSMG",
    ["w_mg_combatmg"] = "WEAPON_COMBATMG",
    ["w_mg_combatmgmk2"] = "WEAPON_COMBATMG_MK2",
    ["w_sb_pdw"] = "WEAPON_COMBATPDW",
    ["w_sb_gusenberg"] = "WEAPON_GUSENBERG",
    ["w_mg_mg"] = "WEAPON_MG",
    ["w_sb_microsmg"] = "WEAPON_MICROSMG",
    ["w_sb_minismg"] = "WEAPON_MINISMG",
    ["w_sb_smg"] = "WEAPON_SMG",
    ["w_sb_smgmk2"] = "WEAPON_SMG_MK2",
    ["w_ar_srifle"] = "WEAPON_RAYCARBINE",

    --[[ Throw Weapons
    ["w_am_baseball"] = "WEAPON_BALL",
    ["w_ex_grenadesmoke"] = "WEAPON_BZGAS",
    ["w_am_flare"] = "WEAPON_FLARE",
    ["w_ex_grenadefrag"] = "WEAPON_GRENADE",
    ["w_am_jerrycan"] = "WEAPON_PETROLCAN",
    ["w_ex_molotov"] = "WEAPON_MOLOTOV",
    ["w_am_jerrycan"] = "WEAPON_PETROLCAN",
    ["w_ex_apmine"] = "WEAPON_PROXMINE",
    ["w_ex_pipebomb"] = "WEAPON_PIPEBOMB",
    ["w_ex_snowball"] = "WEAPON_SNOWBALL",
    ["w_ex_pe"] = "WEAPON_STICKYBOMB",
    ["w_ex_grenadesmoke"] = "WEAPON_SMOKEGRENADE",]]
  }
}
attached_weapons = {}

function AttachWeapon(attachModel, modelHash, weaponGroup)
	local bone = 0

	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
    Wait(0)
	end

  attached_weapons[attachModel] = {
    hash = modelHash,
    handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false)
  }

  if weaponGroup == 'pistols' then
    x = Settings.pistols.x y = Settings.pistols.y z = Settings.pistols.z xR = Settings.pistols.x_rotation yR = Settings.pistols.y_rotation zR = Settings.pistols.z_rotation bone = GetPedBoneIndex(PlayerPedId(), Settings.pistols.bone)
  elseif weaponGroup == 'melee' then
    x = Settings.melee.x y = Settings.melee.y z = Settings.melee.z xR = Settings.melee.x_rotation yR = Settings.melee.y_rotation zR = Settings.melee.z_rotation bone = GetPedBoneIndex(PlayerPedId(), Settings.melee.bone)
  else
    x = Settings.rifles.x y = Settings.rifles.y z = Settings.rifles.z xR = Settings.rifles.x_rotation yR = Settings.rifles.y_rotation zR = Settings.rifles.z_rotation bone = GetPedBoneIndex(PlayerPedId(), Settings.rifles.bone)
  end

	AttachEntityToEntity(attached_weapons[attachModel].handle, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end

function weaponGroup(wep_name)
  if 
    wep_name == 'w_pi_appistol' or 
    wep_name == 'w_pi_ceramic_pistol' or 
    wep_name == 'w_pi_combatpistol' or 
    wep_name == 'w_pi_wep1_gun' or 
    wep_name == 'w_pi_flaregun' or 
    wep_name == 'w_pi_heavypistol' or 
    wep_name == 'w_pi_revolver' or 
    wep_name == 'w_pi_revolvermk2' or 
    wep_name == 'w_pi_singleshot' or 
    wep_name == 'w_pi_wep2_gun' or 
    wep_name == 'w_pi_pistol' or 
    wep_name == 'w_pi_pistolmk2' or 
    wep_name == 'w_pi_pistol50' or 
    wep_name == 'w_pi_sns_pistol' or 
    wep_name == 'w_pi_sns_pistolmk2' or 
    wep_name == 'w_pi_stungun' or 
    wep_name == 'w_pi_raygun' or 
    wep_name == 'w_pi_vintage_pistol' 
  then
    return 'pistols'
  elseif 
--[[     wep_name == 'w_me_battleaxe' or 
    wep_name == 'w_me_bottle' or 
    wep_name == 'w_me_flashlight' or 
    wep_name == 'w_me_gclub' or 
    wep_name == 'w_me_knuckle' or 
    wep_name == 'w_me_machette_lr' or 
    wep_name == 'w_me_nightstick' or 
    wep_name == 'w_me_poolcue' or 
    wep_name == 'w_me_stonehatchet' or 
    wep_name == 'w_me_switchblade'  ]]
    wep_name == 'w_me_wrench' or
    wep_name == 'w_me_crowbar' or
    wep_name == 'p_cs_bbbat_01'
  then
    return 'melee'
  else
    return 'rifles'
  end
end

function GetInventoryItem(name)
  while not PlayerData.inventory do
    Citizen.Wait(7)
  end
  local inventory = PlayerData.inventory
  for i=1, #inventory, 1 do
    if inventory[i].name == name and inventory[i].count >= 1 then
      return inventory[i]
    end
  end
  return false
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
  Citizen.Wait(100)
  PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
  if string.find(item, "WEAPON_", 1) ~= nil then
		Citizen.Wait(100)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
  if string.find(item, "WEAPON_", 1) ~= nil then
    Citizen.Wait(100)
    PlayerData = ESX.GetPlayerData()
  end
end)
