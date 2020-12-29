ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function setPropertyLocked(property)
	MySQL.Async.execute('UPDATE owned_properties SET locked = 0 WHERE name = @name', {
		['@name']    =	property
	},function(result)
		TriggerClientEvent("tqrp_property:requestDoorUpdate",-1)
	end)
end

function setPropertyUnlocked(property)
	MySQL.Async.execute('UPDATE owned_properties SET locked = 1 WHERE name = @name', {
		['@name']    =	property
	},function(result)
		TriggerClientEvent("tqrp_property:requestDoorUpdate",-1)
	end)
end

RegisterServerEvent("tqrp_property:lockDoor")
AddEventHandler("tqrp_property:lockDoor",function(name)
	setPropertyLocked(name)
end)

RegisterServerEvent("tqrp_property:unlockDoor")
AddEventHandler("tqrp_property:unlockDoor",function(name)
	setPropertyUnlocked(name)
end)

function GetProperty(name)
	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name == name then
			return Config.Properties[i]
		end
	end
end

function SetPropertyOwned(name, price, rented, owner)
	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = owner},function(result)
		if result[1] ~= nil then
			local identity = result[1]['firstname'] .." ".. result[1]['lastname']
			MySQL.Async.execute('INSERT INTO owned_properties (name, price, rented, owner, identity) VALUES (@name, @price, @rented, @owner, @identity)', {
				['@name']   = name,
				['@price']  = price,
				['@rented'] = (rented and 1 or 0),
				['@identity'] = identity,
				['@owner']  = owner
			}, function(rowsChanged)
				local xPlayer = ESX.GetPlayerFromIdentifier(owner)

				if xPlayer then
					TriggerClientEvent('tqrp_property:setPropertyOwned', xPlayer.source, name, true)

					if rented then
						TriggerClientEvent('esx:showNotification', xPlayer.source, _U('rented_for', ESX.Math.GroupDigits(price)))
					else
						TriggerClientEvent('esx:showNotification', xPlayer.source, _U('purchased_for', ESX.Math.GroupDigits(price)))
					end
				end
			end)
		end
	end)
end

function RemoveOwnedProperty(name, owner)
	MySQL.Async.execute('DELETE FROM owned_properties WHERE name = @name AND owner = @owner', {
		['@name']  = name,
		['@owner'] = owner
	}, function(rowsChanged)
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('tqrp_property:setPropertyOwned', xPlayer.source, name, false)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('made_property'))
			TriggerClientEvent("tqrp_property:requestUpdate",-1)
		end
	end)
end

ESX.RegisterServerCallback("tqrp_policejob:getMeNames",function(source,callback,ids)
    local identities = {}
    for k,v in pairs(ids) do
        local identifier = GetPlayerIdentifiers(v)[1]
        local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
        if result[1] ~= nil then
            local identity = result[1]
            identities[v] = identity['firstname'] .." ".. identity['lastname']
        end
    end
    callback(identities)
end)
function mysqlInit()
	init = true
	MySQL.Async.fetchAll('SELECT * FROM properties', {}, function(properties)

		for i=1, #properties, 1 do
			local entering  = nil
			local exit      = nil
			local inside    = nil
			local outside   = nil
			local isSingle  = nil
			local isRoom    = nil
			local isGateway = nil
			local roomMenu  = nil
			local chestLocation = nil
			local dressLocation = nil
			local tip = nil

			if properties[i].entering ~= nil then
				entering = json.decode(properties[i].entering)
			end

			if properties[i].exit ~= nil then
				exit = json.decode(properties[i].exit)
			end

			if properties[i].inside ~= nil then
				inside = json.decode(properties[i].inside)
			end
	
			if properties[i].type ~= nil then
				tip = properties[i].type
			end
			
			if properties[i].outside ~= nil then
				outside = json.decode(properties[i].outside)
			end

			if properties[i].is_single == 0 then
				isSingle = false
			else
				isSingle = true
			end

			if properties[i].is_room == 0 then
				isRoom = false
			else
				isRoom = true
			end

			if properties[i].is_gateway == 0 then
				isGateway = false
			else
				isGateway = true
			end

			if properties[i].room_menu ~= nil then
				roomMenu = json.decode(properties[i].room_menu)
			end
			
			if properties[i].chest_location ~= nil then
				chestLocation = json.decode(properties[i].chest_location)
			end

			if properties[i].dress_location ~= nil then
				dressLocation = json.decode(properties[i].dress_location)
			end

			table.insert(Config.Properties, {
				name      = properties[i].name,
				label     = properties[i].label,
				entering  = entering,
				exit      = exit,
				inside    = inside,
				outside   = outside,
				ipls      = json.decode(properties[i].ipls),
				gateway   = properties[i].gateway,
				isSingle  = isSingle,
				isRoom    = isRoom,
				isGateway = isGateway,
				roomMenu  = roomMenu,
				dressLocation = dressLocation,
				chestLocation = chestLocation,
				tip	  = tip,
				price     = properties[i].price
			})
		end

		TriggerClientEvent('tqrp_property:sendProperties', -1, Config.Properties)
	end)
