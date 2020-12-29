ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('Suppressor', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('Suppressor', 1)
    TriggerClientEvent('nfw_wep:silencieux', source)
end)

ESX.RegisterUsableItem('flashlight', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('flashlight', 1)
    TriggerClientEvent('nfw_wep:flashlight', source)
end)

ESX.RegisterUsableItem('grip', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('grip', 1)
    TriggerClientEvent('nfw_wep:grip', source)
end)

ESX.RegisterUsableItem('yusuf', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('yusuf', 1)
    TriggerClientEvent('nfw_wep:yusuf', source)
end)

ESX.RegisterUsableItem('SmallArmor', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('SmallArmor', 1)
    TriggerClientEvent('nfw_wep:SmallArmor', source)
end)

ESX.RegisterUsableItem('MedArmor', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('MedArmor', 1)
    TriggerClientEvent('nfw_wep:MedArmor', source)
end)

ESX.RegisterUsableItem('HeavyArmor', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('HeavyArmor', 1)
    TriggerClientEvent('nfw_wep:HeavyArmor', source)
end)

ESX.RegisterUsableItem('2ct_gold_chain', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('nfw_wep:FioOuro', source)
end)


RegisterNetEvent('returnItem')
AddEventHandler('returnItem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(item, 1)
end)