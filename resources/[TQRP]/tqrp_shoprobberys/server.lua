ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local deadPeds = {}

--[[RegisterServerEvent('loffe_robbery:pedDead')
AddEventHandler('loffe_robbery:pedDead', function(store)
    if not deadPeds[store] then
        deadPeds[store] = 'deadlol'
        TriggerClientEvent('loffe_robbery:onPedDeath', -1, store)
        local second = 1000
        local minute = 60 * second
        local hour = 60 * minute
        local cooldown = Config.Shops[store].cooldown
        local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
        Wait(wait)
        if not Config.Shops[store].robbed then
            for k, v in pairs(deadPeds) do 
                if k == store then 
                    if DoesEntityExist(deadPeds) then
                        table.remove(deadPeds, k) 
                    end
                end 
            end
            TriggerClientEvent('loffe_robbery:resetStore', -1, store)
        end
    end
end)]]

RegisterServerEvent('loffe_robbery:handsUp')
AddEventHandler('loffe_robbery:handsUp', function(store)
    TriggerClientEvent('loffe_robbery:handsUp', -1, store)
end)

RegisterServerEvent('loffe_robbery:pickUp')
AddEventHandler('loffe_robbery:pickUp', function(store)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not Config.Shops[store].busy then
        Config.Shops[store].busy = true
        local randomAmount = math.random(Config.Shops[store].money[1], Config.Shops[store].money[2])
        xPlayer.addMoney(randomAmount)
    end
    TriggerEvent("tqrp_base:serverlog", "[SHOP_ROBBERY]: " .. source, source, GetCurrentResourceName())
    TriggerClientEvent('loffe_robbery:removePickup', source, store)
end)

ESX.RegisterServerCallback('loffe_robbery:canRob', function(source, cb, store, cops)
    local xPlayer = ESX.GetPlayerFromId(source)
    if cops >= Config.Shops[store].cops then
        if not Config.Shops[store].robbed and not deadPeds[store] and (xPlayer.job.name ~= 'police' or xPlayer.job.name ~= 'sheriff') then
            cb(true)
        else
            cb(false)
        end
    else
        cb('no_cops')
    end
end)

RegisterServerEvent('loffe_robbery:rob')
AddEventHandler('loffe_robbery:rob', function(store, ped)
    local src = source
    Config.Shops[store].robbed = true
    TriggerClientEvent('loffe_robbery:rob', -1, store, ped)
    Wait(Config.Shops[store].time)
    TriggerClientEvent('loffe_robbery:robberyOver', src)

    local second = 1000
    local minute = 60 * second
    local hour = 60 * minute
    local cooldown = Config.Shops[store].cooldown
    local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
    Wait(wait)
    Config.Shops[store].robbed = false
    Config.Shops[store].busy = false
    for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
    TriggerClientEvent('loffe_robbery:resetStore', -1, store)
end)

--[[Citizen.CreateThread(function()
    while true do
        for i = 1, #deadPeds do TriggerClientEvent('loffe_robbery:pedDead', -1, i) end -- update dead peds
        Citizen.Wait(1500)
    end
end)]]

RegisterServerEvent('loffe_robbery:alarm')
AddEventHandler('loffe_robbery:alarm', function(store)
    local src = source
    TriggerClientEvent('loffe_robbery:msgPolice', src, store, src)
end)