RegisterServerEvent('disc-vehicles:checkKey')
AddEventHandler('disc-vehicles:checkKey', function(vehicle, plate)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
        ['@identifier'] = player.identifier,
        ['@plate'] = plate
    }, function(results)
        TriggerClientEvent('disc-vehicles:setKey', player.source, vehicle, #results > 0)
    end)
end)