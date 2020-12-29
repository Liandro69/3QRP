

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local OwnedProperties, Blips, CurrentActionData = {}, {}, {}
local CurrentProperty, CurrentPropertyOwner, LastProperty, LastPart, CurrentAction, CurrentActionMsg
local firstSpawn, hasChest, hasAlreadyEnteredMarker, raiding = true, false, false, false
ESX = nil
local propOwner,propOwnerSteamID, keysOwnedHouse = {}, {}, {}
local lockedDoors, openDoors = {}, {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
	
	while not ESX.IsPlayerLoaded() do
		Citizen.Wait(10)
	end

	ESX.TriggerServerCallback('tqrp_property:getProperties', function(properties)
		Config.Properties = properties
	end)	
	ESX.TriggerServerCallback('tqrp_property:getOwnedProperties', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			SetPropertyOwned(ownedProperties[i].name, true, ownedProperties[i].owner)
		end
	end)
	ESX.TriggerServerCallback('tqrp_property:getKeyHolds', function(holds)
		for i=1, #holds, 1 do
			keysOwnedHouse[holds[i].name] = true
		end
	end)
	ESX.TriggerServerCallback('tqrp_property:getOwnedPropertiesAll', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			propOwner[ownedProperties[i].name] = ownedProperties[i].owner
			propOwnerSteamID[ownedProperties[i].name] = ownedProperties[i].ownerid
			if ownedProperties[i].locked == 0 then
				lockedDoors[ownedProperties[i].name] = true
				openDoors[ownedProperties[i].name] = false
			elseif ownedProperties[i].locked == 1 then
				lockedDoors[ownedProperties[i].name] = false
				openDoors[ownedProperties[i].name] = true
			end
		end
		ESX.TriggerServerCallback('tqrp_property:getProperties', function(properties)
			local enable = true
			if Config.BlipsShouldShow ~= nil then
				enable = Config.BlipsShouldShow
			end
			Config.Properties = properties
			if enable then
				CreateBlips()
			end
		end)
	end)
	SpawnProps()
end)

local chestObject = 0
function SpawnProps()
	Citizen.CreateThread(function()
		local chestModel = GetHashKey("xm_prop_x17_chest_closed")
		RequestModel(chestModel)
		while not HasModelLoaded(chestModel) do
			Citizen.Wait(100)
		end
		chestObject = CreateObject(chestModel, 262.45, -1000.67, -99.34, 1, 1, 0)
		SetEntityHeading(chestObject,178.99)
	end)
end


RegisterNetEvent("tqrp_property:requestUpdate")
AddEventHandler("tqrp_property:requestUpdate",function()
	while ESX == nil do
		Citizen.Wait(10)
	end
	while not ESX.IsPlayerLoaded() do
		Citizen.Wait(10)
	end
	ESX.TriggerServerCallback('tqrp_property:getProperties', function(properties)
		Config.Properties = properties
	end)
	ESX.TriggerServerCallback('tqrp_property:getOwnedProperties', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			SetPropertyOwned(ownedProperties[i].name, true, ownedProperties[i].owner)
		end
	end)
	ESX.TriggerServerCallback('tqrp_property:getKeyHolds', function(holds)
		for i=1, #holds, 1 do
			keysOwnedHouse[holds[i].name] = true
		end
		for k,v in pairs(keysOwnedHouse) do
			local found = false
			for z,x in pairs(holds) do
				if v == true and k == x.name then
					found = true
				end
			end
			keysOwnedHouse[k] = found
		end
	end)
	ESX.TriggerServerCallback('tqrp_property:getOwnedPropertiesAll', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			propOwner[ownedProperties[i].name] = ownedProperties[i].owner
			propOwnerSteamID[ownedProperties[i].name] = ownedProperties[i].ownerid
			if ownedProperties[i].locked == 0 then
				lockedDoors[ownedProperties[i].name] = true
				openDoors[ownedProperties[i].name] = false
			elseif ownedProperties[i].locked == 1 then
				lockedDoors[ownedProperties[i].name] = false
				openDoors[ownedProperties[i].name] = true
			end
		end
	end)
end)

RegisterNetEvent("tqrp_property:requestDoorUpdate")
AddEventHandler("tqrp_property:requestDoorUpdate",function()
	ESX.TriggerServerCallback('tqrp_property:getOwnedPropertiesAll', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			propOwner[ownedProperties[i].name] = ownedProperties[i].owner
			propOwnerSteamID[ownedProperties[i].name] = ownedProperties[i].ownerid
			if ownedProperties[i].locked == 0 then
				lockedDoors[ownedProperties[i].name] = true
				openDoors[ownedProperties[i].name] = false
			elseif ownedProperties[i].locked == 1 then
				lockedDoors[ownedProperties[i].name] = false
				openDoors[ownedProperties[i].name] = true
			end
		end
	end)
end)