end

init = false
MySQL.ready(function()
	mysqlInit()
end)


ESX.RegisterServerCallback('tqrp_property:getProperties', function(source, cb)
	cb(Config.Properties)
end)

AddEventHandler('tqrp_ownedproperty:getOwnedProperties', function(cb)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties', {}, function(result)
		local properties = {}

		for i=1, #result, 1 do
			table.insert(properties, {
				id     = result[i].id,
				name   = result[i].name,
				label  = GetProperty(result[i].name).label,
				price  = result[i].price,
				rented = (result[i].rented == 1 and true or false),
				owner  = result[i].owner
			})
		end

		cb(properties)
	end)
end)

AddEventHandler('tqrp_property:setPropertyOwned', function(name, price, rented, owner)
	SetPropertyOwned(name, price, rented, owner)
end)

AddEventHandler('tqrp_property:removeOwnedProperty', function(name, owner)
	RemoveOwnedProperty(name, owner)
end)

RegisterServerEvent('tqrp_property:rentProperty')
AddEventHandler('tqrp_property:rentProperty', function(propertyName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)
	local rent     = ESX.Math.Round(property.price / 200)

	SetPropertyOwned(propertyName, rent, true, xPlayer.getIdentifier())
end)

RegisterServerEvent('tqrp_property:changeLock')
AddEventHandler('tqrp_property:changeLock', function(propertyName)
	MySQL.Async.execute('DELETE FROM owned_keys WHERE name = @name', {
		['@name'] = propertyName
	},function()
		TriggerClientEvent("tqrp_property:requestUpdate",-1)
	end)
end)

RegisterServerEvent('tqrp_property:buyProperty')
AddEventHandler('tqrp_property:buyProperty', function(propertyName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)

	if property.price <= xPlayer.getMoney() then
		xPlayer.removeMoney(property.price)
		SetPropertyOwned(propertyName, property.price, false, xPlayer.getIdentifier())
		TriggerClientEvent("tqrp_property:requestUpdate",-1)
	else
		TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(15000)
	if init == false then
		mysqlInit()
	end
	TriggerClientEvent("tqrp_property:requestUpdate",-1)
end)

RegisterServerEvent('tqrp_property:removeOwnedProperty')
AddEventHandler('tqrp_property:removeOwnedProperty', function(propertyName)
	local xPlayer = ESX.GetPlayerFromId(source)
	RemoveOwnedProperty(propertyName, xPlayer.getIdentifier())
	TriggerClientEvent("tqrp_property:requestUpdate",-1)
end)

AddEventHandler('tqrp_property:removeOwnedPropertyIdentifier', function(propertyName, identifier)
	RemoveOwnedProperty(propertyName, identifier)
end)

RegisterServerEvent('tqrp_property:saveLastProperty')
AddEventHandler('tqrp_property:saveLastProperty', function(property)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Sync.execute('UPDATE users SET last_property = @last_property WHERE identifier = @identifier', {
		['@last_property'] = property,
		['@identifier']    = xPlayer.getIdentifier()
	})
end)

