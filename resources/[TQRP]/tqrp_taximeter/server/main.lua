ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tqrp_taximeter:updatePassenger')
AddEventHandler('tqrp_taximeter:updatePassenger', function(targetID, data, now)
	local _source 	 = ESX.GetPlayerFromId(targetID).source
  TriggerClientEvent('tqrp_taximeter:newValue', _source, data, now)
end)