function DrawSub(text, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandPrint(time, 1)
end

function CreateBlips()
	for i=1, #Config.Properties, 1 do
		local property = Config.Properties[i]
		if property.entering and property.tip ~= "motel" and propOwner[property.name] == nil then
			Blips[property.name] = AddBlipForCoord(property.entering.x, property.entering.y, property.entering.z)

			SetBlipSprite (Blips[property.name], 369)
			SetBlipDisplay(Blips[property.name], 4)
			SetBlipScale  (Blips[property.name], 0.8)
			SetBlipAsShortRange(Blips[property.name], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(_U("unowned_house"))
			EndTextCommandSetBlipName(Blips[property.name])
		elseif property.entering and property.tip ~= "motel" and propOwner[property.name] ~= nil and not OwnedProperties[property.name] then
			Blips[property.name] = AddBlipForCoord(property.entering.x, property.entering.y, property.entering.z)

			SetBlipSprite (Blips[property.name], 357)
			SetBlipDisplay(Blips[property.name], 4)
			SetBlipScale  (Blips[property.name], 0.8)
			SetBlipAsShortRange(Blips[property.name], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(_U("owned_house"))
			EndTextCommandSetBlipName(Blips[property.name])
		elseif property.entering and property.tip ~= "motel" and propOwner[property.name] ~= nil and keysOwnedHouse[property.name] then
			Blips[property.name] = AddBlipForCoord(property.entering.x, property.entering.y, property.entering.z)

			SetBlipSprite (Blips[property.name], 357)
			SetBlipDisplay(Blips[property.name], 4)
			SetBlipColour(Blips[property.name], 6)
			SetBlipScale  (Blips[property.name], 0.8)
			SetBlipAsShortRange(Blips[property.name], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(_U("owned_house"))
			EndTextCommandSetBlipName(Blips[property.name])
		end
	end
end

function GetProperties()
	return Config.Properties
end

function GetProperty(name)
	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name == name then
			return Config.Properties[i]
		end
	end
end

function GetGateway(property)
	for i=1, #Config.Properties, 1 do
		local property2 = Config.Properties[i]

		if property2.isGateway and property2.name == property.gateway then
			return property2
		end
	end
end

function GetGatewayProperties(property)
	local properties = {}

	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].gateway == property.name then
			table.insert(properties, Config.Properties[i])
		end
	end

	return properties
end

function EnterProperty(name, owner)
	local property       = GetProperty(name)
	local playerPed      = PlayerPedId()
	CurrentProperty      = property
	CurrentPropertyOwner = owner

	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name ~= name then
			Config.Properties[i].disabled = true
		end
	end

	TriggerServerEvent('tqrp_property:saveLastProperty', name)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		for i=1, #property.ipls, 1 do
			RequestIpl(property.ipls[i])

			while not IsIplActive(property.ipls[i]) do
				Citizen.Wait(10)
			end
		end

		SetEntityCoords(playerPed, property.inside.x, property.inside.y, property.inside.z)
		DoScreenFadeIn(800)
		DrawSub(property.label, 5000)
	end)

end

function ExitProperty(name)
	local property  = GetProperty(name)
	local playerPed = PlayerPedId()
	local outside   = nil
	CurrentProperty = nil

	if property.isSingle then
		outside = property.outside
	else
		outside = GetGateway(property).outside
	end

	TriggerServerEvent('tqrp_property:deleteLastProperty')

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		SetEntityCoords(playerPed, outside.x, outside.y, outside.z)

		for i=1, #property.ipls, 1 do
			RemoveIpl(property.ipls[i])
		end

		for i=1, #Config.Properties, 1 do
			Config.Properties[i].disabled = false
		end

		DoScreenFadeIn(800)
	end)
end

function SetPropertyOwned(name, owned)
	local property     = GetProperty(name)
	local entering     = nil
	local enteringName = nil

	if property.isSingle then
		entering     = property.entering
		enteringName = property.name
	else
		local gateway = GetGateway(property)
		entering      = gateway.entering
		enteringName  = gateway.name
	end

	if owned then
		OwnedProperties[name] = true
		RemoveBlip(Blips[enteringName])

		Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
		SetBlipSprite(Blips[enteringName], 357)
		SetBlipColour(Blips[enteringName], 2)
		SetBlipAsShortRange(Blips[enteringName], true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Evin")
		EndTextCommandSetBlipName(Blips[enteringName])
	else
		OwnedProperties[name] = nil
		local found = false

		for k,v in pairs(OwnedProperties) do
			local _property = GetProperty(k)
			local _gateway  = GetGateway(_property)

			if _gateway then
				if _gateway.name == enteringName then
					found = true
					break
				end
			end
		end

		if not found then
			RemoveBlip(Blips[enteringName])

			Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
			SetBlipSprite(Blips[enteringName], 369)
			SetBlipAsShortRange(Blips[enteringName], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(_U('free_prop'))
			EndTextCommandSetBlipName(Blips[enteringName])
		end
	end
end

function PropertyIsOwned(property)
	return (OwnedProperties[property.name] == true) or (keysOwnedHouse[property.name] == true)
end

function checkPolice()
	local playerData = ESX.GetPlayerData()
	if playerData.job.name == "police" then
		if Config.PoliceGradeRequiredForRaid ~= nil then
			for k,v in pairs(Config.PoliceGradeRequiredForRaid) do
				if playerData.job.grade_name == v then
					return true
				end
			end
		else
			return true
		end
	end
	return false
end

function OpenPropertyMenu(property)
	local elements = {}

	if PropertyIsOwned(property) or openDoors[property.name] then
		table.insert(elements, {label = _U('enter'), value = 'enter'})

		if not Config.EnablePlayerManagement and OwnedProperties[property.name] == true then
			table.insert(elements, {label = _U('leave'), value = 'leave'})
		end
	elseif propOwner[property.name] and not openDoors[property.name] then
		table.insert(elements, {label = _U("knock_on_door"), value = 'knock'})
	else
		if not Config.EnablePlayerManagement then
			table.insert(elements, {label = _U('buy'), value = 'buy'})
		--	table.insert(elements, {label = _U('rent'), value = 'rent'})
		end

		table.insert(elements, {label = _U('visit'), value = 'visit'})
	end

	if checkPolice() and propOwner[property.name] and not openDoors[property.name] then
		table.insert(elements, {label = _U("force_police"), value = "raid"})
	end

	if checkPolice() and propOwner[property.name] and openDoors[property.name] then
		table.insert(elements, {label = _U("enter_police"), value = "raid"})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'property', {
		title    = property.label,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		if data.current.value == 'enter' then
			ESX.TriggerServerCallback("root_instance:checkInstance",function(instance)
				if not instance then
					TriggerEvent('instance:create', 'property', {property = property.name, owner = propOwnerSteamID[property.name]})
				else
					TriggerEvent('instance:enter',instance)
				end
				TriggerEvent('tqrp_inventoryhud:setowner', propOwnerSteamID[property.name])
				TriggerEvent("root_mobilya:placeFurnitures",property.name)
			end,property.name)
		elseif data.current.value == 'leave' then
			TriggerServerEvent('tqrp_property:removeOwnedProperty', property.name)
		elseif data.current.value == 'knock' then
			ESX.TriggerServerCallback("root_instance:checkInstance",function(instance)
				if not instance then
					exports['mythic_notify']:DoLongHudText('error', _U("knock_empty"))
				else
					TriggerServerEvent('instance:trigger', property.name, "tqrp_property:knockKnock")
				end
			end,property.name)
		elseif data.current.value == 'buy' then
			TriggerServerEvent('tqrp_property:buyProperty', property.name)
		elseif data.current.value == 'rent' then
			TriggerServerEvent('tqrp_property:rentProperty', property.name)
		elseif data.current.value == 'visit' then
			ESX.TriggerServerCallback("root_instance:checkInstance",function(instance)
                if not instance then
                    TriggerEvent('instance:create', 'property', {property = property.name, owner = property.name})
                else
                    TriggerEvent('instance:enter',instance)
                end
                --TriggerEvent("root_mobilya:placeFurnitures",property.name)
            end,property.name)
		elseif data.current.value == 'raid' then
			raidHome(property)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'property_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {property = property}
	end)
end

function raidHome(property)
	if not openDoors[property.name] then
		TriggerEvent('mythic_progbar:client:progress',{
			name = 'lockpicking_house',
			duration = 15000,
			label = _U("picklocking"),
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
				anim = "machinic_loop_mechandplayer",
				flags = 49,
			}}, function(status)
				if not status then
					ESX.TriggerServerCallback("root_instance:checkInstance",function(instance)
						if not instance then
							TriggerEvent('instance:create', 'property', {property = property.name, owner = propOwnerSteamID[property.name]})
						else
							TriggerEvent('instance:enter',instance)
						end
						TriggerEvent('tqrp_inventoryhud:setowner', propOwnerSteamID[property.name])
						TriggerEvent("root_mobilya:placeFurnitures",property.name)
						raiding = true
					end,property.name)
				end
		end)
	else
		ESX.TriggerServerCallback("root_instance:checkInstance",function(instance)
			if not instance then
				TriggerEvent('instance:create', 'property', {property = property.name, owner = propOwnerSteamID[property.name]})
			else
				TriggerEvent('instance:enter',instance)
			end
			TriggerEvent('tqrp_inventoryhud:setowner', propOwnerSteamID[property.name])
			TriggerEvent("root_mobilya:placeFurnitures",property.name)
			raiding = true
		end,property.name)	
	end
end

function specialMenu(menuname,callback)
	local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
	local elements = {}
	local serverIds = {}
	for i = 1, #players, 1 do
		if players[i] ~= PlayerId() then
			table.insert(serverIds, GetPlayerServerId(players[i]))
		end
	end
	ESX.TriggerServerCallback("tqrp_policejob:getMeNames",function(identities)
		for k,v in pairs(identities) do
			table.insert(elements, {
				player = k,
				label = v
			})
		end		
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'special_cop_menu',
		{
			title = menuname,
			align = 'top-left',
			elements = elements,
		},
		function(data, menu)
			menu.close()
			print(data.current.player)
			callback(data.current.player)
		end,
		function(data, menu)
			menu.close()
		end)
	end,serverIds)		
end

function OpenGatewayMenu(property)
	if Config.EnablePlayerManagement then
		OpenGatewayOwnedPropertiesMenu(gatewayProperties)
	else

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway', {
			title    = property.name,
			align    = 'top-left',
			elements = {
				{label = _U('owned_properties'),    value = 'owned_properties'},
				{label = _U('available_properties'), value = 'available_properties'}
		}}, function(data, menu)
			if data.current.value == 'owned_properties' then
				OpenGatewayOwnedPropertiesMenu(property)
			elseif data.current.value == 'available_properties' then
				OpenGatewayAvailablePropertiesMenu(property)
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'gateway_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {property = property}
		end)
	end
end

AddEventHandler("tqrp_property:forceCurrentAction",function(action)
	CurrentAction = action
end)

function OpenGatewayOwnedPropertiesMenu(property)
	local gatewayProperties = GetGatewayProperties(property)
	local elements          = {}

	for i=1, #gatewayProperties, 1 do
		if PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label,
				value = gatewayProperties[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties', {
		title    = property.name .. ' - ' .. _U('owned_properties'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		local elements = {
			{label = _U('enter'), value = 'enter'}
		}

		if not Config.EnablePlayerManagement then
			table.insert(elements, {label = _U('leave'), value = 'leave'})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties_actions', {
			title    = data.current.label,
			align    = 'top-left',
			elements = elements
		}, function(data2, menu2)
			menu2.close()

			if data2.current.value == 'enter' then
				TriggerEvent('instance:create', 'property', {property = data.current.value, owner = propOwnerSteamID[property.name]})
				ESX.UI.Menu.CloseAll()
			elseif data2.current.value == 'leave' then
				TriggerServerEvent('tqrp_property:removeOwnedProperty', data.current.value)
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGatewayAvailablePropertiesMenu(property)
	local gatewayProperties = GetGatewayProperties(property)
	local elements          = {}

	for i=1, #gatewayProperties, 1 do
		if not PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label .. ' $' .. ESX.Math.GroupDigits(gatewayProperties[i].price),
				value = gatewayProperties[i].name,
				price = gatewayProperties[i].price
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_available_properties', {
		title    = property.name .. ' - ' .. _U('available_properties'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_available_properties_actions', {
			title    = property.label .. ' - ' .. _U('available_properties'),
			align    = 'top-left',
			elements = {
				{label = _U('buy'), value = 'buy'},
				{label = _U('rent'), value = 'rent'},
				{label = _U('visit'), value = 'visit'}
		}}, function(data2, menu2)
			menu2.close()

			if data2.current.value == 'buy' then
				TriggerServerEvent('tqrp_property:buyProperty', data.current.value)
			elseif data2.current.value == 'rent' then
				TriggerServerEvent('tqrp_property:rentProperty', data.current.value)
			elseif data2.current.value == 'visit' then
				TriggerEvent('instance:create', 'property', {property = data.current.value, owner = propOwnerSteamID[property.name]})
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
	end)
