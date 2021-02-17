ESX = nil
local disablecontrols = false
allowedchop = true
payitems = math.random(8,15)
chopstarted = false
station = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

chopdoors = {
	[1] = {chopdoor = false, doorgone = false, doordelivered = false, CarParts = "wheel_lf",   PartLabel = "Pneu", 		PartProp = "prop_wheel_tyre", 	 				PartBone = 28422, PartX = 0.0,PartY = 0.5,PartZ = -0.05,	PartxR = 0.0, PartyR = 0.0, PartzR = 0.0},
	[2] = {chopdoor = false, doorgone = false, doordelivered = false, CarParts = "wheel_rf",   PartLabel = "Pneu", 		PartProp = "prop_wheel_tyre",	 				PartBone = 28422, PartX = 0.0,PartY = 0.5,PartZ = -0.05,	PartxR = 0.0, PartyR = 0.0, PartzR = 0.0},
	[3] = {chopdoor = false, doorgone = false, doordelivered = false, CarParts = "wheel_lr",   PartLabel = "Pneu", 		PartProp = "prop_wheel_tyre", 	 				PartBone = 28422, PartX = 0.0,PartY = 0.5,PartZ = -0.05,	PartxR = 0.0, PartyR = 0.0, PartzR = 0.0},
	[4] = {chopdoor = false, doorgone = false, doordelivered = false, CarParts = "wheel_rr",   PartLabel = "Pneu", 		PartProp = "prop_wheel_tyre", 	 				PartBone = 28422, PartX = 0.0,PartY = 0.5,PartZ = -0.05,	PartxR = 0.0, PartyR = 0.0, PartzR = 0.0},
	[5] = {chopdoor = false, doorgone = false, doordelivered = false, CarParts = "engine", 	   PartLabel = "Bateria", 	PartProp = "prop_car_battery_01",				PartBone = 28422, PartX = 0.0,PartY = 0.5,PartZ = -0.05,	PartxR = 0.0, PartyR = 0.0, PartzR = 0.0},
	[6] = {chopdoor = false, doorgone = false, doordelivered = false, CarParts = "engine", 	   PartLabel = "Motor", 	PartProp = "imp_prop_impexp_engine_part_01a", 	PartBone = 28422, PartX = 0.0,PartY = 0.5,PartZ = -0.05,	PartxR = 0.0, PartyR = 0.0, PartzR = 0.0}
}

ChopCarLocation = {  --- Coords [x] = Door Coords [x2] =location if need be
	[1] = { Chop = vector3(-557.64, -1695.82, 19.16), Sell = vector3(-556.36, -1704.7, 19.04), Type = "money"},
	
}

function disable()
	Citizen.CreateThread(function ()
		while disablecontrols do
			Citizen.Wait(10)
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
		end
	end)
end

function start()
	while chopstarted do
		Citizen.Wait(10)
		if station ~= nil then
			if veh == nil or veh == 0 then
				veh = GetVehiclePedIsIn(PlayerPedId(), true)
			end
			for i=1, #chopdoors, 1 do
				if allowedchop and not chopdoors[i].doorgone and not chopdoors[i].doordelivered then
					while not chopdoors[i].chopdoor and chopstarted do
						local x,y,z = table.unpack(GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, chopdoors[i].CarParts)))
						Citizen.Wait(7)
						DrawMarker(27,x,y,z-0.3, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
						if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), x,y,z, true ) < 2.5 and IsPedStill(PlayerPedId()) and not chopdoors[i].chopdoor then --1.2
							DrawText3Ds(x,y,z, tostring("[~g~E~w~] " .. chopdoors[i].PartLabel))
							if(IsControlJustPressed(1, 38)) then
								ESX.TriggerServerCallback('tqrp_base:itemQtty', function(cb)
									if cb > 0 then
										disablecontrols = true
										disable()
										chopdoors[i].chopdoor = true
										ChopDoors(i)
									else
										exports['mythic_notify']:SendAlert('error', 'Não tens o necessário!')
									end
								end, 'blowtorch')
							end
						end
					end
				end
			end
		else
			Citizen.Wait(1500)
		end
	end
end

