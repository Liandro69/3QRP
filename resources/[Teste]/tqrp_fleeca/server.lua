ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Doors = {
    ["F1"] = {loc = vector3(-2956.68, 481.34, 15.70), txtloc = vector3(-2956.68, 481.34, 15.7), state = nil, locked = true},
    ["F2"] = {loc = vector3(1176.40, 2712.75, 38.09), txtloc = vector3(1176.40, 2712.75, 38.09), state = nil, locked = true}, 
--[[     ["F1"] = {loc = vector3(310.93, -284.44, 54.16), txtloc = vector3(310.93, -284.44, 54.16), state = nil, locked = true},
    ["F2"] = {loc = vector3(146.61, -1046.02, 29.37), txtloc = vector3(146.61, -1046.02, 29.37), state = nil, locked = true},
    ["F3"] = {loc = vector3(-1211.07, -336.68, 37.78), txtloc = vector3(-1211.07, -336.68, 37.78), state = nil, locked = true},
    ["F5"] = {loc = vector3(-354.15, -55.11, 49.04), txtloc = vector3(-354.15, -55.11, 49.04), state = nil, locked = true}, ]]
}

ESX.RegisterUsableItem('net_cracker', function(source)
    local _source  = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('tqrp_fleeca:usePen', _source)
end)
  

RegisterServerEvent("tqrp_fleeca:startcheck")
AddEventHandler("tqrp_fleeca:startcheck", function(bank)
    local _source = source
    local Players = ESX.GetPlayers()
    local xPlayer = ESX.GetPlayerFromId(_source)

    if not UTK.Banks[bank].onaction == true then
        if (os.time() - UTK.cooldown) > UTK.Banks[bank].lastrobbed then
                UTK.Banks[bank].onaction = true
                xPlayer.removeInventoryItem('net_cracker', 1)
                TriggerClientEvent("tqrp_fleeca:outcome", _source, true, bank)
        else
            TriggerClientEvent("tqrp_fleeca:outcome", _source, false, 'O cofre está vazio aguarda ate ao reabastecimento.', 60)
           -- TriggerClientEvent("tqrp_fleeca:outcome", _source, false, "O cofre está vazio aguarda até às "..math.floor((UTK.cooldown - (os.time() - UTK.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((UTK.cooldown - (os.time() - UTK.Banks[bank].lastrobbed)).. ' para o reabastecimento.', 60))
        end
    else
        TriggerClientEvent("tqrp_fleeca:outcome", _source, false, "O banco está a ser roubado!")
    end
end)

RegisterServerEvent("tqrp_fleeca:lootup")
AddEventHandler("tqrp_fleeca:lootup", function(var, var2, var3)
    TriggerClientEvent("tqrp_fleeca:lootup_c", -1, var, var2, var3)
end)

--[[  RegisterServerEvent("tqrp_fleeca:openDoor")
AddEventHandler("tqrp_fleeca:openDoor", function(coords, method)
    TriggerClientEvent("tqrp_fleeca:openDoor_c", -1, coords, method)
end)
 ]]
--[[ RegisterServerEvent("tqrp_fleeca:toggleDoor")
AddEventHandler("tqrp_fleeca:toggleDoor", function(key, state)
    Doors[key][1].locked = state
    TriggerClientEvent("tqrp_fleeca:toggleDoor", -1, key, state)
end) ]]

RegisterServerEvent('tqrp_fleeca:deleteDrill')
AddEventHandler('tqrp_fleeca:deleteDrill', function(coords)
    TriggerClientEvent('tqrp_fleeca:deleteDrillCl', -1, coords)
end)

RegisterServerEvent("tqrp_fleeca:toggleVault")
AddEventHandler("tqrp_fleeca:toggleVault", function(key, state)
    Doors[key].locked = state
    TriggerClientEvent("tqrp_fleeca:toggleVault", -1, key, state)
end)

RegisterServerEvent("tqrp_fleeca:updateVaultState")
AddEventHandler("tqrp_fleeca:updateVaultState", function(key, state)
    Doors[key].state = state
end)

RegisterServerEvent("tqrp_fleeca:startLoot")
AddEventHandler("tqrp_fleeca:startLoot", function(data, name, players)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local merteloele = xPlayer.getInventoryItem('drill').count
    if merteloele >= 1 then
      for i = 1, #players, 1 do
          TriggerClientEvent("tqrp_fleeca:startLoot_c", players[i], data, name)
      end
      TriggerClientEvent("tqrp_fleeca:startLoot_c", _source, data, name)
    else
      TriggerClientEvent('mythic_notify:client:SendAlert', source, { text = 'Não tens um martelo eletrico', type = 'error'})
    end  
end)


RegisterServerEvent("tqrp_fleeca:stopHeist")
AddEventHandler("tqrp_fleeca:stopHeist", function(name)
    TriggerClientEvent("tqrp_fleeca:stopHeist_c", -1, name)
end)

RegisterServerEvent("tqrp_fleeca:rewardCash")
AddEventHandler("tqrp_fleeca:rewardCash", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local reward = math.random(UTK.mincash, UTK.maxcash)

    xPlayer.addMoney(reward)

end)

RegisterServerEvent("tqrp_fleeca:rewardDrill")
AddEventHandler("tqrp_fleeca:rewardDrill", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(math.random(6000, 8000))
    xPlayer.addInventoryItem('lingot_gold', math.random(30, 50))
end)

RegisterServerEvent("tqrp_fleeca:setCooldown")
AddEventHandler("tqrp_fleeca:setCooldown", function(name)
    UTK.Banks[name].lastrobbed = os.time()
    UTK.Banks[name].onaction = false
    TriggerClientEvent("tqrp_fleeca:resetDoorState", -1, name)
end)

ESX.RegisterServerCallback("tqrp_fleeca:getBanks", function(source, cb)
    cb(UTK.Banks, Doors)
end)

ESX.RegisterServerCallback("tqrp_fleeca:checkSecond", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem("secure_card")["count"]

    if item >= 1 then
        xPlayer.removeInventoryItem("secure_card", 1)
        cb(true)
    else
        cb(false)
    end
end)