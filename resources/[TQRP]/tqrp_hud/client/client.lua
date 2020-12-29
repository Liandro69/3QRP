ESX = nil
local VehicleSeat = nil
local PedCar = nil
local vehicle = nil
local showing = false
local PlayerData = {}
local podespawn = false
local controlsave_bool = false
local windowup = true
local carspeed = 0
local firstShow = false
local IsEngineOn = true
local street = "N | Los Santos"
local canShow = true
local PlayerPed = PlayerPedId()
local disableShuffle = true
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local direction = 0
local current_zone = 0
local posX = 0
local posY = 0
local posZ = 0
local speedBuffer  = {}
local BeltOn       = false
local vc = nil
local blipm = nil
local busy = false
local hasKeys = false
local imageWidth = 100 -- leave this variable, related to pixel size of the directions
local width =  0;
local south = (-imageWidth) + width
local west = (-imageWidth * 2) + width
local north = (-imageWidth * 3) + width
local east = (-imageWidth * 4) + width
local south2 = (-imageWidth * 5) + width
Citizen.CreateThread(function()
	SendNUIMessage({
		showHud = false
	})
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

IsCar = function(veh)
	vc = GetVehicleClass(veh)
	return (vc >= 0 and vc <= 13) or (vc >= 17 and vc <= 20)
end

function speedo()
	Citizen.CreateThread(function()
		Citizen.Wait(50)
		while showing do

			speedBuffer[1] = GetEntitySpeed(PedCar) * 3.6

			if speedBuffer[1] ~= nil then
				carspeed = math.ceil(speedBuffer[1])
			end

			veloc = GetEntityVelocity(PedCar)

			firstShow = false
			
			SendNUIMessage({
			
				showHud = true,
				updateEngine = showeng,
				Fuel = fuel,
				BeltOn = BeltOn,
				Direction = math.floor(calcHeading(GetEntityHeading(PlayerPed) % 360)),
				cruiseOn = cruiseOn,
				showKeys = hasKeys,
				Street = street,
				Speed = carspeed
			
			})

			Citizen.Wait(250)

		end


		SendNUIMessage({
			
			showhud = false
			
		})
	end)
end

RegisterCommand('carstats', function(source, args, user)
    carstats()
end)

function carstats()
	local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local veh = GetVehiclePedIsIn(ped, false)
        local model = GetEntityModel(veh, false)

        local hash = GetHashKey(model)
        print("^3Name (not spawn name):^7 ".. GetDisplayNameFromVehicleModel(model))
        print("^3Max speed (MPH):^7 ".. round(GetVehicleMaxSpeed(model) * 4 ,1))
        print("^3Acceleration rate:^7 ".. round(GetVehicleModelAcceleration(model),1))
        print("^3Number of gears:^7 ".. GetVehicleHighGear(veh))
        print("^3Capacity:^7 ".. GetVehicleMaxNumberOfPassengers(veh) + 1)
    end
end

function mainThread()
	local lastFrameVehiclespeed = 0
	local lastFrameVehiclespeed2 = 0
	local thisFrameVehicleSpeed = 0
	local tick = 0
	Citizen.CreateThread(function()
		while speedBuffer[1] == nil do
			Citizen.Wait(100)
		end
		while showing do
			if PedIn then
				SetRadarZoom(1100)
				SetPedHelmet(PlayerPed, false)
				if IsControlPressed(2, 75) then
					if IsVehicleEngineOn(PedCar) then
						engineWasRunning = true
					else
						engineWasRunning = false
					end
				end
	
				if GetIsTaskActive(PlayerPed,2) then
					if engineWasRunning then
						SetVehicleEngineOn(PedCar, true, true, true)
					end
				end
	
				if VehicleSeat == PlayerPed and disableShuffle then
					if GetIsTaskActive(PlayerPed, 165) then
						SetPedIntoVehicle(PlayerPed, PedCar, 0)
					end
				end
			end
			if PedCar ~= 0 and IsCar(PedCar) then
				wasInPedCar = true

				if VehicleSeat == PlayerPed then

					if IsControlJustReleased(0, 207) then
						cruiseOn = not cruiseOn
						if cruiseOn then
							SetEntityMaxSpeed(PedCar, GetEntitySpeed(PedCar))
						else
							SetEntityMaxSpeed(PedCar, GetVehicleHandlingFloat(PedCar, "CHandlingData", "fInitialDriveMaxFlatVel"))
						end
					end

				end

				if ((vc ~= 8) and (vc ~= 13))  then
					thisFrameVehicleSpeed = speedBuffer[1]

					if BeltOn then
						DisableControlAction(0, 75)
					end

					if (not BeltOn and (lastFrameVehiclespeed > 150) and (thisFrameVehicleSpeed < (lastFrameVehiclespeed * 0.50))) then
						if (math.random(0, 10) <= 3) then
							SetEntityCoords(PlayerPed, GetOffsetFromEntityInWorldCoords(PedCar, 1.0, 0.0, 1.0))
							Citizen.Wait(1)
							SetPedToRagdoll(PlayerPed, 10000, 10000, 0, 0, 0, 0)
							SetEntityVelocity(PlayerPed, veloc.x*4,veloc.y*4,veloc.z*4)
							BeltOn = false

							if (GetEntityHealth(PlayerPed) > 0) then
								RequestAnimDict("dead")
								RequestAnimSet("move_m@injured")
								SetPedMovementClipset(PlayerPed, "move_m@injured", true)
								Wait(180000)
								ResetPedMovementClipset( PlayerPed, 0 )
							end
						end
						lastFrameVehiclespeed = 0.0
						thisFrameVehicleSpeed = 0.0
						Citizen.Wait(1000)
					end

					if tick > 0 then 
						tick = tick - 1
						if tick == 1 then
							lastFrameVehiclespeed = carspeed
						end
					else

						lastFrameVehiclespeed2 = carspeed

						if lastFrameVehiclespeed2 > lastFrameVehiclespeed then
							lastFrameVehiclespeed = carspeed
						end
	
						if lastFrameVehiclespeed2 < lastFrameVehiclespeed then
							tick = 25
						end
	
					end
		
					if IsControlJustReleased(0, 305) then
						if BeltOn then
							BeltOn = false
							TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'unbuckle', 0.3)
						else
							BeltOn = true
							TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'buckle', 0.3)
						end
					end
				end

			elseif wasInPedCar then
				wasInPedCar = false
				BeltOn = false
				cruiseOn = false
				speedBuffer[1] = 0.0
			end
			Citizen.Wait(10)
		end
	end)
