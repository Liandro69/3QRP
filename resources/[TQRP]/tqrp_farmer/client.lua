ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

function OpenRice()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

	for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = config.items[v.name]

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

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rice_shop', {
		title    = 'Fábrica Fertilizante',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		TriggerServerEvent('caruby_farm:sell', data.current.name, data.current.value)
	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
	end
end)]]


--[[function CreateBlipCircle(coords, text, radius, color, sprite)
	local blip

	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 1)
	SetBlipAlpha(blip, 128)

	blip = AddBlipForCoord(coords)

	SetBlipHighDetail(blip, true)
	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, 0.6)
	SetBlipColour(blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end]]

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 68)
end


Citizen.CreateThread(function()
	--[[for k,zone in pairs(config.zones) do
		CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
	end]]
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local nearMarker = false
		local nearMarker2 = false
		if IsPedOnFoot(playerPed) then
			local coords = GetEntityCoords(playerPed)

			local px,py,pz = table.unpack(config.zones.process.coords)
			if GetDistanceBetweenCoords(coords, config.zones.process.coords, true) < 10 then
				nearMarker = true
				DrawMarker(2, px, py, pz, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 240,230,140, 165, 1,0, 0,1)
                Draw3DText(px, py, pz + 0.5, '[~e~E~w~] - Processar Grãos de Café ')
			else
				nearMarker = false
			end
			local p2x,p2y,p2z = table.unpack(config.zones.dealer.coords)
			if GetDistanceBetweenCoords(coords, config.zones.dealer.coords, true) < 10 then
				nearMarker2 = true
				DrawMarker(2, p2x, p2y, p2z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 240,230,140, 165, 1,0, 0,1)
			else
				nearMarker2 = false
			end

			if not nearMarker and not nearMarker2 then
				Citizen.Wait(1500)
			end
		else
			Citizen.Wait(1500)
		end
	end
end)