function ChopDoors(i)
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	veh = GetClosestVehicle(ChopCarLocation[station].Chop, 4.001, 0, 70)
	if chopdoors[i].chopdoor then
		SetVehicleDoorOpen(veh, 0, false, false)
		TaskStartScenarioInPlace(plyPed, "WORLD_HUMAN_WELDING", 0, true)
		TriggerEvent("mythic_progbar:client:progress", {
			name = "unique_action_name",
			duration = 55000,
			label = "A remover ".. chopdoors[i].PartLabel .. "...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}
		}, function(status)
			if not status then
				--SetVehicleDoorBroken(veh, 0, true)
				ClearPedTasksImmediately(plyPed)
				chopdoors[i].chopdoor = false
				chopdoors[i].doorgone = true
				disablecontrols = false
				local PackageObject = CreateObject(GetHashKey(chopdoors[i].PartProp), 1.0, 1.0, 1.0, 1, 1, 0)
				--SetEntityCollision(PackageObject, false, false)
				--PlaceObjectOnGroundProperly(PackageObject)
				CarryingPart(PackageObject, i)
			else
				disablecontrols = false
				ClearPedTasksImmediately(plyPed)
				chopstarted = false
				for i=1, #chopdoors, 1 do
					chopdoors[i].chopdoor = false
					chopdoors[i].doorgone = false
					chopdoors[i].doordelivered = false
				end
				DeleteEntity(veh)
				veh = nil
			end
		end)
	end
end

function FinishedChopping()
	TriggerServerEvent('tqrp_civlife_illegalchop:success', math.random(50,200), "money")
	local vehchopping = GetClosestVehicle(ChopCarLocation[station].Chop, 4.001, 0, 70)
	chopstarted = false
	DeleteEntity(vehchopping)
	exports['mythic_notify']:SendAlert('success', 'Todo o veículo foi Desmantelado com sucesso')
	for i=1, #chopdoors, 1 do
		chopdoors[i].chopdoor = false
		chopdoors[i].doorgone = false
		chopdoors[i].doordelivered = false
	end
	veh = nil
end

function tofaraway()
	local vehchopping = GetClosestVehicle(ChopCarLocation[station].Chop, 4.001, 0, 70)
	chopstarted = false
	station = nil
	DeleteEntity(vehchopping)
	exports['mythic_notify']:SendAlert('error', 'Afaste-se daqui!')
end

function StartChopThisCar()
	local veh2 = GetVehiclePedIsIn(PlayerPedId(), true)
	SetEntityCoords(veh2, ChopCarLocation[station].Chop)
	SetEntityHeading(veh2, 27.77)
	chopstarted = true
	start()
end

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local scale = 0.30
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end

function CarryingPart(partID, i)
	if DoesEntityExist(partID) then
		loadAnimDict("anim@heists@box_carry@")
		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			ClearPedTasks(PlayerPedId())
			loadAnimDict("anim@heists@box_carry@")
			TaskPlayAnim((PlayerPedId()),"anim@heists@box_carry@","idle",4.0, 1.0, -1,49,0, 0, 0, 0)
			AttachEntityToEntity(partID, PlayerPedId(), chopdoors[i].PartBone, chopdoors[i].PartX, chopdoors[i].PartY, chopdoors[i].PartZ, chopdoors[i].PartxR, chopdoors[i].PartYR, chopdoors[i].PartZR, 1, 1, 0, true, 2, 1)
		end
	else
		return
	end
	local Packaging = true
	while Packaging do
		Citizen.Wait(7)
		if not IsEntityAttachedToEntity(partID, PlayerPedId()) then
			Packaging = false
			DeleteEntity(partID)
		else
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, ChopCarLocation[station].Sell, true)
			local x,y,z = table.unpack(ChopCarLocation[station].Sell)
			DrawText3Ds(x,y,z, tostring("[~g~E~w~] Vender Peças"))
			if DistanceCheck <= 5.0 then
				if IsControlJustPressed(0, 38) then
					disablecontrols = true
					disable()
					DeleteEntity(partID)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false
					if chopdoors[i].doorgone then
						--[[if ChopCarLocation[station].Type == "money" then
							TriggerServerEvent('tqrp_civlife_illegalchop:success', math.random(14,46), "money")
						else
							TriggerServerEvent('tqrp_civlife_illegalchop:success', payitems, "items")
						end]]
						TriggerServerEvent('tqrp_civlife_illegalchop:success', math.random(8,15), "items")
						if math.random(1, 10) > 5 then 
							TriggerServerEvent('tqrp_civlife_illegalchop:success', math.random(80, 150), "money")
						end
						chopdoors[i].doorgone = false
						chopdoors[i].doordelivered = true
						disablecontrols = false
						if chopdoors[#chopdoors].doordelivered then
							FinishedChopping()
						end
					end
				end
			end
		end
	end
end

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end) -- Prevents RAM LEAKS :)