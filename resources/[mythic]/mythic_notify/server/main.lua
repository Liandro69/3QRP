ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addCommand', 'adm', function()
end, {help = ''})


RegisterServerEvent('Notify:admNotifyCheck')
AddEventHandler('Notify:admNotifyCheck', function(args)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local group = xPlayer.getGroup()

	while group == nil do
		Citizen.Wait(0)
	end

	if (group == 'admin') or (group == 'superadmin') then
		TriggerEvent('Notify:adminNotifyAllPlayers', args, 'adm')
	end
end)

RegisterServerEvent('Notify:adminNotifyAllPlayers')
AddEventHandler('Notify:adminNotifyAllPlayers', function(ar, tp)
	local args = ar
	local tipo = tp
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayers[i], { type = tipo, text = args, length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
		TriggerClientEvent('InteractSound_CL:PlayOnOne', xPlayers[i], "demo", 0.3)
	end
end)

function AvisoRestart()
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayers[i], { type = "error", text = "TESTE", length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
		TriggerClientEvent('InteractSound_CL:PlayOnOne', xPlayers[i], "demo", 0.3)
	end
	
end

TriggerEvent('cron:runAt', 21, 02, AvisoRestart)

