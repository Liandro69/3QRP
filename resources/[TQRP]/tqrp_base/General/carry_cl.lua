local carryingBackInProgress = false
local carryAnimNamePlaying = ""
local carryAnimDictPlaying = ""
local carryControlFlagPlaying = 0
local playerPed = nil
local targetPed = nil

RegisterCommand("pegar",function(source, args)
	locked = false
	if not carryingBackInProgress then
		local player = PlayerPedId()	
		lib = 'missfinale_c2mcs_1'
		anim1 = 'fin_c2_mcs_1_camman'
		lib2 = 'nm'
		anim2 = 'firemans_carry'
		distans = 0.15
		distans2 = 0.27
		height = 0.63
		spin = 0.0		
		length = 100000
		controlFlagMe = 49
		controlFlagTarget = 33
		animFlagTarget = 1
		veh = nil
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer == -1 or closestDistance < 3.0 then
			target = GetPlayerServerId(closestPlayer)
			carryingBackInProgress = true
			Citizen.CreateThread(function()
				while carryingBackInProgress do
					value = math.random(1,20)
					if value <= 90 and IsPedRunning(player) then
						ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.04) -- change this float to increase/decrease camera shake
						SetPedToRagdollWithFall(player, 1500, 2000, 1, GetEntityForwardVector(player), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
						carryingBackInProgress = false
						ClearPedSecondaryTask(player)
						DetachEntity(player, true, false)
						TriggerServerEvent("tqrp_base:locksv", target, false)
						if target ~= 0 then 
							TriggerServerEvent("CarryPeople:stop",target)
						end
					end
					if IsPedInAnyVehicle(player, false) then
						veh = GetVehiclePedIsIn(player, false)
						if GetPedInVehicleSeat(veh, -1) == player then
							SetPedToRagdollWithFall(player, 1500, 2000, 1, GetEntityForwardVector(player), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
							carryingBackInProgress = false
							ClearPedSecondaryTask(player)
							DetachEntity(player, true, false)
							TriggerServerEvent("tqrp_base:locksv", target, false)
							if target ~= 0 then 
								TriggerServerEvent("CarryPeople:stop",target)
							end
						end
					end
					Citizen.Wait(5000)
				end
			end)
			Citizen.CreateThread(function()
				while carryingBackInProgress do
					local distance = GetDistanceBetweenCoords(GetEntityCoords(targetPed), GetEntityCoords(playerPed))
					if distance < 2.0 or not carryingBackInProgress then
						TaskPlayAnim(playerPed, carryAnimDictPlaying, carryAnimNamePlaying, 8.0, -8.0, 100000, carryControlFlagPlaying, 0, false, false, false)
						Citizen.Wait(100)
					else
						carryingBackInProgress = false
						ClearPedSecondaryTask(playerPed)
					end
					Citizen.Wait(100)
				end
			end)
			TriggerServerEvent("tqrp_base:locksv", target, true)
			TriggerServerEvent('CarryPeople:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
		end
	else
		carryingBackInProgress = false
		DetachEntity(PlayerPedId(), true, false)
		ClearPedSecondaryTask(PlayerPedId())
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer == -1 or closestDistance < 3.0 then
			target = GetPlayerServerId(closestPlayer)
			TriggerServerEvent("tqrp_base:locksv", target, false)
			if target ~= 0 then 
				TriggerServerEvent("CarryPeople:stop",target)
			end
		end
	end
end,false)

RegisterNetEvent('tqrp_base:lock')
AddEventHandler('tqrp_base:lock', function(dead)
	locked = dead
	while locked do
		DisableControlAction(0, 24, true) -- Attack
		DisableControlAction(0, 257, true) -- Attack 2
		DisableControlAction(0, 25, true) -- Aim
		DisableControlAction(0, 263, true) -- Melee Attack 1
		DisableControlAction(0, 32, true) -- W
		DisableControlAction(0, 34, true) -- A
		DisableControlAction(0, 38, true) -- A
		DisableControlAction(0, 31, true) -- S (fault in Keys table!)
		DisableControlAction(0, 30, true) -- D (fault in Keys table!)

		DisableControlAction(0, 45, true) -- Reload
		DisableControlAction(0, 44, true) -- Cover
		DisableControlAction(0, 37, true) -- Select Weapon
		DisableControlAction(0, 23, true) -- Also 'enter'?

		DisableControlAction(0, 289, true) -- Inventory
		DisableControlAction(0, 170, true) -- Animations
		DisableControlAction(0, 167, true) -- Job

		DisableControlAction(0, 0, true) -- Disable changing view
		DisableControlAction(0, 26, true) -- Disable looking behind
		DisableControlAction(0, 73, true) -- Disable clearing animation
		DisableControlAction(2, 199, true) -- Disable pause screen

		DisableControlAction(0, 59, true) -- Disable steering in vehicle
		DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
		DisableControlAction(0, 72, true) -- Disable reversing in vehicle

		DisableControlAction(2, 36, true) -- Disable going stealth

		DisableControlAction(0, 47, true)  -- Disable weapon
		DisableControlAction(0, 264, true) -- Disable melee
		DisableControlAction(0, 257, true) -- Disable melee
		DisableControlAction(0, 140, true) -- Disable melee
		DisableControlAction(0, 141, true) -- Disable melee
		DisableControlAction(0, 142, true) -- Disable melee
		DisableControlAction(0, 143, true) -- Disable melee
		DisableControlAction(0, 75, true)  -- Disable exit vehicle
		DisableControlAction(27, 75, true) -- Disable exit vehicle
		Citizen.Wait(100)
	end
end)

RegisterNetEvent('CarryPeople:syncTarget')
AddEventHandler('CarryPeople:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	playerPed = PlayerPedId()
	targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(100)
	end

	if spin == nil then spin = 180.0 end
	if GetEntityHealth(ped) < 1 then
		SetEntityHealth(ped, 100)
		Citizen.Wait(200)
		AttachEntityToEntity(PlayerPedId(), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
		if controlFlag == nil then controlFlag = 0 end
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		carryAnimNamePlaying = animation2
		carryAnimDictPlaying = animationLib
		carryControlFlagPlaying = controlFlag
		Citizen.Wait(200)
		SetEntityHealth(ped, 0)
	else
		AttachEntityToEntity(PlayerPedId(), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
		if controlFlag == nil then controlFlag = 0 end
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		carryAnimNamePlaying = animation2
		carryAnimDictPlaying = animationLib
		carryControlFlagPlaying = controlFlag
	end
end)

RegisterNetEvent('CarryPeople:syncMe')
AddEventHandler('CarryPeople:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = PlayerPedId()
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(100)
	end
	Wait(1000)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	carryAnimNamePlaying = animation
	carryAnimDictPlaying = animationLib
	carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('CarryPeople:cl_stop')
AddEventHandler('CarryPeople:cl_stop', function()
	carryingBackInProgress = false
	local ped = PlayerPedId()
	DetachEntity(ped, true, false)
	if GetEntityHealth(ped) < 1 then
		local coords = GetEntityCoords(ped)
		SetEntityHealth(ped, 100)
		SetEntityCoordsNoOffset(ped,coords.x,coords.y,coords.z + 2, false, false, false, true)
		SetEntityHealth(ped, 0)
	end
	ClearPedSecondaryTask(ped)
end)

AddEventHandler('esx:onPlayerDeath', function()
	if carryingBackInProgress then
		TriggerServerEvent("CarryPeople:stop", PlayerPedId())
		carryingBackInProgress = false
	end
end)