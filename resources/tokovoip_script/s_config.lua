TokoVoipConfig = {
	channels = {
		{name = "DPLS", subscribers = {}},
		{name = "SEM", subscribers = {}},
		{name = "DPLS/SEM", subscribers = {}},
		{name = "SO", subscribers = {}},
		{name = "DPLS/SO", subscribers = {}}
	}
};

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('toko:getGroup')
AddEventHandler('toko:getGroup', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == "superadmin" then
		TriggerClientEvent('toko:setGroup', source, "STAFF")
	else
		TriggerClientEvent('toko:setGroup', source, "JOGADOR")
	end
end)