end

Citizen.CreateThread(function()

	Citizen.Wait(10)
	local pos = nil
	local streetName = nil
	local health = 1000
	local lul1, lul2, stringLul2, nameZone = 0, 0, 0, 0
	while true do
		PedIn = IsPedInAnyVehicle(PlayerPed)
		if PedIn then
			PedCar = GetVehiclePedIsIn(PlayerPed, false)
			VehicleSeat = GetPedInVehicleSeat(PedCar, -1)
			if canShow then

				if IsVehicleEngineOn(PedCar) and not IsPauseMenuActive() then
					DisplayRadar(true)
					if not showing then
						hasKeys = exports["tqrp_base"]:hasKeys(ESX.Math.Trim(GetVehicleNumberPlateText(PedCar)))
						speedo()
						mainThread()
						showing = true
					end

					pos = GetEntityCoords(PlayerPed)
		
					posX = pos.x
		
					posY = pos.y
		
					posZ = pos.z
		
					lul1, lul2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
		
					nameZone = GetNameOfZone(posX, posY, posZ)

					current_zone = zones[nameZone]
		
					streetName = GetStreetNameFromHashKey(lul1)
					
					if (streetName and nameZone) then

						if (current_zone and tostring(streetName)) then

							stringLul2 = tostring(GetStreetNameFromHashKey(lul2))
							
							if stringLul2 == "" then
		
								street = tostring(streetName).." | "..current_zone
		
							else
		
								street = tostring(streetName).." | "..stringLul2 .. " | " .. current_zone
		
							end
		
						end
		
					end
	
					fuel = exports["tqrp_base"]:GetFuel(PedCar)

					health = GetVehicleEngineHealth(PedCar)

					if health <= 250 then
						showeng = 1
					elseif health <= 500 then
						showeng = 2
					else
						showeng = 3
					end

				else
					SendNUIMessage({
		
						showHud = false
		
					})

					showing = false
					DisplayRadar(false)

				end

			else
				DisplayRadar(false)
				showing = false
				cruiseOn = false
				seatbeltIsOn = false

			end

		else

			if not firstShow then
				DisplayRadar(false)
				SendNUIMessage({
			
					showHud = false

				})

				firstShow = true

			end

			showing = false
			cruiseOn = false
			seatbeltIsOn = false

		end

		Citizen.Wait(1500)

	end

end)

function calcHeading(direction)
	if (direction < 90) then
		return lerp(north, east, direction / 90)
	elseif (direction < 180) then
		return lerp(east, south2, rangePercent(90, 180, direction))
	elseif (direction < 270) then
		return lerp(south, west, rangePercent(180, 270, direction))
	elseif (direction <= 360) then
		return lerp(west, north, rangePercent(270, 360, direction))
	end
end


function rangePercent(min, max, amt)
	return (((amt - min) * 100) / (max - min)) / 100
end

function lerp(min, max, amt)
	return (1 - amt) * min + amt * max
end

