ESX          = nil
local IsDead = false
local IsAnimated = false
local IsAlreadyDrunk = false
local DrunkLevel     = -1
local armorLoaded = false
local DoEffects = false
local Acidos = false
local Forum = false
local Hostia = false
local crafting = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

-- SISTEMA DE CRAFT DESCOMENTAR QUANDO PRONTO

local Skillbar = false

RegisterNetEvent('tqrp_basicneeds:craft')
AddEventHandler('tqrp_basicneeds:craft', function(table)
	if not crafting then
		crafting = true
		Skillbar = exports['tqrp_skillbar']:GetSkillbarObject()
		Skillbar.Start({
			duration = math.random(4500, 6500),
			pos = math.random(10, 80),
			width = math.random(10, 15),
		}, function()
			TriggerServerEvent("tqrp_basicneeds:sucessCraft", table)
			crafting = false
		end, function()
			crafting = false
		end)
	end
end)


Citizen.CreateThread(function()
	local sleep = 3000
	while true do

        if DoEffects then
			SetPedMoveRateOverride(PlayerPedId(), 2.0)
			exports["acidtrip"]:DoAcid(60000)
			sleep = 16
		end

		if Acidos then
			SetPedMoveRateOverride(PlayerPedId(), 4.0)
			sleep = 16
		end

		if Forum then
			SetPedMoveRateOverride(PlayerPedId(), 1.0)
			sleep = 16
		end

		if Hostia then
			SetPedMoveRateOverride(PlayerPedId(), 2.0)
			sleep = 16
		end

		Citizen.Wait(sleep)
		sleep = 3000
    end
end)

RegisterNetEvent('usameta')
AddEventHandler('usameta', function()

    DoEffects = true
    Citizen.Wait(10000)
	DoEffects = false

end)

RegisterNetEvent('forumd')
AddEventHandler('forumd', function()

	Forum = true
	ShakeGameplayCam('FAMILY5_DRUG_TRIP_SHAKE', 3.5)
	SetTimecycleModifier("drug_drive_blend01")
	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 0.1, "fdboavibe", 1.0)
	Citizen.Wait(52000)
	ClearPedTasks(PlayerPedId())
	SetTimecycleModifier()
	ShakeGameplayCam('FAMILY5_DRUG_TRIP_SHAKE', 0.0)
	Forum = false

end)

RegisterNetEvent('hostia')
AddEventHandler('hostia', function()

	Hostia = true
	SetTimecycleModifier("StuntFastDark")
	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 0.1, "anon", 0.1)
	Citizen.Wait(210000)
	ClearPedTasks(PlayerPedId())
	SetTimecycleModifier()
	Hostia = false

end)

RegisterNetEvent('usa2')
AddEventHandler('usa2', function()

	Acidos = true
	--exports["acidtrip"]:DoAcid(8000)
	ShakeGameplayCam('FAMILY5_DRUG_TRIP_SHAKE', 2.5)
	SetTimecycleModifier("prologue_ending_fog")
	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 0.1, "trance2", 2.5)
	Citizen.Wait(35000)
	ClearPedTasks(PlayerPedId())
	SetTimecycleModifier()
	ShakeGameplayCam('FAMILY5_DRUG_TRIP_SHAKE', 0.0)
	Acidos = false

end)

