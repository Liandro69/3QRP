RegisterNUICallback('CreateContact', function(data, cb)
    ESX.TriggerServerCallback('tqrp_phone:server:CreateContact', function(callback)
        cb(callback)
    end, data)
end)

RegisterNUICallback('EditContact', function( data, cb )
    ESX.TriggerServerCallback('tqrp_phone:server:EditContact', function(callback)
        cb(callback)
    end, data)
end)

RegisterNUICallback('DeleteContact', function(data, cb)
    ESX.TriggerServerCallback('tqrp_phone:server:DeleteContact', function(callback)
        cb(callback)
        if callback then
            exports['mythic_notify']:SendAlert('inform', 'Número Apagado! ('.. data.name .. ' | '.. data.number ..')')   
        end 
    end, data)
end)