Citizen.CreateThread(function()
	local previousCoords = vector3(0, 0, 0)
	local veh = nil
	local vehiclePropsn = nil
	local playerCoords = nil
	local distance = nil
	local headings = nil
	local engineHealth  = nil
	while true do
		Citizen.Wait(15000)
		PlayerPed = PlayerPedId()
		veh = ESX.Game.GetVehicles()
		ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
			for _,v in pairs(vehicles) do
				for i=1, #veh, 1 do
					if DoesEntityExist(veh[i]) then
						if ESX.Math.Trim(GetVehicleNumberPlateText(veh[i])) == v.plate then
							vehiclePropsn  = ESX.Game.GetVehicleProperties(veh[i])
							playerCoords = GetEntityCoords(veh[i])
							distance = #(playerCoords - previousCoords)
							if distance > 5 then
								previousCoords = playerCoords
								headings = GetEntityHeading(veh[i])
								engineHealth  = GetVehicleEngineHealth(veh[i])
								vehiclePropsn.fuelLevel = exports["tqrp_base"]:GetFuel(veh[i])
								TriggerServerEvent('garagem:apre', vehiclePropsn.plate, playerCoords.x, playerCoords.y, playerCoords.z, headings, engineHealth, vehiclePropsn)
								local asd = GetVehicleDoorLockStatus(veh[i])
								if asd == 2 then --if is locked
									TriggerServerEvent("garagem:lockveh", vehiclePropsn.plate, 1)
								elseif asd == 1 then -- elseif is unlocked
									TriggerServerEvent("garagem:lockveh", vehiclePropsn.plate, 2)
								end
							end

						end
					end
				end
				Citizen.Wait(500)
			end
		end)
	end
end)

