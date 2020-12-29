ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tqrp_meth:start')
AddEventHandler('tqrp_meth:start', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('acetone').count >= 23 and xPlayer.getInventoryItem('lithium').count >= 14 and xPlayer.getInventoryItem('methlab').count >= 1 then
			TriggerClientEvent('tqrp_meth:startprod', _source)
			xPlayer.removeInventoryItem('acetone', 23)
			xPlayer.removeInventoryItem('lithium', 14)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Não tens material suficiente para produzir a metanfetamina!'})
	end
end)

RegisterServerEvent('tqrp_meth:stopf')
AddEventHandler('tqrp_meth:stopf', function(id)
local _source = source
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('tqrp_meth:stopfreeze', xPlayers[i], id)
	end
end)

RegisterServerEvent('tqrp_meth:make')
AddEventHandler('tqrp_meth:make', function(posx,posy,posz)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('methlab').count >= 1 then
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			TriggerClientEvent('tqrp_meth:smoke',xPlayers[i],posx,posy,posz, 'a') 
		end
	else
		TriggerClientEvent('tqrp_meth:stop', _source)
	end
end)

RegisterServerEvent('tqrp_meth:finish')
AddEventHandler('tqrp_meth:finish', function(qualtiy)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	print(qualtiy)
	if qualtiy < 20 then
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Fraca Produção!'})
	elseif qualtiy < 30 then
		xPlayer.addInventoryItem('meth', 1)
	else 
		xPlayer.addInventoryItem('meth', 2)	
	end	
	TriggerClientEvent('tqrp_meth:stop')
end)

RegisterServerEvent('tqrp_meth:blow')
AddEventHandler('tqrp_meth:blow', function(posx, posy, posz)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(_source)
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('tqrp_meth:blowup', xPlayers[i],posx, posy, posz)
	end
	xPlayer.removeInventoryItem('methlab', 1)
end)