ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tqrp_outlawalert:GetMyName')
AddEventHandler('tqrp_outlawalert:GetMyName', function()
    local src = source
    local firstname = nil
    local identifier = GetPlayerIdentifiers(src)[1]
	MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1].firstname ~= nil then
			firstname = result[1].firstname
            lastname = result[1].lastname
        else
            firstname = 'Desconhecido'
            lastname = ''
		end
    end)

    while firstname == nil do
        Citizen.Wait(100)
    end

    TriggerClientEvent('tqrp_outlawalert:setMyName', src, firstname.." "..lastname)
end)

ESX.RegisterServerCallback('tqrp_outlawalert:isVehicleOwner', function(source, cb, plate)
    local owner = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate' , {
        ['@plate'] = plate
    }, function(result)
        if result[1] == owner then
            cb(true)
		else
			cb(false)
		end
	end)
end)

RegisterServerEvent('tqrp_outlawalert:Vangelico')
AddEventHandler('tqrp_outlawalert:Vangelico', function(job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    if job ~= nil then
        TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    end
end, false)

RegisterServerEvent('tqrp_outlawalert:houseRobberyinProgress')
AddEventHandler('tqrp_outlawalert:houseRobberyinProgress', function(job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    if job ~= nil then
        TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    end
end, false)

RegisterServerEvent('tqrp_outlawalert:gunshotInProgress')
AddEventHandler('tqrp_outlawalert:gunshotInProgress', function(job, job2, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    if job ~= nil then
        TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    end
    if job2 ~= nil then
        TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job2, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    end
end, false)

RegisterServerEvent('tqrp_outlawalert:drugsaleInProgress')
AddEventHandler('tqrp_outlawalert:drugsaleInProgress', function(job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    if job ~= nil then
        TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    end
end, false)

RegisterServerEvent('tqrp_outlawalert:shoprobberyInProgress')
AddEventHandler('tqrp_outlawalert:shoprobberyInProgress', function(job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    if job ~= nil then
        TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    end
end, false)

--

RegisterServerEvent('tqrp_outlawalert:carJackInProgress')
AddEventHandler('tqrp_outlawalert:carJackInProgress', function(job, job2, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    if job ~= nil and job2 ~= nil then
        TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
        TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job2, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    end
end, false)

--

RegisterServerEvent('tqrp_outlawalert:server:NewAlert')
AddEventHandler('tqrp_outlawalert:server:NewAlert', function(job, job2, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    if job ~= nil then
        TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    end
    if job2 ~= nil then
        TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job2, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    end
end, false)


RegisterServerEvent('tqrp_outlawalert:send911')
AddEventHandler('tqrp_outlawalert:send911', function(job, job2, job3, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local telele = xPlayer.getInventoryItem('phone').count
    if telele >= 1 then
	  if job ~= nil then
          TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
      end
      if job2 ~= nil then
          TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job2, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
      end
      if job3 ~= nil then
          TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job3, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
      end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'Não tens telemovel.'})  
    end
end, false)

RegisterServerEvent('tqrp_outlawalert:sendmecanicos')
AddEventHandler('tqrp_outlawalert:sendmecanicos', function(job, job2, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
	if job ~= nil then
        TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    end
	if job2 ~= nil then
        TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job2, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    end
end, false)

RegisterServerEvent('tqrp_outlawalert:sendPanic')
AddEventHandler('tqrp_outlawalert:sendPanic', function(job, job2, job3, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local telele = xPlayer.getInventoryItem('radio').count
    if telele >= 1 then
	  if job ~= nil and job2 ~= nil and job3 ~= nil then
          TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
          TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job2, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
          TriggerClientEvent('tqrp_outlawalert:NewAlert', -1, job3, title, desc, emote, emote2, number, x, y, z, blipID, color, code)
          TriggerClientEvent('tqrp_outlawalert:PlaySoundPanic', src)
      end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'Não tens rádio.'})
    end
end, false)