RegisterNetEvent('kuana:checkveh')
AddEventHandler('kuana:checkveh', function(xxx, yyy, zzz)
	local xxx = xxx + 0.0
	local zzz = zzz + 0.0
	local yyy = yyy + 0.0
	blipm = AddBlipForCoord(xxx, yyy, zzz)
	SetBlipSprite (blipm, 66)
	SetBlipDisplay(blipm, 4)
	SetBlipScale  (blipm, 0.8)
	SetBlipColour (blipm, 59)
	SetBlipAsShortRange(blipm, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Carro Perdido")
	EndTextCommandSetBlipName(blipm)
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterCommand('lock', function(source, args, rawCommand)
	TriggerEvent("garage:lock")
end)

RegisterNetEvent('lockLights')
AddEventHandler('lockLights',function(vehicle)
	StartVehicleHorn(vehicle, 100, 1, false)
	SetVehicleLights(vehicle, 2)
	Wait (200)
	SetVehicleLights(vehicle, 0)
	StartVehicleHorn(vehicle, 100, 1, false)
	Wait (200)
	SetVehicleLights(vehicle, 2)
	Wait (400)
	SetVehicleLights(vehicle, 0)
end)

RegisterNetEvent('garage:lock')
AddEventHandler('garage:lock',function()
	if not busy then
		busy = true
		local playerVeh = nil
		if saveVehicle ~= nil and DoesEntityExist(saveVehicle) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), GetEntityCoords(saveVehicle), 1) <= 25 then
			playerVeh = saveVehicle
		else
			playerVeh = GetClosestVehicle(GetEntityCoords(PlayerPed), 5.0, 0, 71)
		end

		if IsPedInAnyVehicle(PlayerPed) then
			playerVeh = PedCar
		end

		if playerVeh ~= nil and playerVeh ~= 0 then
			local plate = ESX.Math.Trim(GetVehicleNumberPlateText(playerVeh))
			local tick = 0
			while plate == nil do 
				Citizen.Wait(100)
				if tick >= 10 then 
					exports['mythic_notify']:SendAlert('error', 'Erro a obter matrícula!')
					return 
				end
				tick = tick + 1 
			end
			
			if exports["tqrp_base"]:hasKeys(plate) then
				local asd = GetVehicleDoorLockStatus(playerVeh)
				local dict = "anim@mp_player_intmenu@key_fob@"
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(100)
				end
				local plyCoords = GetOffsetFromEntityInWorldCoords(PlayerPed, 0.0, 0.0, -5.0)
				local micspawned = CreateObject(GetHashKey("p_car_keys_01"), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
				AttachEntityToEntity(micspawned, PlayerPed, GetPedBoneIndex(PlayerPed, 28422), 0.055, 0.05, 0.0, 240.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
				TaskPlayAnim(PlayerPed, dict, "fob_click", 8.0, 8.0, -1, 48, 1, false, false, false)
				Citizen.Wait(500)
				if asd == 2 then --if is locked
					SetVehicleDoorsLocked(playerVeh, 1)
					TriggerEvent('lockLights', playerVeh)
					msg(1, playerVeh)
					TriggerServerEvent("garagem:lockveh", plate, 1)
				elseif asd == 1 then -- elseif is unlocked
					SetVehicleDoorsLocked(playerVeh, 2)
					TriggerEvent('lockLights', playerVeh)
					msg(2, playerVeh)
					TriggerServerEvent("garagem:lockveh", plate, 2)
				else
					SetVehicleDoorsLocked(playerVeh, 2)
					TriggerEvent('lockLights', playerVeh)
					msg(2, playerVeh)
					TriggerServerEvent("garagem:lockveh", plate, 2)
				end
				ClearPedSecondaryTask(PlayerPed)
				DetachEntity(micspawned, 1, 1)
				DeleteEntity(micspawned)
			else
				exports['mythic_notify']:SendAlert('error', 'Não tens chaves!')
			end
		end
		busy = false
	end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/mala', 'Abrir/fechar mala do veículo')
	TriggerEvent('chat:addSuggestion', '/capo', 'Abrir/fechar capô do veículo')
	TriggerEvent('chat:addSuggestion', '/malac', 'Abrir/fechar mala da carrinha')
end)

-- T R U N K --
RegisterCommand("mala", function()
	local player = GetPlayerPed(-1)
    local coords    = GetEntityCoords(player)
    local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)
	local isopen = GetVehicleDoorAngleRatio(vehicle,5)
	local locked = GetVehicleDoorLockStatus(vehicle)
	local heding = GetEntityHeading(vehicle)
	local isopen = GetVehicleDoorAngleRatio(vehicle,5)
	local coords = GetEntityCoords(player)
	local coords2 = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
		if GetDistanceBetweenCoords(coords, coords2, 1) < 3.5 then
			SetEntityHeading(player, heding)
			Wait(100)
			if locked == 1 then
				if (isopen == 0) then
					loadAnimDict("rcmnigel3_trunk")
					TaskPlayAnim(player, "rcmnigel3_trunk", "out_trunk_trevor", 8.0, 1.0, -1, 0, 1, 0, 0, 0)
					Wait(1000)
					SetVehicleDoorOpen(vehicle,5,0,0)
					ClearPedTasks(player)
				else
					loadAnimDict("rcmepsilonism8")
					TaskPlayAnim(player, "rcmepsilonism8", "bag_handler_close_trunk_walk_left", 8.0, 1.0, -1, 0, 1, 0, 0, 0)
					Wait(2000)
					SetVehicleDoorShut(vehicle,5,0)
					ClearPedTasks(player)
				end
			else
				exports['mythic_notify']:SendAlert('error', "Veículo Trancado!")
			end
        end
end,false)


-- T R U N K --
RegisterCommand("malac", function()
	local player = GetPlayerPed(-1)
    local coords    = GetEntityCoords(player)
    local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)
	local isopen = GetVehicleDoorAngleRatio(vehicle,5)
	local locked = GetVehicleDoorLockStatus(vehicle)
	local heding = GetEntityHeading(vehicle)
	local isopen = GetVehicleDoorAngleRatio(vehicle,5)
	local coords = GetEntityCoords(player)
	local coords2 = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
	local heding = GetEntityHeading(vehicle)
	local isopen = GetVehicleDoorAngleRatio(vehicle,3)
	local isopen2 = GetVehicleDoorAngleRatio(vehicle,2)
	if GetDistanceBetweenCoords(coords, coords2, 1) < 3.5 then
		SetEntityHeading(player, heding)
		Wait(100)
		if locked == 1 then
			if (isopen == 0) or (isopen2 == 0) then
				loadAnimDict("rcmnigel3_trunk")
				TaskPlayAnim(player, "rcmnigel3_trunk", "out_trunk_trevor", 8.0, 1.0, -1, 0, 1, 0, 0, 0)
				Wait(1000)
				SetVehicleDoorOpen(vehicle,3,0,0)
				SetVehicleDoorOpen(vehicle,2,0,0)
				ClearPedTasks(player)
			else
				loadAnimDict("rcmepsilonism8")
				TaskPlayAnim(player, "rcmepsilonism8", "bag_handler_close_trunk_walk_left", 8.0, 1.0, -1, 0, 1, 0, 0, 0)
				Wait(2000)
				SetVehicleDoorShut(vehicle,3,0)
				SetVehicleDoorShut(vehicle,2,0)
				ClearPedTasks(player)
			end
		else
			exports['mythic_notify']:SendAlert('error', "Veículo Trancado!")
		end
	end	
end,false)


RegisterCommand("capo", function()
	local player = GetPlayerPed(-1)
    local coords    = GetEntityCoords(player)
    local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)
	local isopen = GetVehicleDoorAngleRatio(vehicle,5)
	local locked = GetVehicleDoorLockStatus(vehicle)
	local heding = GetEntityHeading(vehicle)
	local isopen = GetVehicleDoorAngleRatio(vehicle,5)
	local coords = GetEntityCoords(player)
	local coords2 = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "bonnet"))
	local heding = GetEntityHeading(vehicle)
	local isopen = GetVehicleDoorAngleRatio(vehicle,4)
	if GetDistanceBetweenCoords(coords, coords2, 1) < 3.5 then
		SetEntityHeading(player, heding-180)
		Wait(100)
		if locked == 1 then
			if (isopen == 0) then
				loadAnimDict("rcmnigel3_trunk")
				TaskPlayAnim(player, "rcmnigel3_trunk", "out_trunk_trevor", 8.0, 1.0, -1, 0, 1, 0, 0, 0)
				Wait(1000)
				SetVehicleDoorOpen(vehicle,4,0,0)
				ClearPedTasks(player)
			else
				loadAnimDict("rcmepsilonism8")
				TaskPlayAnim(player, "rcmepsilonism8", "bag_handler_close_trunk_walk_left", 8.0, 1.0, -1, 0, 1, 0, 0, 0)
				Wait(2000)
				SetVehicleDoorShut(vehicle,4,0)
				ClearPedTasks(player)
			end
		else
			exports['mythic_notify']:SendAlert('error', "Veículo Trancado!")
		end
	end
