local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData = {}
--local CurrentActionData = {}
--local lastTime = 0
local used = 0


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

-- Start of Oxygen Mask

RegisterNetEvent('tqrp_extraitems:oxygen_mask')
AddEventHandler('tqrp_extraitems:oxygen_mask', function()
	local playerPed  = PlayerPedId()
	local coords     = GetEntityCoords(playerPed)
	local boneIndex  = GetPedBoneIndex(playerPed, 12844)
	local boneIndex2 = GetPedBoneIndex(playerPed, 24818)

	ESX.Game.SpawnObject('p_s_scuba_mask_s', {
		x = coords.x,
		y = coords.y,
		z = coords.z - 3
	}, function(object)
		ESX.Game.SpawnObject('p_s_scuba_tank_s', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object2)
			AttachEntityToEntity(object2, playerPed, boneIndex2, -0.30, -0.22, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			AttachEntityToEntity(object, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			SetPedDiesInWater(playerPed, false)

			ESX.ShowNotification(_U('dive_suit_on') .. '%.')
			Citizen.Wait(180000)
			ESX.ShowNotification(_U('oxygen_notify', '~y~', '50') .. '%.')
			Citizen.Wait(100000)
			ESX.ShowNotification(_U('oxygen_notify', '~o~', '25') .. '%.')
			Citizen.Wait(160000)
			ESX.ShowNotification(_U('oxygen_notify', '~r~', '0') .. '%.')

			SetPedDiesInWater(playerPed, true)
			DeleteObject(object)
			DeleteObject(object2)
			ClearPedSecondaryTask(playerPed)
		end)
	end)
end)

-- End of Oxygen Mask
-- Start of Bullet Proof Vest

--[[RegisterCommand('fullarmor', function(...)
	local playerPed = PlayerPedId()
	--SetPedComponentVariation(playerPed, 9, 27, 9, 2)
	AddArmourToPed(playerPed, 100)
	SetPedArmour(playerPed, 100)
end)]]


RegisterNetEvent('tqrp_extraitems:bulletproof')
AddEventHandler('tqrp_extraitems:bulletproof', function()
	local playerPed = PlayerPedId()
	SetPedComponentVariation(playerPed, 9, 27, 9, 2)
	AddArmourToPed(playerPed, 100)
	SetPedArmour(playerPed, 100)
end)


-- End of Oxygen Mask
-- Start of Bullet Proof Vest

RegisterNetEvent('tqrp_extraitems:joint')
AddEventHandler('tqrp_extraitems:joint', function()
	if IsPedOnFoot(PlayerPedId()) then
		TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_DRUG_DEALER', 0, true)
	end
	exports['mythic_progbar']:Progress({
		name = "smk",
		duration = 25000,
		label = "A fumar..",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {},
        animation = {
            animDict = "",
            anim = "",
            flags = nil,
        },
        prop = {
            model = ""
        },
	  }, function(status)
		if not status then
			local playerPed = PlayerPedId()
			ClearPedSecondaryTask(playerPed)
			TriggerEvent('tqrp_status:getStatus', 'stress', function(status)
				TriggerEvent("tqrp_status:remove", "stress", 350000)
				SetTimecycleModifier("Barry1_Stoned")
				SetPedMotionBlur(playerPed, true)
				SetPedMovementClipset(playerPed, "move_m@hipster@a", true)

				--Efects
				local player = PlayerId()
				SetRunSprintMultiplierForPlayer(player, 1.5)
				SetSwimMultiplierForPlayer(player, 1.5)
				Wait(300000)
				ResetPlayerStamina(PlayerId())
				ClearTimecycleModifier()
				SetSwimMultiplierForPlayer(player, 1.0)
				SetRunSprintMultiplierForPlayer(player, 1.0)
				SetPedMotionBlur(playerPed, false)
			end)
		end
	  end)
end)

-- End of Bullet Proof Vest
-- Start of First Aid Kit

RegisterNetEvent('tqrp_extraitems:firstaidkit')
AddEventHandler('tqrp_extraitems:firstaidkit', function()
	local playerPed = PlayerPedId()
	local health = GetEntityHealth(playerPed)
	local max = GetEntityMaxHealth(playerPed)

	if health > 0 and health < max then
		--ESX.ShowNotification(_U('use_firstaidkit'))
		exports['mythic_notify']:SendAlert('inform', 'Usas te um Kit Médico')


		health = health + (max / 4)
		if health > max then
			health = max
		end
		SetEntityHealth(playerPed, health)
	end
end)

-- End of First Aid Kit

-- Start do Silenciador
RegisterNetEvent('tqrp_extraitems:Suppressor')
AddEventHandler('tqrp_extraitems:Suppressor', function(duration)
	local inventory = ESX.GetPlayerData().inventory
	local Suppressor = 0
	for i=1, #inventory, 1 do
	  if inventory[i].name == 'Suppressor' then
		Suppressor = inventory[i].count
	  end
	end

    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used26 <= Suppressor then
				if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
					GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP_02"))
					--ESX.ShowNotification(_U('equip'))
					used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_SNSPISTOL_MK2") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_SNSPISTOL_MK2"), GetHashKey("COMPONENT_AT_PI_SUPP_02"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_AT_PI_SUPP_02"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_PI_SUPP"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_SMG_MK2") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_SMG_MK2"), GetHashKey("COMPONENT_AT_PI_SUPP"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_VINTAGEPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
						GiveWeaponComponentToPed(PlayerPedId(), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_AR_SUPP"))
						--ESX.ShowNotification(_U('equip'))
						used26 = used26 + 1


		  	else
				ESX.ShowNotification(_U('error1'))

			end
		else
			ESX.ShowNotification(_U('error2'))

		end
end)
-- End of First Aid Kit

