ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("tqrp_alugabarco:pay")
AddEventHandler("tqrp_alugabarco:pay", function(price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeMoney(price)
end)