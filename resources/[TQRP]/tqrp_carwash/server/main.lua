ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Price = 25

RegisterServerEvent('tqrp_carwash:removeMoney')
AddEventHandler('tqrp_carwash:removeMoney', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    xPlayer.removeMoney(Price)

end)

ESX.RegisterServerCallback('tqrp_carwash:hasMoney', function(source, cb)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)

    if xPlayer.getMoney() >= Price then
        cb(true)
    else
        cb(false)
    end
end) 