end

RegisterCommand("givehousekey",function(source, args, rawCommand)
	specialMenu("Which property?",function(playerID)
		ESX.TriggerServerCallback("tqrp_property:getOwnedProperties",function(properties)
			local elements = {}
			for k,v in pairs(properties) do
				table.insert(elements, {
					label = v.name
				})
			end		
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_key_menu',
			{
				title = menuname,
				align = 'top-left',
				elements = elements,
			},
			function(data, menu)
				menu.close()
				TriggerServerEvent("tqrp_property:giveKey",playerID,data.current.label)
			end,
			function(data, menu)
				menu.close()
			end)
		end)			
	end)
end)

function AccessChest(property, owner)
	ESX.TriggerServerCallback(
	"root_property:getPropertyInventory",
	function(inventory)
		if inventory then
			TriggerEvent("tqrp_inventoryhud:openRootPropertyInventory", inventory)
		else
			print("Problem: ROOT-ALPHA-664")
		end
	end, owner)
end

function OpenRoomMenu(property, owner)
	local entering = nil
	local elements = {}

	if property.isSingle then
		entering = property.entering
	else
		entering = GetGateway(property).entering
	end
	if not raiding then
		table.insert(elements, {label = _U("give_house_key_option"), value = 'givekey'})
	end
	if OwnedProperties[property.name] then
		table.insert(elements, {label = _U("change_lock"), value = 'changelock'})
		table.insert(elements, {label = _U("furniture_option"), value = 'openFurniture'})
	end
	table.insert(elements, {label = _U("lock_unlock_door_menu"), value = 'doortoggle'})
	

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = property.label,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'doortoggle' then
			if openDoors[property.name] then
				TriggerServerEvent("tqrp_property:lockDoor",property.name)
				exports['mythic_notify']:DoLongHudText('error', _U('front_door_locked'))
			elseif lockedDoors[property.name] then
				exports['mythic_notify']:DoLongHudText('success', _U('front_door_unlocked'))
				TriggerServerEvent("tqrp_property:unlockDoor",property.name)
			end
			menu.close()
		elseif data.current.value == 'givekey' then
		
			specialMenu("Whom would you like to give the keys to?",function(playerID)
					exports['mythic_notify']:DoLongHudText('success', _U('house_keys_are_given'))
					TriggerServerEvent("tqrp_property:giveKey",playerID,property.name)			
			end)
			menu.close()
		elseif data.current.value == 'changelock' then
			exports['mythic_notify']:DoLongHudText('success', _U('changed_lock'))
			TriggerServerEvent("tqrp_property:changeLock",property.name)
		elseif data.current.value == 'openFurniture' then
			TriggerEvent("root_mobilya:openFurnitureMenu",property.name)
		elseif data.current.value == 'room_inventory' then
			OpenRoomInventoryMenu(property, owner)
		elseif data.current.value == 'player_inventory' then
			OpenPlayerInventoryMenu(property, owner)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'room_menu'
		CurrentActionData = {property = property, owner = owner}
	end)
end

function OpenRoomInventoryMenu(property, owner)
	ESX.TriggerServerCallback('tqrp_property:getPropertyInventory', function(inventory)
		local elements = {}

		if inventory.blackMoney > 0 then
			table.insert(elements, {
				label = _U('dirty_money', ESX.Math.GroupDigits(inventory.blackMoney)),
				type = 'item_account',
				value = 'black_money'
			})
		end

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		for i=1, #inventory.weapons, 1 do
			local weapon = inventory.weapons[i]

			table.insert(elements, {
				label = ESX.GetWeaponLabel(weapon.name) .. ' [' .. weapon.ammo .. ']',
				type  = 'item_weapon',
				value = weapon.name,
				ammo  = weapon.ammo
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room_inventory', {
			title    = property.label .. ' - ' .. _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)

			if data.current.type == 'item_weapon' then
				menu.close()

				TriggerServerEvent('tqrp_property:getItem', owner, data.current.type, data.current.value, data.current.ammo)
				ESX.SetTimeout(300, function()
					OpenRoomInventoryMenu(property, owner)
				end)
			else
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'get_item_count', {
					title = _U('amount')
				}, function(data2, menu)

					local quantity = tonumber(data2.value)
					if quantity == nil then
						exports['mythic_notify']:DoHudText('inform', (_U('amount_invalid')))
					else
						menu.close()

						TriggerServerEvent('tqrp_property:getItem', owner, data.current.type, data.current.value, quantity)
						ESX.SetTimeout(300, function()
							OpenRoomInventoryMenu(property, owner)
						end)
					end
				end, function(data2,menu)
					menu.close()
				end)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, owner)
end

