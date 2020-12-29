ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tqrp_barbershop:pay')
AddEventHandler('tqrp_barbershop:pay', function()

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeMoney(Config.Price)
end)

ESX.RegisterServerCallback('tqrp_barbershop:checkMoney', function(source, cb)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.get('money') >= Config.Price then
		cb(true)
	else
		cb(false)
	end

end)
