ESX = nil
local training 		= false
local resting	 	= false
local membership 	= false
--[[local strengthValue = nil
local staminaValue 	= nil
local shootingValue = nil
local drivingValue 	= nil
local drugsValue 	= nil
local openKey 		= 170 -- F3 
local guiEnabled = false]]

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
    SetTextScale(0.35, 0.35)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
	SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function round(num)
	local mult = 10^(2)
	return math.floor(num * mult + 0.5) / mult
end

--[[RegisterNetEvent('big_skills:sendPlayerSkills')
AddEventHandler('big_skills:sendPlayerSkills', function(stamina, strength, driving, shooting, drugs)
	strengthValue = strength
	staminaValue = stamina
	shootingValue = shooting
	drivingValue = driving
	drugsValue = drugs

	StatSetInt("MP0_STRENGTH", round(strengthValue), true)
	StatSetInt("MP0_STAMINA", round(staminaValue), true)
	StatSetInt('MP0_LUNG_CAPACITY', round(shootingValue), true)
	StatSetInt('MP0_SHOOTING_ABILITY', round(shooting), true)
	StatSetInt('MP0_WHEELIE_ABILITY', round(driving), true)
	StatSetInt('MP0_DRIVING_ABILITY', round(driving), true)
end)

function EnableGui(enable)
	if staminaValue == nil or strengthValue == nil or shootingValue == nil or drivingValue == nil or drugsValue == nil then
		print("enalbe")
		SendNUIMessage({
			type = "enableui",
			enable = enable,
			stamina = staminaValue,
			strength = strengthValue,
			driving = drivingValue,
			shooting = shootingValue,
			drugs = drugsValue
		})
	else
		SetNuiFocus(enable)
		guiEnabled = enable

		SendNUIMessage({
			type = "enableui",
			enable = enable,
			stamina = staminaValue,
			strength = strengthValue,
			driving = drivingValue,
			shooting = shootingValue,
			drugs = drugsValue
		})
	end
end

Citizen.CreateThread(function()
	while true do
        if guiEnabled then
			if IsControlJustReleased(0, 170) then
				EnableGui(false)
				guiEnabled = false
			end
		else
			if IsControlJustReleased(0, 170) then
				EnableGui(true)
				guiEnabled = true
			end
		end
        Citizen.Wait(10)
    end
end)]]

--[[ Citizen.CreateThread(function() -- Thread for  timer
	while true do 
		Citizen.Wait(15000)
		if IsPedInAnyVehicle(PlayerPedId(), true) then
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
			if GetVehicleCurrentRpm(vehicle) >= 5 then
				--TriggerServerEvent('big_skills:addDriving', GetPlayerServerId(PlayerId()), (math.random() + 0))
				TriggerServerEvent("big_skills:addStress", (GetVehicleCurrentRpm(vehicle) * 5000))
				Citizen.Wait(5000)
			end
		else
			Citizen.Wait(5000)
		end
	end 
end) ]]

RegisterNetEvent('big_skills:trueMembership')
AddEventHandler('big_skills:trueMembership', function()
	membership = true
end)

RegisterNetEvent('big_skills:falseMembership')
AddEventHandler('big_skills:falseMembership', function()
	membership = false
end)

-- LOCATION (START)
locations = {
	[1] = {x = -1203.3242,y = -1570.6184,z = 4.6115, text= "Clica [~g~E~w~] para fazeres ~b~Flexões",type = "pushup"},
	[2] = {x = -1204.7958,y = -1560.1906,z = 4.6115, text= "Clica [~g~E~w~] para fazeres ~b~Yoga", 	 type = "yoga"},
	[3] = {x = -1206.1055,y = -1565.1589,z = 4.6115, text= "Clica [~g~E~w~] para fazeres ~b~Situps", type = "situps"},
	[4] = {x = -1200.1284,y = -1570.9903,z = 4.6115, text= "Clica [~g~E~w~] para fazeres ~b~Chins",  type = "chins"}
}

local blips = {
	{title="Ginásio", colour=7, id=311, x = -1201.2257, y = -1568.8670, z = 4.6101}
}
	
