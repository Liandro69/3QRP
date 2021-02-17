ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tqrp_hunting:reward')
AddEventHandler('tqrp_hunting:reward', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local item = 'carneveado'
    local itemlabel = 'Carne de Veado'
    
    if xPlayer ~= nil then
        xPlayer.addInventoryItem(item, amount)
        TriggerClientEvent('mythic_notify:notify', _source, 'success', 'Recebes-te x' .. amount .. ' ' .. itemlabel)
    end    
end)

ESX.RegisterServerCallback('tqrp_hunting:canCarry', function(source, cb, amount)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local item = 'carneveado'

    if xPlayer.canCarryItem(item, amount) then
        cb(true)
    else
        cb(false)
    end
end) 