end,false)


RegisterNetEvent('portas')
AddEventHandler('portas',function()
	if controlsave_bool == true then
		vehicle = saveVehicle
	else
		vehicle = PedCar
	end
	local isopen = GetVehicleDoorAngleRatio(vehicle,2) and GetVehicleDoorAngleRatio(vehicle,3)
	local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), GetEntityCoords(vehicle), 1)

	if distanceToVeh <= 3.5 then
		if (isopen == 0) then
		SetVehicleDoorOpen(vehicle,2,0,0)
		SetVehicleDoorOpen(vehicle,3,0,0)
		else
		SetVehicleDoorShut(vehicle,2,0)
		SetVehicleDoorShut(vehicle,3,0)
		end
	end
end)

RegisterCommand("p", function(source, args, rawCommand)
	local closeCar = 0
	local door = tonumber(args[1]) - 1
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	if door < 4 then 
		if IsPedInAnyVehicle(ped, false) then
			closeCar = PedCar
		elseif GetClosestVehicle(coords.x, coords.y, coords.z, 5.0,  0,  71) ~= 0 then
			closeCar = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0,  0,  71)
		elseif controlsave_bool == true then
			closeCar = saveVehicle
		end

		if GetVehicleDoorAngleRatio(closeCar, door) > 0 then
			SetVehicleDoorShut(closeCar, door, 0, 0)
		else
			SetVehicleDoorOpen(closeCar, door, 0, 0)
		end
	end
end,false)

local OpenedWindows = {}

RegisterCommand("j", function(source, args, rawCommand)
	local veh = 0
	if IsPedInAnyVehicle(ped, false) then
		veh = PedCar
	elseif GetClosestVehicle(coords.x, coords.y, coords.z, 5.0,  0,  71) ~= 0 then
		veh = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0,  0,  71)
	elseif controlsave_bool == true then
		veh = saveVehicle
	end
    local WindowFound = false
    local window = tonumber(args[1]) - 1
    for i=1,#OpenedWindows do
        if OpenedWindows[i] == window and not WindowFound then
            RollUpWindow(veh, window)
            table.remove(OpenedWindows, i)
            WindowFound = true
        end
    end
    if not WindowFound then
        RollDownWindow(veh, window)
        table.insert(OpenedWindows, window)
    end
end)






local targetBlip

RegisterNetEvent('save')
AddEventHandler('save',function()
	if (IsPedSittingInAnyVehicle(PlayerPed)) then
		ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
			local playerVeh = GetVehiclePedIsIn(PlayerPed, true)
			local vehiclePropsn  = ESX.Game.GetVehicleProperties(playerVeh)
			for _,v in pairs(vehicles) do
				if vehiclePropsn.plate == v.plate then
					RemoveBlip(targetBlip)
					saveVehicle = playerVeh
					vehicle = saveVehicle
					SetEntityAsMissionEntity(vehicle, true, true)
					SetVehicleHasBeenOwnedByPlayer(vehicle,true)
		
					local id = NetworkGetNetworkIdFromEntity(saveVehicle)
					SetNetworkIdCanMigrate(id, true)
					local x,y,z = table.unpack(GetEntityCoords(vehicle))
					local headings = GetEntityHeading(vehicle)
					local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
					local engineHealth  = GetVehicleEngineHealth(vehicle)
					vehicleProps.fuelLevel = exports["tqrp_base"]:GetFuel(vehicle)
					TriggerServerEvent('garagem:apre', vehicleProps.plate, x, y, z, headings, engineHealth, vehicleProps)
					exports['mythic_notify']:SendAlert('success', GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. ' Salvo!')
					TriggerEvent("onyx:updatePlates", vehicleProps.plate)
					TriggerEvent("tqrp_phone:client:UpdateVehConfig", GetEntityCoords(vehicle), headings, vehicleProps)

					targetBlip = AddBlipForEntity(vehicle)
					SetBlipSprite(targetBlip,225)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString("Veículo")
					EndTextCommandSetBlipName(targetBlip)

					saved = true
				end
			end
		end)
	else
		ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
			local playerVeh = GetClosestVehicle(GetEntityCoords(PlayerPed), 5.0, 0, 71)
			if DoesEntityExist(playerVeh) then
				local vehiclePropsn  = ESX.Game.GetVehicleProperties(playerVeh)
				for _,v in pairs(vehicles) do
					if vehiclePropsn.plate == v.plate then
						RemoveBlip(targetBlip)
						saveVehicle = playerVeh
						vehicle = saveVehicle
						SetEntityAsMissionEntity(vehicle, true, true)
						SetVehicleHasBeenOwnedByPlayer(vehicle,true)
			
						local id = NetworkGetNetworkIdFromEntity(saveVehicle)
						SetNetworkIdCanMigrate(id, true)
						local x,y,z = table.unpack(GetEntityCoords(vehicle))
						local headings = GetEntityHeading(vehicle)
						local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
						local engineHealth  = GetVehicleEngineHealth(vehicle)
						vehicleProps.fuelLevel = exports["tqrp_base"]:GetFuel(vehicle)
						TriggerServerEvent('garagem:apre', vehicleProps.plate, x, y, z, headings, engineHealth, vehicleProps)
						exports['mythic_notify']:SendAlert('success', GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. ' Salvo!')
						TriggerEvent("onyx:updatePlates", vehicleProps.plate)
						TriggerEvent("tqrp_phone:client:UpdateVehConfig", GetEntityCoords(vehicle), headings, vehicleProps)

						targetBlip = AddBlipForEntity(vehicle)
						SetBlipSprite(targetBlip,225)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Veículo")
						EndTextCommandSetBlipName(targetBlip)

						saved = true
					end
				end
			else
				exports['mythic_notify']:SendAlert('error', 'Nenhum veículo por perto')
			end
		end)
	end
