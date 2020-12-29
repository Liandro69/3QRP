ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

itemprice, itemamount = 0, 0
--[[
RegisterNetEvent('np_selltonpc:dodeal')
AddEventHandler('np_selltonpc:dodeal', function(drugtype)
	local src = source

	-- Start with the most frequent drug.
	if drugtype == 'bagofdope' then
		itemprice = math.random(19,24)
		itemamount = math.random(1, 10)
	elseif drugtype == 'bagofmeth' then
		itemprice = math.random(36,40)
		itemamount = math.random(1, 5)
	end	
	elseif drugtype == 'meth' then
		itemprice = math.random(500,750)
		itemamount = math.random(1, 15)
	elseif drugtype == 'opium' then
		itemprice = math.random(750,1000)
		itemamount = math.random(1, 20)
	end
	
	local xPlayer = ESX.GetPlayerFromId(src)
    local inventoryamount = xPlayer.getInventoryItem(drugtype).count
	if inventoryamount == 1 then
		itemamount = 1
	elseif inventoryamount == 2 then
		itemamount = 2
	elseif inventoryamount == 3 then
		itemamount = 3
	end
			
	if inventoryamount >= itemamount then
		xPlayer.removeInventoryItem(drugtype, itemamount)
		local moneyamount = itemamount * itemprice
		xPlayer.addMoney(moneyamount)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Vendeste ' .. itemamount .. ' sacos por ' .. moneyamount ..' $', length = 4000 })
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Não tens droga suficiente para vender.', length = 5000, })
	end
end)



RegisterNetEvent('checkC')
AddEventHandler('checkC', function()
	local xPlayers = ESX.GetPlayers()
	local cops = 0
	for i=1, #xPlayers, 1 do
 	local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 	if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end
	TriggerClientEvent("checkC", source, cops)
end)
]]

local prices = {
	bagofdope = 30,
	bagofmeth = 78
}


ESX.RegisterServerCallback("tqrp_sellnpc:getItemsToSell", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local inventory = xPlayer.getInventory()
	local itemstosell = {}
	local empty = true
	local solditem = {}
	while inventory == nil do
		Citizen.Wait(100)
	end
	for key, value in pairs(inventory) do
		if (inventory[key].name == "bagofdope" and inventory[key].count > 0) or (inventory[key].name == "bagofmeth" and inventory[key].count > 0)  then
				empty = false
				table.insert(itemstosell, inventory[key])
		end
	end
	if empty == false then
		solditem = itemstosell[math.random(1, #itemstosell)]
		if solditem.name == "bagofdope" then
			solditem.price = prices.bagofdope
		elseif solditem.name == "bagofmeth" then
			solditem.price = prices.bagofmeth
		end
		cb(solditem)
	else
		cb(false)
	end
end)

--[[
RegisterNetEvent('checkD')
AddEventHandler('checkD', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		-- Since this is the only way to not make the server check for an item 4 times in a row

		if Config.EnableWeed then
			local weed = xPlayer.getInventoryItem('bagofdope').count
			if weed >= 1 then
				TriggerClientEvent("checkR", src, 'bagofdope')
				return
			end
		end

		if Config.EnableCoke then
			local coke = xPlayer.getInventoryItem('bagofmeth').count
			if coke >= 1 then
				TriggerClientEvent("checkR", src, 'bagofmeth')
				return
			end
		end

		if Config.EnableMeth then
			local meth = xPlayer.getInventoryItem('meth_pooch').count
			if meth >= 1 then
				TriggerClientEvent("checkR", src, 'meth')
				return
			end
		end

		if Config.EnableOpium then
			local opium = xPlayer.getInventoryItem('opium_pooch').count
			if opium >= 1 then
				TriggerClientEvent("checkR", src, 'opium')
				return
			end
		end

		-- If they have nothing of the above, do this...
		TriggerClientEvent("checkR", src, nil)
	end
end)]]


RegisterNetEvent("tqrp_sellnpc:removeitem")
AddEventHandler("tqrp_sellnpc:removeitem", function(item, count)
   	local xPlayer = ESX.GetPlayerFromId(source)
   	xPlayer.removeInventoryItem(item, count)
end)

RegisterNetEvent("tqrp_sellnpc:addmoney")
AddEventHandler("tqrp_sellnpc:addmoney", function(count)
   	local xPlayer = ESX.GetPlayerFromId(source)
   	xPlayer.addMoney(count)
end)