RegisterServerEvent('tqrp_property:deleteLastProperty')
AddEventHandler('tqrp_property:deleteLastProperty', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Sync.execute('UPDATE users SET last_property = NULL WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.getIdentifier()
	})
end)

RegisterServerEvent('tqrp_property:getItem')
AddEventHandler('tqrp_property:getItem', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		TriggerEvent('tqrp_addoninventory:getInventory', 'root_property', xPlayerOwner.identifier, function(inventory)
			local inventoryItem = inventory.getItem(item)

			-- is there enough in the property?
			if count > 0 and inventoryItem.count >= count then
			
				-- can the player carry the said amount of x item?
				if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
				else
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
					TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('not_enough_in_property'))
			end
		end)

	elseif type == 'item_account' then

		TriggerEvent('tqrp_addonaccount:getAccount', 'root_property_' .. item, xPlayerOwner.identifier, function(account)
			local roomAccountMoney = account.money

			if roomAccountMoney >= count then
				account.removeMoney(count)
				xPlayer.addAccountMoney(item, count)
			else
				TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
			end
		end)

	elseif type == 'item_weapon' then

		TriggerEvent('tqrp_datastore:getDataStore', 'root_property', xPlayerOwner.identifier, function(store)
			local storeWeapons = store.get('weapons') or {}
			local weaponName   = nil
			local ammo         = nil

			for i=1, #storeWeapons, 1 do
				if storeWeapons[i].name == item then
					weaponName = storeWeapons[i].name
					ammo       = storeWeapons[i].ammo

					table.remove(storeWeapons, i)
					break
				end
			end

			store.set('weapons', storeWeapons)
			xPlayer.addWeapon(weaponName, ammo)
		end)

	end
end)

RegisterServerEvent('tqrp_property:giveKey')
AddEventHandler('tqrp_property:giveKey', function(target, name)
	local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.execute('INSERT INTO owned_keys (identifier, name) VALUES (@name, @price)', {
		['@name']   = xPlayer.getIdentifier(),
		['@price']  = name,
	},function()
		TriggerClientEvent("tqrp_property:requestUpdate",-1)
	end)
end)


ESX.RegisterServerCallback('tqrp_property:getOwnedProperties', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE owner = @owner', {
		['@owner'] = xPlayer.getIdentifier()
	}, function(ownedProperties)
		local properties = {}
	

		for i=1, #ownedProperties, 1 do
			table.insert(properties, {name=ownedProperties[i].name,owner=ownedProperties[i].identity})
		end

		cb(properties)
	end)
end)

ESX.RegisterServerCallback('tqrp_property:getKeyHolds', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_keys WHERE identifier = @owner', {
		['@owner'] = xPlayer.getIdentifier()
	}, function(ownedProperties)
		local properties = {}
	

		for i=1, #ownedProperties, 1 do
			table.insert(properties, {name=ownedProperties[i].name})
		end

		cb(properties)
	end)
end)

ESX.RegisterServerCallback('tqrp_property:getOwnedPropertiesAll', function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties', {}, function(ownedProperties)
		local properties = {}
		for i=1, #ownedProperties, 1 do
			table.insert(properties, {name=ownedProperties[i].name,ownerid=ownedProperties[i].owner,owner=ownedProperties[i].identity,locked=ownedProperties[i].locked})
		end
		cb(properties)
	end)
end)

ESX.RegisterServerCallback('tqrp_property:getLastProperty', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT last_property FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.getIdentifier()
	}, function(users)
		cb(users[1].last_property)
	end)
end)

ESX.RegisterServerCallback('tqrp_property:getPropertyInventory', function(source, cb, owner)
	local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
	local blackMoney = 0
	local items      = {}
	local weapons    = {}

	TriggerEvent('tqrp_addonaccount:getAccount', 'property_black_money', xPlayer.getIdentifier(), function(account)
		blackMoney = account.money
	end)

	TriggerEvent('tqrp_addoninventory:getInventory', 'property', xPlayer.getIdentifier(), function(inventory)
		items = inventory.items
	end)

	TriggerEvent('tqrp_datastore:getDataStore', 'root_property', xPlayer.getIdentifier(), function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = weapons
	})
