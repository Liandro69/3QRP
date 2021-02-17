ESX.RegisterUsableItem('simcard', function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = GetPlayerIdentifiers(src)[1]
    local myPhoneNumber = nil
    
    xPlayer.removeInventoryItem('simcard', 1)
    myPhoneNumber = getPhoneRandomNumber()
    Citizen.Wait(10)
    MySQL.Async.insert("UPDATE users SET phone_number = @myPhoneNumber WHERE identifier = @identifier", { 
        ['@myPhoneNumber'] = myPhoneNumber,
        ['@identifier'] = identifier
    }, function()
        TriggerClientEvent("tqrp_phone:client:UpdateData", src)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'success', text = 'Novo número: '.. myPhoneNumber})
    end)
end)