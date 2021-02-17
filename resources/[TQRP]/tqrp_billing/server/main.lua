ESX = nil

--[[]]

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tqrp_billing:sendBill')
AddEventHandler('tqrp_billing:sendBill', function(playerId, sharedAccountName, label, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	amount        = ESX.Math.Round(amount)
	local name = GetNameFromIdentifier(xPlayer.identifier)
	
	TriggerEvent('tqrp_addonaccount:getSharedAccount', sharedAccountName, function(account)
		if amount < 0 then
			print(('tqrp_billing: %s attempted to send a negative bill!'):format(xPlayer.identifier))
		elseif account == nil then
			if xTarget ~= nil then
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount, day, month, sender_name) VALUES (@identifier, @sender, @target_type, @target, @label, @amount, @day, @month, @sender_name)',
				{
					['@identifier']  = xTarget.identifier,
					['@sender']      = xPlayer.identifier,
					['@target_type'] = 'player',
					['@target']      = xPlayer.identifier,
					['@label']       = label,
					['@amount']      = amount,
					['@day']		 = os.date("%d"),
					['@month']		 = os.date("%m"),
					['@sender_name'] = name
				}, function(rowsChanged)
					TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'bill', text = _U('received_invoice'), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
				end)
			end

		else

			if xTarget ~= nil then
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount, day, month, sender_name) VALUES (@identifier, @sender, @target_type, @target, @label, @amount, @day, @month, @sender_name)',
				{
					['@identifier']  = xTarget.identifier,
					['@sender']      = xPlayer.identifier,
					['@target_type'] = 'society',
					['@target']      = sharedAccountName,
					['@label']       = label,
					['@amount']      = amount,
					['@day']		 = os.date("%d"),
					['@month']		 = os.date("%m"),
					['@sender_name'] = name
				}, function(rowsChanged)
					TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'bill', text = _U('received_invoice'), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
				end)
			end

		end
	end)

end)

ESX.RegisterServerCallback('tqrp_billing:getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local bills = {}
		for i=1, #result, 1 do
			table.insert(bills, {
				id         = result[i].id,
				identifier = result[i].identifier,
				sender     = result[i].sender,
				targetType = result[i].target_type,
				target     = result[i].target,
				label      = result[i].label,
				amount     = result[i].amount,
				day 	   = result[i].day,
				month	   = result[i].month
			})
		end
		cb(bills)
	end)
end)

ESX.RegisterServerCallback('tqrp_billing:getTargetBills', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local bills = {}
		for i=1, #result, 1 do
			table.insert(bills, {
				id         = result[i].id,
				identifier = result[i].identifier,
				sender     = result[i].sender,
				targetType = result[i].target_type,
				target     = result[i].target,
				label      = result[i].label,
				amount     = result[i].amount,
				day 	   = result[i].day,
				month	   = result[i].month
			})
		end

		cb(bills)
	end)
end)

ESX.RegisterServerCallback('tqrp_billing:getSocietyBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = ("society_" .. xPlayer.job.name)
	local bills = {}
	MySQL.Async.fetchAll('SELECT * FROM billing WHERE target = @target', {
		['@target'] = society
	}, function(result)
		for i=1, #result, 1 do
			table.insert(bills, {
				id         = result[i].id,
				identifier = result[i].identifier,
				sender     = result[i].sender,
				targetType = result[i].target_type,
				target     = result[i].target,
				label      = result[i].label,
				amount     = result[i].amount,
				day 	   = result[i].day,
				month	   = result[i].month
			})
		end
		cb(bills)
	end)
end)

ESX.RegisterServerCallback('tqrp_billing:getSpecialSocietyBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = ("society_" .. xPlayer.job.name)
	local bills = {}

	MySQL.Async.fetchAll('SELECT users.firstname, users.lastname, billing.label, billing.amount, billing.day, billing.month FROM billing INNER JOIN users WHERE billing.identifier = users.identifier AND billing.target = @target ORDER BY billing.month, billing.day DESC', 
	{ 
		['@target'] = society 

	}, function(results)
        cb(results)
    end)
end)


