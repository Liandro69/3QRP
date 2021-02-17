ESX                = nil
local Vehicles = nil
local playersHealing = {}
local cuffed = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('tqrp_society:registerSociety', 'mechanic', 'mechanic', 'society_mechanic', 'society_mechanic', 'society_mechanic', {type = 'public'})
TriggerEvent('tqrp_society:registerSociety', 'mechanic2', 'mechanic2', 'society_mechanic2', 'society_mechanic2', 'society_mechanic2', {type = 'public'})
TriggerEvent('tqrp_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})
TriggerEvent('tqrp_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})
TriggerEvent('tqrp_society:registerSociety', 'sheriff', 'Sheriff', 'society_sheriff', 'society_sheriff', 'society_sheriff', {type = 'public'})

function setLog(text, source)
	local time = os.date("%d/%m/%Y %X")
	local name = GetPlayerName(source)
	local identifier = GetPlayerIdentifiers(source)
	local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "logmechanic.txt")
	while content == nil do
		Citizen.Wait(10)
	end
	local newContent = content .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), "logmechanic.txt", newContent, -1)
end

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

ESX.RegisterUsableItem("cuffs", function(source)
    TriggerClientEvent("tqrp_algemas:checkCuff", source)
end)

ESX.RegisterUsableItem("cuff_keys", function(source)
    TriggerClientEvent("tqrp_algemas:uncuff", source)
end)

RegisterServerEvent("tqrp_algemas:uncuff")
AddEventHandler("tqrp_algemas:uncuff",function(player)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if cuffed[player] then
        xPlayer.addInventoryItem("cuffs",1)
        cuffed[player]=false
        TriggerClientEvent('tqrp_algemas:forceUncuff', player)
    end
end)

RegisterServerEvent("tqrp_algemas:TryCuff")
AddEventHandler("tqrp_algemas:TryCuff",function(player)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem("cuffs",1)
	TriggerClientEvent('tqrp_algemas:TryCuff', player)
end)

RegisterServerEvent("tqrp_algemas:handcuff")
AddEventHandler("tqrp_algemas:handcuff",function()
    local _source = source
    cuffed[_source]=true
	TriggerClientEvent('tqrp_algemas:handcuff', _source)
end)

ESX.RegisterServerCallback("tqrp_algemas:isCuffed",function(source,cb,target)
    cb(cuffed[target]~=nil and cuffed[target])
end)

TriggerEvent('es:addGroupCommand', 'revive', 'admin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			TriggerClientEvent('tqrp_ambulancejob:revive', tonumber(args[1]))
		end
	else
		TriggerClientEvent('tqrp_ambulancejob:revive', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = _U('revive_help'), params = {{ name = 'id' }} })

