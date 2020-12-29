

local robbableItemsCommon= { -- MATERIAIS E COISAS BANAIS DE CRIME QUE VALEM POUCO - ACTUALIZADO 28/05/2020
    [1] = {chance = 1, id = 'nail', name = 'Prego', quantity = math.random(4, 8)},
    [2] = {chance = 1, id = 'fixkit', name = 'Kit Reparação', quantity = 1},
    [3] = {chance = 4, id = 'scrapmetal', name = 'Aluminio', quantity = math.random(5,7)},
    [4] = {chance = 2, id = 'trimmedweed', name = 'Weed', quantity = math.random(5,10)},
    [5] = {chance = 3, id = 'screw', name = 'Parafusos', quantity = math.random(4,8)},
    [6] = {chance = 3, id = '2ct_gold_chain', name = '2CT Corrente Ouro', quantity = math.random(1,3)},
    [7] = {chance = 5, id = 'cuffs', name = 'Algemas', quantity = 1},
    [8] = {chance = 4, id = 'bagofdope', name = 'Saco de Erva', quantity = math.random(5,10)},
    [9] = {chance = 4, id = 'blowtorch', name = 'Saco de Erva', quantity = 1},
    [10] = {chance = 5, id = 'cuff_keys', name = 'Chave Algemas', quantity = 1},
    [11] = {chance = 4, id = 'screwdriver', name = 'Gancho', quantity = math.random(1,2)},
    [12] = {chance = 6, id = 'cabplastico', name = 'Faca de Pesca', quantity = 1},
	[13] = {chance = 6, id = 'cabomadeira', name = 'Faca de Pesca', quantity = 1},
	[14] = {chance = 6, id = 'Pentrite', name = 'Faca de Pesca', quantity = math.random(2,4)},
    [15] = {chance = 6, id = 'blowtorch', name = 'Maçarico', quantity = 1},
    [16] = {chance = 6, id = 'cabplastico', name = 'Faca de Pesca', quantity = 1},
    [17] = {chance = 5, id = 'batteri', name = 'Tecido', quantity = math.random(5,8)},
    [18] = {chance = 10, id = 'disc_ammo_pistol', name = 'Munição', math.random(2,4)},
    [19] = {chance = 9, id = 'rolex', name = 'Relógio Rolex', quantity = 1},
    [20] = {chance = 6, id = 'fishingknife', name = 'Faca de Pesca', quantity = 1},
    [21] = {chance = 4, id = 'bobbypin', name = 'Gancho', quantity = math.random(2,3)},
    [22] = {chance = 4, id = 'screwdriver', name = 'Gancho', quantity = math.random(2,3)},
    [23] = {chance = 4, id = 'fabric', name = 'Saco de Erva', quantity = math.random(2,4)},
    [24] = {chance = 8, id = 'copper', name = 'Munição x15', quantity = math.random(3,6)},


}

local robbableItemsRare= { -- MATERIAIS DE CRAFT DO CRIME - ACTUALIZADO 28/05/2020
    [1] = {chance = 4, id = 'arma_mola', name = 'Gancho', quantity = 1},
    [2] = {chance = 4, id = 'arma_percurssor', name = 'Chave de Fendas', quantity = 1},
    [3] = {chance = 10, id = 'armacaodb', name = 'Tec-9', quantity = 1},
    [4] = {chance = 10, id = 'tec9_body', name = 'Tec-9', quantity = 1},
    [5] = {chance = 6, id = 'arma_cao', name = 'Faca de Pesca', quantity = 1},
    [6] = {chance = 6, id = 'arma_armacaopistola', name = 'Faca de Pesca', quantity = 1},
    [7] = {chance = 6, id = 'massademira', name = 'Faca de Pesca', quantity = 1},
    [8] = {chance = 4, id = 'arma_gatilho', name = 'Saco de Erva', quantity = 1},
    [9] = {chance = 10, id = 'WEAPON_SNSPISTOL', name = 'Heckler&Koch P7M10', quantity = 1},
    [10] = {chance = 8, id = 'WEAPON_KNIFE', name = 'Extintor', quantity = 1},
    [11] = {chance = 8, id = 'arma_cano', name = 'Extintor', quantity = 1},
    [12] = {chance = 8, id = 'Pentrite', name = 'Extintor', quantity = math.random(5,10)},

}