Citizen.CreateThread(function()
	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.6)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)

-- LOCATION (END)
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(10)
		sleep = false
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), false), -1201.23, -1568.87, 4.61) < 25 then
			for i = 1, #locations, 1 do
				dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), false),locations[i].x,locations[i].y,locations[i].z)
				if dist < 6.0 then
					sleep = false
					DrawMarker(21, locations[i].x, locations[i].y, locations[i].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 153, 255, 255, 0, 0, 0, 0)
					if dist < 1.5 then
						DrawText3D(locations[i].x, locations[i].y, locations[i].z, locations[i].text)
						if IsControlJustPressed(0, 38) then
							if locations[i].type == "yoga" then
								OpenYoga()
							elseif locations[i].type == "pushup" then
								OpenPushups()
							elseif locations[i].type == "situps" then
								OpenSitups()
							elseif locations[i].type == "chins" then
								OpenChins()
							end
						end
					end
				end
			end
			if sleep then
				Citizen.Wait(1500)
			end
		else
			Citizen.Wait(10000)
		end
    end
end)

function OpenChins()
	if training == false then
	
		TriggerServerEvent('big_skills:checkChip')
		Citizen.Wait(1500)					
	
		if membership == true then
			local playerPed = PlayerPedId()
			TaskStartScenarioInPlace(playerPed, "prop_human_muscle_chin_ups", 0, true)
			Citizen.Wait(30000)
			ClearPedTasksImmediately(playerPed)	
			--TriggerServerEvent('big_skills:trainChins')
			TriggerServerEvent("big_skills:removeStress", 100000)
			training = true
		elseif membership == false then
			exports['mythic_notify']:SendAlert('error', 'Não tens um cartão de membro')
		end
	elseif training == true then
		exports['mythic_notify']:SendAlert('error', 'Estás muito cansado')
		resting = true
		CheckTraining()
	end		
end

function OpenPushups()
	if training == false then
	
		TriggerServerEvent('big_skills:checkChip')
		Citizen.Wait(1500)					
	
		if membership == true then				
			local playerPed = PlayerPedId()
			TaskStartScenarioInPlace(playerPed, "world_human_push_ups", 0, true)
			Citizen.Wait(30000)
			ClearPedTasksImmediately(playerPed)
			--TriggerServerEvent('big_skills:trainPushups')
			TriggerServerEvent("big_skills:removeStress", 100000)
			training = true
		elseif membership == false then
			exports['mythic_notify']:SendAlert('error', 'Não tens um cartão de membro')
		end							
	elseif training == true then
		exports['mythic_notify']:SendAlert('error', 'Estás muito cansado')
		
		resting = true
		
		CheckTraining()
	end	
end

function OpenYoga ()
	if training == false then
		TriggerServerEvent('big_skills:checkChip')
		Citizen.Wait(1500)					
	
		if membership == true then	
			local playerPed = PlayerPedId()
			TaskStartScenarioInPlace(playerPed, "world_human_yoga", 0, true)
			Citizen.Wait(30000)
			ClearPedTasksImmediately(playerPed)
			exports['mythic_notify']:SendAlert('error', 'Tens de descansar uns segundos')
			--TriggerServerEvent('big_skills:trainYoga')
			TriggerServerEvent("big_skills:removeStress", 100000)
			training = true
		elseif membership == false then
			exports['mythic_notify']:SendAlert('error', 'Não tens um cartão de membro')
		end
	elseif training == true then
		exports['mythic_notify']:SendAlert('error', 'Estás muito cansado')	
		resting = true
		CheckTraining()
	end		
end

function OpenSitups()
	if training == false then

		TriggerServerEvent('big_skills:checkChip')
		Citizen.Wait(1500)					
	
		if membership == true then	
			local playerPed = PlayerPedId()
			TaskStartScenarioInPlace(playerPed, "world_human_sit_ups", 0, true)
			Citizen.Wait(30000)
			ClearPedTasksImmediately(playerPed)
			exports['mythic_notify']:SendAlert('error', 'Tens de descansar uns segundos')
			--TriggerServerEvent('big_skills:trainSitups')
			TriggerServerEvent("big_skills:removeStress", 100000)
			training = true
		elseif membership == false then
			exports['mythic_notify']:SendAlert('error', 'Não tens um cartão de membro')
		end
	elseif training == true then
		exports['mythic_notify']:SendAlert('error', 'Estás muito cansado')
		resting = true
		CheckTraining()
	end		
