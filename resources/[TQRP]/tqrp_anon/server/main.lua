ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'anon', "superadmin", function(source, args, user)
	TriggerClientEvent("tqrp_anon:start", source)
end)