ESX.RegisterServerCallback('tqrp_billing:payBill', function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE id = @id', {
		['@id'] = id
	}, function(result)

		local sender     = result[1].sender
		local targetType = result[1].target_type
		local target     = result[1].target
		local amount     = result[1].amount

		local xTarget = ESX.GetPlayerFromIdentifier(sender)

		if targetType == 'player' then

			if xTarget ~= nil then

				if xPlayer.getMoney() >= amount then

					MySQL.Async.execute('DELETE from billing WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						xPlayer.removeMoney(amount)
						xTarget.addMoney(amount)
						TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'true', text = _U('paid_invoice', ESX.Math.GroupDigits(amount)), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
						TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'bill', text = _U('received_payment', ESX.Math.GroupDigits(amount)), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
						cb()
					end)

				elseif xPlayer.getBank() >= amount then

					MySQL.Async.execute('DELETE from billing WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						xPlayer.removeAccountMoney('bank', amount)
						xTarget.addAccountMoney('bank', amount)

						TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'true', text = _U('paid_invoice', ESX.Math.GroupDigits(amount)), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
						TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'bill', text = _U('received_payment', ESX.Math.GroupDigits(amount)), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
						
						cb()
					end)

				else
					TriggerClientEvent("pNotify:SendNotification", xTarget.source, {text = "<span style='font-weight: 300'>" .. _U('target_no_money') .. "</span>",
						layout = "centerLeft",
						timeout = 2000,
						progressBar = false,
						type = "error",
						animation = {
							open = "gta_effects_fade_in",
							close = "gta_effects_fade_out"
					}})
					TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = "<span style='font-weight: 300'>" .. _U('no_money') .. "</span>",
						layout = "centerLeft",
						timeout = 2000,
						progressBar = false,
						type = "error",
						animation = {
							open = "gta_effects_fade_in",
							close = "gta_effects_fade_out"
					}})	
					cb()
				end
			end

		else

			TriggerEvent('tqrp_addonaccount:getSharedAccount', target, function(account)

				if xPlayer.getMoney() >= amount then

					MySQL.Async.execute('DELETE from billing WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						xPlayer.removeMoney(amount)
						account.addMoney(amount)
						if xTarget ~= nil then
							TriggerClientEvent("pNotify:SendNotification", xTarget.source, {text = "<span style='font-weight: 300'>" .. _U('received_payment', ESX.Math.GroupDigits(amount)) .. "</span>",
								layout = "centerLeft",
								timeout = 2000,
								progressBar = false,
								type = "error",
								animation = {
									open = "gta_effects_fade_in",
									close = "gta_effects_fade_out"
							}})
						end

						cb()
					end)

				elseif xPlayer.getBank() >= amount then

					MySQL.Async.execute('DELETE from billing WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						xPlayer.removeAccountMoney('bank', amount)
						account.addMoney(amount)
						TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'true', text = _U('paid_invoice', ESX.Math.GroupDigits(amount)), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
						if xTarget ~= nil then
							TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'true', text = _U('received_payment', ESX.Math.GroupDigits(amount)), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
						end
						cb()
					end)

				else
					TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = "<span style='font-weight: 300'>" .. _U('no_money') .. "</span>",
						layout = "centerLeft",
						timeout = 2000,
						progressBar = false,
						type = "error",
						animation = {
							open = "gta_effects_fade_in",
							close = "gta_effects_fade_out"
					}})	
					if xTarget ~= nil then
						TriggerClientEvent("pNotify:SendNotification", xTarget.source, {text = "<span style='font-weight: 300'>" .. _U('target_no_money') .. "</span>",
							layout = "centerLeft",
							timeout = 2000,
							progressBar = false,
							type = "error",
							animation = {
								open = "gta_effects_fade_in",
								close = "gta_effects_fade_out"
						}})	
					end

					cb()
				end
			end)

		end

	end)
end)

function GetNameFromIdentifier(identifier)
	local _identifier = identifier
	local firstname, lastname = 'Desconhecido', ' '
	MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = _identifier
	}, function(result)
		if result[1].firstname ~= nil then
			firstname = result[1].firstname
			lastname = result[1].lastname
		end
	end)
	Wait(100)
	local name = firstname .. ' ' .. lastname
	return name
end