RegisterServerEvent('tqrp_mechanicjob:refreshOwnedVehicle')
AddEventHandler('tqrp_mechanicjob:refreshOwnedVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)
			if vehicleProps.model == vehicle.model then
				print(vehicleProps.modLivery)
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = vehicleProps.plate,
					['@vehicle'] = json.encode(vehicleProps)
				})
			else
				print(('tqrp_mechanicjob: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)

RegisterServerEvent('tqrp_policejob:drag')
AddEventHandler('tqrp_policejob:drag', function(target)
  local _source = source
  TriggerClientEvent('tqrp_policejob:drag', target, _source)
end)

RegisterNetEvent('tqrp_policejob:putInVehicle')
AddEventHandler('tqrp_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
		TriggerClientEvent('tqrp_policejob:putInVehicle', target)
	else
		print(('tqrp_policejob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('tqrp_policejob:OutVehicle')
AddEventHandler('tqrp_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
		TriggerClientEvent('tqrp_policejob:OutVehicle', target)
	else
		print(('tqrp_policejob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

--[[RegisterServerEvent('tqrp_mechanicjob:update')
AddEventHandler('tqrp_mechanicjob:update', function()

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {}, function(result)
		for i=1, #result, 1 do
			local vehicle = json.decode(result[i].vehicle)
			print(vehicle)
			local plate = result[i].plate
			print(plate)
			vehicle.plate = plate
			print(vehicle.plate)
			local vehicleProps = vehicle
			print(vehicleProps)
			MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
				['@plate'] = plate,
				['@vehicle'] = json.encode(vehicleProps)
			})
		end
	end)
end)]]

RegisterServerEvent('tqrp_mechanicjob:setJob')
AddEventHandler('tqrp_mechanicjob:setJob', function(identifier,job,grade)
	local xTarget = ESX.GetPlayerFromIdentifier(identifier)	
		if xTarget then
			xTarget.setJob(job, grade)
		end
end)

RegisterServerEvent('tqrp_mechanicjob:buyMod')
AddEventHandler('tqrp_mechanicjob:buyMod', function(price)
	local _source = source
	price = tonumber(price)

	local societyAccount = nil
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'mechanic' then
		TriggerEvent('tqrp_addonaccount:getSharedAccount', 'society_mechanic', function(account)
			societyAccount = account
		end)
	elseif xPlayer.job.name == 'mechanic2' then
		TriggerEvent('tqrp_addonaccount:getSharedAccount', 'society_mechanic2', function(account)
			societyAccount = account
		end)
	end

	if price < societyAccount.money then
		TriggerClientEvent('tqrp_mechanicjob:installMod', _source)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'true', text = _U('purchased'), length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
		setLog('(Buy Mod)- ' .. price, _source)
		societyAccount.removeMoney(price)
	else
		TriggerClientEvent('tqrp_mechanicjob:cancelInstallMod', _source)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'false', text = _U('not_enough_money'), length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
	end

end)

RegisterServerEvent('tqrp_mechanicjob:buy')
AddEventHandler('tqrp_mechanicjob:buy', function(item, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'mechanic' then
		TriggerEvent('tqrp_addonaccount:getSharedAccount', 'society_mechanic', function(account)
			if account.money >= price then
				setLog('(Buy Item)- ' .. price, source)
				account.removeMoney(price)
				xPlayer.addInventoryItem(item, 1)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'A tua empresa não tem dinheiro suficiente', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
			end
		end)
	elseif xPlayer.job.name == 'mechanic2' then
		TriggerEvent('tqrp_addonaccount:getSharedAccount', 'society_mechanic2', function(account)
			if account.money >= price then
				setLog('(Buy Item)- ' .. price, source)
				account.removeMoney(price)
				xPlayer.addInventoryItem(item, 1)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'A tua empresa não tem dinheiro suficiente', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
			end
		end)
	end
	
end)


AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
	end
end)

--[[ESX.RegisterUsableItem('lockpickcar', function(source)
	local _source = source
	TriggerClientEvent('tqrp_mechanicjob:onHijack', _source)
end)]]

ESX.RegisterUsableItem('fixkit', function(source)
	local _source = source
	TriggerClientEvent('tqrp_mechanicjob:onFixkit', _source)
end)

ESX.RegisterUsableItem('carokit', function(source)
	local _source = source
	TriggerClientEvent('tqrp_mechanicjob:onCarokit', _source)
end)

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)
		playersHealing[source] = true
		TriggerClientEvent('tqrp_ambulancejob:useItem', source, 'medikit')
		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

--[[ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)
		--export['tqrp_base']:attachItem('xm_prop_x17_bag_med_01a')
		playersHealing[source] = true
		TriggerClientEvent('tqrp_ambulancejob:useItem', source, 'bandage')
		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)]]

ESX.RegisterServerCallback('tqrp_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(is_dead)
		if is_dead then
			print(('[AVISO] [COMBATLOG]: %s'):format(identifier))
		end

		cb(is_dead)
	end)
end)

ESX.RegisterServerCallback('tqrp_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

ESX.RegisterServerCallback('tqrp_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('tqrp_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('tqrp_ambulancejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		TriggerEvent('tqrp_addonaccount:getSharedAccount', 'society_ambulance', function(account)
			if account.money >= price then
				account.removeMoney(price)
				MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
					['@owner'] = xPlayer.identifier,
					['@vehicle'] = json.encode(vehicleProps),
					['@plate'] = vehicleProps.plate,
					['@type'] = type,
					['@job'] = xPlayer.job.name,
					['@stored'] = true
				}, function (rowsChanged)
					cb(true)
				end)
			else
				cb(false)
			end
		end)
	end
end)