function OpenPlayerInventoryMenu(property, owner)
	ESX.TriggerServerCallback('tqrp_property:getPlayerInventory', function(inventory)
		local elements = {}

		if inventory.blackMoney > 0 then
			table.insert(elements, {
				label = _U('dirty_money', ESX.Math.GroupDigits(inventory.blackMoney)),
				type  = 'item_account',
				value = 'black_money'
			})
		end

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		for i=1, #inventory.weapons, 1 do
			local weapon = inventory.weapons[i]

			table.insert(elements, {
				label = weapon.label .. ' [' .. weapon.ammo .. ']',
				type  = 'item_weapon',
				value = weapon.name,
				ammo  = weapon.ammo
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_inventory', {
			title    = property.label .. ' - ' .. _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)

			if data.current.type == 'item_weapon' then
				menu.close()
				TriggerServerEvent('tqrp_property:putItem', owner, data.current.type, data.current.value, data.current.ammo)

				ESX.SetTimeout(300, function()
					OpenPlayerInventoryMenu(property, owner)
				end)
			else
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'put_item_count', {
					title = _U('amount')
				}, function(data2, menu2)
					local quantity = tonumber(data2.value)

					if quantity == nil then
						exports['mythic_notify']:DoHudText('inform', (_U('amount_invalid')))
					else
						menu2.close()

						TriggerServerEvent('tqrp_property:putItem', owner, data.current.type, data.current.value, tonumber(data2.value))
						ESX.SetTimeout(300, function()
							OpenPlayerInventoryMenu(property, owner)
						end)
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

AddEventHandler('instance:loaded', function()
	TriggerEvent('instance:registerType', 'property', function(instance)
		TriggerEvent("EnterProperty",instance.data.property, instance.data.owner)
	end, function(instance)
		TriggerEvent("ExitProperty",instance.data.property)
	end)
end)


AddEventHandler("EnterProperty",function(p1,p2)
	EnterProperty(p1, p2)
end)

AddEventHandler("ExitProperty",function(p1)
	ExitProperty(p1)
end)

AddEventHandler('playerSpawned', function()
	if firstSpawn then
		Citizen.CreateThread(function()
			while not ESX.IsPlayerLoaded() do
				Citizen.Wait(10)
			end

			ESX.TriggerServerCallback('tqrp_property:getLastProperty', function(propertyName)
				if propertyName then
					if propertyName ~= '' then
						local property = GetProperty(propertyName)

						for i=1, #property.ipls, 1 do
							RequestIpl(property.ipls[i])
				
							while not IsIplActive(property.ipls[i]) do
								Citizen.Wait(10)
							end
						end
						ESX.TriggerServerCallback("root_instance:checkInstance",function(instance)
							if not instance then
								TriggerEvent('instance:create', 'property', {property = propertyName, owner = propOwnerSteamID[property.name]})
							else
								TriggerEvent('instance:enter',instance)
							end
							TriggerEvent('tqrp_inventoryhud:setowner', propOwnerSteamID[property.name])
							TriggerEvent("root_mobilya:placeFurnitures",property.name)
						end,propertyName)
					end
				end
			end)
		end)

		firstSpawn = false
	end
end)

AddEventHandler('tqrp_property:getProperties', function(cb)
	cb(GetProperties())
end)

AddEventHandler('tqrp_property:getProperty', function(name, cb)
	cb(GetProperty(name))
end)

AddEventHandler('tqrp_property:getGateway', function(property, cb)
	cb(GetGateway(property))
end)

RegisterNetEvent('tqrp_property:setPropertyOwned')
AddEventHandler('tqrp_property:setPropertyOwned', function(name, owned)
	SetPropertyOwned(name, owned)
end)

RegisterNetEvent('tqrp_property:knockKnock')
AddEventHandler('tqrp_property:knockKnock', function()
	TriggerEvent('InteractSound_CL:PlayOnOne',"knockknock",0.3)
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'property' then
		TriggerEvent('instance:enter', instance)
	end
end)

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(instance)
	if instance.type == 'property' then
		local property = GetProperty(instance.data.property)
		local isHost   = GetPlayerFromServerId(instance.host) == PlayerId()
		local isOwned  = false

		if PropertyIsOwned(property) == true then
			isOwned = true
		end

		if isOwned or not isHost then
			hasChest = true
		else
			hasChest = false
		end
	end
end)

RegisterNetEvent('instance:onPlayerLeft')
AddEventHandler('instance:onPlayerLeft', function(instance, player)
	if player == 1 then
		TriggerEvent('instance:leave')
	end
end)

AddEventHandler('tqrp_property:hasEnteredMarker', function(name, part)
	local property = GetProperty(name)
	CurrentActionMsg = ""
	if part == 'entering' then
		if property.isSingle then
			CurrentAction     = 'property_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {property = property}
		else
			CurrentAction     = 'gateway_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {property = property}
		end
	elseif part == 'exit' then
		CurrentAction     = 'room_exit'
		CurrentActionData = {propertyName = name}
	elseif part == 'roomMenu' then
		CurrentAction     = 'room_menu'
		CurrentActionData = {property = property, owner = CurrentPropertyOwner}
	elseif part == 'chest' then
		CurrentAction     = 'chest'	
		CurrentActionData = {property = property, owner = CurrentPropertyOwner}	
	elseif part == 'dress' then
		CurrentAction     = 'dress'	
	end
end)

AddEventHandler('tqrp_property:hasExitedMarker', function(name, part)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

function comma_value(n) -- credit http://richard.warburton.it
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end
-- Enter / Exit marker events & Draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep = false, true
		local currentProperty, currentPart
		
		for i=1, #Config.Properties, 1 do
			local property = Config.Properties[i]
			if property.tip ~= "motel" then
			-- Entering
			if property.entering and not property.disabled and not propOwner[property.name] then
				local distance = GetDistanceBetweenCoords(coords, property.entering.x, property.entering.y, property.entering.z, true)

				if distance < Config.DrawDistance +5 then
				Draw3DText({
					xyz= vector3(property.entering.x, property.entering.y, property.entering.z),
					text={
						content="~b~".._U("3d_house").."~n~~n~~r~".._U("3d_name")..": ~m~"..property.name.."~n~~g~".._U("3d_cost")..": ~m~$"..comma_value(property.price),
						rgb={255 , 255, 255},
						textOutline=true,
						scaleMultiplier=1,
						font=0,
					},
					perspectiveScale=4,
					radius=1000,
				})
				letSleep = false
				end



				if distance < 1 then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'entering'
				end
			end

			if property.entering and not property.disabled and propOwner[property.name] then
				local distance = GetDistanceBetweenCoords(coords, property.entering.x, property.entering.y, property.entering.z, true)
				local locked = {"r",_U("door_is_locked")}
				if openDoors[property.name] then
					locked = {"g",_U("door_is_unlocked")}
				end
				if distance < Config.DrawDistance+5 then
					--DrawMarker(Config.MarkerType, property.entering.x, property.entering.y, property.entering.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
					Draw3DText({
						xyz= vector3(property.entering.x, property.entering.y, property.entering.z),
						text={
							content="~b~".._U("3d_house").."~n~~n~~r~".._U("3d_name")..": ~m~"..property.name.."~n~~o~".._U("3d_owner")..": ~m~"..propOwner[property.name].."~n~~"..locked[1].."~"..locked[2],
							rgb={255 , 255, 255},
							textOutline=true,
							scaleMultiplier=1,
							font=0,
						},
						perspectiveScale=4,
						radius=1000,
					})
				end

				if distance < 1 then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'entering'
				end
			end

			-- Exit
			if property.exit and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.exit.x, property.exit.y, property.exit.z, true)

				if distance < Config.DrawDistance then
					DrawText3D(property.exit.x, property.exit.y, property.exit.z + 0.35, _U("to_leave"))
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'exit'
				end
			end

			-- Room menu
			if (PropertyIsOwned(property) or raiding == true) and property.roomMenu and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, true)

				if distance < Config.DrawDistance then
					DrawText3D(property.roomMenu.x, property.roomMenu.y, property.roomMenu.z + 0.35, _U("to_manage"))
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'roomMenu'
				end
			end

			
			if (PropertyIsOwned(property) or raiding == true) and property.chestLocation and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.chestLocation.x, property.chestLocation.y, property.chestLocation.z+1, true)

				if distance < Config.DrawDistance then
					DrawText3D(property.chestLocation.x, property.chestLocation.y, property.chestLocation.z + 0.35, _U("to_chest"))
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'chest'
				end
			end
			if PropertyIsOwned(property) and property.dressLocation and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.dressLocation.x, property.dressLocation.y, property.dressLocation.z+1, true)

				if distance < Config.DrawDistance then
					DrawText3D(property.dressLocation.x, property.dressLocation.y, property.dressLocation.z + 0.35, _U("to_wardrobe"))
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'dress'
				end
			end

			end
		end

		if isInMarker and not hasAlreadyEnteredMarker or (isInMarker and (LastProperty ~= currentProperty or LastPart ~= currentPart) ) then
			hasAlreadyEnteredMarker = true
			LastProperty            = currentProperty
			LastPart                = currentPart

			TriggerEvent('tqrp_property:hasEnteredMarker', currentProperty, currentPart)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('tqrp_property:hasExitedMarker', LastProperty, LastPart)
		end

		if letSleep then
			Citizen.Wait(1500)
		end
	end
end)

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	local scale = 0.45
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
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0150, 0.030 + factor , 0.030, 66, 66, 66, 150)
	end
end

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'property_menu' then
					OpenPropertyMenu(CurrentActionData.property)
					CurrentAction = nil
				elseif CurrentAction == 'gateway_menu' then
					if Config.EnablePlayerManagement then
						OpenGatewayOwnedPropertiesMenu(CurrentActionData.property)
					else
						OpenGatewayMenu(CurrentActionData.property)
					end
				elseif CurrentAction == 'room_menu' then
					OpenRoomMenu(CurrentActionData.property, CurrentActionData.owner)
					CurrentAction = nil
				elseif CurrentAction == 'chest' then
					AccessChest(CurrentActionData.property, CurrentActionData.owner)
					CurrentAction = nil
				elseif CurrentAction == 'dress' then
					PlayerDressings()
					CurrentAction = nil
				elseif CurrentAction == 'room_exit' then
					raiding = false
					TriggerEvent('instance:leave')
					CurrentAction = nil
				end
			end
		else
			Citizen.Wait(1500)
		end
	end
end)

function PlayerDressings()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dress_menu',
	{
		title    = _U("ward_menu"),
		align    = 'top-left',
		elements = {
            {label = _U("ward_menu_1"), value = 'player_dressing'},
	        {label = _U("ward_menu_2"), value = 'remove_cloth'}
        }
	}, function(data, menu)

		if data.current.value == 'player_dressing' then 
            menu.close()
			ESX.TriggerServerCallback('root_property:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
				{
					title    = _U("ward_menu_3"),
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)

					TriggerEvent('skinchanger:getSkin', function(skin)
						ESX.TriggerServerCallback('root_property:getPlayerOutfit', function(clothes)
							TriggerEvent('skinchanger:loadClothes', skin, clothes)
							TriggerEvent('tqrp_skin:setLastSkin', skin)

							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('tqrp_skin:save', skin)
							end)
						end, data2.current.value)
					end)

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		elseif data.current.value == 'remove_cloth' then
            menu.close()
			ESX.TriggerServerCallback('root_property:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					title    = _U("ward_menu_4"),
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('root_property:removeOutfit', data2.current.value)
					ESX.ShowNotification(_U("ward_menu_5"))
				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
        menu.close()
	end)




end




-- Fix vehicles randomly spawning nearby the player inside an instance
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10) -- must be run every frame
		
		if InsideInstance then
			SetVehicleDensityMultiplierThisFrame(0.0)
			SetParkedVehicleDensityMultiplierThisFrame(0.0)

			local pos = GetEntityCoords(PlayerPedId())
			RemoveVehiclesFromGeneratorsInArea(pos.x - 900.0, pos.y - 900.0, pos.z - 900.0, pos.x + 900.0, pos.y + 900.0, pos.z + 900.0)
		else
			Citizen.Wait(1500)
		end
	end
