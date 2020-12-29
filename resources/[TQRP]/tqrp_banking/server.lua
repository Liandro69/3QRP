ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('orp:bank:deposit')
AddEventHandler('orp:bank:deposit', function(amount)
    local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('orp:bank:notify', _source, "error", "Quantidade inválida")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
		TriggerClientEvent('orp:bank:notify', _source, "success", "Deposito efetuado com sucesso de $" .. amount)
	end
end)

RegisterServerEvent('orp:bank:withdraw')
AddEventHandler('orp:bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local min = 0
	amount = tonumber(amount)
	min = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > min then
		TriggerClientEvent('orp:bank:notify', _source, "error", "Quantidade inválida")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('orp:bank:notify', _source, "success", "Levantamento efetuado com sucesso de $" .. amount)
	end
end)

RegisterServerEvent('orp:bank:balance')
AddEventHandler('orp:bank:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('orp:bank:info', _source, balance)
end)

RegisterServerEvent('orp:bank:transfer')
AddEventHandler('orp:bank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(to)
	local amount = amountt
	local balance = 0

	if(xTarget == nil or xTarget == -1) then
		TriggerClientEvent('orp:bank:notify', _source, "error", "NIB Inválido")
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = xTarget.getAccount('bank').money
		
		if tonumber(_source) == tonumber(to) then
			TriggerClientEvent('orp:bank:notify', _source, "success", "Transferência efetuada com sucesso: $" .. amount)
		else
			if balance <= 0 or balance < tonumber(amount) or tonumber(amount) <= 0 then
				TriggerClientEvent('orp:bank:notify', _source, "error", "You don't have enough money for this transfer")
			else
				xPlayer.removeAccountMoney('bank', tonumber(amount))
				xTarget.addAccountMoney('bank', tonumber(amount))
				TriggerClientEvent('orp:bank:notify', _source, "success", "Transferência efetuada com sucesso: $" .. amount)
				TriggerClientEvent('orp:bank:notify', to, "success", "Recebeste $" .. amount .. ' via transferencia bancária')
			end
		end
	end
end)