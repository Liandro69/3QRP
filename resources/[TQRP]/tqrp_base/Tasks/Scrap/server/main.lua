ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local items = {
	'scrapmetal',
	'screw',
	'nai',
	'acidbat',
	'rope'
}

RegisterServerEvent('tqrp_civlife_illegalchop:success')
AddEventHandler('tqrp_civlife_illegalchop:success', function(pay, typo)
	local xPlayer = ESX.GetPlayerFromId(source)
	if typo == "money" then
		xPlayer.addMoney(pay)
	else
		local item = (items[math.random(#items)])
		if xPlayer.canCarryItem(item, pay) then
			xPlayer.addInventoryItem(item, pay)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'É muito pesado para ti' })
		end
	end
end)

ESX.RegisterServerCallback('tqrp_base:itemQtty', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.getInventoryItem(item).count)
end)