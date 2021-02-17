
RegisterServerEvent('tqrp_phone:server:RefreshBills')
AddEventHandler("tqrp_phone:server:RefreshBills", function()
    local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.getIdentifier()
	}, function(result)
		local bills = {}
		for i=1, #result, 1 do
			table.insert(bills, {
				id         = result[i].id,
				sender     = result[i].sender_name,
				label      = result[i].label,
				amount     = result[i].amount,
				day 	   = result[i].day,
				month	   = result[i].month			
			})
		end
		TriggerClientEvent('tqrp_phone:client:SetupData', src, {
			{ name = 'faturas', data = bills }
		})
	end)
end)


ESX.RegisterServerCallback("tqrp_phone:server:payBill", function(source, cb, data)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE id = @id', {
		['@id'] = data.id
	}, function(result)
		if result ~= nil then
			local sender     = result[1].sender
			local targetType = result[1].target_type
			local target     = result[1].target
			local amount     = result[1].amount

			local xTarget = ESX.GetPlayerFromIdentifier(sender)

			if targetType == 'player' then

				if xTarget ~= nil then

					if xPlayer.getMoney() >= amount then

						MySQL.Async.execute('DELETE from billing WHERE id = @id', {
							['@id'] = data.id
						}, function(rowsChanged)
							xPlayer.removeMoney(amount)
							xTarget.addMoney(amount)
							TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'bill', text = "Pagamento Recebido " .. ESX.Math.GroupDigits(amount).. " Euros", length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
							cb(true)
						end)

					elseif xPlayer.getBank() >= amount then

						MySQL.Async.execute('DELETE from billing WHERE id = @id', {
							['@id'] = data.id
						}, function(rowsChanged)
							xPlayer.removeAccountMoney('bank', amount)
							xTarget.addAccountMoney('bank', amount)

							TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'bill', text = "Pagamento Recebido " .. ESX.Math.GroupDigits(amount).. " Euros", length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
							
							cb(true)
						end)

					else
						cb(-1)
					end
				end
			else

				TriggerEvent('tqrp_addonaccount:getSharedAccount', target, function(account)

					if xPlayer.getMoney() >= amount then

						MySQL.Async.execute('DELETE from billing WHERE id = @id', {
							['@id'] = data.id
						}, function(rowsChanged)
							if rowsChanged > 0 then
								xPlayer.removeMoney(amount)
								account.addMoney(amount)
								if xTarget ~= nil then
									TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'true', text = "Pagamento Recebido " .. ESX.Math.GroupDigits(amount).. " Euros", length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
								end

								cb(true)
							else
								cb(-3)
							end
						end)

					elseif xPlayer.getBank() >= amount then

						MySQL.Async.execute('DELETE from billing WHERE id = @id', {
							['@id'] = data.id
						}, function(rowsChanged)
							if rowsChanged > 0 then
								xPlayer.removeAccountMoney('bank', amount)
								account.addMoney(amount)
								if xTarget ~= nil then
									TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'true', text = "Pagamento Recebido " .. ESX.Math.GroupDigits(amount).. " Euros", length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
								end
								cb(true)
							else
								cb(-3)
							end
						end)

					else
						cb(-1)
					end
				end)

			end
		else
			cb(-3)
		end
	end)
end)