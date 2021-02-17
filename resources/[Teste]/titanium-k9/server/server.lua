ESX                = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Webhook = 'WEBHOOK_LINK'

local function SendHook(Name, Message)
	PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message}), {['Content-Type'] = 'application/json'})
end

Dogs = {
	["MissionRow"] = {
		{
			name = "Nobolso", 
			model = "a_c_shepherd",
			dogStats = {
				thirst = 100,
				hunger = 100,
				play = 100
			}, 
			isInHouse = true, 
			grade = 10
		},
		{
			name = "Atos", 
			model = "a_c_rottweiler", 
			dogStats = {
				thirst = 100,
				hunger = 100,
				play = 100
			},
			isInHouse = true, 
			grade = 2
		},
		{
			name = "Pimpek", 
			model = "a_c_rottweiler", 
			dogStats = {
				thirst = 100,
				hunger = 100,
				play = 100
			},
			isInHouse = true, 
			grade = 2
		},
		{
			name = "Rocky", 
			model = "a_c_chop",
			dogStats = {
				thirst = 100,
				hunger = 100,
				play = 100
			}, 
			isInHouse = true, 
			grade = 13
		},
	},
	["SandyShores"] = {
		{
			name = "Max", 
			model = "a_c_rottweiler", 
			dogStats = {
				thirst = 100,
				hunger = 100,
				play = 100
			},
			isInHouse = true, 
			grade = 2
		},
		{
			name = "Fifa", 
			model = "a_c_rottweiler", 
			dogStats = {
				thirst = 100,
				hunger = 100,
				play = 100
			},
			isInHouse = true, 
			grade = 2
		},
		{
			name = "Texas", 
			model = "a_c_rottweiler",
			dogStats = {
				thirst = 100,
				hunger = 100,
				play = 100
			}, 
			isInHouse = true, 
			grade = 2
		},
	},
	["BolingBroke"] = {
		{
			name = "Venator", 
			model = "a_c_chop",
			dogStats = {
				thirst = 100,
				hunger = 100,
				play = 100
			}, 
			isInHouse = true, 
			grade = 5
		},
	}
}

ESX.RegisterServerCallback("lspdk9:getDogs", function(source, cb, zone)
	cb(Dogs[zone])
end)

ESX.RegisterServerCallback("lspdk9:checkPlayerInventory", function(source, cb, target)
	local TxPlayer = ESX.GetPlayerFromId(target)

	local wq = TxPlayer.getInventoryItem('weed_pooch').count
	local wqS = TxPlayer.getInventoryItem('weed').count
	local mq = TxPlayer.getInventoryItem('meth_pooch').count
	local mqS = TxPlayer.getInventoryItem('meth').count
	local cq = TxPlayer.getInventoryItem('coke_pooch').count
	local cqS = TxPlayer.getInventoryItem('coke').count
	local oq = TxPlayer.getInventoryItem('opium_pooch').count
	local oqS = TxPlayer.getInventoryItem('opium').count

	if (wq > 0) or (wqS > 0) or (mq > 0) or (mqS > 0) or (cq > 0) or (cqS > 0) or (oq > 0) or (oqS > 0) then
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback("lspdk9:checkPlayerHasItem", function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)

	local wq = xPlayer.getInventoryItem(item).count

	if (wq > 0) then
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('lspdk9:searchCar', function(souce, cb, plate)
	local found = false

	MySQL.Async.fetchAll('SELECT * FROM trunk_inventory WHERE plate = @plate', {
		["@plate"] = plate
	}, function(result)
		if result[1] then
			local encoded = json.decode(result[1].data)

			local items = {}

			for i=1, #encoded.coffre, 1 do
				table.insert(items, {names = encoded.coffre[i].name, counts = encoded.coffre[i].count})
			end

			local count = 0
			for i=1, #items, 1 do
				count = count+1
				if (items[i].names == 'weed') or (items[i].names == 'weed_pooch') or (items[i].names == 'meth_pooch') or (items[i].names == 'meth') or (items[i].names == 'coke_pooch') or (items[i].names == 'opium') or (items[i].names == 'opium_pooch') then
					found = true
					break
				end
			end

			cb(found)
		else
			cb(found)
		end
	end)
end)

RegisterServerEvent('lspdk9:getDog')
AddEventHandler('lspdk9:getDog', function(doges, label, spawn)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer["job"]["name"] == 'police' then
		for i=1, #Dogs[label], 1 do
			if doges.name == Dogs[label][i].name then
				Dogs[label][i].isInHouse = false
				TriggerClientEvent('lspdk9:spawnDog', xPlayer.source, doges, label, spawn)
				SendHook('[LSPD K-9]', '__**'..GetPlayerName(xPlayer.source)..'**__ wziął jednostkę __**'..doges.name..'**__ na służbę!')
				break
			end
		end
	end
end)

RegisterServerEvent('lspdk9:returnDogHosp')
AddEventHandler('lspdk9:returnDogHosp', function(name, label, stats)
	local xPlayer = ESX.GetPlayerFromId(source)

	local xPlayers = ESX.GetPlayers()

	if xPlayer["job"]["name"] == 'police' then
		for i=1, #Dogs[label], 1 do
			if Dogs[label][i].name == name then
				Dogs[label][i].isInHouse = false
				Dogs[label][i].dogStats = stats
				SendHook('[LSPD K-9]', 'Trener: __**'..GetPlayerName(xPlayer.source)..'**__ Jednostka: __**'..name..'**__ trafiła w ciężkim stanie do szpitala!')
				break
			end
		end
	end


	for i=1, #xPlayers,1 do
		local xP = ESX.GetPlayerFromId(xPlayers[i])

		if xP["job"]["name"] == 'police' and xP["job"]["grade"] >= 10 then
			TriggerClientEvent('esx:showNotification', xP.source, '~b~K-9: ~o~'..name..' ~b~Trener: ~o~'..GetPlayerName(xPlayer.source)..'~b~ | ~r~Trafił do weterynaża w ciężkim stanie.')
		end
	end
end)

RegisterServerEvent('lspdk9:returnDog')
AddEventHandler('lspdk9:returnDog', function(name, label, stats)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer["job"]["name"] == 'police' then
		for i=1, #Dogs[label], 1 do
			if Dogs[label][i].name == name then
				Dogs[label][i].isInHouse = true
				Dogs[label][i].dogStats = stats
				SendHook('[LSPD K-9]', '__**'..GetPlayerName(xPlayer.source)..'**__ oddał jednostkę __**'..name..'**__ do kojca!')
				break
			end
		end
	end
end)

RegisterServerEvent('lspdk9:syncAnim')
AddEventHandler('lspdk9:syncAnim', function(target, lib, anim)
	TriggerClientEvent('lspdk9:syncAnim', target, lib, anim)
	SendHook('[LSPD K-9]', 'Trener: __**'..GetPlayerName(source)..'**__ Zlecił atak **K-9** na __**'..GetPlayerName(target)..'**__!')
end)

RegisterServerEvent('lspdk9:RequestStreamCoords')
AddEventHandler('lspdk9:RequestStreamCoords', function(target)
	TriggerClientEvent('lspdk9:startStreamCoords', target, source)
end)

RegisterServerEvent('lspdk9:StopStreamCoords')
AddEventHandler('lspdk9:StopStreamCoords', function()
	TriggerClientEvent('lspdk9:stopStreamCoords', target)
end)

RegisterServerEvent('lspdk9:StreamCoords')
AddEventHandler('lspdk9:StreamCoords', function(target, coords)
	TriggerClientEvent('lspdk9:respondToCoordsStream', target, coords)
end)