end)

ESX.RegisterServerCallback('tqrp_property:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local blackMoney = xPlayer.getAccount('black_money').money
	local items      = xPlayer.inventory

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = xPlayer.getLoadout()
	})
end)

ESX.RegisterServerCallback('tqrp_property:getPlayerDressing', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('tqrp_datastore:getDataStore', 'root_property', xPlayer.getIdentifier(), function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback('tqrp_property:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('tqrp_datastore:getDataStore', 'root_property', xPlayer.getIdentifier(), function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterServerEvent('tqrp_property:removeOutfit')
AddEventHandler('tqrp_property:removeOutfit', function(label)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('tqrp_datastore:getDataStore', 'root_property', xPlayer.getIdentifier(), function(store)
		local dressing = store.get('dressing') or {}

		table.remove(dressing, label)
		store.set('dressing', dressing)
	end)
end)

function PayRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE rented = 1', {}, function (result)
		for i=1, #result, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)

			-- message player if connected
			if xPlayer then
				xPlayer.removeAccountMoney('bank', result[i].price)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_rent', ESX.Math.GroupDigits(result[i].price)))
			else -- pay rent either way
				MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE identifier = @identifier', {
					['@bank']       = result[i].price,
					['@identifier'] = result[i].owner
				})
			end

			TriggerEvent('tqrp_addonaccount:getSharedAccount', 'society_realestateagent', function(account)
				account.addMoney(result[i].price)
			end)
		end
	end)
end

RegisterServerEvent('root_property:getItem')
AddEventHandler('root_property:getItem', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		TriggerEvent('tqrp_addoninventory:getInventory', 'root_property', xPlayerOwner.identifier, function(inventory)
			local inventoryItem = inventory.getItem(item)

			-- is there enough in the property?
			if count > 0 and inventoryItem.count >= count then
			
				-- can the player carry the said amount of x item?
				if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
				else
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
					TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('not_enough_in_property'))
			end
		end)

	elseif type == 'item_account' then

		TriggerEvent('tqrp_addonaccount:getAccount', 'root_property_' .. item, xPlayerOwner.identifier, function(account)
			local roomAccountMoney = account.money

			if roomAccountMoney >= count then
				account.removeMoney(count)
				xPlayer.addAccountMoney(item, count)
			else
				TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
			end
		end)

	elseif type == 'item_weapon' then

		TriggerEvent('tqrp_datastore:getDataStore', 'root_property', xPlayerOwner.identifier, function(store)
			local storeWeapons = store.get('weapons') or {}
			local weaponName   = nil
			local ammo         = nil

			for i=1, #storeWeapons, 1 do
				if storeWeapons[i].name == item then
					weaponName = storeWeapons[i].name
					ammo       = storeWeapons[i].ammo

					table.remove(storeWeapons, i)
					break
				end
			end

			store.set('weapons', storeWeapons)
			xPlayer.addWeapon(weaponName, ammo)
		end)

	end

end)

RegisterServerEvent('root_property:putItem')
AddEventHandler('root_property:putItem', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('tqrp_addoninventory:getInventory', 'root_property', xPlayerOwner.identifier, function(inventory)
				xPlayer.removeInventoryItem(item, count)
				inventory.addItem(item, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_deposited', count, inventory.getItem(item).label))
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('invalid_quantity'))
		end

	elseif type == 'item_account' then

		local playerAccountMoney = xPlayer.getAccount(item).money

		if playerAccountMoney >= count and count > 0 then
			xPlayer.removeAccountMoney(item, count)

			TriggerEvent('tqrp_addonaccount:getAccount', 'root_property' .. item, xPlayerOwner.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
		end

	elseif type == 'item_weapon' then

		TriggerEvent('tqrp_datastore:getDataStore', 'root_property', xPlayerOwner.identifier, function(store)
			local storeWeapons = store.get('weapons') or {}

			table.insert(storeWeapons, {
				name = item,
				ammo = count
			})

			store.set('weapons', storeWeapons)
			xPlayer.removeWeapon(item)
		end)

	end

end)

ESX.RegisterServerCallback('root_property:getPropertyInventory', function(source, cb, owner)
	local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
	local blackMoney = 0
	local items      = {}
	local weapons    = {}

	TriggerEvent('tqrp_addonaccount:getAccount', 'root_property_black_money', xPlayer.getIdentifier(), function(account)
		blackMoney = account.money
	end)

	TriggerEvent('tqrp_addoninventory:getInventory', 'root_property', xPlayer.getIdentifier(), function(inventory)
		items = inventory.items
	end)

	TriggerEvent('tqrp_datastore:getDataStore', 'root_property', xPlayer.getIdentifier(), function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = weapons
	})
end)

ESX.RegisterServerCallback('root_property:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local blackMoney = xPlayer.getAccount('black_money').money
	local items      = xPlayer.inventory

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = xPlayer.getLoadout()
	})
