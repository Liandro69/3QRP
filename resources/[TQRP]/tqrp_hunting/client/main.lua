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
local huntSession = false
local AnimalsInSession = {}



local AnimalPositions = {
	{ x = -1505.2, y = 4887.39, z = 78.38 },
	{ x = -1164.68, y = 4806.76, z = 223.11 },
	{ x = -1410.63, y = 4730.94, z = 44.0369 },
	{ x = -1377.29, y = 4864.31, z = 134.162 }
}

local InicioX = -680.0
local InicioY = 5833.62
local InicioZ = 17.33

local Positions = {
	['StartHunting'] = { ['x'] = -680.0, ['y'] = 5833.62, ['z'] = 17.33 }
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
	LoadScript()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

function startHunt()
	if huntSession then

		huntSession = false
		exports["mythic_notify"]:SendAlert( 'inform', 'Paraste de caçar.')

		for index, value in pairs(AnimalsInSession) do
			if DoesEntityExist(value.id) then
				DeleteEntity(value.id)
			end
		end

	else
		
		huntSession = true

		exports["mythic_notify"]:SendAlert( 'inform', 'Começaste a caçar.')

		Citizen.CreateThread(function()
				
			for index, value in pairs(AnimalPositions) do
				local Animal = CreatePed(5, GetHashKey('a_c_deer'), value.x, value.y, value.z, 0.0, true, false)
				local ped = PlayerPedId()
				TaskWanderStandard(Animal, 10, 10)
				SetEntityAsMissionEntity(Animal, true, true)
				TaskSmartFleePed(Animal, ped, 20.0, -1, false, false)
				--Blips

				local AnimalBlip = AddBlipForEntity(Animal)
				SetBlipScale(blipInicio,0.25)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Veado')
				EndTextCommandSetBlipName(AnimalBlip)


				table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})
			end

			while huntSession do
				local sleep = 2500
				for index, value in ipairs(AnimalsInSession) do
					if DoesEntityExist(value.id) then
						local _source = source
						local ped = PlayerPedId()
						local AnimalCoords = GetEntityCoords(value.id)
						local PlyCoords = GetEntityCoords(PlayerPedId())
						--local AnimalHealth = GetEntityHealth(value.id)
						
						local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)

						if IsEntityDead(value.id) then
							RemoveBlip(value.Blipid)
							--[[SetBlipColour(value.Blipid, 1)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString('Veado - Morto')
							EndTextCommandSetBlipName(value.Blipid)]]
							if PlyToAnimal < 2.0 then
								sleep = 7

								DrawText3D(AnimalCoords.x,AnimalCoords.y,AnimalCoords.z, '[E] para retirar a carne')

								if IsControlJustReleased(0, 51) then
									if GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_KNIFE') or GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_SWITCHBLADE') then
										if DoesEntityExist(value.id) then
											SlaughterAnimal(value.id)
										end
									else
										exports["mythic_notify"]:SendAlert('error', 'Precisas de ter uma faca ou um canivete na mão.')
									end
								end
							end
						end
					end
				end
				Citizen.Wait(sleep)
			end
		end)
	end
end		

function SlaughterAnimal(AnimalId)
	local amount = math.random(3, 6)
	ESX.TriggerServerCallback('tqrp_hunting:canCarry', function(canCarry)
		if canCarry then
			local ped = PlayerPedId()

			removeSlaughterMessage(AnimalId)

			TaskPlayAnim(ped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
			TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )

			Citizen.Wait(5000)
			ClearPedTasksImmediately(ped)
			TriggerServerEvent('tqrp_hunting:reward', amount)
			Citizen.Wait(7500)
			DeleteEntity(AnimalId)

		else
			exports["mythic_notify"]:SendAlert( 'error', 'Não tens espaço suficiente.')
		end
	end, amount)
end

function removeSlaughterMessage(AnimalId)
	for index, value in ipairs(AnimalsInSession) do
		if value.id == AnimalId then
			table.remove(AnimalsInSession, index)
		end
	end
end	

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local scale = 0.3
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 190)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

function LoadScript()
	Citizen.Wait(1000)
	LoadBlips()
end	

function LoadBlips()

	Citizen.CreateThread(function()
	local blipInicio = AddBlipForCoord(InicioX, InicioY, InicioZ)
	SetBlipSprite(blipInicio, 141)
	SetBlipColour(blipInicio, 5)
	SetBlipScale(blipInicio,1.2)
	SetBlipAsShortRange(blipInicio, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Caça')
	EndTextCommandSetBlipName(blipInicio)  
	end)

	Citizen.CreateThread(function()
		while true do
			local sleep = 3500
			for index, value in pairs(Positions) do

				local plyPed = PlayerPedId()
				local plyCoords = GetEntityCoords(plyPed)
				local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)

				if huntSession and index == 'StartHunting' and distance < 2 then
					sleep = 7
					DrawText3D(value.x, value.y, value.z, 'Pressiona [E] para terminar de caçar')
				elseif not huntSession and index == 'StartHunting' and distance < 2 then
					sleep = 7
					DrawText3D(value.x, value.y, value.z, 'Pressiona [E] para começar a caçar')
				end

				if distance < 5.0 then
					sleep = 7
					DrawMarker(27, InicioX, InicioY, InicioZ - 1, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < 1.0 then
						if IsControlJustReleased(0, Keys['E']) then
							if index == 'StartHunting' then
								startHunt()
							end
						end
					end
				end	
			end
			Citizen.Wait(sleep)
		end
	end)

	LoadModel('a_c_deer')
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
	
end	