local robbableItemsSuperRare= { -- ARMAS DE CORPO A CORPO, ALGUMAS COISAS DO CRIME
    [1] = {chance = 8, id = 'highgradefemaleseed', name = 'Semente Fêmea (AQ)', quantity = math.random(1,4)},
    [2] = {chance = 8, id = 'copper', name = 'Munição x15', quantity = math.random(8,10)},
    [3] = {chance = 9, id = 'SmallArmor', name = 'Colete Leve', quantity = 1},
    [4] = {chance = 8, id = 'medikit', name = 'Lanterna', quantity = math.random(1,2)},
    [5] = {chance = 9, id = 'rolex', name = 'Relógio Rolex', quantity = math.random(2,4)},
	[6] = {chance = 10, id = 'disc_ammo_pistol', name = 'Munição', quantity = 4},
    [7] = {chance = 9, id = 'WEAPON_BOTTLE', name = 'Garrafa de vidro', quantity = 1},
	[8] = {chance = 10, id = 'bagofdope', name = 'Faca', quantity = math.random(10,14)},
	[9] = {chance = 8, id = 'Pentrite', name = 'Blueprint: Machete', quantity = math.random(5,8)},
	[10] = {chance = 6, id = 'fishingknife', name = 'Faca de Pesca', quantity = math.random(1,2)},
    [11] = {chance = 6, id = 'WEAPON_BAT', name = 'Garrafa', quantity = 1},
    [12] = {chance = 10, id = 'WEAPON_GOLFCLUB', name = 'Faca', quantity = 1},
    [13] = {chance = 8, id = 'WEAPON_KNIFE', name = 'Extintor', quantity = 1},
    [14] = {chance = 10, id = 'disc_ammo_smg', name = 'Heckler&Koch P7M10', quantity = 1},
    [15] = {chance = 6, id = 'WEAPON_PISTOL', name = 'Machete', quantity = 1},
    [16] = {chance = 6, id = 'WEAPON_MACHINEPISTOL', name = 'Machete', quantity = 1},
    [17] = {chance = 6, id = 'WEAPON_HEAVYPISTOL', name = 'Machete', quantity = 1},
    [18] = {chance = 8, id = 'nail', name = 'Blueprint: Machete', quantity = 1}, --
    [19] = {chance = 10, id = 'recipe_WEAPON_MACHETE', name = 'Receita Vaso', quantity = 1}, --
    [20] = {chance = 10, id = 'drill', name = 'Receita Vaso', quantity = math.random(1,3)}, --
}

local robbableItemsUltraRare= { -- BLUEPRINTS DE ARMAS; COISAS MUITO RARAS OU QUE VALEM MUITO - RODAR 15 a 15 dias
    [1] = {chance = 10, id = 'WEAPON_PISTOL', name = 'Heckler&Koch P7M10', quantity = 1},     --RODAR SE QUISER MUITO
    [2] = {chance = 10, id = 'weed_brick', name = 'Tijolo Haxixe', quantity = 1},
    [3] = {chance = 6, id = 'disc_ammo_pistol', name = 'Machete', quantity = math.random(5,10)},
	[4] = {chance = 9, id = 'rolex', name = 'Relógio Rolex', quantity = math.random(10,20)},
	[5] = {chance = 6, id = 'WEAPON_MINISMG', name = 'Skorpion', quantity = 1},
	[6] = {chance = 6, id = 'bagofmeth', name = 'Machete', quantity = math.random(2,4)},
    [7] = {chance = 6, id = 'lockpick', name = 'Machete', quantity = math.random(10,15)}, --RODAR PARA UMA BLUEPRINT IMPORTANTE
    [8] = {chance = 10, id = 'advancedlockpick', name = 'Receita Vaso', quantity = 1}, --
    [9] = {chance = 10, id = 'WEAPON_DBSHOTGUN', name = 'Receita Vaso', quantity = 1}, --
}


TriggerEvent('esx:getSharedObject', function(obj)
 ESX = obj
end)

ESX.RegisterUsableItem('advancedlockpick', function(source) --Hammer high time to unlock but 100% call cops
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 TriggerClientEvent('houseRobberies:attempt', source, xPlayer.getInventoryItem('advancedlockpick').count)
end)

TriggerEvent('es:addCommand', 'arrombar', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'police' then
        TriggerClientEvent('houseRobberies:policeattempt', source)
    end
end)


RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 xPlayer.removeInventoryItem('advancedlockpick', 1)
 --TriggerClientEvent('chatMessage', source, '^1Your lockpick has bent out of shape')
 --TriggerClientEvent('notification', source, 'Teu lockpick esta torto.', 2)
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 local cash = math.random(2000, 3000)
 xPlayer.addMoney(cash)
 --TriggerClientEvent('chatMessage', source, '^4You have found $'..cash)
 --TriggerClientEvent('notification', source, 'You found $'..cash)
end)

RegisterServerEvent('houseRobberies:server:search')
AddEventHandler('houseRobberies:server:search', function(id, table)
 TriggerClientEvent('houseRobberies:client:search', -1, id, table)
end)

RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function(id)
 local source = tonumber(source)
 local item = {}
 local xPlayer = ESX.GetPlayerFromId(source)
 local gotID = {}
 local itemchance = math.random(1,100)
    if itemchance == 1 then
        item = robbableItemsUltraRare[math.random(1, #robbableItemsUltraRare)]     --item[32]
        xPlayer.addInventoryItem(item.id, item.quantity)
    elseif itemchance <= 7 then
        item = robbableItemsSuperRare[math.random(1, #robbableItemsSuperRare)]
        xPlayer.addInventoryItem(item.id, item.quantity)
    elseif itemchance <= 24 then
        item = robbableItemsRare[math.random(1, #robbableItemsRare)]
        xPlayer.addInventoryItem(item.id, item.quantity)
    elseif itemchance <= 90 then
        item = robbableItemsCommon[math.random(1, #robbableItemsCommon)]
        xPlayer.addInventoryItem(item.id, item.quantity)
    else
        xPlayer.addMoney(math.random(120,220))
    end
end)
