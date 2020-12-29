local logEnabled = true

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, type)
	TriggerEvent("tqrp_base:serverlog", "[ME]: "..text, source, GetCurrentResourceName())
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source, type)
end)