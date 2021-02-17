ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local prices = {
	rolex = 525,
	anel = 800,
	pearl_b = 100,
	dia_box = 1800,
	gold_chain = 490,
	diamond = 1200
}


ESX.RegisterServerCallback("tqrp_runs:getItemsToSell", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local inventory = xPlayer.getInventory()
	local itemstosell = {}
	local empty = true
	local solditem = {}
	while inventory == nil do
		Citizen.Wait(100)
	end
	for key, value in pairs(inventory) do
		if (inventory[key].name == "anel" and inventory[key].count > 0) or (inventory[key].name == "rolex" and inventory[key].count > 0) or (inventory[key].name == "pearl_b" and inventory[key].count > 0) or (inventory[key].name == "dia_box" and inventory[key].count > 0)  or (inventory[key].name == "2ct_gold_chain" and inventory[key].count > 0) or (inventory[key].name == "diamond" and inventory[key].count > 0) then
				empty = false
				table.insert(itemstosell, inventory[key])
		end
	end
	if empty == false then
		solditem = itemstosell[math.random(1, #itemstosell)]
		if solditem.name == "rolex" then
			solditem.price = prices.rolex
		elseif solditem.name == "anel" then
			solditem.price = prices.anel
		elseif solditem.name == "pearl_b" then
			solditem.price = prices.pearl_b
		elseif solditem.name == "dia_box" then
			solditem.price = prices.dia_box
		elseif solditem.name == "2ct_gold_chain" then
			solditem.price = prices.gold_chain
		elseif solditem.name == "diamond" then
			solditem.price = prices.diamond
		end
		cb(solditem)
	else
		cb(false)
	end
end)

RegisterNetEvent("tqrp_runs:removeitem")
AddEventHandler("tqrp_runs:removeitem", function(item, count)
   	local xPlayer = ESX.GetPlayerFromId(source)
   	xPlayer.removeInventoryItem(item, count)
end)

RegisterNetEvent("tqrp_runs:addmoney")
AddEventHandler("tqrp_runs:addmoney", function(count)
   	local xPlayer = ESX.GetPlayerFromId(source)
   	xPlayer.addMoney(count)
end)



