ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerDropped', function(source)
	TriggerEvent('tqrp_phone:removeSource', 'darknet', source)
end)

-- Oxygen Mask
ESX.RegisterUsableItem('oxygen_mask', function(source)
	TriggerClientEvent('tqrp_extraitems:oxygen_mask', source)
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('oxygen_mask', 1)
end)

-- Bullet-Proof Vest
ESX.RegisterUsableItem('bulletproof', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('tqrp_extraitems:bulletproof', source)
	xPlayer.removeInventoryItem('bulletproof', 1)
end)

-- First Aid Kit
ESX.RegisterUsableItem('firstaidkit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('tqrp_extraitems:firstaidkit', source)
	xPlayer.removeInventoryItem('firstaidkit', 1)
end)

-- Joint
ESX.RegisterUsableItem('joint', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('tqrp_extraitems:joint', source)
	xPlayer.removeInventoryItem('joint', 1)
end)

--Silenciador
ESX.RegisterUsableItem('Suppressor', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('tqrp_extraitems:Suppressor', source)

end)