InitPed = function()
  local plyPed = GetPlayerPed(-1)
  local pos = GetEntityCoords(plyPed)

  local randomAlt     = math.random(0,359)
  local randomDist    = math.random(50,80)
  local spawnPos      = pos + PointOnSphere(0.0,randomAlt,randomDist)

  while World3dToScreen2d(spawnPos.x,spawnPos.y,spawnPos.z) and not IsPointOnRoad(spawnPos.x,spawnPos.y,spawnPos.z) do
    randomAlt   = math.random(0,359)
    randomDist  = math.random(50,80)
    spawnPos    = GetEntityCoords(GetPlayerPed(-1)) + PointOnSphere(0.0,randomAlt,randomSphere)
    Citizen.Wait(0)
  end

  EvilPed = ClonePed(plyPed, GetEntityHeading(plyPed), false, false)
  Wait(10)
  SetEntityCoordsNoOffset(EvilPed, spawnPos.x,spawnPos.y,spawnPos.z + 1.0)
  SetPedComponentVariation(EvilPed, 1, 60, 0, 0, 0)

  SetEntityInvincible(EvilPed,true)
  SetBlockingOfNonTemporaryEvents(EvilPed,true)

  TrackEnt()
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	Citizen.Wait(1500)
	Citizen.CreateThread(function()
		TriggerEvent('tqrp_status:getStatus', 'armor', function(status)
			Citizen.Wait(2000)
			SetPedArmour(PlayerPedId(), status.val)
			armorLoaded = true
		end)
	end)
end)


AddEventHandler('tqrp_basicneeds:resetStatus', function()
	TriggerEvent('tqrp_status:set', 'hunger', 500000)
	TriggerEvent('tqrp_status:set', 'thirst', 500000)
	TriggerEvent('tqrp_status:set', 'stress', 10)
	TriggerEvent('tqrp_status:set', 'armor', 0)
end)

RegisterNetEvent('tqrp_basicneeds:healPlayer')
AddEventHandler('tqrp_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('tqrp_status:set', 'hunger', 500000)
	TriggerEvent('tqrp_status:set', 'thirst', 500000)
	TriggerEvent('tqrp_status:set', 'stress', 0)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))

	-- Ferimentos
	exports["mythic_hospital"]:ResetAll()
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('tqrp_basicneeds:resetStatus')
	end

	IsDead = false
end)


