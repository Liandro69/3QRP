ESX = nil
local lastSkin, playerLoaded
local firstSpawn, zoomOffset, heading = true, 0.0, 0.0, 90.0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

function OpenMenu(submitCb, cancelCb, restrict)
	local playerPed = PlayerPedId()

	TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkin = skin
	end)

	TriggerEvent('skinchanger:getData', function(components, maxVals)
		local elements    = {}
		local _components = {}

		-- Restrict menu
		if restrict == nil then
			for i=1, #components, 1 do
				_components[i] = components[i]
			end
		else
			for i=1, #components, 1 do
				local found = false

				for j=1, #restrict, 1 do
					if components[i].name == restrict[j] then
						found = true
					end
				end

				if found then
					table.insert(_components, components[i])
				end
			end
		end

		-- Insert elements
		for i=1, #_components, 1 do
			local value       = _components[i].value
			local componentId = _components[i].componentId

			if componentId == 0 then
				value = GetPedPropIndex(playerPed, _components[i].componentId)
			end

			local data = {
				label     = _components[i].label,
				name      = _components[i].name,
				value     = value,
				min       = _components[i].min,
				textureof = _components[i].textureof,
				type      = 'slider'
			}

			for k,v in pairs(maxVals) do
				if k == _components[i].name then
					data.max = v
					break
				end
			end

			table.insert(elements, data)
		end


		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'skin', {
			title    = _U('skin_menu'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			TriggerEvent('skinchanger:getSkin', function(skin)
				lastSkin = skin
			end)

			submitCb(data, menu)
		end, function(data, menu)
			menu.close()
			TriggerEvent('skinchanger:loadSkin', lastSkin)

			if cancelCb ~= nil then
				cancelCb(data, menu)
			end
		end, function(data, menu)
			local skin, components, maxVals

			TriggerEvent('skinchanger:getSkin', function(getSkin)
				skin = getSkin
			end)


			if skin[data.current.name] ~= data.current.value then
				-- Change skin element
				TriggerEvent('skinchanger:change', data.current.name, data.current.value)

				-- Update max values
				TriggerEvent('skinchanger:getData', function(comp, max)
					components, maxVals = comp, max
				end)

				local newData = {}

				for i=1, #elements, 1 do
					newData = {}
					newData.max = maxVals[elements[i].name]

					if elements[i].textureof ~= nil and data.current.name == elements[i].textureof then
						newData.value = 0
					end

					menu.update({name = elements[i].name}, newData)
				end

				menu.refresh()
			end
		end, function(data, menu)
		end)
	end)
end

function OpenSaveableMenu(submitCb, cancelCb, restrict)
	TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkin = skin
	end)

	OpenMenu(function(data, menu)
		menu.close()

		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerServerEvent('tqrp_skin:save', skin)

			if submitCb ~= nil then
				submitCb(data, menu)
			end
		end)

	end, cancelCb, restrict)
end

AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not playerLoaded do
			Citizen.Wait(100)
		end

		if firstSpawn then
			ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)
				else
					TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)

			firstSpawn = false
		end
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	playerLoaded = true
end)

AddEventHandler('tqrp_skin:getLastSkin', function(cb)
	cb(lastSkin)
end)

AddEventHandler('tqrp_skin:setLastSkin', function(skin)
	lastSkin = skin
end)

RegisterNetEvent('tqrp_skin:openMenu')
AddEventHandler('tqrp_skin:openMenu', function(submitCb, cancelCb)
	OpenMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('tqrp_skin:openRestrictedMenu')
AddEventHandler('tqrp_skin:openRestrictedMenu', function(submitCb, cancelCb, restrict)
	OpenMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('tqrp_skin:openSaveableMenu')
AddEventHandler('tqrp_skin:openSaveableMenu', function(submitCb, cancelCb)
	OpenSaveableMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('tqrp_skin:openSaveableRestrictedMenu')
AddEventHandler('tqrp_skin:openSaveableRestrictedMenu', function(submitCb, cancelCb, restrict)
	OpenSaveableMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('tqrp_skin:requestSaveSkin')
AddEventHandler('tqrp_skin:requestSaveSkin', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('tqrp_skin:responseSaveSkin', skin)
	end)
end)