end

function CheckTraining()
	if resting == true then
		resting = false
		Citizen.Wait(60000)
		training = false
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(20000)

		TriggerEvent('tqrp_status:getStatus', 'stress', function(status)
			StressVal = status.val
		end)

		if StressVal == 1000000 then -- max StressVal
			SetTimecycleModifier("WATER_silty")
			SetTimecycleModifierStrength(1)
		else
			ClearExtraTimecycleModifier()
		end

		if StressVal >= 900000 then
			Citizen.Wait(1500)
			ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.18)
		elseif StressVal >= 800000 then
			Citizen.Wait(1500)
			ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.14)
		elseif StressVal >= 700000 then
			Citizen.Wait(1500)
			ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.10)
		elseif StressVal >= 600000 then -- %60 altındayken araç sürüşüne bir etkisi olmuyor // Below ½60 no effect to driving
			Citizen.Wait(2500) --frequency
			ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.08) -- efekt // effect
		elseif StressVal >= 500000 then
			Citizen.Wait(3500)
			ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07)
		elseif StressVal >= 350000 then
			Citizen.Wait(5500)
			ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.05)
		elseif StressVal >= 200000 then
			Citizen.Wait(6500)
			ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.03)
		else
			Citizen.Wait(1500)
		end
	end
end)

--[[ Citizen.CreateThread(function() -- Aiming with a weapon
    while true do
        local ped = PlayerPedId()
        local status = GetPedConfigFlag(ped, 78, 1)
		TriggerServerEvent("big_skills:removeStress", 50000)
        if status and (GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED")) then
            TriggerServerEvent("big_skills:addStress", 150000)
            Citizen.Wait(5000)
        else
            Citizen.Wait(3000)
        end
    end
end) ]]

--[[ Citizen.CreateThread(function() -- While shooting
    while true do
        local ped = PlayerPedId()
        local status = IsPedShooting(ped)
        local silenced = IsPedCurrentWeaponSilenced(ped)

        if status and not silenced then
            TriggerServerEvent("big_skills:addStress", 140000)
            Citizen.Wait(2000)
        else
            Citizen.Wait(1500)
        end
    end
end) ]]

--[[ Citizen.CreateThread(function() --  Aiming with a melee, hitting with a melee or getting hit by a melee
    while true do
        local ped = PlayerPedId()
        local status = IsPedInMeleeCombat(ped)

        if status then
            TriggerServerEvent("big_skills:addStress", 60000)
            Citizen.Wait(5000)
        else
            Citizen.Wait(2000)
        end
    end
end) ]]


Citizen.CreateThread(function() -- While healt is below 100(half) TEST THIS BEFORE USE, CAN GET PROBLEMATIC
    while true do
        local ped = PlayerPedId()
        local amount = (GetEntityHealth(ped)-100)

        if amount <= 50 then
            TriggerServerEvent("big_skills:addStress", 10000)
            Citizen.Wait(60000)
        else
            Citizen.Wait(1500)
        end
    end
end)

Citizen.CreateThread(function() -- Staying still or walking
    while true do
        local ped = PlayerPedId()
        local status = IsPedStill(ped)
        local status2 = IsPedWalking(ped)
		local status_v = IsPedInAnyVehicle(ped, false)
        if status and not status_v and not GetPedStealthMovement(ped) then -- still
            Citizen.Wait(15000)
            TriggerServerEvent("big_skills:removeStress", 140000)
            Citizen.Wait(1500)
        elseif status2 and not GetPedStealthMovement(ped) then -- walking
            Citizen.Wait(15000)
            TriggerServerEvent("big_skills:removeStress", 90000)
            Citizen.Wait(1500)
        else
            Citizen.Wait(3000)
        end
    end
end)