end)

RegisterCommand("mudar", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false)

RegisterNetEvent('carhud')
AddEventHandler('carhud',function(show)
	canShow = show
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if inVeh then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterNetEvent("tqrp_givecarkeys:keys")
AddEventHandler("tqrp_givecarkeys:keys", function()
	giveCarKeys()
end)

function disableSeatShuffle(flag)
	disableShuffle = flag
end

function giveCarKeys()
	local coords    = GetEntityCoords(PlayerPed)
	if IsPedInAnyVehicle(PlayerPed,  false) then
        vehicle = PedCar
    else
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
    end
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	ESX.TriggerServerCallback('tqrp_givecarkeys:requestPlayerCars', function(isOwnedVehicle)
		if isOwnedVehicle then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				exports['mythic_notify']:SendAlert('error', 'Não ha jogadores por perto')
			else
				exports['mythic_notify']:SendAlert('error', 'Carro Removido: ('..vehicleProps.plate..')')
				TriggerServerEvent('tqrp_givecarkeys:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
			end
		end
	end, ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
end

function drawText( str, x, y, style )
	if style == nil then
		style = {}
	end

	SetTextFont( (style.font ~= nil) and style.font or 0 )
	SetTextScale( 0.0, (style.size ~= nil) and style.size or 1.0 )
	SetTextProportional( 1 )

	if style.colour ~= nil then
		SetTextColour( style.colour.r ~= nil and style.colour.r or 255, style.colour.g ~= nil and style.colour.g or 255, style.colour.b ~= nil and style.colour.b or 255, style.colour.a ~= nil and style.colour.a or 255 )
	else
		SetTextColour( 255, 255, 255, 255 )
	end

	if style.shadow ~= nil then
		SetTextDropShadow( style.shadow.distance ~= nil and style.shadow.distance or 0, style.shadow.r ~= nil and style.shadow.r or 0, style.shadow.g ~= nil and style.shadow.g or 0, style.shadow.b ~= nil and style.shadow.b or 0, style.shadow.a ~= nil and style.shadow.a or 255 )
	else
		SetTextDropShadow( 0, 0, 0, 0, 255 )
	end

	if style.border ~= nil then
		SetTextEdge( style.border.size ~= nil and style.border.size or 1, style.border.r ~= nil and style.border.r or 0, style.border.g ~= nil and style.border.g or 0, style.border.b ~= nil and style.border.b or 0, style.border.a ~= nil and style.shadow.a or 255 )
	end

	if style.centered ~= nil and style.centered == true then
		SetTextCentre( true )
	end

	if style.outline ~= nil and style.outline == true then
		SetTextOutline()
	end

	SetTextEntry( "STRING" )
	AddTextComponentString( str )

	DrawText( x, y )
end

function degreesToIntercardinalDirection( dgr )
	dgr = dgr % 360.0
	if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
		return "N "
	elseif dgr >= 22.5 and dgr < 67.5 then
		return "NE"
	elseif dgr >= 67.5 and dgr < 112.5 then
		return "E"
	elseif dgr >= 112.5 and dgr < 157.5 then
		return "SE"
	elseif dgr >= 157.5 and dgr < 202.5 then
		return "S"
	elseif dgr >= 202.5 and dgr < 247.5 then
		return "SO"
	elseif dgr >= 247.5 and dgr < 292.5 then
		return "O"
	elseif dgr >= 292.5 and dgr < 337.5 then
		return "NO"
	end
end

function drawTxt(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function msg(state, vehicle)
	local position = GetEntityCoords(vehicle)
	local stt = state
	local tmp = 75
	while tmp > 0 do
		position = GetEntityCoords(vehicle)
		if stt == 1 then
			--exports['mythic_notify']:SendAlert('error', 'TRANCADO')
			DrawText3Ds(position.x, position.y, position.z + 0.5, "~g~DESTRANCADO")
		elseif stt == 2 then
			--exports['mythic_notify']:SendAlert('success', 'DESTRANCADO')
			DrawText3Ds(position.x, position.y, position.z + 0.5, "~r~TRANCADO")
		end
		tmp = tmp - 1
		Citizen.Wait(7)
	end
end

--[[function OpenMenuGarage(PointType)

	ESX.UI.Menu.CloseAll()

	local elements = {}

	if PointType == 'spawn' then
		table.insert(elements,{label = "Lista de Veículos", value = 'list_vehicles'})
	end

	if PointType == 'comando' then
		table.insert(elements,{label = "Lista de Veículos", value = 'list_vehicles1'})
	end

	if PointType == 'delete' then
		table.insert(elements,{label = "Lista de Veículos", value = 'stock_vehicle'})
	end

	if PointType == 'pound' then
		table.insert(elements,{label = "Veiculos Apreendidos", value = 'return_vehicle'})
	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'garage_menu',
		{
			title    = "Garagem",
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)

			menu.close()
			if(data.current.value == 'list_vehicles') then
				ListVehiclesMenu()
			end
			if(data.current.value == 'list_vehicles1') then
				ListVehiclesMenu()
			end
			if(data.current.value == 'stock_vehicle') then
				if bilhete == true then
					StockVehicleMenu()
				else
					TriggerEvent('esx:showNotification', 'Tem de obter o Bilhete de Parque')
				end
			end
			if(data.current.value == 'return_vehicle') then
				ReturnVehicleMenu()
			end


		end,
		function(data, menu)
			menu.close()

		end
	)
end

function ListVehiclesMenu()
	local elements = {}

	ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)

		for _,v in pairs(vehicles) do

			local hashVehicule = v.vehicle.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
    		local labelvehicle
			local plate = v.plate

    		if(v.state)then
    		labelvehicle = vehicleName.. ' (' .. plate .. ') ' .."Garagem"
    		else
    		labelvehicle = vehicleName.. ' (' .. plate .. ') Out of Garage'
    		end
			table.insert(elements, {label =labelvehicle , value = v})

		end


	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'spawn_vehicle',
		{
			title    = "Garagem",
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)
			menu.close()
		end,
		function(data, menu)
			menu.close()
			--CurrentAction = 'open_garage_action'
		end
	)
	end)
end]]

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    local scale = 0.225

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
		SetTextOutline()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