end)

default = {
    xyz={x = -1377.514282266, y = -2852.64941406, z = 13.9448}, -- At airport
    text={
        content="Test",
        rgb={255 , 255, 255},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=4,
    radius=5000,
    timeout=5000
}

function Draw3DTextPermanent(params)
    if params == nil then params=default end
    if params.xyz == nil then params.xyz=default.xyz end
    if params.text.rgb == nil then params.text.rgb=default.text.rgb end
    if params.text.textOutline == nil then params.text.textOutline=default.text.textOutline end
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(10)
            -- Checks distance between player and the coords 
            if Vdist2(GetEntityCoords(PlayerPedId(), false), params.xyz.x,params.xyz.y,params.xyz.z) < (params.radius or default.radius) then
                local onScreen, _x, _y = World3dToScreen2d(params.xyz.x,params.xyz.y,params.xyz.z)
                local p = GetGameplayCamCoords()
                local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, params.xyz.x,params.xyz.y,params.xyz.z, 1)
                local scale = (1 / distance) * (params.perspectiveScale or default.perspectiveScale)
                local fov = (1 / GetGameplayCamFov()) * 75
                local scale = scale * fov
                if onScreen then
                    SetTextScale(tonumber(params.text.scaleMultiplier*0.0), tonumber(0.35 * (params.text.scaleMultiplier or default.text.scaleMultiplier)))
                    SetTextFont(params.text.font or default.text.font)
                    SetTextProportional(true)
                    SetTextColour(params.text.rgb[1], params.text.rgb[2], params.text.rgb[3], 255)
                    --SetTextDropshadow(0, 0, 0, 0, 255)
                    --SetTextEdge(2, 0, 0, 0, 150)
                    if (params.text.textOutline) == true then SetTextOutline() end;
                    SetTextEntry("STRING")
                    SetTextCentre(true)
                    AddTextComponentString(params.text.content or default.text.content)
                    DrawText(_x,_y)
                end
            end
        end
    end)
end

function Draw3DText(params)
	local enable = true
	if Config.ThreeDShouldShowUp ~= nil then
		enable = Config.ThreeDShouldShowUp
	end
    if params == nil then params=default end
    if params.xyz == nil then params.xyz=default.xyz end
    if params.text.rgb == nil then params.text.rgb=default.text.rgb end
    if params.text.textOutline == nil then params.text.textOutline=default.text.textOutline end
	if not enable then return end
    Citizen.CreateThread(function()
          -- Checks distance between player and the coords 
            if Vdist2(GetEntityCoords(PlayerPedId(), false), params.xyz.x,params.xyz.y,params.xyz.z) < (params.radius or default.radius) then
                local onScreen, _x, _y = World3dToScreen2d(params.xyz.x,params.xyz.y,params.xyz.z)
                local p = GetGameplayCamCoords()
                local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, params.xyz.x,params.xyz.y,params.xyz.z, 1)
                local scale = (1 / distance) * (params.perspectiveScale or default.perspectiveScale)
                local fov = (1 / GetGameplayCamFov()) * 75
                local scale = scale * fov
                if onScreen then
                    SetTextScale(tonumber(params.text.scaleMultiplier*0.0), tonumber(0.35 * (params.text.scaleMultiplier or default.text.scaleMultiplier)))
                    SetTextFont(params.text.font or default.text.font)
                    SetTextProportional(true)
                    SetTextColour(params.text.rgb[1], params.text.rgb[2], params.text.rgb[3], 255)
                    --SetTextDropshadow(0, 0, 0, 0, 255)
                    --SetTextEdge(2, 0, 0, 0, 150)
                    if (params.text.textOutline) == true then SetTextOutline() end;
                    SetTextEntry("STRING")
                    SetTextCentre(true)
                    AddTextComponentString(params.text.content or default.text.content)
                    DrawText(_x,_y)
                end
        end
    end)
end

function Draw3DTextTimeout(params)
    timeoutState = true
    if params == nil then params=default end
    if params.xyz == nil then params.xyz=default.xyz end
    if params.text.rgb == nil then params.text.rgb=default.text.rgb end
    if params.text.textOutline == nil then params.text.textOutline=default.text.textOutline end
    if params.timeout == nil then params.timeout=default.timeout end
    Citizen.CreateThread(function()
        Wait(params.timeout)
        -- waits until after the timeout is done to close it
		timeoutState = false
	end)
    Citizen.CreateThread(function()
        -- checks if the timeout is true
        while timeoutState do 
            Citizen.Wait(10)
          -- Checks distance between player and the coords 
            if Vdist2(GetEntityCoords(PlayerPedId(), false), params.xyz.x,params.xyz.y,params.xyz.z) < (params.radius or default.radius) then
                local onScreen, _x, _y = World3dToScreen2d(params.xyz.x,params.xyz.y,params.xyz.z)
                local p = GetGameplayCamCoords()
                local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, params.xyz.x,params.xyz.y,params.xyz.z, 1)
                local scale = (1 / distance) * (params.perspectiveScale or default.perspectiveScale)
                local fov = (1 / GetGameplayCamFov()) * 75
                local scale = scale * fov
                if onScreen then
                    SetTextScale(tonumber(params.text.scaleMultiplier*0.0), tonumber(0.35 * (params.text.scaleMultiplier or default.text.scaleMultiplier)))
                    SetTextFont(params.text.font or default.text.font)
                    SetTextProportional(true)
                    SetTextColour(params.text.rgb[1], params.text.rgb[2], params.text.rgb[3], 255)
                    --SetTextDropshadow(0, 0, 0, 0, 255)
                    --SetTextEdge(2, 0, 0, 0, 150)
                    if (params.text.textOutline) == true then SetTextOutline() end;
                    SetTextEntry("STRING")
                    SetTextCentre(true)
                    AddTextComponentString(params.text.content or default.text.content)
                    DrawText(_x,_y)
                end
            end
        end
    end)
end





Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)


local chest_location,dress_location


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLenght	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(10)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(1500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(1500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end


RegisterCommand("addhouse",function()
	local ok = nil
	ESX.TriggerServerCallback("root_evekle:grupver",function(group)
		ok = false
		if group == "superadmin" then
			ok = true
		end
	end)
	while ok == nil do 
		Wait(10)
	end
	if ok == false then return end
	local pos = GetEntityCoords(PlayerPedId())
	local entering = '{"x":'..pos.x..',"y":'..pos.y..',"z":'..pos.z..'}'
	local ipl = '[]'
	local isim = KeyboardInput("Home name:","",30)
	while isim == nil do
		Wait(100)
	end
	local fiyat = KeyboardInput("Price:","",30)
	while fiyat == nil do
		Wait(100)
	end
	local interieur = KeyboardInput("Interior: ","",30)
	while interieur == nil do
		Wait(100)
	end
	if isim and fiyat and interieur then		
		Wait(50)
		inside = Config.interiors[tonumber(interieur)].inside
		roommenu = Config.interiors[tonumber(interieur)].roommenu
		chest_location = Config.interiors[tonumber(interieur)].chest_location
		dress_location = Config.interiors[tonumber(interieur)].dress_location
		price = fiyat
		isSingle = 1
		isRoom = 0
		name = isim


		TriggerServerEvent('putIn',name,name,entering,inside,ipl,isSingle,isRoom,roommenu,price,chest_location,dress_location)
	end
end,false)

guiEnabled = false
curObject = 0
obj = {}
curObjectName = "None"
modifiedObjects = {}
obj.x = 0.0
obj.y = 1.0
obj.z = 0.0
rot = true
cam = 0
camX = 0
camY = 0
camZ = 0
objX = 0
objY = 0
objZ = 0
camCrds = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0 }
camball = 0
house_id = 0
house_model = 0
Citizen.CreateThread(function()
	guiEnabled = false
	curObject = 0
	obj = {}
	curObjectName = "None"
	modifiedObjects = {}
	obj.x = 0.0
	obj.y = 1.0
	obj.z = 0.0
	rot = true
	cam = 0
	camX = 0
	camY = 0
	camZ = 0
	objX = 0
	objY = 0
	objZ = 0
	camCrds = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0 }
	camball = 0
	house_id = 0
	house_model = 0
end)

function ResetVars()
    curObjectName = "None"
    curObject = 0
    obj.x = 0.0
    obj.y = 1.0
    obj.z = 0.0
    cam = 0
end

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 196, ["D"] = 195, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

objectControl = false

