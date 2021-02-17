ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('radialmenu:showJob')
AddEventHandler('radialmenu:showJob', function(target, job, grade)
	TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'inform', text = job .. '[ ' .. grade .. '€ ]', length = 3500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
end)

RegisterServerEvent('radialmenu:showMoney')
AddEventHandler('radialmenu:showMoney', function(target, money, black)
	if money ~= nil then
		TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'success', text = '[ ' .. money .. '€ ]', length = 3500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
	end
	if black ~= nil then
		TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'error', text = '[ ' .. black .. '€ ]', length = 3500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
	end
end)

RegisterServerEvent('radialmenu:seesociety')
AddEventHandler('radialmenu:seesociety', function(target, job)
	TriggerEvent('tqrp_addonaccount:getSharedAccount', ('society_' .. job), function(account) 
		if account ~= nil then
			TriggerClientEvent("ILRP_radialmenu:societyMoney",target,account.money)
		end
	end)
end)