ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('lockpick', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("welldone_lockpick:open", xPlayer.source)
end)

TriggerEvent('es:addGroupCommand', 'lockpick', 'superadmin', function(source, args, user)
	TriggerClientEvent("welldone_lockpick:open", source)
end)

RegisterServerEvent('welldone_lockpick:add')
AddEventHandler('welldone_lockpick:add', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('lockpick', 1)
end)

RegisterServerEvent('welldone_lockpick:remove')
AddEventHandler('welldone_lockpick:remove', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('lockpick', 1)
end)