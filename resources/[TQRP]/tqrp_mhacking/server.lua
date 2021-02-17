ESX= nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)


RegisterServerEvent('mchacking:additem')
AddEventHandler('mchacking:additem', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.addInventoryItem('bread', 5)

end)    
 