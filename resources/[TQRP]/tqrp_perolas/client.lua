ESX = nil
local isProcessing = false
local shellss = {}
local spawnedshells = 0
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if menuOpen then
			ESX.UI.Menu.CloseAll()
		end
		for k, v in pairs(shellss) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function Process()
	isProcessing = true

	TriggerServerEvent('fm_pearl:process')
	local timeLeft = 5000 / 1000
	local playerPed = PlayerPedId()
	
	TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
	Citizen.Wait(5000)
	ClearPedTasks(playerPed)

	while timeLeft > 0 do
		Citizen.Wait(1500)
		timeLeft = timeLeft - 1
		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.zones.process.coords, false) > 4 then
			TriggerServerEvent('fm_pearl:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 0.73, 0.49, 0.39, 0.95, 1.07, 1.21, 1.25, 1.26, 1.27, 1.29, 1.30 }

	for i, height in ipairs(groundCheckHeights) do
		return height
	end
end

function OpenOpium()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

	for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.items[v.name]

		if price and v.count > 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">$%s</span>'):format(v.label, ESX.Math.GroupDigits(price)),
				name = v.name,
				price = price,

				type = 'slider',
				value = 1,
				min = 1,
				max = v.count
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pearl_shop', {
		title    = 'pearl',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		TriggerServerEvent('fm_pearl:sell', data.current.name, data.current.value)
	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

function Spawnshelles()
	while spawnedshells < 20 do
		Citizen.Wait(2000)
		local shellCoords = GenerateshellCoords()

		ESX.Game.SpawnLocalObject('prop_coral_bush_01', shellCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(shellss, obj)
			spawnedshells = spawnedshells + 1
		end)
	end
end

function ValidateshellCoord(plantCoord)
	if spawnedshells > 0 then
		local validate = true

		for k, v in pairs(shellss) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 10 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.zones.field.coords, false) > 20 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateshellCoords()
	while true do
		Citizen.Wait(200)

		local shellCoordX, shellCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-25, 25)

		shellCoordX = Config.zones.field.coords.x + modX
		shellCoordY = Config.zones.field.coords.y + modY

		local coordZ = GetCoordZ(shellCoordX, shellCoordY)
		local coord = vector3(shellCoordX, shellCoordY, coordZ)

		if ValidateshellCoord(coord) then
			return coord
		end
	end
end

--[[Citizen.CreateThread(function()	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		if not IsPedInAnyVehicle(PlayerPedId()) then
			local coords = GetEntityCoords(playerPed)
			if GetDistanceBetweenCoords(coords, Config.zones.dealer.coords, true) < 3 then	
				DrawText3Ds(Config.zones.dealer.coords.x, Config.zones.dealer.coords.y, Config.zones.dealer.coords.z, "Pressiona ~INPUT_CONTEXT~ para vender perolas")
				if IsControlJustReleased(0, 38) then
					OpenOpium()	
				end
			else
				Citizen.Wait(1500)
			end
		else
			Citizen.Wait(1500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.zones.process.coords, true) < 3 then
			if not isProcessing then
				DrawText3Ds(Config.zones.process.coords.x, Config.zones.process.coords.y, Config.zones.process.coords.z, "Pressiona ~INPUT_CONTEXT~ para processar perolas")
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
				Process()
			end
		else
			Citizen.Wait(1500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local nearMarker = false
		if IsPedOnFoot(playerPed) then
			local coords = GetEntityCoords(playerPed)
			local px,py,pz = table.unpack(Config.zones.process.coords)
			if GetDistanceBetweenCoords(coords, Config.zones.process.coords, true) < 10 then
				nearMarker = true
				DrawMarker(2, px, py, pz, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 240,230,140, 165, 1,0, 0,1)
			else
				nearMarker = false
			end
			local p2x,p2y,p2z = table.unpack(Config.zones.dealer.coords)
			if GetDistanceBetweenCoords(coords, Config.zones.dealer.coords, true) < 10 then
				nearMarker = true
				DrawMarker(2, p2x, p2y, p2z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 240,230,140, 165, 1,0, 0,1)
			else
				nearMarker = false
			end
			if not nearMarker then
				Citizen.Wait(1500)
			end
		else
			Citizen.Wait(1500)
		end
	end
end)]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(11000)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.zones.field.coords, true) < 20 then
			Spawnshelles()
			Citizen.Wait(11000)
		else
			Citizen.Wait(11000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		local shel = nil
		for i=1, #shellss, 1 do
			shel = GetEntityCoords(shellss[i])
			if GetDistanceBetweenCoords(coords, GetEntityCoords(shellss[i]), false) < 1 then
				nearbyObject, nearbyID = shellss[i], i
				break
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then
			if not isPickingUp then
				DrawText3Ds(shel.x, shel.y, shel.z, _U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('fm_shell:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						Citizen.Wait(3500)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
						ClearPedTasks(playerPed)
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(shellss, nearbyID)
						spawnedshells = spawnedshells - 1
					end

					isPickingUp = false

				end, 'shell_a')
			end

		else
			Citizen.Wait(1500)
		end

	end

end)

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)

    local scale = 0.3

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
        local factor = (string.len(text)) / 500
	DrawRect(_x, _y + 0.0150, 0.030 + factor , 0.030, 66, 66, 66, 150)
    end
end