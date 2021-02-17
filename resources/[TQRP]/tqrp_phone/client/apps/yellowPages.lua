RegisterNUICallback( 'NewYellowPages', function( data, cb )
    ESX.TriggerServerCallback('tqrp_phone:server:NewYellowPages', function(callback)
        cb(callback)
    end, data) 
end)

RegisterNetEvent('tqrp_phone:client:RecieveNewYellow')
AddEventHandler('tqrp_phone:client:RecieveNewYellow', function(adData)
    SendNUIMessage({
        action = 'receiveYellow',
        data = adData
    })
end)

RegisterNetEvent('tqrp_phone:client:ToastNotify')
AddEventHandler('tqrp_phone:client:ToastNotify', function(message)
    SendNUIMessage({
        action = 'toastNotify',
        data = message
    })
end)

RegisterNUICallback( 'DeleteYellowPages', function( data, cb )
    ESX.TriggerServerCallback('tqrp_phone:server:DeleteAd', function(callback)
        cb(callback)
    end, data)
end)


RegisterNetEvent('tqrp_phone:client:RemoveNewYellow')
AddEventHandler('tqrp_phone:client:RemoveNewYellow', function(id)
    SendNUIMessage({
        action = 'removeYellow',
        id = id
    })
end)