Citizen.CreateThread(function()
    while true do
      	local ped = PlayerPedId()
      	local car = GetVehiclePedIsUsing(ped)
      	local waitWi = 5000
      	if IsPedInAnyVehicle(ped, false) then
			if GetIsTaskActive(ped, 2) then

				local data = ESX.Game.GetVehicleProperties(car)
				data.fuelLevel = exports["tqrp_base"]:GetFuel(car)
				local health = GetVehicleBodyHealth(car)

				local coords = GetEntityCoords(car, false)
				local heading = GetEntityHeading(car)

          		local coordsPed = GetEntityCoords(ped, false)
                local int = GetInteriorAtCoords(coordsPed.x, coordsPed.y, coordsPed.z)
                
				if int == 0 then
				--  SALVAR NA BD IF NEEDED
					TriggerServerEvent('tqrp_phone:server:UpdateVehConfigBD', coords, heading, data, health)
	            end
              	Wait(3000)
        	end
        	waitWi = 5
      	end
      	Citizen.Wait(waitWi)
    end
end)

RegisterNUICallback('VehiclePos', function(data, cb)
	local x =  tonumber(string.format("%.1f",data.data.x))
	local y =  tonumber(string.format("%.1f",data.data.y))
	local z =  tonumber(string.format("%.1f",data.data.z))

    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip,  326)
    SetBlipAlpha(blip,  255)
    SetBlipScale(blip, 1.4)
    SetBlipColour(blip, 0)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Carro Perdido")
    EndTextCommandSetBlipName(blip)

    CreateThread(function()
        while true do
            Wait(5)
            local coords = GetEntityCoords(GetPlayerPed(-1), true)
            if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, x, y, z, false) < 40 then
            	DrawText3D(x, y, z, "Carro Perdido")
				DrawMarker(0, x, y, z-1.3, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 255, 255, 255, 50, 0, 0, 2, 0, 0, 0, 0)
            end

            if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, x, y, z, false) < 2 then
	        	RemoveBlip(blip)
	            break
            end
        end
    end)
end)

RegisterNUICallback('SpawnCar', function(data, cb)
	local x =  tonumber(string.format("%.1f",data.data.x))
	local y =  tonumber(string.format("%.1f",data.data.y))
	local z =  tonumber(string.format("%.1f",data.data.z))
	
	local coords = GetEntityCoords(GetPlayerPed(-1), true)
  	if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
	    if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, x, y, z, false) < 20 then
	    	local vehArea = ESX.Game.GetVehiclesInArea(coords, 50)
			local canSpawn = true
			local veh = ESX.Game.GetVehicles()
			local myCar, myCarCoods = nil, nil
			for k,v in ipairs(vehArea) do
		    	local vehCoords = GetEntityCoords(v, false)
		    	if GetDistanceBetweenCoords(vehCoords, x, y, z, false) < 3 then
		    		canSpawn = false
		    	end
		    	
		    	if GetVehicleNumberPlateText(v):gsub('%s+', '') == data.data.plate:gsub('%s+', '') then
		    		exports['mythic_notify']:SendAlert('error', 'O teu carro já foi entregue')
		    		canSpawn = false
		    		break
		    	end
		    end
		    
	    	if canSpawn then
				local vehicle = data.data.vehicle
				ESX.Game.SpawnVehicle(vehicle.model, {
					x = x ,
					y = y,
					z = z + 1
					},data.data.h + 0.01, function(callback_vehicle)
					ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
					TriggerEvent('onyx:updatePlates', vehicle.plate)
					if data.data.health < 900 then
						SetVehicleEngineHealth(callback_vehicle, tonumber(string.format("%.1f", data.data.health)))
					end
					
					if vehicle.bodyHealth < 900 then
						SetVehicleBodyHealth(callback_vehicle, tonumber(string.format("%.1f", vehicle.bodyHealth)))

						SetVehicleDamage(callback_vehicle, 0.0, 1.0, 0.1, math.floor(1000 - tonumber(string.format("%.1f", vehicle.bodyHealth))) + 0.0, 1850.0, true) --800
						SetVehicleDamage(callback_vehicle, -0.2, 1.0, 0.5, math.floor(1000 - tonumber(string.format("%.1f", vehicle.bodyHealth))) + 0.0, 650.0, true) -- 50
						SetVehicleDamage(callback_vehicle, -0.7, -0.2, 0.3, math.floor(1000 - tonumber(string.format("%.1f", vehicle.bodyHealth))) + 0.0, 500.0, true) --00 50
					end
					exports["tqrp_base"]:SetFuel(callback_vehicle, vehicle.fuelLevel)
				end)
			else
			end
		else
			exports['mythic_notify']:SendAlert('error', 'Tens de estar mais perto da localização do veículo')
	    end
	  else
		exports['mythic_notify']:SendAlert('error', 'Não podes pedir um veículo dentro de um veículo')
  	end
end)


RegisterNetEvent('tqrp_phone:client:UpdateVehConfig')
AddEventHandler('tqrp_phone:client:UpdateVehConfig', function(coords, heading, vData)
	local data = {
	   plate = vData.plate,
	   vehicle = vData,
	   health = health,
	   x = coords.x,
	   y = coords.y,
	   z = coords.z,
	   h = heading
	}

	SendNUIMessage({
		action = 'updateCarConfigs',
		data = data
	})
end)

RegisterNetEvent('tqrp_phone:client:updateVehState')
AddEventHandler('tqrp_phone:client:updateVehState', function(plate, garage, state)
     local data = {
	  plate = plate,
	  garage = garage,
      state = state
    } 

    SendNUIMessage({
        action = 'updateVehState',
        data = data
    })
end)

RegisterNUICallback('GiveCarKey', function(data, cb)
	local player, distance = ESX.Game.GetClosestPlayer()
	--actionCb['GiveCarKey'] = cb

	if distance ~= -1 and distance <= 3.0 then
		TriggerServerEvent("tqrp_phone:server:giveCarKeys", GetPlayerServerId(player), data.plate)
		TriggerEvent('tqrp_phone:client:ActionCallback', 'GiveCarKey', true)
	else
		TriggerEvent('tqrp_phone:client:ActionCallback', 'GiveCarKey', false)
	end
end)

RegisterNUICallback('RemoveAllCarKey', function(data, cb)
	--actionCb['RemoveAllCarKey'] = cb
	TriggerServerEvent("tqrp_phone:server:RemoveAllCarKey", "RemoveAllCarKey", data.plate)
end)








function DrawText3D(x,y,z, text)

    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
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