function switchControl(status)
	objectControl = status
	if objectControl == true then
		SetIbuttons({
		{GetControlInstructionalButton(1,Keys["RIGHTCTRL"],0),_U("a1")},
		{GetControlInstructionalButton(1,Keys["Q"],0),_U("a3")},
		{GetControlInstructionalButton(1,Keys["E"],0),_U("a4")},
		{GetControlInstructionalButton(1,Keys["W"],0),_U("a5")},
		{GetControlInstructionalButton(1,Keys["S"],0),_U("a6")},
		{GetControlInstructionalButton(1,Keys["D"],0),_U("a7")},
		{GetControlInstructionalButton(1,Keys["A"],0),_U("a8")},
		{GetControlInstructionalButton(1,220,0),_U("a9")},
		}, 0)
	else
		SetIbuttons({
		{GetControlInstructionalButton(1,Keys["RIGHTCTRL"],0),_U("a2")},
		{GetControlInstructionalButton(1,Keys["Q"],0),_U("a3")},
		{GetControlInstructionalButton(1,Keys["E"],0),_U("a4")},
		{GetControlInstructionalButton(1,Keys["W"],0),_U("a5")},
		{GetControlInstructionalButton(1,Keys["S"],0),_U("a6")},
		{GetControlInstructionalButton(1,Keys["D"],0),_U("a7")},
		{GetControlInstructionalButton(1,Keys["A"],0),_U("a8")},
		{GetControlInstructionalButton(1,220,0),_U("a9")},
		}, 0)	
	end
end

function openGui()
	elements = {{option = "new",label = _U("a10")},{option = "edit",label = _U("a11")}}
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobilya_menu',
	{
		title = _U("a12"),
		align = 'top-left',
		elements = elements,
	},
	function(data, menu)
		if data.current.option == "new" then
			objectCreationMenu()
		elseif data.current.option == "edit" then
			objectEditMenu()
		end
	end,
	function(data, menu)
		menu.close()
		TriggerEvent("tqrp_property:forceCurrentAction",'room_menu')
		updateDatabase(house_id,house_model)
		camOff() 
		closeGui()
	end)
end

function objectEditMenu()
	SetIbuttons({
	{GetControlInstructionalButton(1,Keys["RIGHTCTRL"],0),_U("a2")},
	{GetControlInstructionalButton(1,Keys["Q"],0),_U("a3")},
	{GetControlInstructionalButton(1,Keys["E"],0),_U("a4")},
	{GetControlInstructionalButton(1,Keys["W"],0),_U("a5")},
	{GetControlInstructionalButton(1,Keys["S"],0),_U("a6")},
	{GetControlInstructionalButton(1,Keys["D"],0),_U("a7")},
	{GetControlInstructionalButton(1,Keys["A"],0),_U("a8")},
	{GetControlInstructionalButton(1,220,0),_U("a9")},
	}, 0)	
	scanObjects(function(status)
		if status then
			elements = {{option = "save",label = _U("a13")},{option = "next",label = _U("a14")},{option = "prev",label = _U("a15")},{option = "del",label = _U("a16")}}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobilya_edit',
			{
				title = _U("a17"),
				align = 'top-left',
				elements = elements,
			},
			function(data, menu)
				if data.current.option == "save" then
					SaveCurObjectToTable()
					menu.close()
					objectEditMenu()
					exports['mythic_notify']:DoLongHudText('success', _U("a18"))
				elseif data.current.option == "next" then
					prevObj()
					--RestackFurniture(modifiedObjects)
				elseif data.current.option == "prev" then
					nextObj()
					--RestackFurniture(modifiedObjects)
				elseif data.current.option == "del" then
					DelSelectedObj()
					menu.close()
					objectEditMenu()
					exports['mythic_notify']:DoLongHudText('success', _U("a19"))
				end
			end,
			function(data, menu)
				menu.close()
				RestackFurniture(modifiedObjects)
				updateDatabase(house_id,house_model)
				camOff() 
				closeGui()
			end)
		else
			exports['mythic_notify']:DoLongHudText('error', _U("a20"))
		end
	end)
end

function closeGui()
    guiEnabled = false
    FreezeEntityPosition(PlayerPedId(),false)
    ClearPedTasks(PlayerPedId())
	Citizen.CreateThread(function()
		Citizen.Wait(1500)
		ClearPedTasks(PlayerPedId())
		FreezeEntityPosition(PlayerPedId(),false)
	end)
end

function objectCreationMenu()
	SetIbuttons({
	{GetControlInstructionalButton(1,Keys["RIGHTCTRL"],0),_U("a2")},
	{GetControlInstructionalButton(1,Keys["Q"],0),_U("a3")},
	{GetControlInstructionalButton(1,Keys["E"],0),_U("a4")},
	{GetControlInstructionalButton(1,Keys["W"],0),_U("a5")},
	{GetControlInstructionalButton(1,Keys["S"],0),_U("a6")},
	{GetControlInstructionalButton(1,Keys["D"],0),_U("a7")},
	{GetControlInstructionalButton(1,Keys["A"],0),_U("a8")},
	{GetControlInstructionalButton(1,220,0),_U("a9")},
	}, 0)
	elements = {}
	for k,v in pairs(objectCategories) do
		table.insert(elements, {
			category = v["category"],
			label = v["name"]
		})
	end		
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobilya_creation',
	{
		title = _U("a21"),
		align = 'top-left',
		elements = elements,
	},
	function(data, menu)
		elements = {}
		for k,v in pairs(categories[data.current.category]) do
			table.insert(elements, {
				objectvar = v["object"],
				price = v["price"],
				label = v["name"] .. " Price: " .. v["price"] .. "$"
			})
		end		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobilya_creation2',
		{
			title = _U("a21"),
			align = 'top-left',
			elements = elements,
		},
		function(data2, menu)
			elements = {}
			selectObject(data2.current.objectvar,function(status)
				if status == "ok" then
					newObject()
					TriggerEvent("tqrp_property:forceCurrentAction",'none')
					guiEnabled = true

					elements = {{status = true,label = _U("a23")},{status = false,label = _U("a24")}}
					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobilya_creation3',
					{
						title = _U("a22"),
						align = 'top-left',
						elements = elements,
					},
					function(data3, menu)
						menu.close()
						if data3.current.status == true then
							ESX.TriggerServerCallback("root_mobilya:checkMoney",function(status)
								if status then
									exports['mythic_notify']:DoLongHudText('success', _U("a25"))
									menu.close()
									rot = false
									SaveCurObjectToTable()
									switchControl(false)
									TriggerEvent("tqrp_property:forceCurrentAction",'room_menu')
									closeGui()
								else
									exports['mythic_notify']:DoLongHudText('success', _U("a26"))
									DelSelectedObj()
									camOff()
									TriggerEvent("tqrp_property:forceCurrentAction",'room_menu')
									closeGui()
								end
							end,data2.current.price)
						else
							DelSelectedObj()
							camOff()
							TriggerEvent("tqrp_property:forceCurrentAction",'room_menu')
							closeGui()
						end
					end,
					function(data3, menu)
						menu.close()
					end)				
				else
					exports['mythic_notify']:DoLongHudText('error', 'ERROR! CONTACT SERVER ADMIN.')
				end
			end)
		end,
		function(data2, menu)
			menu.close()
			TriggerEvent("tqrp_property:forceCurrentAction",'room_menu')
		end)
	end,
	function(data, menu)
		menu.close()
		TriggerEvent("tqrp_property:forceCurrentAction",'room_menu')
		updateDatabase(house_id,house_model)
		camOff() 
		closeGui()
	end)
end




function scanObjects(cb)
    --print("m1")
    closestDist = 999.9
    pass = false

    if(not DoesCamExist(cam)) then
        --print("m6")
        createCam()
    end

    for i = 1, #modifiedObjects do
        if (GetDistanceBetweenCoords(GetEntityCoords(modifiedObjects[i]["object"]), GetCamCoord(cam)) < closestDist and GetDistanceBetweenCoords(GetEntityCoords(modifiedObjects[i]["object"]), GetCamCoord(cam)) < 20.0) then
			delObj = i
			curObject = modifiedObjects[i]["object"]
            closestDist = GetDistanceBetweenCoords(GetEntityCoords(modifiedObjects[i]["object"]), GetCamCoord(cam))
            pass = true
            --print("m2")
            --print(closestDist)
        end
    end

    --print("m3")
    if pass then
        --print("m4")
        TriggerEvent("DoLongHudText","We have found an object - entering movement mode.")
		TriggerEvent("tqrp_property:forceCurrentAction",'none')
		guiEnabled = true
        FreezeEntityPosition(PlayerPedId(),true)
    else
        --print("m5")
        TriggerEvent("DoLongHudText","No objects near.")
    end


	cb(pass)
    --print("m7")
    CamFocusObject()
    --print("m8")
end    


