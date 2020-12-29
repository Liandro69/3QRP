ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('big_skills:checkChip')
AddEventHandler('big_skills:checkChip', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local oneQuantity = xPlayer.getInventoryItem('gym_membership').count

	if oneQuantity > 0 then
		TriggerClientEvent('big_skills:trueMembership', source) -- true
	else
		TriggerClientEvent('big_skills:falseMembership', source) -- false
	end
end)

--[[RegisterServerEvent('big_skills:trainChins')
AddEventHandler('big_skills:trainArms', function()
	TriggerEvent("big_skills:add", source, 2, "strength")
end)

RegisterServerEvent('big_skills:trainPushups')
AddEventHandler('big_skills:trainPushups', function()
	TriggerEvent("big_skills:add", source, 2, "strength")
end)

RegisterServerEvent('big_skills:trainYoga')
AddEventHandler('big_skills:trainYoga', function()
	TriggerEvent("big_skills:add", source, 1, "stamina")
end)

RegisterServerEvent('big_skills:trainSitups')
AddEventHandler('big_skills:trainSitups', function()
	TriggerEvent("big_skills:add", source, 1, "strength")
end)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

AddEventHandler('esx:playerLoaded', function(source)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM `big_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		print(skillInfo)
		print(skillInfo[1])
		print(skillInfo[1].stamina)
		if (skillInfo and skillInfo[1]) then
			TriggerClientEvent('big_skills:sendPlayerSkills', _source, skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].driving, skillInfo[1].shooting, skillInfo[1].drugs)
		else
			MySQL.Async.execute('INSERT INTO big_skills` (`identifier`, `strength`, `stamina`, `driving`, `shooting`, `drugs`) VALUES (@identifier, @strength, @stamina, @driving, @shooting, @drugs);',
				{
				['@identifier'] = xPlayer.identifier,
				['@strength'] = 0,
				['@stamina'] = 0,
				['@driving'] = 0,
				['@shooting'] = 0,
				['@drugs'] = 0
				}, function ()
			end)
			updatePlayerInfo(source)
		end
	end)
end)

function updatePlayerInfo(source)
	TriggerEvent("big_skills:get", source)
end

RegisterServerEvent("big_skills:add")
AddEventHandler("big_skills:add", function(source, amount, tipo)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx:showNotification', source, 'You became ~g~' .. round(amount, 2) .. '% ~s~better at handling ~y~' .. tipo .. '~s~!')
	MySQL.Async.fetchAll('SELECT @type FROM `big_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier, ['@type'] = tipo}, function(skillInfo)
		MySQL.Async.execute('UPDATE `big_skills` SET @type = @drugs WHERE `identifier` = @identifier',
			{
			['@drugs'] = (skillInfo[1].drugs + amount),
			['@type'] = tipo,
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("big_skills:get")
AddEventHandler("big_skills:get", function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM `big_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		if (skillInfo and skillInfo[1]) then
			TriggerClientEvent('big_skills:sendPlayerSkills', _source, skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].driving, skillInfo[1].shooting, skillInfo[1].drugs)
		end
	end)
end)]]

RegisterServerEvent("big_skills:addStress")
AddEventHandler("big_skills:addStress", function (value)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.job.name == "police" then -- Polis ise daha yarı yarıya stress ekleniyor, bu şekilde farklı meslekler ekleyebilirsiniz // if player is a police officer, he/she gaing half the stress, you can add different jobs using same method
			TriggerClientEvent("tqrp_status:add", _source, "stress", value/5)
		else
			TriggerClientEvent("tqrp_status:add", _source, "stress", value)
		end
	end
end)

RegisterServerEvent("big_skills:removeStress") -- stres azalttır // remove stress
AddEventHandler("big_skills:removeStress", function (source, value)
	TriggerClientEvent("tqrp_status:remove", source, "stress", value)
end)
