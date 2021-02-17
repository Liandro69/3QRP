ESX						= nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local using = {}

RegisterServerEvent('tqrp_saco:server:useBag')
AddEventHandler('tqrp_saco:server:useBag', function(Closest)
    if using[Closest] then
        TriggerClientEvent('tqrp_saco:client:removeBag', Closest)
        using[Closest] = false
    else
        TriggerClientEvent('tqrp_saco:client:putBag', Closest)
        using[Closest] = true
    end
end)

ESX.RegisterUsableItem("blindfold", function(source)
    local _source = source
    TriggerClientEvent('tqrp_saco:use', _source)
end)