function SaveCurObjectToTable()
    --print("s1")
    if curObject == 0 then
        --print("s2")
        TriggerEvent("DoLongHudText","Exiting Free-Cam or object was 0!")
        return
    end
    --print("s3")
    for i = 1, #modifiedObjects do
        if curObject == modifiedObjects[i]["object"] then
            --print("s4")
            --print("updating obj to db confirmation")
            objCoords = GetEntityCoords(curObject)
            modifiedObjects[i]["x"] = math.ceil(objCoords["x"] * 1000) /1000
            modifiedObjects[i]["y"] = math.ceil(objCoords["y"] * 1000) /1000
            modifiedObjects[i]["z"] = math.ceil(objCoords["z"] * 1000) /1000
            modifiedObjects[i]["heading"] = math.ceil(GetEntityHeading(curObject) * 1000) /1000
            modifiedObjects[i]["hash"] = GetEntityModel(curObject)
        end
    end
    --print("s5")
	updateDatabase(house_id,house_model)
	camOff() 
	closeGui()
	FreezeEntityPosition(PlayerPedId(),false)
    TriggerEvent("DoLongHudText","You have saved the object!")
    curObject = 0
end

function newObject(data, cb)
    --print("n1")
    if curOjbect == 0 then
        --print("n1 - no object stored curently")
        return
    end
    FreezeEntityPosition(PlayerPedId(),true)
    objCoords = GetEntityCoords(curObject)
    modifiedObjects[#modifiedObjects+1] = { ["hash"] = GetEntityModel(curObject),["object"] = curObject, ["x"] = math.ceil(objCoords["x"] * 1000) /1000, ["y"] = math.ceil(objCoords["y"] * 1000) /1000, ["z"] = math.ceil(objCoords["z"] * 1000) /1000, ["heading"] = math.ceil(GetEntityHeading(curObject) * 1000) /1000 }
    if(not DoesCamExist(cam)) then
        createCam()
        --print("n2")
    end
    rot = false
    CamFocusObject()
    --print("n3")
    oldobjects = modifiedObjects
    RestackFurniture(oldobjects)
end

function selectObject(data,cb)
    --print("s1")
    if data == "none" then
        return
    end
    --print("s2")
    if DoesEntityExist(camball) then
        DeleteEntity(camball)
    end
    --print("s3")
    if DoesEntityExist(curObject) then
        DeleteEntity(curObject)
    end
    --print("s4")
    ResetVars()
    createNewObject(data)
    --print("s5")
    if(not DoesCamExist(cam)) then
        createCam()
    end 
    CamFocusObject()
    DoRotation()
    --print("s6")
    cb('ok')
end

function DoRotation()
    defhead = GetEntityHeading(curObject)
    reshead = GetEntityHeading(curObject)
    while rot do
        Citizen.Wait(1)
        defhead = defhead + 1.0
        if defhead > 360.0 then
            defhead = 0.0
        end
        SetEntityHeading(curObject,defhead)
    end
    SetEntityHeading(curObject,reshead)
    CamFocusObject()
end
delObj = 0

function DelSelectedObj(data, cb)
    if #modifiedObjects == 0 then
        return
    end

	if curObject == nil then
		curObject = modifiedObjects[delObj]["object"]
		table.remove(modifiedObjects,delObj)
	else
		for k,v in pairs(modifiedObjects) do
			if v["object"] == curObject then
				modifiedObjects[k] = nil
			end
		end
	end
    DeleteEntity(curObject)
    delObj = 0
    curObject = 0
    TriggerEvent("DoLongHudText","Object Deleted from Database.",2)
    updateDatabase(house_id,house_model)
    --cb('ok')
end


function prevObj()
    if #modifiedObjects == 0 then
        return
    end
    if #modifiedObjects < (delObj + 1) then
        delObj = 1
    else
        delObj = delObj + 1
    end
    curObject = modifiedObjects[delObj]["object"]
    CamFocusObject()
end


function nextObj()
    if #modifiedObjects == 0 then
        return
    end

    if delObj == 1 then
        delObj = #modifiedObjects
    else
        delObj = delObj - 1
    end
    --print("grabbing table id " .. delObj .. "? - current count of table is " .. #modifiedObjects)
    curObject = modifiedObjects[delObj]["object"]
    CamFocusObject()
end


function createNewObject(objType)
    --print("cn1")
    curObjectName = objType
    --print("Creating New Object")
    RequestModel(GetHashKey(objType))
    count = 6000
    TriggerEvent("DoLongHudText","Loading Model - please wait.",2)
    while not HasModelLoaded(GetHashKey(objType)) and count > 0 do
        count = count - 1
        Citizen.Wait(1)
    end  
    --print("cn2")
    if count == 0 then
        TriggerEvent("DoLongHudText","Error Loading",2)  
        return
    end
    TriggerEvent("DoLongHudText","Loaded",2)  

    crds = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)
    curObject = CreateObjectNoOffset(GetHashKey(objType),crds["x"],crds["y"],crds["z"],false, true, true)
    FreezeEntityPosition(curObject, true)
    if selected then
        --print("Start moving here")
    else
        --print("Stored as selected object")
    end
    --print("cn3")
end

function camOff()
    --print("Cam Disabled!")
    rot = false
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    DeleteEntity(camball)
end

function createCam()
    camOff()
	switchControl(false)
    --print("Cam Creating!")
    crds = GetOffsetFromEntityInWorldCoords(curObject, 0.0, -2.0, 0.5)

    if curObject == 0 then
        crds = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -2.0, 0.5)
    end
    
    camball = CreateObjectNoOffset(GetHashKey("prop_golf_ball"), crds, true, true, true)
    FreezeEntityPosition(camball,true)
    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamActive(cam,  true)
    RenderScriptCams(true,  false,  0,  true,  true)
    CamFocusObject()
end

function CamFocusObject()
    --print("Cam Focusing.!")
    crds = GetOffsetFromEntityInWorldCoords(curObject, 0.0, -2.0, 0.5)

    if curObject == 0 then
        crds = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -2.0, 0.5)
    end
    
    SetEntityCoords(camball,crds)
    SetCamCoord(cam, crds)
    SetCamRot(cam, 0.0, 0.0, GetEntityHeading(curObject))
    
end

Citizen.CreateThread(function()
    Citizen.Wait(3000)   
    while true do
        Citizen.Wait(1)
        if guiEnabled then
            TaskStandStill(PlayerPedId(),1.0)
			DrawIbuttons()
			CamControls()
        else
            Citizen.Wait(1500)
        end
    end
end)


function CamControls()

    if(DoesCamExist(cam)) then



        if curObject ~= 0 then
            d1,d2 = GetModelDimensions(GetEntityModel(curObject))
            top = GetOffsetFromEntityInWorldCoords(curObject, 0.0,0.0,d2["z"]+0.05)
            bot = GetOffsetFromEntityInWorldCoords(curObject, 0.0,0.0,d1["z"]-0.05)

            DrawMarker(2,top["x"],top["y"],top["z"], 0.0, 0.0, 0.0, 0, 0, 0, d1["x"] * 2, d2["y"] * 2, 0.035, 0,110,0 , 150, false, true, false, false)
            DrawMarker(2,bot["x"],bot["y"],bot["z"], 0.0, 0.0, 0.0, 0, 0, 0, d1["x"] * 2, d2["y"] * 2, -0.035, 0,110,0 , 150, false, true, false, false)

        end

		if IsControlPressed(1, Keys["RIGHTCTRL"]) then
			switchControl(not objectControl)
			Wait(400)
		end
		
        if objectControl then

            if IsControlPressed(1, Keys["Q"]) then
                rot = false
                crds = GetOffsetFromEntityInWorldCoords(curObject, 0.0, 0.0, 0.01)
                SetEntityCoords(curObject,crds)   
            end

            if IsControlPressed(1, Keys["E"]) then
                rot = false
                crds = GetOffsetFromEntityInWorldCoords(curObject, 0.0, 0.0, -0.01)
                SetEntityCoords(curObject,crds)
            end    

            if IsControlPressed(1, Keys["W"]) then
                rot = false
                crds = GetOffsetFromEntityInWorldCoords(curObject, 0.0, 0.01, 0.0)
                SetEntityCoords(curObject,crds)   
            end

            if IsControlPressed(1, Keys["S"]) then
                rot = false
                crds = GetOffsetFromEntityInWorldCoords(curObject, 0.0, -0.01, 0.0)
                SetEntityCoords(curObject,crds)
            end       

            if IsControlPressed(1, Keys["D"]) then
                rot = false
                crds = GetOffsetFromEntityInWorldCoords(curObject, 0.01, 0.0, 0.0)
                SetEntityCoords(curObject,crds)     
            end

            if IsControlPressed(1, Keys["A"]) then
                rot = false
                crds = GetOffsetFromEntityInWorldCoords(curObject, -0.01, 0.0, 0.0)
                SetEntityCoords(curObject,crds)   
            end 
            CheckObjectRotation(curObject, 0.0)
      
        else

            if IsControlPressed(1, Keys["Q"]) then
                rot = false
                crds = GetOffsetFromEntityInWorldCoords(camball, 0.0, 0.0, 0.1)
                SetEntityCoords(camball,crds) 
                SetCamCoord(cam, crds) 
            end

            if IsControlPressed(1, Keys["E"]) then
                rot = false
                crds = GetOffsetFromEntityInWorldCoords(camball, 0.0, 0.0, -0.1)
                SetEntityCoords(camball,crds)
                SetCamCoord(cam, crds)
            end    

            if IsControlPressed(1, Keys["W"]) then
                rot = false
                crds = GetOffsetFromEntityInWorldCoords(camball, 0.0, 0.1, 0.0)
                SetEntityCoords(camball,crds)
                SetCamCoord(cam, crds)  
            end

            if IsControlPressed(1, Keys["S"]) then
                rot = false
                crds = GetOffsetFromEntityInWorldCoords(camball, 0.0, -0.1, 0.0)
                SetEntityCoords(camball,crds)
                SetCamCoord(cam, crds)  
            end       

            if IsControlPressed(1, Keys["D"]) then
                rot = false
                crds = GetOffsetFromEntityInWorldCoords(camball, 0.1, 0.0, 0.0)
                SetEntityCoords(camball,crds)
                SetCamCoord(cam, crds)    

            end

            if IsControlPressed(1, Keys["A"]) then
                rot = false
                crds = GetOffsetFromEntityInWorldCoords(camball, -0.1, 0.0, 0.0)
                SetEntityCoords(camball,crds)
                SetCamCoord(cam, crds)  
            end 

            CheckInputRotation(cam, 0.0)

        end

    end

