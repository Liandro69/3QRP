ESX = nil
local playersProcessing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('caruby_farm:sell')
AddEventHandler('caruby_farm:sell', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = config.items[itemName]
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

RegisterServerEvent('caruby_farm:pickedUp')
AddEventHandler('caruby_farm:pickedUp', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('graodecafe')
	local graodecafe = math.random(8, 12)
	if xPlayer.canCarryItem('graodecafe', graodecafe) then
		xPlayer.addInventoryItem(xItem.name, graodecafe)
	else		
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text =  "Não tens espaço no inventário!" })
	end	
end)

ESX.RegisterServerCallback('caruby_farm:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xPlayer.canCarryItem(item, 1) then
		cb(true)
	else
		cb(false)
	end
end)
ESX.RegisterServerCallback('caruby_farm:haveItem', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('sickle')

	if xItem.count >= 1 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('caruby_farm:process')
AddEventHandler('caruby_farm:process', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(3500, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xMin = xPlayer.getInventoryItem('graodecafe')
		
			if xMin.count >= 7 then
				--editado conde enquanto crafting nao esta a funcionar:
				xPlayer.removeInventoryItem('graodecafe', 7)
				if math.random(1, 10) >= 6 then
					xPlayer.addInventoryItem('fertilizer_25', 1)
				else
					xPlayer.addInventoryItem('highgradefert', 1)		
				end		
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

RegisterServerEvent('caruby_farm:cancelProcessing')
AddEventHandler('caruby_farm:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
