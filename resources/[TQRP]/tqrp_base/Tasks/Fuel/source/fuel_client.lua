Citizen.CreateThread(function()
	while not ESX do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(500)
	end
end)

local isNearPump = false
local isFueling = false
local currentFuel = 0.0
local currentCost = 0.0
local currentCash = 1000
local fuelSynced = false
local inBlacklisted = false

function ManageFuelUsage(vehicle)
	if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))

		fuelSynced = true
	end

	if IsVehicleEngineOn(vehicle) then
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
	end
end

Citizen.CreateThread(function()
	DecorRegister(Config.FuelDecor, 1)

	for index = 1, #Config.Blacklist do
		if type(Config.Blacklist[index]) == 'string' then
			Config.Blacklist[GetHashKey(Config.Blacklist[index])] = true
		else
			Config.Blacklist[Config.Blacklist[index]] = true
		end
	end

	for index = #Config.Blacklist, 1, -1 do
		table.remove(Config.Blacklist, index)
	end

	while true do
		Citizen.Wait(1000)

		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)

			if Config.Blacklist[GetEntityModel(vehicle)] then
				inBlacklisted = true
			else
				inBlacklisted = false
			end

			if not inBlacklisted and GetPedInVehicleSeat(vehicle, -1) == ped then
				ManageFuelUsage(vehicle)
			end
		else
			if fuelSynced then
				fuelSynced = false
			end

			if inBlacklisted then
				inBlacklisted = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		local pumpObject, pumpDistance = FindNearestFuelPump()

		if pumpDistance < 3.5 then
			isNearPump = pumpObject

			currentCash = ESX.GetPlayerData().money
		else
			isNearPump = false
			Citizen.Wait(math.ceil(pumpDistance * 20))
		end
	end
end)

AddEventHandler('joca_fuel:startFuelUpTick', function(pumpObject, ped, vehicle)
	currentFuel = GetVehicleFuelLevel(vehicle)

	while isFueling do
		Citizen.Wait(500)

		local oldFuel = DecorGetFloat(vehicle, Config.FuelDecor)
		local fuelToAdd = math.random(10, 20) / 10.0
		local extraCost = fuelToAdd / 1.5 * Config.CostMultiplier

		if not pumpObject then
			if GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100 >= 0 then
				currentFuel = oldFuel + fuelToAdd

				SetPedAmmo(ped, 883325847, math.floor(GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100))
			else
				isFueling = false
			end
		else
			currentFuel = oldFuel + fuelToAdd
		end

		if currentFuel > 100.0 then
			currentFuel = 100.0
			isFueling = false
		end

		currentCost = currentCost + extraCost

		if currentCash >= currentCost then
			SetFuel(vehicle, currentFuel)
		else
			isFueling = false
		end
	end

	if pumpObject then
		TriggerServerEvent('joca_fuel:pay', currentCost)
	end

	currentCost = 0.0
end)

AddEventHandler('joca_fuel:refuelFromPump', function(pumpObject, ped, vehicle)
	TaskTurnPedToFaceEntity(ped, vehicle, 1000)
	Citizen.Wait(1000)
	SetCurrentPedWeapon(ped, -1569615261, true)
	LoadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)

	TriggerEvent('joca_fuel:startFuelUpTick', pumpObject, ped, vehicle)

	while isFueling do
		for _, controlIndex in pairs(Config.DisableKeys) do
			DisableControlAction(0, controlIndex)
		end

		local vehicleCoords = GetEntityCoords(vehicle)

		if pumpObject then
			local stringCoords = GetEntityCoords(pumpObject)
			local extraString = ""

			extraString = "\n" .. Config.Strings.TotalCost .. " ~g~$" .. Round(currentCost, 1)

			DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.CancelFuelingPump .. extraString)
			DrawText3Ds(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z + 0.5, Round(currentFuel, 1) .. "%")
		end

		if not IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
			TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
		end

		if IsControlJustReleased(0, 38) or DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) or (isNearPump and GetEntityHealth(pumpObject) <= 0) then
			isFueling = false
		end

		Citizen.Wait(7)
	end

	ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
end)

Citizen.CreateThread(function()
	local ped = nil
	local coords = nil
	local pumpCoords = nil
	while true do
		ped = PlayerPedId()

		if not isFueling and (isNearPump and GetEntityHealth(isNearPump) > 0) then
			coords = GetEntityCoords(ped)
			if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped then
				pumpCoords = GetEntityCoords(isNearPump)
				DrawText3Ds(pumpCoords.x, pumpCoords.y, pumpCoords.z + 1.2, Config.Strings.ExitVehicle)
			else
				local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
				local vehicleCoords = GetEntityCoords(vehicle)

				if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(coords, vehicleCoords) < 2.5 then
					if not DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
						local stringCoords = GetEntityCoords(isNearPump)

						if GetVehicleFuelLevel(vehicle) < 95 then
							if currentCash > 0 then
								DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.EToRefuel)

								if IsControlJustReleased(0, 38) then
									isFueling = true

									TriggerEvent('joca_fuel:refuelFromPump', isNearPump, ped, vehicle)
									LoadAnimDict("timetable@gardener@filling_can")
								end
							else
								DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCash)
							end
						else
							DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.FullTank)
						end
					end
				elseif isNearPump then
					local stringCoords = GetEntityCoords(isNearPump)

					if currentCash >= Config.JerryCanCost then
						DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.PurchaseJerryCan)

						if IsControlJustReleased(0, 74) then
							TriggerServerEvent('joca_fuel:giveItem')

							TriggerServerEvent('joca_fuel:pay', Config.JerryCanCost)

							currentCash = ESX.GetPlayerData().money
						end
					else
						DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCash)
					end
				else
					Citizen.Wait(250)
				end
			end
		else
			Citizen.Wait(1500)
		end

		Citizen.Wait(7)
	end
end)

Citizen.CreateThread(function()
	for _, gasStationCoords in pairs(Config.GasStations) do
		CreateBlip(gasStationCoords)
	end
end)

-- Added by Joca
RegisterNetEvent('joca_fuel:useJerryCan')
AddEventHandler('joca_fuel:useJerryCan', function()
  	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	if isFueling == false and DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(vehicle)) < 2.5 then
		if GetVehicleFuelLevel(vehicle) < 95 then
			if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 2.0) then
				if IsPedInAnyVehicle(playerPed, false) then
					ESX.ShowNotification(Config.Strings.LeaveVehicle)
				else
					isFueling = true
					TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
					TriggerServerEvent("joca_fuel:removeItem")
			   	 	FreezeEntityPosition(playerPed, true)
					LoadAnimDict("timetable@gardener@filling_can")
					TaskPlayAnim(playerPed, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
					SetFuel(vehicle, GetFuel(vehicle) + Config.JerryCanPercentage)
					Citizen.Wait(Config.JerryCanTime)
					ClearPedTasks(playerPed)
			    	FreezeEntityPosition(playerPed, false)
					isFueling = false
				end
			else
				ESX.ShowNotification(Config.Strings.NoVehicleNearby)
			end
		else
			ESX.ShowNotification(Config.Strings.FullTank)
		end
	end
end)
