
-- EDITED BY B1G --]]

ESX = nil
local has = false
local list = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tqrp_uber:pay')
AddEventHandler('tqrp_uber:pay', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if has then
		for i=1, #list, 1 do
			xPlayer.removeInventoryItem(list[i].itemname, list[i].quantity)
		end
	end
	xPlayer.addMoney(tonumber(amount))
	has = false
end)

ESX.RegisterServerCallback('tqrp_uber:GenerateList', function(source, cb)
	list = {}
	local Variety = math.random(1,5)
	for i=1, Variety, 1 do
		local randomItem = List[math.random(#List)]
		if not has_value(list, randomItem) then
			local quantity = math.random(1,randomItem.Max)
			local itemfound = ESX.GetItemLabel(randomItem.Name)
			table.insert(list, i, {itemname = randomItem.Name, itemfound = itemfound, quantity = quantity, Payout = randomItem.Payout})
		end
	end
	cb(list)
	
end)

ESX.RegisterServerCallback('tqrp_uber:HasEverything', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	for i=1, #list, 1 do
		if (xPlayer.getInventoryItem(list[i].itemname).count >= list[i].quantity) then
			has = true
		else
			has = false
			break
		end
	end
	cb(has)
end)

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end