ESX.RegisterServerCallback('tqrp_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('tqrp_ambulancejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

ESX.RegisterServerCallback('tqrp_mechanicjob:getVehiclesPrices', function(source, cb)
	if not Vehicles then
		MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)

ESX.RegisterServerCallback('tqrp_mechanicjob:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('tqrp_policejob:getOtherPlayerData', function(source, cb, target)

	local xPlayer = ESX.GetPlayerFromId(target)

	local identifier = GetPlayerIdentifiers(target)[1]

	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
		['@identifier'] = identifier
	})

	local firstname = result[1].firstname
	local lastname  = result[1].lastname
	local sex       = result[1].sex
	local dob       = result[1].dateofbirth
	local height    = result[1].height

	local data = {
		name      = GetPlayerName(target),
		job       = xPlayer.job,
		inventory = xPlayer.inventory,
		accounts  = xPlayer.accounts,
		weapons   = xPlayer.loadout,
		firstname = firstname,
		lastname  = lastname,
		sex       = sex,
		dob       = dob,
		height    = height
	}

	TriggerEvent('tqrp_status:getStatus', target, 'drunk', function(status)
		if status ~= nil then
			data.drunk = math.floor(status.percent)
		end
	end)

	if Config.EnableLicenses then
		TriggerEvent('tqrp_license:getLicenses', target, function(licenses)
			data.licenses = licenses
			cb(data)
		end)
	else
		cb(data)
	end

end)

ESX.RegisterServerCallback('tqrp_policejob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

RegisterServerEvent("Spikes:TriggerDeleteSpikes")
AddEventHandler("Spikes:TriggerDeleteSpikes", function(netid)
    TriggerClientEvent("Spikes:DeleteSpikes", -1, netid)
end)

function ShowPermis(source,identifier)
	local _source = source
	local licenses = MySQL.Sync.fetchAll("SELECT * FROM user_licenses where `owner`= @owner",{['@owner'] = identifier})
  
	  for i=1, #licenses, 1 do
  
		  if(licenses[i].type =="weapon")then
		   TriggerClientEvent('esx:notifyPl',_source,"Permis de port d'arme")
		  end
		  if(licenses[i].type =="dmv")then
			  TriggerClientEvent('esx:notifyPl',_source,"Code de la route")
		  end
		  if(licenses[i].type =="drive")then
			  TriggerClientEvent('esx:notifyPl',_source,"Permis de conduire")
		  end
		  if(licenses[i].type =="drive_bike")then
			 TriggerClientEvent('esx:notifyPl',_source,"Permis moto")
		  end
		  if(licenses[i].type =="drive_truck")then
			TriggerClientEvent('esx:notifyPl',_source,"Permis camion")
		  end
		  if(licenses[i].type =="hunt")then
			TriggerClientEvent('esx:notifyPl',_source,"Caça")
		  end
  
	  end
  
end

function deleteLicense(owner, license)
    MySQL.Sync.execute("DELETE FROM user_licenses WHERE `owner` = @owner AND `type` = @license", {
        ['@owner'] = owner,
        ['@license'] = license,
    })

end

function AddLicense(target, type, cb)
	local xPlayer = ESX.GetPlayerFromId(target)
	TriggerEvent('tqrp_license:CheckLicense', target, type, function(valid)
		if not valid then
			MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)',
			{
				['@type']  = type,
				['@owner'] = xPlayer.identifier
			},
			function(rowsChanged)
				if cb ~= nil then
					cb()
				end
			end)
		end
	end)
end

RegisterServerEvent('tqrp_mechanicjob:remove')
AddEventHandler('tqrp_mechanicjob:remove', function(item)
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)
end)

RegisterServerEvent('tqrp_policejob:license_see')
AddEventHandler('tqrp_policejob:license_see', function(target)

	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local identifier = GetPlayerIdentifiers(target)[1]
	TriggerClientEvent('esx:notifyPl', sourceXPlayer.source, '~b~'..targetXPlayer.name)
	ShowPermis(source,identifier)

end)

