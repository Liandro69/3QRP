ESX = nil

cachedData = {}

Citizen.CreateThread(function()
	while not ESX do
		TriggerEvent("esx:getSharedObject", function(library) 
			ESX = library 
		end)

		Citizen.Wait(0)
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
	ESX.PlayerData = playerData
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)

Citizen.CreateThread(function()
	local CanDraw = function(action)
		if action == "vehicle" then
			if IsPedInAnyVehicle(PlayerPedId()) then
				local vehicle = GetVehiclePedIsIn(PlayerPedId())

				if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
					return true
				else
					return false
				end
			else
				return false
			end
		end

		return true
	end

	for garage, garageData in pairs(Config.Garages) do
		local garageBlip = AddBlipForCoord(garageData["positions"]["menu"]["position"])

		SetBlipSprite(garageBlip, 357)
		SetBlipDisplay(garageBlip, 4)
		SetBlipScale (garageBlip, 0.65)
		SetBlipColour(garageBlip, 67)
		SetBlipAsShortRange(garageBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Garage: " .. garage)
		EndTextCommandSetBlipName(garageBlip)
	end

	while true do
		local sleepThread = 1000

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		for garage, garageData in pairs(Config.Garages) do
			for action, actionData in pairs(garageData["positions"]) do
				local dstCheck = #(pedCoords - actionData["position"])

				if dstCheck <= 10.0 then
					sleepThread = 7
					local draw = CanDraw(action)

					if draw then
						local markerSize = action == "vehicle" and 4.0 or 1.5
						if dstCheck <= markerSize - 0.1 then
							local usable = not DoesCamExist(cachedData["cam"])
							if Menu.hidden then
								DrawText3Ds(actionData["position"].x,actionData["position"].y,actionData["position"].z, "Pressiona [~g~E~w~] para abrir a garagem")
							end
							if IsControlJustPressed(1, 177) and not Menu.hidden then
								CloseMenu()
								PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							end
							if usable then
								if IsControlJustPressed(0, 38) and Menu.hidden then
									cachedData["currentGarage"] = garage
									if garage == 'Apreendidos' then
										ESX.TriggerServerCallback("betrayed_garage:obterApreendidos", function(fetchedVehicles)
											EnvioVehApreend(fetchedVehicles)
										end,garage)
										Menu.hidden = not Menu.hidden
										MenuApreendidos(action)
										TriggerEvent("inmenu",true)
									else	
										ESX.TriggerServerCallback("betrayed_garage:obtenerVehiculos", function(fetchedVehicles)
											EnvioVehLocal(fetchedVehicles[1])
											if fetchedVehicles[2] then
												EnvioVehFuera(fetchedVehicles[2])
											end
										end,garage)
										Menu.hidden = not Menu.hidden
										MenuGarage(action)
										TriggerEvent("inmenu",true)
									end
								end
							end
						end
						DrawScriptMarker({
							["type"] = 27,
							["pos"] = actionData["position"] - vector3(0.0, 0.0, 0.0),
							["sizeX"] = markerSize,
							["sizeY"] = markerSize,
							["sizeZ"] = markerSize,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0
						})
					end
				elseif (dstCheck > 10.0 and dentro == garage) then
					dentro = nil
				end
			end
		end
		Menu.renderGUI()
		Citizen.Wait(sleepThread)
	end
end)
-------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.30, 0.30)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextOutline()
    AddTextComponentString(text)
    DrawText(_x,_y)
end