end)

ESX.RegisterServerCallback('root_property:getPlayerDressing', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('tqrp_datastore:getDataStore', 'property', xPlayer.getIdentifier(), function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback('root_property:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('tqrp_datastore:getDataStore', 'property', xPlayer.getIdentifier(), function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterServerEvent('root_property:removeOutfit')
AddEventHandler('root_property:removeOutfit', function(label)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('tqrp_datastore:getDataStore', 'property', xPlayer.getIdentifier(), function(store)
		local dressing = store.get('dressing') or {}

		table.remove(dressing, label)
		store.set('dressing', dressing)
	end)
end)



RegisterServerEvent('putIn')
AddEventHandler('putIn', function(name,label,entering,inside,ipl,isSingle,isRoom,roommenu,price,chest_location,dress_location)
	local _source = source
	MySQL.Async.execute('INSERT INTO properties (name,label,entering,`exit`,inside,outside,ipls,is_single,is_room,room_menu,price,chest_location,dress_location) VALUES (@name,@label,@entering,@exit,@inside,@outside,@ipl,@isSingle,@isRoom,@roommenu,@price,@chest_location,@dress_location)',
	{
		['@name'] = name,
		['@label'] = name,
		['@entering'] = entering,
		['@exit'] = inside,
		['@inside'] = inside,
		['@outside'] = entering,
		['@ipl'] = ipl,
		['@isSingle'] = isSingle,
		['@isRoom'] = isRoom,
		['@roommenu'] = roommenu,
		['@price'] = price,
		['@chest_location'] = chest_location,
		['@dress_location'] = dress_location		
	}, function (rowsChanged)
		TriggerClientEvent("tqrp_property:requestUpdate",-1)
		TriggerClientEvent('esx:showNotification', _source, 'House Added = Name:'..name..'    Price:'..price)
	end)
end)

ESX.RegisterServerCallback("root_evekle:grupver",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		cb(xPlayer.getGroup())
	else
		cb("user")
	end
end)

RegisterServerEvent("root_mobilya:saveToDatabase")
AddEventHandler("root_mobilya:saveToDatabase",function(house_id,objectsTable)
	print(house_id,objectsTable)
	MySQL.Async.execute('UPDATE owned_properties SET objects_table = @objects_table WHERE name = @name', {
		['@name']    =	house_id,
		['@objects_table']    =	json.encode(objectsTable)
	},function(result)
		TriggerClientEvent("root_mobilya:requestMobilyaUpdate",-1)
	end)
end)

ESX.RegisterServerCallback("root_mobilya:requestMobilya",function(player,cb,property)
	MySQL.Async.fetchAll('SELECT objects_table FROM owned_properties WHERE name = @name', {
		['@name'] = property
	}, function(ownedProperties)
		if ownedProperties[1] ~= nil and ownedProperties[1].objects_table ~= nil then
			cb(json.decode(ownedProperties[1].objects_table))
		else
			cb(nil)
		end
	end)
end)

ESX.RegisterServerCallback("root_mobilya:checkMoney",function(player,cb,price)
	local xPlayer = ESX.GetPlayerFromId(player)
	if xPlayer then
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)
			cb(true)
		else
			cb(false)
		end
	else
		cb(false)
	end
end)
