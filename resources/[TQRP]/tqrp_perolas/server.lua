ESX = nil
local playersProcessing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('fm_shell:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem(item, 1) then
		xPlayer.addInventoryItem(item, math.random(1,5))
		cb(true)
	 else
		TriggerClientEvent('esx:showNotification', source, _U('weed_inventoryfull'))
		cb(false)
	 end
end)

RegisterServerEvent('fm_pearl:sell')
AddEventHandler('fm_pearl:sell', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.items[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		return
	end

	if xItem.count < amount then
		return
	end

	price = ESX.Math.Round(price * amount)
	xPlayer.addMoney(price)

	xPlayer.removeInventoryItem(xItem.name, amount)

end)


RegisterServerEvent('fm_pearl:process')
AddEventHandler('fm_pearl:process', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(5000, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			xItem = xPlayer.getInventoryItem('shell_a')
			if xItem.count >= 5 then
				xPlayer.removeInventoryItem('shell_a', 5)
				xPlayer.addInventoryItem('pearl_b', math.random(2,5))
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Só fazemos isso com 5 perolas.', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
			end

			playersProcessing[_source] = nil
		end)
	end
end)

function CancelProcessing(playerID)
	if playersProcessing[playerID] then
		ESX.ClearTimeout(playersProcessing[playerID])
		playersProcessing[playerID] = nil
	end
end

RegisterServerEvent('fm_pearl:cancelProcessing')
AddEventHandler('fm_pearl:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