AddEventHandler('tqrp_status:loaded', function(status)

	TriggerEvent('tqrp_status:registerStatus', 'hunger', 1000000, '#FFFF00', function(status) -- #CFAD0F -- Amarelo
		return true
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('tqrp_status:registerStatus', 'thirst', 1000000, '#0099FF', function(status) -- #0C98F1 -- Azul
		return true
	end, function(status)
		status.remove(75)
	end)

	TriggerEvent('tqrp_status:registerStatus', 'stress', 0, '#c03b3b', function(status) -- #c03b3b -- Azul
		return true
	end, function(status)
		status.remove(10)
	end)

	TriggerEvent('tqrp_status:registerStatus', 'armor', 0, '#0099FF', function(status) -- #0C98F1 -- Azul
		return true
	end, function(status)
		status.remove(0)
	end)

	--- FIX PEDS SPAWNAM SEM VIDA
	SetEntityHealth(PlayerPedId(), 200)

	Citizen.CreateThread(function()
		local playerPed  = PlayerPedId()
		local prevHealth = GetEntityHealth(playerPed)
		local health     = prevHealth
		while true do
			if PlayerData ~= nil then
				Citizen.Wait(2000)

				playerPed  = PlayerPedId()
				prevHealth = GetEntityHealth(playerPed)
				health     = prevHealth
				TriggerEvent('tqrp_status:getStatus', 'hunger', function(status)
					if status.val == 0 then
						if prevHealth <= 150 then
							health = health - 5
						else
							health = health - 1
						end
					end
				end)

				TriggerEvent('tqrp_status:getStatus', 'thirst', function(status)
					if status.val == 0 then
						if prevHealth <= 150 then
							health = health - 5
						else
							health = health - 1
						end
					end
				end)

				if health ~= prevHealth then
					SetEntityHealth(playerPed, health)
				end

				if armorLoaded then
					local armour = GetPedArmour(playerPed)
					TriggerEvent('tqrp_status:set', 'armor', armour)
				end
			else
				Citizen.Wait(15000)
			end
		end
	end)
end)

AddEventHandler('tqrp_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('tqrp_basicneeds:onEat')
AddEventHandler('tqrp_basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A comer...",
			useWhileDead = false,
			canCancel = true, controlDisables = {},
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.03, -240.0, -180.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
					TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end

	end
end)

RegisterNetEvent('tqrp_basicneeds:onEattaco')
AddEventHandler('tqrp_basicneeds:onEattaco', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_taco_01'
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A comer...",
			useWhileDead = false,
			canCancel = true, controlDisables = {},
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.03, -240.0, -180.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
					TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end

	end
end)

RegisterNetEvent('tqrp_basicneeds:onEatChocolate')
AddEventHandler('tqrp_basicneeds:onEatChocolate', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_choc_ego'
		IsAnimated = true

		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A comer...",
			useWhileDead = false,
			canCancel = true, controlDisables = {},
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.03, -240.0, -180.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
					TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end

	end
end)

RegisterNetEvent('tqrp_basicneeds:onEatCupCake')
AddEventHandler('tqrp_basicneeds:onEatCupCake', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'ng_proc_food_ornge1a'
		IsAnimated = true

		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A comer...",
			useWhileDead = false,
			canCancel = true, controlDisables = {},
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.03, -240.0, -180.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
					TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end

	end
end)

RegisterNetEvent('tqrp_basicneeds:onEatChips')
AddEventHandler('tqrp_basicneeds:onEatChips', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'v_ret_ml_chips4'
		IsAnimated = true

		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A comer...",
			useWhileDead = false,
			canCancel = true, controlDisables = {},
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.03, -240.0, -180.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
					TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end

	end
end)

RegisterNetEvent('tqrp_basicneeds:onEatSandwich')
AddEventHandler('tqrp_basicneeds:onEatSandwich', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_sandwich_01'
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A comer...",
			useWhileDead = false,
			canCancel = true, controlDisables = {},
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.03, -240.0, -180.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
					TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end

	end
end)

RegisterNetEvent('tqrp_basicneeds:onEatPizza')
AddEventHandler('tqrp_basicneeds:onEatPizza', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'v_res_tt_pizzaplate'
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A comer...",
			useWhileDead = false,
			canCancel = true, controlDisables = {},
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.03, -240.0, -180.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
					TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end
	end
end)

---DRINK
RegisterNetEvent('tqrp_basicneeds:onDrink')
AddEventHandler('tqrp_basicneeds:onDrink', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A beber...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {}
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
					TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end
	end
end)

RegisterNetEvent('tqrp_basicneeds:onDrinkCocaCola')
AddEventHandler('tqrp_basicneeds:onDrinkCocaCola', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ecola_can' --ng_proc_sodacan_01a
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A beber...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {}
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
					TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end
	end
end)

RegisterNetEvent('tqrp_basicneeds:onDrinkIceTea')
AddEventHandler('tqrp_basicneeds:onDrinkIceTea', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_can_01' --ng_proc_sodacan_01b
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A beber...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {}
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
					TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end
	end
end)

RegisterNetEvent('tqrp_basicneeds:onDrinkVodka')
AddEventHandler('tqrp_basicneeds:onDrinkVodka', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_vodka_bottle'
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A beber...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {}
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
					TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end

	end
end)

RegisterNetEvent('tqrp_basicneeds:onDrinkWhisky')
AddEventHandler('tqrp_basicneeds:onDrinkWhisky', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_whiskey_bottle'
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A beber...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {}
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
					TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end

	end
end)

RegisterNetEvent('tqrp_basicneeds:onDrinkTequila')
AddEventHandler('tqrp_basicneeds:onDrinkTequila', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_tequila_bottle'
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A beber...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {}
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
					TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end

	end
end)

RegisterNetEvent('tqrp_basicneeds:onDrinkMilk')
AddEventHandler('tqrp_basicneeds:onDrinkMilk', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_milk_01'
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A beber...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {}
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
					TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end
	end
end)

-- Disco
RegisterNetEvent('tqrp_basicneeds:onDrinkGin')
AddEventHandler('tqrp_basicneeds:onDrinkGin', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_rum_bottle'
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A beber...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {}
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
					TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end

	end
end)

RegisterNetEvent('tqrp_basicneeds:onDrinkAbsinthe')
AddEventHandler('tqrp_basicneeds:onDrinkAbsinthe', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_bottle_cognac'
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A beber...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {}
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
					TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end

	end
end)

RegisterNetEvent('tqrp_basicneeds:onDrinkChampagne')
AddEventHandler('tqrp_basicneeds:onDrinkChampagne', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_wine_white'
		IsAnimated = true
		exports['mythic_progbar']:Progress({
			name = "firstaid_action",
			duration = 2500,
			label = "A beber...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {}
		})
		if not IsPedInAnyVehicle(PlayerPedId()) then
			Citizen.CreateThread(function()
				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

				ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
					TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

					Citizen.Wait(3000)
					IsAnimated = false
					ClearPedSecondaryTask(playerPed)
					DeleteObject(prop)
				end)
			end)
		else
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				IsAnimated = false
			end)
		end

	end
end)

