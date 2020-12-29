ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'startanon', "superadmin", function(source, args, user)
	TriggerClientEvent("tqrp_broadcast:toggle", -1)
end)