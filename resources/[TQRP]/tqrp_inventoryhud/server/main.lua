ESX = nil
ServerItems = {}
itemShopList = {}
TriggerEvent(
	"esx:getSharedObject",
	function(obj)
		ESX = obj
	end
)

ESX.RegisterServerCallback("suku:getCustomShopItems", function(source, cb, shoptype, customInventory)
	itemShopList = {}
	local itemResult = MySQL.Sync.fetchAll('SELECT * FROM items')
	local itemInformation = {}
	for i=1, #itemResult, 1 do
		if itemInformation[itemResult[i].name] == nil then
			itemInformation[itemResult[i].name] = {}
		end
		itemInformation[itemResult[i].name].name = itemResult[i].name
		itemInformation[itemResult[i].name].label = itemResult[i].label
		itemInformation[itemResult[i].name].weight = itemResult[i].weight
		itemInformation[itemResult[i].name].rare = itemResult[i].rare
		itemInformation[itemResult[i].name].can_remove = itemResult[i].can_remove
		itemInformation[itemResult[i].name].price = itemResult[i].price
		if shoptype == "normal" then
			for _, v in pairs(customInventory.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end

		if shoptype == "weapon" then
			local weapons = customInventory.Weapons
			for _, v in pairs(customInventory.Weapons) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_weapon",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 0,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
			for _, v in pairs(customInventory.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
	end
	cb(itemShopList)
end)

RegisterNetEvent("suku:SellItemToPlayer")
AddEventHandler("suku:SellItemToPlayer",function(source, type, item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if type == "item_standard" then
		local targetItem = xPlayer.getInventoryItem(item)
		if xPlayer.canCarryItem(item, count) then
			local list = itemShopList
			for i = 1, #list, 1 do
				if list[i].name == item then
				end
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não consegues carregar mais nada no inventário!' })
		end
end
	if type == "item_weapon" then
		--[[local targetItem = xPlayer.getInventoryItem(item)
		if targetItem.count < 1 then
			local list = itemShopList
			for i = 1, #list, 1 do
				if list[i].name == item then
					local targetWeapon = xPlayer.hasWeapon(tostring(list[i].name))
					if not targetWeapon then
						local totalPrice = 1 * list[i].price
						if xPlayer.getMoney() >= totalPrice then
							xPlayer.removeMoney(totalPrice)
							xPlayer.addWeapon(list[i].name, list[i].ammo)
							TriggerEvent("tqrp_base:serverlog", "[BUYWEAPON]: ("..list[i].name .. ") x" .. list[i].ammo .. " $("..totalPrice..")", _source, GetCurrentResourceName())
							TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Compraste '..list[i].label })
						else
							TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens dinheiro suficiente!' })
						end
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You already own this weapon!' })
					end
				end
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Já tens essa arma!' })
		end]]
		if xPlayer.canCarryItem(item, count) then
			local list = itemShopList
			for i = 1, #list, 1 do
				if list[i].name == item then
					local totalPrice = count * list[i].price
					if xPlayer.getMoney() >= totalPrice then
						xPlayer.removeMoney(totalPrice)
						xPlayer.addInventoryItem(item, count)
						TriggerEvent("tqrp_base:serverlog", "[BUYITEM]: ("..item .. ") x" .. count .. " $("..totalPrice..")", _source, GetCurrentResourceName())
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Compraste '..count.." "..list[i].label })
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens dinheiro suficiente!' })
					end
				end
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não consegues carregar mais nada no inventário!' })
		end
	end

	if type == "item_ammo" then
		local targetItem = xPlayer.getInventoryItem(item)
		local list = itemShopList
		for i = 1, #list, 1 do
			if list[i].name == item then
				local targetWeapon = xPlayer.hasWeapon(list[i].weaponhash)
				if targetWeapon then
					local totalPrice = count * list[i].price
					local ammo = count * list[i].ammo
					if xPlayer.getMoney() >= totalPrice then
						xPlayer.removeMoney(totalPrice)
						TriggerClientEvent("suku:AddAmmoToWeapon", source, list[i].weaponhash, ammo)
						TriggerEvent("tqrp_base:serverlog", "[BUYAMMO]: ("..list[i].weaponhash .. ") x" .. ammo .. " $("..totalPrice..")", _source, GetCurrentResourceName())
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Compraste '..count.." "..list[i].label })
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens dinheiro suficiente!' })
					end
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens a arma para este tipo de munição!' })
				end
			end
		end
	end
end)
AddEventHandler('esx:playerLoaded', function (source)
	GetLicenses(source)
end)

function GetLicenses(source)
	TriggerEvent('tqrp_license:getLicenses', source, function (licenses)
		TriggerClientEvent('suku:GetLicenses', source, licenses)
	end)
end

RegisterServerEvent('suku:buyLicense')
AddEventHandler('suku:buyLicense', function ()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get('money') >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Compraste uma licença de armas!' })
		TriggerEvent('tqrp_license:addLicense', _source, 'weapon', function ()
			GetLicenses(_source)
		end)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens dinheiro suficiente!' })
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(10)
	MySQL.Async.fetchAll('SELECT * FROM items WHERE LCASE(name) LIKE \'%weapon_%\'', {}, function(results)
		for k, v in pairs(results) do
			ESX.RegisterUsableItem(v.name, function(source)
				TriggerClientEvent('conde-inventoryhud:useWeapon', source, v.name)
			end)
		end
	end)
end)

RegisterServerEvent('conde-inventoryhud:updateAmmoCount')
AddEventHandler('conde-inventoryhud:updateAmmoCount', function(hash, wepInfo)
	local player = ESX.GetPlayerFromId(source)
end)

ESX.RegisterServerCallback('conde-inventoryhud:getAmmoCount', function(source, cb, hash)
	local player = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM disc_ammo WHERE owner = @owner and hash = @hash', {
		['@owner'] = player.identifier,
		['@hash'] = hash
	}, function(results)
		if #results == 0 then
			local cbResult = {
				ammoCount = nil,
				attachments = {}
			}
			cb(cbResult)
		else
			local cbResult = {
				ammoCount = results[1].count,
				attachments = json.decode(results[1].attach)
			}
			cb(cbResult)
		end
	end)
end)

Citizen.CreateThread(function()
	for i = 1, #attach do
		ESX.RegisterUsableItem(attach[i], function(source)
			TriggerClientEvent("tqrp_inventoryhud:useAttach", source, attach[i])
		end)
	end
end)

ESX.RegisterServerCallback('GetCharacterNameServer', function(source, cb, target) -- GR10
    local xTarget = ESX.GetPlayerFromId(target)

    local result = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {
        ['@identifier'] = xTarget.identifier
    })

    local firstname = result[1].firstname
    local lastname  = result[1].lastname

    cb(''.. firstname .. ' ' .. lastname ..'')
end)