RegisterServerEvent('tqrp_policejob:deletelicense')
AddEventHandler('tqrp_policejob:deletelicense', function(target, license)
  local text = ""
  local sourceXPlayer = ESX.GetPlayerFromId(source)
  local targetXPlayer = ESX.GetPlayerFromId(target)

  if(license =="weapon")then
    text= "Uso e porte de arma"
  end
  if(license =="dmv")then
    text = "Código de condução"
  end
  if(license =="drive")then
    text= "Carta de Ligeiros"
  end
  if(license =="drive_bike")then
    text= "Carta de Motociclos"
  end
  if(license =="drive_truck")then
    text="Carta de Pesados"
  end
  if(license =="hunt")then
    text="Licença de Caça"
  end

    TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'true', text = "Habilitação removida : "..text, length = 2500})
	TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer.source, { type = 'false', text = "Habilitação removida : "..text, length = 2500})
	
  local identifier = GetPlayerIdentifiers(target)[1]
  deleteLicense(identifier,license)
end)

RegisterNetEvent('tqrp_policejob:addLicense')
AddEventHandler('tqrp_policejob:addLicense', function(target, type,cb)
  local text = "Erro!"
  local sourceXPlayer = ESX.GetPlayerFromId(source)
  local targetXPlayer = ESX.GetPlayerFromId(target)

  if(type =="weapon")then
    text= "Uso e porte de arma"
  end
  if(type =="dmv")then
    text = "Código de condução"
  end
  if(type =="drive")then
    text= "Carta de Ligeiros"
  end
  if(type =="drive_bike")then
    text= "Carta de Motociclos"
  end
  if(type =="drive_truck")then
    text="Carta de Pesados"
  end
  if(type =="hunt")then
    text="Licença de Caça"
  end
	
	TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'true', text = "Habilitação atribuída: "..text, length = 2500})
	TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer.source, { type = 'true', text = "Habilitação atribuída: "..text, length = 2500})
	AddLicense(target, type, cb)
end)

RegisterServerEvent('tqrp_ambulancejob:revive')
AddEventHandler('tqrp_ambulancejob:revive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('tqrp_ambulancejob:revive', target)
	else
		print(('tqrp_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('smerfikubrania:despir')
AddEventHandler('smerfikubrania:despir', function(target)
	TriggerClientEvent('smerfikubrania:despir', target)
end)

RegisterServerEvent('tqrp_ambulancejob:heal')
AddEventHandler('tqrp_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('tqrp_ambulancejob:heal', target, type)
	else
		print(('tqrp_ambulancejob: %s attempted to heal!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('tqrp_ambulancejob:removeItem')
AddEventHandler('tqrp_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem(item, 1)
end)

RegisterServerEvent('tqrp_ambulancejob:giveItem')
AddEventHandler('tqrp_ambulancejob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('tqrp_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage' and itemName ~= 'vicodin' and itemName ~= 'hydrocodone' and itemName ~= 'morphine') then
		print(('tqrp_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.canCarryItem(itemName, 1) then
		xPlayer.addInventoryItem(itemName, 1)
	end
end)

RegisterServerEvent('tqrp_ambulancejob:setDeathStatus')
AddEventHandler('tqrp_ambulancejob:setDeathStatus', function(is_dead)
	local identifier = GetPlayerIdentifiers(source)[1]
	if type(is_dead) ~= 'boolean' then
		print(('tqrp_ambulancejob: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET is_dead = @is_dead WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@is_dead'] = is_dead
	})
end)

RegisterServerEvent('tqrp_ambulancejob:firstSpawn')
AddEventHandler('tqrp_ambulancejob:firstSpawn', function()
	local _source    = source
	local identifier = GetPlayerIdentifiers(_source)[1]
	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier=@identifier',
	{
		['@identifier'] = identifier
	}, function(is_dead)
		if is_dead then
			print('[INFO] [' .. GetPlayerName(_source) .. '] [' .. identifier .. '] [COMBATLOG]')
			TriggerClientEvent('tqrp_ambulancejob:requestDeath', _source)
		end
	end)
end)

