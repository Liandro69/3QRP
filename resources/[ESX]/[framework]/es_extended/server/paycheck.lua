ESX.StartPayCheck = function()

	function payCheck()
		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			local job     = xPlayer.job.grade_name
			local salary  = xPlayer.job.grade_salary

			if salary > 0 then
				if job == 'unemployed' then -- unemployed
					xPlayer.addAccountMoney('bank', salary)
					--TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_help', salary), 'CHAR_BANK_MAZE', 9)
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'money', text = _U('received_help', salary), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
				elseif Config.EnableSocietyPayouts then -- possibly a society
					TriggerEvent('tqrp_society:getSociety', xPlayer.job.name, function (society)
						if society ~= nil then -- verified society
							TriggerEvent('tqrp_addonaccount:getSharedAccount', society.account, function (account)
								if account.money >= salary then -- does the society money to pay its employees?
									xPlayer.addAccountMoney('bank', salary)
									account.removeMoney(salary)
									--TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
									TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'money', text = _U('received_help', salary), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
								else
									--TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), '', _U('company_nomoney'), 'CHAR_BANK_MAZE', 1)
									TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'money', text = _U('company_nomoney'), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
								end
							end)
						else -- not a society
							xPlayer.addAccountMoney('bank', salary)
							--TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
							TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'money', text = _U('received_help', salary), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
						end
					end)
				else -- generic job
					xPlayer.addAccountMoney('bank', salary)
					
					if Ayar.EnableAveiroLog and Ayar.PaycheckAveiroLog then
						
						local playerName = xPlayer.name
						local meslek = xPlayer.job.name
						local rutbe	= xPlayer.job.grade
						local maas = salary
						local zaman = os.date("%Y-%m-%d %H:%M:%S")
						
						MySQL.Async.execute('INSERT INTO aveirolog_paycheck (identifier, name, job, grade, salary, date) VALUES (@identifier, @name, @job, @grade, @salary, @date)',
						{
							['@identifier']	= xPlayer.identifier,
							['@name']	= playerName,
							['@job']	= meslek,
							['@grade']	= rutbe,
							['@salary']	= maas,
							['@date']	= zaman
						}, function(rowsChanged)
							--TriggerClientEvent('esx:showNotification', xPlayer.source, ("Aveiro Logs: Kaydedildi."))
						end)

					end -- EnableAveiroLog						
					
					--TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'money', text = _U('received_salary', salary), length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
				end
			end

		end

		SetTimeout(Config.PaycheckInterval, payCheck)

	end

	SetTimeout(Config.PaycheckInterval, payCheck)

end