end
function CheckObjectRotation()
    rightAxisX = GetDisabledControlNormal(0, 220)
    rightAxisY = GetDisabledControlNormal(0, 221)
    if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        SetEntityHeading(curObject,GetEntityHeading(curObject) - rightAxisX * 2) 
    end
end
function CheckInputRotation(cam, zoomvalue)
    rightAxisX = GetDisabledControlNormal(0, 220)
    rightAxisY = GetDisabledControlNormal(0, 221)
    rotation = GetCamRot(cam, 2)
    if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        new_z = rotation.z
        SetEntityHeading(camball,GetEntityHeading(camball) - rightAxisX * 5)  
        new_x = rotation.x - rightAxisY * 5 -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
        SetCamRot(cam, new_x, 0.0, GetEntityHeading(camball), 2)
    end
end


function updateDatabase(house_id,house_model)
  --  curObject = 0
    --print("Updating " .. house_id .. " objects " .. #modifiedObjects)
    TriggerServerEvent("root_mobilya:saveToDatabase",house_id,modifiedObjects)
end

RegisterNetEvent("openFurnitureConfirm")
AddEventHandler("openFurnitureConfirm", function(house_id2,house_model2,furniture)
    house_id = house_id2
    house_model = house_model2
    oldobjects = modifiedObjects
    modifiedObjects = furniture
    if #furniture > 0 then
        RestackFurniture(oldobjects)
    end
    openGui()
end)

AddEventHandler("root_mobilya:openFurnitureMenu", function(house_id2)
	house_id = house_id2
	ESX.TriggerServerCallback("root_mobilya:requestMobilya",function(mobilya)
		mobilyaCame2(mobilya)
	end,house_id2)
end)

AddEventHandler("root_mobilya:placeFurnitures", function(property)
	house_id = house_id2
	ESX.TriggerServerCallback("root_mobilya:requestMobilya",function(mobilya)
		mobilyaCame(mobilya)
	end,property)
end)

function mobilyaCame2(mobilya)
	house_model = house_id2
	oldobjects = modifiedObjects
	if mobilya ~= nil and mobilya ~= "null" then
		modifiedObjects = mobilya
		if #mobilya > 0 then
			RestackFurniture(oldobjects)
		end
	else
		modifiedObjects = {}
	end
	openGui()
end

function mobilyaCame(mobilya)
	oldobjects = modifiedObjects
	if mobilya ~= nil and mobilya ~= "null" then
		modifiedObjects = mobilya
		if #mobilya > 0 then
			RestackFurniture(oldobjects)
		end
	else
		DeleteOldObjects(oldobjects)
	end
end

function DeleteOldObjects(oldobjects)
    for i = 1, #modifiedObjects do
        if oldobjects[i] ~= nil then
			--print(oldobjects[i])
			SetEntityAsMissionEntity(oldobjects[i]["object"])
            SetEntityAsNoLongerNeeded(oldobjects[i]["object"])
            SetEntityCoords(oldobjects[i]["object"],0.0,0.0,-20.0)
			DeleteEntity(oldobjects[i]["object"])
        end
    end
	modifiedObjects = {}
end

function RestackFurniture(oldobjects)
    for i = 1, #modifiedObjects do
        if oldobjects[i] ~= nil then
			--print(oldobjects[i])
			SetEntityAsMissionEntity(oldobjects[i]["object"])
            SetEntityAsNoLongerNeeded(oldobjects[i]["object"])
            SetEntityCoords(oldobjects[i]["object"],0.0,0.0,-20.0)
			DeleteEntity(oldobjects[i]["object"])
        end
        RequestModel(modifiedObjects[i]["hash"])
        count = 10000
        while not HasModelLoaded(modifiedObjects[i]["hash"]) and count > 0 do
            count = count - 1
            Citizen.Wait(1)
        end  
        modifiedObjects[i]["object"] = CreateObjectNoOffset(modifiedObjects[i]["hash"],modifiedObjects[i]["x"],modifiedObjects[i]["y"],modifiedObjects[i]["z"],false, true, true)
        FreezeEntityPosition(modifiedObjects[i]["object"],true)
        SetEntityCoords(modifiedObjects[i]["object"],modifiedObjects[i]["x"],modifiedObjects[i]["y"],modifiedObjects[i]["z"])
        SetEntityHeading(modifiedObjects[i]["object"],modifiedObjects[i]["heading"])
		curObject = modifiedObjects[i]["object"]
    end
end

Ibuttons = nil
function SetIbuttons(buttons, layout) --Layout: 0 - Horizontal, 1 - vertical
	Citizen.CreateThread(function()
		if not HasScaleformMovieLoaded(Ibuttons) then
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Ibuttons) do
				Citizen.Wait(10)
			end
		end
		sf = Ibuttons
		w,h = GetScreenResolution()
		PushScaleformMovieFunction(sf,"INSTRUCTIONAL_BUTTONS")
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_DISPLAY_CONFIG")
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PushScaleformMovieFunctionParameterFloat(0.02)
		PushScaleformMovieFunctionParameterFloat(0.98)
		PushScaleformMovieFunctionParameterFloat(0.02)
		PushScaleformMovieFunctionParameterFloat(0.98)
		PushScaleformMovieFunctionParameterBool(true)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_MAX_WIDTH")
		PushScaleformMovieFunctionParameterInt(1)
		PopScaleformMovieFunction()
		--PushScaleformMovieFunction(sf,"SET_BACKGROUND_COLOUR")
		--PushScaleformMovieFunctionParameterInt(0)
		--PushScaleformMovieFunctionParameterInt(0)
		--PushScaleformMovieFunctionParameterInt(0)
		--PushScaleformMovieFunctionParameterInt(100)
		--PopScaleformMovieFunction()
		
		for i,btn in pairs(buttons) do
			PushScaleformMovieFunction(sf,"SET_DATA_SLOT")
			PushScaleformMovieFunctionParameterInt(i-1)
			PushScaleformMovieFunctionParameterString(btn[1])
			PushScaleformMovieFunctionParameterString(btn[2])
			PopScaleformMovieFunction()
			
		end
		if layout ~= 1 then
			PushScaleformMovieFunction(sf,"SET_PADDING")
			PushScaleformMovieFunctionParameterInt(10)
			PopScaleformMovieFunction()
		end
		PushScaleformMovieFunction(sf,"DRAW_INSTRUCTIONAL_BUTTONS")
		PushScaleformMovieFunctionParameterInt(layout)
		PopScaleformMovieFunction()
	end)
end
function DrawIbuttons() -- Layout: 1 - vertical,0 - horizontal 
	if HasScaleformMovieLoaded(Ibuttons) then
		DrawScaleformMovie(Ibuttons, 0.5, 0.5, 1.0, 1.0, 255, 255, 255, 255)
	end
end















