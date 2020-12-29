ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('joca_fuel:pay')
AddEventHandler('joca_fuel:pay', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	local amount = ESX.Math.Round(price)

	if price > 0 then
		xPlayer.removeMoney(amount)
	end
end)

-- Added by Joca
RegisterServerEvent('joca_fuel:giveItem')
AddEventHandler('joca_fuel:giveItem', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('WEAPON_PETROLCAN', 1)
end)

RegisterServerEvent('joca_fuel:removeItem')
AddEventHandler('joca_fuel:removeItem', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('WEAPON_PETROLCAN', 1)
end)

--ESX.RegisterUsableItem('WEAPON_PETROLCAN', function(source)
--		TriggerClientEvent('joca_fuel:useJerryCan', source)
--end)
