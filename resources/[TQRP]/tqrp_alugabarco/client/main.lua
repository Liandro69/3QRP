ESX = nil

local PlayerData, CurrentActionData	= {}, {}
local HasAlreadyEnteredMarker		= false
local LastPlace, LastPart, LastPartNum, LastEntity, CurrentAction
AlreadyHiringBoat = false

--[[
	Don't touch here of you dont know what you are doing!
]]

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

AddEventHandler('ksrp_hiteboat:hasEnteredMarker', function(club, part, partNum)
	if part == 'Marker_Hireboat' then 
		CurrentAction     = 'HireBoat'
		CurrentActionData = {}
	elseif part == 'Marker_LeaveBoat' then
		CurrentAction	  = 'LeaveBoat'
		CurrentActionData = {}
	end
end)

AddEventHandler('ksrp_hiteboat:hasExitedMarker', function(club, part, partNum)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
	if Boat then
		DeleteEntity(Boat)
	end
	
	if cam then
		ResetSettings(cam)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)


		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local isInMarker, hasExited, letSleep = false, false, true
		local currentPlace, currentPart, currentPartNum

		for k,v in pairs(Config.Zones) do

			for i=1, #v["HireBoat"], 1 do
				local place = v["HireBoat"][i]
				local distance = GetDistanceBetweenCoords(coords, place["Coords"], true)

				if not AlreadyHiringBoat then
					if distance <= place["DrawDistance"] then
						if distance < place["Radius"] then
							ESX.Game.Utils.DrawText3D(vector3(place["Coords"].x, place["Coords"].y, place["Coords"].z + 0.2), '[~o~~h~E~h~~s~] ' .. place["Text"], 0.8)
						elseif distance > place["Radius"] then
							ESX.Game.Utils.DrawText3D(vector3(place["Coords"].x, place["Coords"].y, place["Coords"].z + 0.2), '~h~~o~' .. place["Text"], 0.8)
						end
						DrawMarker(place["Type"], place["Coords"]["x"], place["Coords"]["y"], place["Coords"]["z"] - 0.99, 0.0, 0.0, 90.0, 0, 0.0, 0.0, 1.1, 1.1, 1.1, place["Color"]["r"], place["Color"]["g"], place["Color"]["b"], place["Opacity"], false, false, 2, false, false, false, false)
						letSleep = false
					end

					if distance < place["Radius"] then
						isInMarker, currentPlace, currentPart, currentPartNum = true, k, 'Marker_Hireboat', i
					end
				else 
					if distance <= place["DrawDistance"] then
						ESX.Game.Utils.DrawText3D(vector3(place["Coords"].x, place["Coords"].y, place["Coords"].z + 0.2), '~h~~o~' .. _U('already_rent'), 0.8)
					end
					letSleep = false
				end
			end

			for i=1, #v["LeaveBoat"], 1 do
				local place = v["LeaveBoat"][i]
				local distance = GetDistanceBetweenCoords(coords, place["Coords"], true)

				if AlreadyHiringBoat then
					if IsPedInAnyBoat(PlayerPedId()) then
						if IsPedInVehicle(PlayerPedId(), HiredBoat, false) then
							if distance <= 50 then
								if distance <= place["DrawDistance"] then
									if distance < place["Radius"] then
										ESX.Game.Utils.DrawText3D(vector3(place["Coords"].x, place["Coords"].y, place["Coords"].z + 0.5), '[~o~~h~E~h~~s~] ' .. place["Text"], 0.8)
									elseif distance > place["Radius"] then
										ESX.Game.Utils.DrawText3D(vector3(place["Coords"].x, place["Coords"].y, place["Coords"].z + 0.5), '~h~~o~' .. place["Text"], 0.8)
									end
									DrawMarker(place["Type"], place["Coords"]["x"], place["Coords"]["y"], place["Coords"]["z"] - 0.99, 0.0, 0.0, 90.0, 0, 0.0, 0.0, 4.1, 4.1, 4.1, place["Color"]["r"], place["Color"]["g"], place["Color"]["b"], place["Opacity"], false, false, 2, false, false, false, false)
									letSleep = false
								elseif distance >= place["DrawDistance"] then
									DrawMarker(20, place["Coords"]["x"], place["Coords"]["y"], place["Coords"]["z"] + 10.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 3.0, 3.0, 3.0, place["Color"]["r"], place["Color"]["g"], place["Color"]["b"], place["Opacity"], true, false, 2, true, false, false, false)
								end
							end

							if distance < place["Radius"] then
								isInMarker, currentPlace, currentPart, currentPartNum = true, k, 'Marker_LeaveBoat', i
							end
						end
					end
				end
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastPlace ~= currentPlace or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
			if
				(LastPlace and LastPart and LastPartNum) and
				(LastPlace ~= currentPlace or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			then
				TriggerEvent('ksrp_hiteboat:hasExitedMarker', LastPlace, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastPlace             	= currentPlace
			LastPart                = currentPart
			LastPartNum             = currentPartNum

			TriggerEvent('ksrp_hiteboat:hasEnteredMarker', currentPlace, currentPart, currentPartNum)
		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('ksrp_hiteboat:hasExitedMarker', LastPlace, LastPart, LastPartNum)
		end

		if letSleep then
			Citizen.Wait(1500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction then
			if IsControlJustPressed(0, 38) then
				for k,v in ipairs(Config.Zones[LastPlace]["Info"]) do
					if CurrentAction == 'HireBoat' then
						HireBoat(v, LastPlace)
					elseif CurrentAction == 'LeaveBoat' then
						DeleteEntity(HiredBoat)
						AlreadyHiringBoat = false
						RemoveBlip(Dropoff)
						AdvancedNotification('~y~' .. _U('boathiring'), _U('boatreturn'))
						SetEntityCoords(PlayerPedId(), v["BridgePosition"])
						SetEntityHeading(PlayerPedId(), v["BridgeHeading"])
					end
				end
			end
		else
			Citizen.Wait(1500)
		end
	end
end)

Citizen.CreateThread(function()

	for k,v in pairs(Config.Zones) do
		blip = AddBlipForCoord(v["Blip"]["Position"])

		SetBlipSprite (blip, v["Blip"]["Sprite"])
		SetBlipDisplay(blip, v["Blip"]["Display"])
		SetBlipScale  (blip, v["Blip"]["Scale"])
		SetBlipColour (blip, v["Blip"]["Color"])
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(v["Blip"]["Name"])
		EndTextCommandSetBlipName(blip)
	end
end)