RegisterNetEvent('tqrp_cigarett:startSmoke')
AddEventHandler('tqrp_cigarett:startSmoke', function(source)
	if IsPedOnFoot(PlayerPedId()) then
		SmokeAnimation()
	else
		exports["mythic_notify"]:SendAlert("error", "o cigarro voou pela janela!")
	end
end)

function SmokeAnimation()
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)
		Citizen.Wait(22000) -- wait a bit so stress won't change instantly and animation can be played
		ClearPedTasksImmediately(PlayerPedId())
	end)
end

-- Optionalneeds
function Drunk(level, start)

  Citizen.CreateThread(function()
     local playerPed = PlayerPedId()
     if start then
      DoScreenFadeOut(800)
      Wait(1000)
    end
     if level == 0 then
       RequestAnimSet("move_m@drunk@slightlydrunk")

      while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(10)
      end
       SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
     elseif level == 1 then
       RequestAnimSet("move_m@drunk@moderatedrunk")

      while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
        Citizen.Wait(10)
      end
       SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
     elseif level == 2 then
       RequestAnimSet("move_m@drunk@verydrunk")

      while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
        Citizen.Wait(10)
      end
       SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
     end
     SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)
     if start then
      DoScreenFadeIn(800)
    end
   end)
 end
 function Reality()
   Citizen.CreateThread(function()
     local playerPed = PlayerPedId()
     DoScreenFadeOut(800)
    Wait(1000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
     DoScreenFadeIn(800)
   end)
 end
 AddEventHandler('tqrp_status:loaded', function(status)
   TriggerEvent('tqrp_status:registerStatus', 'drunk', 0, '#8F15A5', --roxo
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end,
    function(status)
      status.remove(1500)
    end
  )
 	Citizen.CreateThread(function()
 		while true do
 			Wait(1000)
 				TriggerEvent('tqrp_status:getStatus', 'drunk', function(status)
				if status.val > 0 then
					local start = true
					if IsAlreadyDrunk then
						start = false
					end
					local level = 0
					if status.val <= 250000 then
						level = 0
					elseif status.val <= 500000 then
						level = 1
					else
						level = 2
					end
					if level ~= DrunkLevel then
						Drunk(level, start)
					end
					IsAlreadyDrunk = true
					DrunkLevel     = level
				end
 				if status.val == 0 then
					if IsAlreadyDrunk then
						Reality()
					end
					IsAlreadyDrunk = false
					DrunkLevel     = -1
 				end
 			end)
 		end
 	end)
 end)

 RegisterNetEvent('tqrp_optionalneeds:onDrink')
AddEventHandler('tqrp_optionalneeds:onDrink', function()

  if IsPedOnFoot(PlayerPedId()) then
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_DRINKING", 0, 1)
  end
  Citizen.Wait(1500)
  ClearPedTasksImmediately(PlayerPedId())
 end)

 Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end) -- Fix RAM leaks by collecting garbage