--[[function ReturnVehicleMenu()
	ESX.TriggerServerCallback('kuana:getOutVehicles', function(vehicles)
		local elements = {}
		for _,v in pairs(vehicles) do
			local hashVehicule = v.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
			local labelvehicle
			local plate = v.plate
    		labelvehicle = vehicleName..': ' ..plate
			table.insert(elements, {label =labelvehicle, value = v})
		end
		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'return_vehicle',
		{
			title    = "Veiculos apreendidos",
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)
			placa = data.current.value.plate
			TriggerServerEvent('kuana:modifystate', placa, 1)
			menu.close()
		end,
		function(data, menu)
			menu.close()
			--CurrentAction = 'open_garage_action'
		end
		)
	end)
end]]
--[[
RegisterCommand('garagem', function(source, args, rawCommand)
	local vehicle = nil
	local veh = ESX.Game.GetVehicles()
	local elements = {}
	ESX.TriggerServerCallback('kuana:getVehicles', function(vehicles)
		for _,v in pairs(vehicles) do
			local hashVehicule = v.vehicle.model
			local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
			local labelvehicle
			local plate = v.plate
			labelvehicle = vehicleName.. ' (' .. plate .. ') '
			table.insert(elements, {label =labelvehicle , value = v})
		end
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'spawn_vehiclereload',
			{
				title    = "Garagem",
				align    = 'bottom-right',
				elements = elements,
			},
			function(data, menu)
				for i=1, #veh, 1 do
					if DoesEntityExist(veh[i]) then
						local vehiclePropsn  = ESX.Game.GetVehicleProperties(veh[i])
						if vehiclePropsn ~= nil then
							if vehiclePropsn.plate == data.current.value.plate then
								podespawn = false
								vehicle = veh[i]
								coords = GetEntityCoords(veh[i])
								break
							else
								podespawn = true
							end
						else
							menu.close()
						end
					else
						podespawn = true
					end
				end
				if podespawn == true then
					ESX.TriggerServerCallback('kuana:checkcoordsall', function(xx, yy, zz, hh, vidaa, islock)
						local cods = {x = xx + 0.0, y = yy + 0.0, z= zz + 1.0}
						if ESX.Game.IsSpawnPointClear(cods, 2.5) then
							createVehicle(cods, hh, vidaa, data, islock)
						else
							ESX.Game.DeleteVehicle(ESX.Game.GetClosestVehicle(cods))
							createVehicle(cods, hh, vidaa, data, islock)
						end
						RemoveBlip(blipm)
						local xx = xx + 0.0
						local zz = zz + 0.0
						local yy = yy + 0.0
						blipm = AddBlipForCoord(xx, yy, zz)
						SetBlipSprite (blipm, 66)
						SetBlipDisplay(blipm, 4)
						SetBlipScale  (blipm, 0.8)
						SetBlipColour (blipm, 59)
						SetBlipAsShortRange(blipm, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Carro Perdido")
						EndTextCommandSetBlipName(blipm)
					end, data.current.value.plate)
					menu.close()
				else
					createBlip(vehicle)
					exports['mythic_notify']:SendAlert('success', 'O teu carro já foi entregue')
					menu.close()
				end
			end,
			function(data, menu)
				menu.close()
				--CurrentAction = 'open_garage_action'
			end
		)
	end)
end)
--]]
function createVehicle(cods, hh, vidaa, data, islock)
	Citizen.CreateThread(function ()
		local hh    = hh + 0.0000000001
		local vidaa = vidaa + 0.0
		if vidaa < 0 then
			vidaa = 450
		end
		local ply = PlayerPedId()
		local plyloc = GetEntityCoords(ply)
		exports['mythic_notify']:SendAlert('success', 'Carro entregue!')
		while true do
			plyloc = GetEntityCoords(ply)
			if GetDistanceBetweenCoords(cods.x, cods.y, cods.z, plyloc) < 150.0 then
				ESX.Game.SpawnVehicle(data.current.value.vehicle.model, cods, hh, function(callback_vehicle)
					ESX.Game.SetVehicleProperties(callback_vehicle, data.current.value.vehicle)
					SetVehicleNumberPlateText(callback_vehicle, data.current.value.vehicle.plate)
					if data.current.value.vehicle.modLivery ~= -1 then
						SetVehicleLivery(vehicle, data.current.value.vehicle.modLivery, true)
					end
					SetVehicleDoorsLocked(callback_vehicle, islock)
					SetVehicleEngineHealth(callback_vehicle, vidaa)
					SetVehicleExtraColours(callback_vehicle, data.current.value.vehicle.pearlescentColor, data.current.value.vehicle.wheelColor)
					SetVehicleExtraColours(callback_vehicle, data.current.value.vehicle.pearlescentColor, data.current.value.vehicle.wheelColor)
					SetVehicleNeonLightsColour(callback_vehicle, data.current.value.vehicle.neonColor[1], data.current.value.vehicle.neonColor[2], data.current.value.vehicle.neonColor[3])
					TriggerEvent("onyx:updatePlates", data.current.value.plate)
					exports["tqrp_base"]:SetFuel(callback_vehicle, data.current.value.vehicle.fuelLevel)
					TriggerServerEvent('kuana:modifystate', data.current.value.plate, 0)
				end)
				break
			end
			Citizen.Wait(1500)
		end
	end)
