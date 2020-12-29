ESX = nil
local anchored = false
local boat = nil
PlayerPed = PlayerPedId()
coords = GetEntityCoords(PlayerPed)
local inside = false
local showJobs = false
local players = 0
local leftSide = 0.72
local emsY = 1.454
local sound = false
local mp_pointing = false
local crouched = false
local proned = false
local crouchKey = 36
local proneKey = 243
local isTaz = false
local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)
local clipboardEntity
local forceDraw = false
local shouldDraw = false
local Ran = false 
local seconds = 0
local minutes = 0
local hours = 0
local days = 0
local timechecked = false
local count = 0
local TackleTime = 2500 -- In milliseconds		= 0
local stamina = 0
inVeh = false
local vehicles = {}
local searchedVehicles = {}
local isHotwiring = false
local engineOn = false
local disableShuffle = true
local mask = false
local angle = 0.0
local speed = 0.0
local ped = {}

local foodMachines = {
    {o = -654402915}, 
    {o = -1034034125}
}

local drinkMachines = {
    {o = 992069095}, 
    {o = 1114264700}
}

local Locations = {
	-- CELAS PALETO
	[1] = {From = {332.05, -595.63, 42.6}, To = {319.41, -559.45, 28.1}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] para descer", Car = false},
	[2] = {From = {319.41, -559.45, 28.10}, To = {332.05, -595.63, 42.6}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] para subir", Car = false},
	-- Hostpial 2 Heliporto
	[3] = {From = {330.11, -601.18, 42.6}, To = {338.91, -585.38, 74.17}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Subir", Car = false},
	[4] = {From = {338.91, -585.38, 74.17}, To = {330.11, -601.18, 42.6}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Descer", Car = false},
	-- Vanilla
	[5] = {From = {132.76, -1293.76, 28.57}, To = {132.62, -1287.41, 28.57}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Entrar", Car = false},
	[6] = {From = {132.62, -1287.41, 28.57}, To = {132.76, -1293.76, 28.57}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Sair", Car = false},
	-- Vanilla
	[7] = {From = {3540.72, 3675.6, 27.50}, To = {3540.72, 3675.6, 20.20}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Descer", Car = false},
	[8] = {From = {3540.72, 3675.6, 20.20}, To = {3540.72, 3675.6, 27.50}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Subir", Car = false},
	--- Hospital morgue
	[9] = {From = {279.42, -1349.47, 23.44}, To = {327.22, -603.32, 42.6}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Subir", Car = false},
	[10] = {From = {327.22, -603.32, 42.6}, To = {279.42, -1349.47, 23.44}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Descer", Car = false},
	--- casino
	[11] = {From = {925.0, 47.0, 80.00, 0}, To = {1090.00, 207.00, -49.9, 358}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Entrar", Car = false},
	[12] = {From = {1090.00, 207.00, -49.9, 358}, To = {925.0, 47.0, 80.00, 0}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Sair", Car = false},
	--- pentouse
	[13] = {From = {1086.00, 215.0, -50.00, 312}, To = {980.00, 57.0, 115.0, 52}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Entrar", Car = false},
	[14] = {From = {980.00, 57.0, 115.0, 52}, To = {1086.00, 215.0, -50.00, 312}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Sair", Car = false},
	--- DFI Building Elevator 1
	[15] = {From = {136.33, -761.50, 44.75, 312}, To = {136.46, -761.640, 241.15, 52}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Entrar", Car = false},
	[16] = {From = {136.46, -761.640, 241.15, 52}, To = {136.33, -761.50, 44.75, 312}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Sair", Car = false},
	--- DFI Building Elevator 2
	[17] = {From = {139.19, -762.66, 44.75, 312}, To = {2033.72, 2942.12, -61.24}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Entrar", Car = false},
	[18] = {From = {2033.71, 2942.11, -62.90, 52}, To = {139.19, -762.66, 44.75, 312}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Sair", Car = false},
	--- DFI Building Elevator 3
	[19] = {From = {156.87, -757.20, 257.15, 312}, To = {131.20, -762.11, 241.15, 52}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Entrar", Car = false},
	[20] = {From = {131.20, -762.11, 241.15, 52}, To = {156.87, -757.20, 257.15, 312}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Sair", Car = false},
	--- DFI Building Elevator 4
	[21] = {From = {2154.78, 2921.08, -62.9, 312}, To = {141.29, -734.93, 261.85, 52}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Entrar", Car = false},
	[22] = {From = {141.29, -734.93, 261.85, 52}, To = {2154.78, 2921.08, -62.9, 312}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Sair", Car = false},
	--- DFI Building Elevator 5
	[21] = {From = {2030.43, 3003.08, -73.7, 311.16}, To = {180.17, -694.55, 32.13, 67.21}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Entrar", Car = true},
	[22] = {From = {180.17, -694.55, 32.13, 67.21}, To = {2030.43, 3003.08, -73.7, 311.16}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Sair", Car = true},

	--- PR ELEVADOR
	[23] = {From = {-1309.46, -559.35, 20.0, 220.02}, To = {-1309.38, -563.79, 30.07, 220.76}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Subir", Car = false},
	[24] = {From = {-1309.38, -563.79, 30.07, 220.76}, To = {-1309.46, -559.35, 20.0, 220.02}, DistanceVision = 3, DistanceClick = 1.5, Message = "[~g~E~w~] Descer", Car = false}
}

--local CasinoVehHash = GetHashKey("t20")

local Vehicle = {
	Coords = nil,
	Vehicle = nil,
	Dimension = nil,
	IsInFront = false,
	Distance = nil
}

local coordonate = {
    {-1169.32, -1572.78, 3.66, 137.57, 0x989DFD9A, "csb_money"},
	{-1215.91, -1515.76, 3.37, 70.97, 0xF0EC56E2, "u_m_m_aldinapoli"},
	{308.43, -595.62, 42.28, 78.25, 0xD47303AC, "s_m_m_doctor_01"},
    {303.04, -590.15, 42.28, 342.44, 0x22911304, "s_m_y_doorman_01"},
	{321.45, -558.92, 27.74, 41.03, 0x22911304, "s_m_y_doorman_01"}
}

local relationshipTypes = {
	'GANG_1',
	'GANG_2',
	'GANG_9',
	'GANG_10',
	'AMBIENT_GANG_LOST',
	'AMBIENT_GANG_MEXICAN',
	'AMBIENT_GANG_FAMILY',
	'AMBIENT_GANG_BALLAS',
	'AMBIENT_GANG_MARABUNTE',
	'AMBIENT_GANG_CULT',
	'AMBIENT_GANG_SALVA',
	'AMBIENT_GANG_WEICHENG',
	'AMBIENT_GANG_HILLBILLY',
	'DEALER',
	'COP',
	'PRIVATE_SECURITY',
	'SECURITY_GUARD',
	'ARMY',
	'MEDIC',
	'FIREMAN',
	'HATES_PLAYER',
	'NO_RELATIONSHIP',
	'SPECIAL',
	'MISSION2',
	'MISSION3',
	'MISSION4',
	'MISSION5',
	'MISSION6',
	'MISSION7',
	'MISSION8'
}

Citizen.CreateThread(function()
	for _,v in pairs(coordonate) do
		RequestModel(GetHashKey(v[6]))
		while not HasModelLoaded(GetHashKey(v[6])) do
			Wait(100)
		end

		RequestAnimDict("mini@strip_club@idles@bouncer@base")
		while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
			Wait(100)
		end
	end
	while true do
		for k,v in pairs(coordonate) do
			if #(vector3(v[1],v[2],v[3]) - GetEntityCoords(PlayerPed)) <= 20 then
				if not DoesEntityExist(ped[k]) then
					ped[k] =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
					SetEntityHeading(ped[k], v[4])
					FreezeEntityPosition(ped[k], true)
					SetBlockingOfNonTemporaryEvents(ped[k], true)
					TaskPlayAnim(ped[k], "mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
				end
			else
				if DoesEntityExist(ped[k]) then
					DeletePed(ped[k])
				end
			end
		end
		Citizen.Wait(5000)
	end

	--- CASINO VEHICLE ----

    --[[while not HasModelLoaded(CasinoVehHash) do Citizen.Wait(10); RequestModel(CasinoVehHash); end
    ESX.Game.SpawnLocalVehicle(CasinoVehHash, vector3(1100.08, 219.62, -48.75), 262.79, function(cbVeh)
		Citizen.Wait(10)
		SetVehicleNumberPlateText(cbVeh, 'DIAMOND')
        SetEntityCoords(cbVeh, 1100.08, 219.62, -48.75, 0.0, 0.0, 0.0, true)
        SetEntityHeading(cbVeh, 262.79)
        SetEntityAsMissionEntity(cbVeh, true, true)
       -- SetVehicleOnGroundProperly(cbVeh)
        Citizen.Wait(10)
        FreezeEntityPosition(cbVeh, true)
        SetEntityInvincible(cbVeh, true)
        SetVehicleDoorsLocked(cbVeh, 2)
    end)
	SetModelAsNoLongerNeeded(CasinoVehHash) ]]
end)

function collectAndSendResourceList()
    local resourceList = {}
    for i=0, (GetNumResources()-1), 1 do
        resourceList[i+1] = GetResourceByFindIndex(i)
    end
    TriggerServerEvent("checkMyResources", resourceList)
end

CreateThread(function()
    while true do
        collectAndSendResourceList()
        Wait(15000)
    end
end)

RegisterNetEvent('tqrp_base:intrunk')
AddEventHandler('tqrp_base:intrunk', function()
	local vehicle = VehicleInFront()
	SetEntityAsMissionEntity(vehicle, false, true)
	if GetVehiclePedIsIn(PlayerPed, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
		SetVehicleDoorOpen(vehicle, 5, false, false)
		ClearPedTasks(PlayerPed)
		AttachEntityToEntity(PlayerPed, vehicle, -1, 0.0, -1.7, 0.3, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
		RaiseConvertibleRoof(vehicle, false)
		while not IsEntityAttached(PlayerPed) do
			Citizen.Wait(100)
		end
		if IsEntityAttached(PlayerPed) then
			ClearPedTasksImmediately(PlayerPed)
			Citizen.Wait(100)
			TaskPlayAnim(PlayerPed, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)
			if not (IsEntityPlayingAnim(PlayerPed, 'timetable@floyd@cryingonbed@base', 'base', 3) == 1) then
				Streaming('timetable@floyd@cryingonbed@base', function()
				TaskPlayAnim(PlayerPed, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 47, 0, 0, 0, 0)
				end)
				inside = true
			end
		end
		Citizen.Wait(2000)
		SetVehicleDoorShut(vehicle, 5, false)
	end
	if DoesEntityExist(vehicle) and inside then
		car = GetEntityAttachedTo(PlayerPed)
		carxyz = GetEntityCoords(car, 0)
		local visible = true
		DisableAllControlActions(0)
		DisableAllControlActions(1)
		DisableAllControlActions(2)
		EnableControlAction(0, 0, true) --- V - camera
		EnableControlAction(0, 249, true) --- N - push to talk
		EnableControlAction(2, 1, true) --- camera moving
		EnableControlAction(2, 2, true) --- camera moving
		EnableControlAction(0, 177, true) --- BACKSPACE
		EnableControlAction(0, 200, true) --- ESC
		if IsDisabledControlJustPressed(1, 22) then
			if visible then
				SetEntityVisible(PlayerPed, false, false)
				visible = false
			end
		end
		while inside do
			AttachEntityToEntity(PlayerPed, vehicle, -1, 0.0, -1.7, 0.3, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			Citizen.Wait(100)
		end
	end
end)


RegisterNetEvent('tqrp_base:clearVehicle')
AddEventHandler('tqrp_base:clearVehicle', function()

	local vehicle = GetClosestVehicle(coords, 6.0, 0, 71)
	if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
		TaskStartScenarioInPlace(PlayerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
		exports['mythic_progbar']:Progress({
			name = "unique_action_name",
			duration = 5000,
			label = "A limpar o veículo..",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}
		}, function(status)
			SetVehicleDirtLevel(vehicle, 0)
			ClearPedTasksImmediately(PlayerPed)
		end)
	end

end)

RegisterNetEvent('tqrp_base:outtrunk')
AddEventHandler('tqrp_base:outtrunk', function()
	local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 6.0, 0, 71)
	if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
		inside = false
		DetachEntity(PlayerPed, true, true)
		SetEntityVisible(PlayerPed, true, true)
		ClearPedTasks(PlayerPed)
	end
end)

RegisterNetEvent('smerfikubrania:koszulka')
AddEventHandler('smerfikubrania:koszulka', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:acessorio')
AddEventHandler('smerfikubrania:acessorio', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {
		['decals_1'] = 0, ['decals_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:backpack')
AddEventHandler('smerfikubrania:backpack', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {
		['bags_1'] = 0, ['bags_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)


RegisterNetEvent('smerfikubrania:despir')
AddEventHandler('smerfikubrania:despir', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 15, ['torso_2'] = 0,
			['arms'] = 15, ['arms_2'] = 0,
			['pants_1'] = 21, ['pants_2'] = 0,
			['shoes_1'] = 34, ['shoes_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['bproof_1'] = 0, ['bproof_2'] = 0,
			['bproof_1'] = 0, ['bproof_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:spodnie')
AddEventHandler('smerfikubrania:spodnie', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {
		['pants_1'] = 21, ['pants_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:buty')
AddEventHandler('smerfikubrania:buty', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {
			['shoes_1'] = 34, ['shoes_2'] = 0
			}
		if skin['sex'] == 1 then
			clothesSkin = {
				['shoes_1'] = 35, ['shoes_2'] = 0
			}
		end
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:fio')
AddEventHandler('smerfikubrania:fio', function()
	TriggerEvent('skinchanger:getSkin', function(skin)

		local clothesSkin = {
		['chain_1'] = 0, ['chain_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:luvas')
AddEventHandler('smerfikubrania:luvas', function()
	TriggerEvent('skinchanger:getSkin', function(skin)

		local clothesSkin = {
		['arms'] = 15, ['arms'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:colete')
AddEventHandler('smerfikubrania:colete', function()
	TriggerEvent('skinchanger:getSkin', function(skin)

		local clothesSkin = {
		['bproof_1'] = 0, ['bproof_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

AddEventHandler("onClientMapStart", function ()
	-- If not already ran
	if not Ran then
		-- Close loading screen resource
		ShutdownLoadingScreenNui()
		-- Set as ran
		Ran = true
	end
end)

RegisterNetEvent('onlinetime_sql:sendDados')
AddEventHandler('onlinetime_sql:sendDados', function(s, m, h, d)
    seconds = s
	minutes = m
    hours = h
    days = d
    timechecked = true -- STARTS THE COUNT OF THE ONLINE TIME
end)

RegisterNetEvent('disc-showid:id')
AddEventHandler('disc-showid:id', function()
    forceDraw = not forceDraw
end)

RegisterNetEvent('nfwlock:setVehicleDoors')
AddEventHandler('nfwlock:setVehicleDoors', function(veh, doors)
	busy = false
	SetVehicleDoorsLocked(veh, doors)
end)

RegisterNetEvent('Tackle:Client:TacklePlayer')
AddEventHandler('Tackle:Client:TacklePlayer', function(ForwardVectorX, ForwardVectorY, ForwardVectorZ, Tackler)
	SetPedToRagdollWithFall(PlayerPedId(), TackleTime, TackleTime, 0, ForwardVectorX, ForwardVectorY, ForwardVectorZ, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterNetEvent('onyx:pickDoor')
AddEventHandler('onyx:pickDoor', function()
    -- TODO: Lockpicking vehicle doors to gain access
end)

RegisterNetEvent('onyx:updatePlates')
AddEventHandler('onyx:updatePlates', function(plate)
	table.insert(vehicles, plate)
	keys = hasKeys(plate)
end)

RegisterNetEvent('onyx:beginHotwire')
AddEventHandler('onyx:beginHotwire', function(plate)
    RequestAnimDict("veh@std@ds@base")

    while not HasAnimDictLoaded("veh@std@ds@base") do
        Citizen.Wait(100)
	end

    local vehPlate = plate
    isHotwiring = true
    lockControls()
    SetVehicleEngineOn(PlayerVeh, false, true, true)
    SetVehicleLights(PlayerVeh, 0)
    
    local alarmChance = math.random(1, 10)

    if alarmChance == 9 then
        SetVehicleAlarm(PlayerVeh, true)
        StartVehicleAlarm(PlayerVeh)
    end

    TaskPlayAnim(PlayerPed, "veh@std@ds@base", "hotwire", 8.0, 8.0, -1, 1, 0.3, true, true, true)
	Skillbar = exports['tqrp_skillbar']:GetSkillbarObject()
	Skillbar.Start({
		duration = math.random(5500, 7000),
		pos = math.random(10, 80),
		width = math.random(10, 20),
	}, function()  -- SUCCESS
		Skillbar.Start({
			duration = math.random(2500, 5000),
			pos = math.random(10, 80),
			width = math.random(8, 15),
		}, function()  -- SUCCESS
			Skillbar.Start({
				duration = math.random(500, 2000),
				pos = math.random(10, 80),
				width = math.random(6, 10),
			}, function()  -- SUCCESS
				table.insert(vehicles, vehPlate)
				keys = hasKeys(vehPlate)
				StopAnimTask(PlayerPed, 'veh@std@ds@base', 'hotwire', 1.0)
				isHotwiring = false
				engineOn = false
				while not engineOn do
					SetVehicleEngineOn(GetVehiclePedIsUsing(PlayerPed), true, true, false)
					if engineOn then
						break
					end
					Citizen.Wait(10)
				end
			end, function()	-- ERROR
				StopAnimTask(PlayerPed, 'veh@std@ds@base', 'hotwire', 1.0)
				isHotwiring = false
			end)
		end, function()	-- ERROR
			StopAnimTask(PlayerPed, 'veh@std@ds@base', 'hotwire', 1.0)
			isHotwiring = false
		end)
	end, function()	-- ERROR
		StopAnimTask(PlayerPed, 'veh@std@ds@base', 'hotwire', 1.0)
		isHotwiring = false
	end)
end)



RegisterNetEvent('onyx:returnSearchedVehTable')
AddEventHandler('onyx:returnSearchedVehTable', function(plate)
    local vehPlate = plate
    table.insert(searchedVehicles, vehPlate)
end)



Citizen.CreateThread(function()
    while true do
        Wait(1000)
		TriggerServerEvent('onlinetime_sql:time')
		return
    end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
	TriggerEvent('chat:addSuggestion', '/mudar', 'mudar para condutor')
	for i = 1, 15 do
        EnableDispatchService(i, false)
    end
	Citizen.InvokeNative(0xDC0F817884CDD85, 1, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 2, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 3, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 4, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 5, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 6, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 8, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 9, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 10, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 11, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 12, false)
	SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
	SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
	SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
	SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
	SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
end)


RegisterNetEvent("gasMask")
AddEventHandler("gasMask", function()
	mask = not mask
	if mask then
		loadAnimDict("misscommon@van_put_on_masks")
		TaskPlayAnim(PlayerPed, "misscommon@van_put_on_masks", "put_on_mask_rps", 500.0, -8, -1, 49, 0, 0, 0, 0)
		Wait(500)
		SetPedComponentVariation(PlayerPed, 1, 38, 0, 1)
		N_0x4757f00bc6323cfe(`WEAPON_SMOKEGRENADE`, 0.0)
		N_0x4757f00bc6323cfe(`WEAPON_BZGAS`, 0.0)
		Wait(1700)
		ClearPedTasks(PlayerPed)
	else
		loadAnimDict("missfbi4")
		TaskPlayAnim(PlayerPed, "missfbi4", "takeoff_mask", 500.0, -8, -1, 49, 0, 0, 0, 0)
		Wait(1000)
		SetPedComponentVariation(PlayerPed, 1, prevMask, 0, 1)
		N_0x4757f00bc6323cfe(`WEAPON_SMOKEGRENADE`, 1.0)
		N_0x4757f00bc6323cfe(`WEAPON_BZGAS`, 1.0)
		Wait(300)
		ClearPedTasks(PlayerPed)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsPedInAnyBoat(PlayerPed) then
			boat  = GetVehiclePedIsIn(PlayerPed, true)
			if IsControlJustPressed(1, 182) and not inVeh and boat ~= nil  then
				if not anchored then
					SetBoatAnchor(boat, true)
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Anchordown", 0.6)
					exports['mythic_progbar']:Progress({
						name = "ligacao_direta",
						duration = 6000,
						label = "A baixar a ancora...",
						useWhileDead = true,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
						animation = {},
						prop = {},
						propTwo = {},
					})
					Citizen.Wait(6000)
					--ShowNotification("Anker geworfen")
					exports['mythic_notify']:SendAlert('success', 'Ancora baixada')
					ClearPedTasks(PlayerPed)
				else
					SetBoatAnchor(boat, false)
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Anchorup", 0.6)
					exports['mythic_progbar']:Progress({
						name = "ligacao_direta",
						duration = 6000,
						label = "A subir a ancora...",
						useWhileDead = true,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
						animation = {},
						prop = {},
						propTwo = {},
					})
					Citizen.Wait(6000)
					SetBoatAnchor(boat, false)
					--ShowNotification("Anker eingeholt")
					exports['mythic_notify']:SendAlert('success', 'Ancora recolhida')
					ClearPedTasks(PlayerPed)
					boat = nil
				end
				anchored = not anchored
			end
			if IsVehicleEngineOn(boat) then
				anchored = false
			end
		else
			ClearAreaOfCops(coords.x, coords.y, coords.z, 500.0)
			Citizen.Wait(3000)
		end
	end
end)

--- VARIAVEIS CONTROLO NPC ---------
local plyPed
local plyVeh
local plyCoords
local dist1 = 0
local dist2 = 0
--------------------------------------
Citizen.CreateThread(function() -- CONTROLO NPC
	
    while true do
		Citizen.Wait(0)
		
		plyPed = PlayerPedId()
        plyVeh = GetVehiclePedIsIn(plyPed, false)
        plyCoords = GetEntityCoords(plyPed, true)

		SetPlayerHealthRechargeMultiplier(plyPed, 0.0)
        StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')

        -- Disables emergency response

		dist1 = #(vector3(plyCoords.x, plyCoords.y, plyCoords.z) - vector3(194.23, -925.44, 30.69))
		dist2 = #(vector3(plyCoords.x, plyCoords.y, plyCoords.z) - vector3(246.75, -337.17, -118.79))


        if dist1 < 750.0 or dist2 < 750.0 then
            if (GetPedInVehicleSeat(plyVeh, -1) == plyPed) then
                SetVehicleDensityMultiplierThisFrame(0.4)
                SetPedDensityMultiplierThisFrame(0.8)
                SetParkedVehicleDensityMultiplierThisFrame(0.5)
            else
                SetVehicleDensityMultiplierThisFrame(0.0)
                SetPedDensityMultiplierThisFrame(0.8)
                SetParkedVehicleDensityMultiplierThisFrame(0.5)
            end
        else
            if IsPedInAnyVehicle(plyPed, false) then
                if (GetPedInVehicleSeat(plyVeh, -1) == plyPed) then
                    SetVehicleDensityMultiplierThisFrame(0.4)
                    SetPedDensityMultiplierThisFrame(0.8)
                    SetParkedVehicleDensityMultiplierThisFrame(0.5)
                else
                    SetVehicleDensityMultiplierThisFrame(0.2)
                    SetPedDensityMultiplierThisFrame(0.8)
                    SetParkedVehicleDensityMultiplierThisFrame(0.5)
                end
            else
                SetVehicleDensityMultiplierThisFrame(0.2)
                SetPedDensityMultiplierThisFrame(0.8)
                SetParkedVehicleDensityMultiplierThisFrame(0.5)
            end
		end 

		SetCreateRandomCops(false) -- disable random cops walking/driving around.
		SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
		SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
    end
end)

local BONES = {
	--[[Pelvis]][11816] = true,
	--[[SKEL_L_Thigh]][58271] = true,
	--[[SKEL_L_Calf]][63931] = true,
	--[[SKEL_L_Foot]][14201] = true,
	--[[SKEL_L_Toe0]][2108] = true,
	--[[IK_L_Foot]][65245] = true,
	--[[PH_L_Foot]][57717] = true,
	--[[MH_L_Knee]][46078] = true,
	--[[SKEL_R_Thigh]][51826] = true,
	--[[SKEL_R_Calf]][36864] = true,
	--[[SKEL_R_Foot]][52301] = true,
	--[[SKEL_R_Toe0]][20781] = true,
	--[[IK_R_Foot]][35502] = true,
	--[[PH_R_Foot]][24806] = true,
	--[[MH_R_Knee]][16335] = true,
	--[[RB_L_ThighRoll]][23639] = true,
	--[[RB_R_ThighRoll]][6442] = true,
}


--function Bool (num) return num == 1 or num == true end

--[[ function Disarm (ped)
	if IsEntityDead(ped) then return false end

	local boneCoords
	local hit, bone = GetPedLastDamageBone(ped)

	hit = Bool(hit)

	if hit then
		if BONES[bone] then
			

			boneCoords = GetWorldPositionOfEntityBone(ped, GetPedBoneIndex(ped, bone))
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
			

			return true
		end
	end

	return false
end ]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		for wep_name, wep_hash in pairs(Settings.compatable_weapon_hashes) do
			local item = GetInventoryItem(wep_hash)
			if item and item.count > 0 then
			  if not attached_weapons[wep_name] and not (GetSelectedPedWeapon(PlayerPed) == GetHashKey(wep_hash)) then
				AttachWeapon(wep_name, wep_hash, weaponGroup(wep_name))
			  elseif attached_weapons[wep_name] ~= nil then
				if (GetSelectedPedWeapon(PlayerPed) == GetHashKey(attached_weapons[wep_name].hash)) then
				  DeleteObject(attached_weapons[wep_name].handle)
				  attached_weapons[wep_name] = nil
				end
			  end
			elseif attached_weapons[wep_name] then
			  if DoesEntityExist(attached_weapons[wep_name].handle) then
				DeleteObject(attached_weapons[wep_name].handle)
				attached_weapons[wep_name] = nil
			  end
			end
			Citizen.Wait(250)
		end
		for i=1, #ChopCarLocation, 1 do
			local DistanceCheck = #(coords - ChopCarLocation[i].Chop)
			if DistanceCheck <= 20 then
				station = i
			end
			if station ~= nil and DistanceCheck >= 20 then
				station = nil
			end
			Citizen.Wait(250)
		end
		if station ~= nil then
			if #(coords - ChopCarLocation[station].Chop) >= 50 and chopstarted then
				tofaraway()
			end
		end
		for _, group in ipairs(relationshipTypes) do
			SetRelationshipBetweenGroups(1, GetHashKey('PLAYER'), GetHashKey(group)) -- could be removed
			SetRelationshipBetweenGroups(1, GetHashKey(group), GetHashKey('PLAYER'))
		end

		if coords == prevPos then
			if time > 0 then
				if time == math.ceil(600 / 4) then
					exports["mythic_notify"]:SendAlert("error", "Vais ser Kickado em " .. time .. "segundos por estares AFK")
				end

				time = time - 5
			else
				TriggerServerEvent("kickForBeingAnAFKDouchebag")
			end
		else
			time = 600
		end

		prevPos = coords
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if stamina >= 80 then
			exports["mythic_notify"]:SendAlert("inform", "Pouca stamina")
		--	sounds()
		end
		RestorePlayerStamina(PlayerId(), 0.22)
	end
end)







Citizen.CreateThread(function()
	local sleep = 3000
	local dist = nil
	while true do
		Citizen.Wait(sleep)
		sleep = 3000
		for i=1, #Locations, 1 do
			dist = #(vector3(coords.x, coords.y, coords.z) - vector3(Locations[i].From[1],Locations[i].From[2],Locations[i].From[3]))
			if Locations[i].Car then
				if inVeh then
					if dist < Locations[i].DistanceVision then
						sleep = 7
						DrawText3Ds(Locations[i].From[1],Locations[i].From[2],Locations[i].From[3]+1.15, Locations[i].Message)
						if dist < Locations[i].DistanceClick then
							if IsControlPressed(1, 38) then
								DoScreenFadeOut(500)
								Wait(1000)
								SetEntityCoordsNoOffset(GetVehiclePedIsUsing(PlayerPed), Locations[i].To[1],Locations[i].To[2],Locations[i].To[3], 0, 0, 0, 1)
								Wait(50)
								FreezeEntityPosition(GetVehiclePedIsUsing(PlayerPed), true)
								Wait(750)
								DoScreenFadeIn(500)
								FreezeEntityPosition(GetVehiclePedIsUsing(PlayerPed), false)
							end
						end
						break
					end
				end
			else
				if dist < Locations[i].DistanceVision then
					sleep = 7
					DrawText3Ds(Locations[i].From[1],Locations[i].From[2],Locations[i].From[3] +1.15, Locations[i].Message)
					if dist < Locations[i].DistanceClick then
						if IsControlPressed(1, 38) then
							DoScreenFadeOut(500)
							Wait(1000)
							SetEntityCoords(PlayerPed, Locations[i].To[1],Locations[i].To[2],Locations[i].To[3], 0, 0, 0, 1)
							Wait(50)
							FreezeEntityPosition(PlayerPed, true)
							Wait(750)
							DoScreenFadeIn(500)
							FreezeEntityPosition(PlayerPed, false)
						end
					end
					break
				end
			end
		end
    end
end)




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		N_0xf4f2c0d4ee209e20()
        N_0x9e4cfff989258472()
		if timechecked then
		    count = count + 1
			seconds = seconds + 1
			if seconds == 60 then
			    seconds = 0
			    minutes = minutes + 1
				if minutes == 60 then
				    minutes = 0
				    hours = hours + 1
				    if hours == 24 then
					    hours = 0
				        days = days + 1
				    end
				end
			end
		end
		if count == 300 then
			count = 0
		    TriggerServerEvent("onlinetime_sql:savetimedb", seconds, minutes, hours, days)
		end
		if IsPedBeingStunned(GetPlayerPed(-1)) then
		
			SetPedMinGroundTimeForStungun(GetPlayerPed(-1), 15000)

		end

		if IsPedInAnyVehicle(PlayerPed, false) then
			if not inVeh then
				car = GetVehiclePedIsUsing(PlayerPed)
				plate = GetVehicleNumberPlateText(car)
				keys = hasKeys(plate)
				if GetPedInVehicleSeat(car, -1) == PlayerPed and IsVehicleEngineOn(car) and not keys then
					table.insert(vehicles, plate)
					keys = hasKeys(plate)
				end
				inVeh = true
				vehiclelul()
			end
		else
			inVeh = false
		end
	end
end)

function Draw3DText(x, y, z, text)

    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        local dist = #(GetGameplayCamCoords() - vector3(x, y, z))
        local scale = 1.8 * (1 / dist) * (1 / GetGameplayCamFov()) * 100
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function disableSeatShuffle(flag)
	disableShuffle = flag
end

function GetTouchedPlayers()

	local TouchedPlayer = {}

	for Key, Value in ipairs(ESX.Game.GetPlayers()) do

		if IsEntityTouchingEntity(PlayerPedId(), GetPlayerPed(Value)) then

			table.insert(TouchedPlayer, Value)

		end

	end

	return TouchedPlayer

end

function vehiclelul()
	local sleep = 250
	Citizen.CreateThread(function ()
		while inVeh do
			Citizen.Wait(sleep)
			sleep = 250
			engineOn = IsVehicleEngineOn(car)
			if not engineOn and not keys then
				SetVehicleEngineOn(car, false, true, true)
			end

			if GetPedInVehicleSeat(car, -1) == PlayerPed then
				if engineOn then
					if allowedchop and not chopstarted and station ~= nil then
						sleep = 7
						DrawMarker(20,ChopCarLocation[station].Chop, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
						if #(coords - ChopCarLocation[station].Chop) < 1.2 then
							local x,y,z = table.unpack(ChopCarLocation[station].Chop)
							DrawText3Ds(x,y,z, "[~g~E~w~] Remover")
							if(IsControlJustPressed(0, 38)) then
								if not clientcooldown then
									Citizen.CreateThread(function()
										StartChopThisCar()
									end)
								end
							end
						end
					end
				else
					if not keys and not isHotwiring and not isSearching then
						SetVehicleNeedsToBeHotwired(GetVehiclePedIsTryingToEnter(PlayerPed), false)
						sleep = 7
						if hasBeenSearched(plate) then
							DrawText3Ds(coords.x, coords.y, coords.z + 0.2, 'Pressina [~y~H~w~] para fazer Ligação-Direta')
						else
							DrawText3Ds(coords.x, coords.y, coords.z + 0.2, 'Pressina [~y~H~w~] para fazer Ligação-Direta ou [~g~Y~w~] para procurar')
						end
						
						-- Searching
						if IsControlJustReleased(0, 246) and not isSearching and not hasBeenSearched(plate) then -- Y
							if hasBeenSearched(plate) then
								isSearching = true
								Citizen.Wait(5000)
								isSearching = false
								exports['mythic_notify']:SendAlert('error', 'Não tinha nada...')
							else
								local rnd = math.random(1, 8)
								if rnd == 4 then
									isSearching = true
									Citizen.Wait(3000)
									isSearching = false
									exports['mythic_notify']:SendAlert('inform', "Encontraste as chaves!")
									table.insert(vehicles, plate)
									keys = hasKeys(plate)
									TriggerServerEvent('onyx:updateSearchedVehTable', plate)
									table.insert(searchedVehicles, plate)
								else
									isSearching = true
									Citizen.Wait(3000)
									isSearching = false
									exports['mythic_notify']:SendAlert('error', 'Não tinha nada...')
									-- Update veh table so other players cant search the same vehicle
									TriggerServerEvent('onyx:updateSearchedVehTable', plate)
									table.insert(searchedVehicles, plate)
								end
							end
						end
						-- Hotwiring
						if IsControlJustReleased(0, 74) and not isHotwiring then -- E
							TriggerServerEvent('onyx:reqHotwiring', plate)
						end
					end
				end
			elseif GetPedInVehicleSeat(car, 0) == PlayerPed and disableShuffle then
				if GetIsTaskActive(PlayerPed, 165) then
					SetPedIntoVehicle(PlayerPed, GetVehiclePedIsIn(PlayerPed, false), 0)
					sleep = 10
				end
			end
		end
	end)
end

function lockControls()
    Citizen.CreateThread(function()
        while isHotwiring do
            Citizen.Wait(10)
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(0, 74, true)  -- Lights
        end
    end) 
end

function hasBeenSearched(plate)
    local vehPlate = plate
    for k, v in ipairs(searchedVehicles) do
        if v == vehPlate then
            return true
        end
    end
    return false
end

function sounds()
	Citizen.CreateThread(function()
		if not sound then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 2, "stamina", 0.001)
			sound = true
			Citizen.Wait(5000)
			sound = false
		end
	end)
end

function hasKeys(plate)
    local vehPlate = plate
    for k, v in ipairs(vehicles) do
        if v == vehPlate or v == vehPlate .. ' ' then
            return true
        end
    end
    return false
end

function GetNeareastPlayers()
    local players, _ = ESX.Game.GetPlayersInArea(coords, 10.0)

    local players_clean = {}

    for i = 1, #players, 1 do
        table.insert(players_clean, { playerName = GetPlayerName(players[i]), playerId = GetPlayerServerId(players[i]), coords = GetEntityCoords(GetPlayerPed(players[i])) })
    end
    return players_clean
end

function startPointing()
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(100)
    end
    SetPedCurrentWeaponVisible(PlayerPed, 0, 1, 1, 1)
    SetPedConfigFlag(PlayerPed, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, PlayerPed, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

function stopPointing()
    Citizen.InvokeNative(0xD01015C7316AE176, PlayerPed, "Stop")
    if not IsPedInjured(PlayerPed) then
        ClearPedSecondaryTask(PlayerPed)
    end
    if not IsPedInAnyVehicle(PlayerPed, 1) then
        SetPedCurrentWeaponVisible(PlayerPed, 1, 1, 1, 1)
    end
    SetPedConfigFlag(PlayerPed, 36, 0)
    ClearPedSecondaryTask(PlayerPed)
end

function SetProned()
	ClearPedTasksImmediately(PlayerPed)
	TaskPlayAnimAdvanced(PlayerPed, "move_crawl", "onfront_fwd", coords, 0.0, 0.0, GetEntityHeading(PlayerPed), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
end

function ProneMovement()
	if proned then
		if IsControlPressed(0, 32) or IsControlPressed(0, 33) then
			DisablePlayerFiring(PlayerPed, true)
		 elseif IsControlJustReleased(0, 32) or IsControlJustReleased(0, 33) then
		 	DisablePlayerFiring(PlayerPed, false)
		 end
		if IsControlJustPressed(0, 32) and not movefwd then
			movefwd = true
		    TaskPlayAnimAdvanced(PlayerPed, "move_crawl", "onfront_fwd", coords, 1.0, 0.0, GetEntityHeading(PlayerPed), 1.0, 1.0, 1.0, 47, 1.0, 0, 0)
		elseif IsControlJustReleased(0, 32) and movefwd then
		    TaskPlayAnimAdvanced(PlayerPed, "move_crawl", "onfront_fwd", coords, 1.0, 0.0, GetEntityHeading(PlayerPed), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
			movefwd = false
		end
		if IsControlJustPressed(0, 33) and not movebwd then
			movebwd = true
		    TaskPlayAnimAdvanced(PlayerPed, "move_crawl", "onfront_bwd", coords, 1.0, 0.0, GetEntityHeading(PlayerPed), 1.0, 1.0, 1.0, 47, 1.0, 0, 0)
		elseif IsControlJustReleased(0, 33) and movebwd then
		    TaskPlayAnimAdvanced(PlayerPed, "move_crawl", "onfront_bwd", coords, 1.0, 0.0, GetEntityHeading(PlayerPed), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
		    movebwd = false
		end
		if IsControlPressed(0, 34) then
			SetEntityHeading(PlayerPed, GetEntityHeading(PlayerPed)+2.0 )
		elseif IsControlPressed(0, 35) then
			SetEntityHeading(PlayerPed, GetEntityHeading(PlayerPed)-2.0 )
		end
	end
end

function Streaming(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(100)
		end
	end

	if cb ~= nil then
		cb()
	end
end

function VehicleInFront()
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPed, 0.0, 6.0, 0.0)
    local rayHandle = CastRayPointToPoint(coords.x, coords.y, coords.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPed, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

function DrawText2D(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterCommand("darchaves", function(source, args, raw) 
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	 if closestPlayer ~= -1 and closestDistance < 3.0 then
		local veh = ESX.Game.GetClosestVehicle()
		Citizen.Wait(10)
		local plate = GetVehicleNumberPlateText(veh)
		if hasKeys(plate) then
			TriggerServerEvent('onyx:givecarkeys', GetPlayerServerId(closestPlayer), plate)
			exports['mythic_notify']:SendAlert('success', 'Deste as chaves desse carro!')		
		else
			exports['mythic_notify']:SendAlert('error', 'Não tens as chaves do carro')		
		end	
	else
		exports['mythic_notify']:SendAlert('error', 'Nenhum jogador por perto')		
	end	
end, false)

RegisterCommand("on", function(source, args, raw)

	if showJobs then
		showJobs = false
	else
		showJobs = true
	end

	Citizen.CreateThread(function ()
		while showJobs do
			ESX.TriggerServerCallback('tqrp_base:getJobsOnline', function(ems, police)
				emsonline    = ems
				policeonline = police
			end)
			players = #GetActivePlayers()
			Citizen.Wait(30000)
			showJobs = false
			emsonline = nil
		end
	end)

	while emsonline == nil do
		Citizen.Wait(100)
	end

	while showJobs do
		Citizen.Wait(7)
		DrawText2D(leftSide+ 0.15, emsY, 1.0,1.0,0.45, "ON:~b~ " .. players, 169, 169, 169, 150)
		-- EMS
		if emsonline >= 1 then
			DrawText2D(leftSide + 0.20, emsY, 1.0,1.0,0.45, "SEM: ~g~ON", 169, 169, 169, 150)
		else
			DrawText2D(leftSide + 0.20, emsY, 1.0,1.0,0.45, "SEM: ~r~OFF", 169, 169, 169, 150)
		end

		-- POLICE
		if policeonline >= 1 then
			DrawText2D(leftSide + 0.25, emsY, 1.0,1.0,0.45, "DPLS: ~g~ON", 169, 169, 169, 150)
		else
			DrawText2D(leftSide + 0.25, emsY, 1.0,1.0,0.45, "DPLS: ~r~OFF", 169, 169, 169, 150)
		end
	end
end, false)

local IsEngineOn = true

RegisterNetEvent('engine')
AddEventHandler('engine',function()
	if (IsPedSittingInAnyVehicle(PlayerPed)) and not isSearching then
		local vehicle = playerVeh
		if IsVehicleEngineOn(playerVeh) then
			IsEngineOn = false
			SetVehicleEngineOn(vehicle,false,false,false)
			exports['mythic_progbar']:Progress({
				name = "unique_action_name",
				duration = 500,
				label = "A desligar motor...",
				useWhileDead = true,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}
			})
		else
			IsEngineOn = true
			SetVehicleUndriveable(vehicle,false)
			SetVehicleEngineOn(vehicle,true,false,false)
			exports['mythic_progbar']:Progress({
				name = "unique_action_name",
				duration = 500,
				label = "A ligar motor...",
				useWhileDead = true,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}
			})
		end

		while (IsEngineOn == false) do
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(10)
		end
	end
end)

RegisterCommand("bars", function(source, args, raw) --change command here
	if blackBars then
		blackBars = false
		TriggerEvent('carhud', true)
	else
		blackBars = true
		DisplayRadar(false)
		TriggerEvent('carhud', false)
		DrawRect(1.0, 1.0, 2.0, 0.25, 0, 0, 0, 255)
		DrawRect(1.0, 0.0, 2.0, 0.25, 0, 0, 0, 255)
	end
    while blackBars do
		DrawRect(1.0, 1.0, 2.0, 0.25, 0, 0, 0, 255)
		DrawRect(1.0, 0.0, 2.0, 0.25, 0, 0, 0, 255)
		Citizen.Wait(5)
	end
end, false)

RegisterCommand("roupa", function(source, args, raw) --change command here
    ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
    end)
end, false)

RegisterCommand("tshirt", function(source, args, raw) --change command here
    TriggerEvent('smerfikubrania:koszulka')
end, false)

RegisterCommand("calças", function(source, args, raw) --change command here
    TriggerEvent('smerfikubrania:spodnie')
end, false)

RegisterCommand("calçado", function(source, args, raw) --change command here
    TriggerEvent('smerfikubrania:buty')
end, false)

RegisterCommand("acessorio", function(source, args, raw) --change command 
    TriggerEvent('smerfikubrania:acessorio')
end, false) 

RegisterCommand("mochila", function(source, args, raw) --change command
    TriggerEvent('smerfikubrania:backpack')
end, false) 

RegisterCommand("fio", function(source, args, raw) --change command here
    TriggerEvent('smerfikubrania:fio')
end, false)

RegisterCommand("luvas", function(source, args, raw) --change command here
    TriggerEvent('smerfikubrania:luvas')
end, false)

RegisterCommand("tcolete", function(source, args, raw) --change command here
    TriggerEvent('smerfikubrania:colete')
end, false)

RegisterCommand("entrarmala",function(source, args)
	exports['mythic_progbar']:Progress({
		name = "asd",
		duration = 4000,
		label = "A entrar na mala",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {},
		prop = {}
	}, function(status)
		if not status then
			TriggerEvent('tqrp_base:intrunk', PlayerPedId())
		end
	end)
end,false)

RegisterCommand("sairmala",function(source, args)
	exports['mythic_progbar']:Progress({
		name = "asd",
		duration = 4000,
		label = "A sair da mala",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {},
		prop = {}
	}, function(status)
		if not status then
			TriggerEvent('tqrp_base:outtrunk')
		end
	end)
end,false)

RegisterCommand("colocarmala",function(source, args)
	local target, closestPlayerDist = ESX.Game.GetClosestPlayer()
	if target ~= nil and closestPlayerDist <= 2.5 then
		exports['mythic_progbar']:Progress({
			name = "asd",
			duration = 4000,
			label = "A coloca na mala",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {},
			prop = {}
		}, function(status)
			if not status then
				TriggerServerEvent('tqrp_base:intrunk', GetPlayerServerId(target))
			end
		end)
	end
end,false)

RegisterCommand("retirarmala",function(source, args)
	local target, closestPlayerDist = ESX.Game.GetClosestPlayer()
	if target ~= nil and closestPlayerDist <= 2.5 then
		exports['mythic_progbar']:Progress({
			name = "asdasd",
			duration = 4000,
			label = "A retirar da mala",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {},
			prop = {}
		}, function(status)
			if not status then
				TriggerServerEvent('tqrp_base:outtrunk', GetPlayerServerId(target))
			end
		end)
	end
end,false)

RegisterCommand("mudar", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false)

function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

RegisterCommand('maquina', function(source, args)
    if playerNearFoodMachine() then
        coinAnim()
        openMachineShop('foodMachine')
    elseif playerNearDrinkMachine() then
        coinAnim()
    	openMachineShop('drinkMachine')
    else
        TriggerEvent('mythic_notify:notify', 'error', 'Não estás perto de uma máquina de venda.')
    end
end)  

function openMachineShop(shoptype)
	text = "Máquina de Venda"
    data = {text = text}
    inventory = {}

    ESX.TriggerServerCallback("suku:getShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
        end
    end, shoptype)

    Citizen.Wait(500)
    TriggerEvent("tqrp_inventoryhud:openShopInventory", data, inventory)
end

function playerNearFoodMachine()

    for i = 1, #foodMachines do
        local foodMachine = GetClosestObjectOfType(coords.x, coords.y, coords.z, 1.0, foodMachines[i].o, false, false, false)
        local foodMachinePos = GetEntityCoords(foodMachine)
        local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, foodMachinePos.x, foodMachinePos.y, foodMachinePos.z, true)
        if dist < 1.5 then
            return true
        end
    end
end

function playerNearDrinkMachine()

    for i = 1, #drinkMachines do
        local drinkMachine = GetClosestObjectOfType(coords.x, coords.y, coords.z, 1.0, drinkMachines[i].o, false, false, false)
        local drinkMachinePos = GetEntityCoords(drinkMachine)
        local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, drinkMachinePos.x, drinkMachinePos.y, drinkMachinePos.z, true)
        if dist < 1.5 then
            return true
        end
    end
end

function coinAnim()
    local ped = PlayerPedId()
    LoadAnimDict('mini@sprunk')
    LoadModel('prop_ecola_can')
    TaskPlayAnim(ped, 'mini@sprunk', 'plyr_buy_drink_pt1', 8.0, 5.0, -1, true, 1, 0, 0, 0)
    Citizen.Wait(2300)
    ClearPedTasks(ped)
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

function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
Citizen.CreateThread(function()
    AddTextEntry('POLTAURUS', 'Ford Taurus')
    AddTextEntry('r1200rtp', 'BMW R1200')
	AddTextEntry('POLCHAR', ' Dodge Charger 2014')
	AddTextEntry('POLVIC', 'Crown Vic')
	AddTextEntry('POLVIC2', 'Crown Vic - 2')
	AddTextEntry('POLTAH', 'Chevy Tahoe')
	AddTextEntry('POLRAPTOR', 'Ford Raptor')
	AddTextEntry('camaroRB', 'Chevrolet Camaro')
	AddTextEntry('2015POLSTANG', 'Mustang')
	AddTextEntry('GTR', 'Nissan GTR') 
end)



Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end) -- Fix RAM leaks by collecting garbage