end

function createBlip(vehicle)
	RemoveBlip(blipm)
	blipm = AddBlipForEntity(vehicle)
	SetBlipSprite (blipm, 66)
	SetBlipDisplay(blipm, 4)
	SetBlipScale  (blipm, 0.8)
	SetBlipColour (blipm, 59)
	SetBlipAsShortRange(blipm, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Carro Perdido")
	EndTextCommandSetBlipName(blipm)
end

RegisterCommand('windows', function(source, args, rawCommand)
    if IsPedInAnyVehicle(PlayerPed, false) then
        local playerCar = PedCar
		if (GetPedInVehicleSeat(playerCar, -1) == PlayerPed) then
            SetEntityAsMissionEntity( playerCar, true, true )
			if ( windowup ) then
				RollDownWindow(playerCar, 0)
				TriggerEvent('InteractSound_CL:PlayOnOne',"window",0.01)
				Citizen.Wait(2300)
				RollDownWindow(playerCar, 1)
				windowup = false
			else
				RollUpWindow(playerCar, 0)
				TriggerEvent('InteractSound_CL:PlayOnOne',"window",0.01)
				Citizen.Wait(2300)
				RollUpWindow(playerCar, 1)
				windowup = true
			end
		end
	end
end, false)

RegisterCommand("fecharhud",function(source, args)
	SendNUIMessage({
		showHud = false
	})
end, false)

RegisterCommand("neon", function()
    local veh = PedCar
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
		--left
        if IsVehicleNeonLightEnabled(veh) then
            SetVehicleNeonLightEnabled(veh, 0, false)
            SetVehicleNeonLightEnabled(veh, 1, false)
            SetVehicleNeonLightEnabled(veh, 2, false)
            SetVehicleNeonLightEnabled(veh, 3, false)
        else
            SetVehicleNeonLightEnabled(veh, 0, true)
            SetVehicleNeonLightEnabled(veh, 1, true)
            SetVehicleNeonLightEnabled(veh, 2, true)
            SetVehicleNeonLightEnabled(veh, 3, true)
        end
    end
end, false)

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end)-- Prevents RAM LEAKS :)