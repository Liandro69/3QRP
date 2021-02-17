RegisterNetEvent('tqrp_phone:client:ReceiveText')
AddEventHandler('tqrp_phone:client:ReceiveText', function(sender, text, number)
    exports["mythic_notify"]:SendAlert('inform', 'Recebeste uma nova mensagem de ' .. sender)

    if not muted then
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'sms_receive', 0.1)
    end 

    SendNUIMessage({
        action = 'receiveText',
        data = {
            sender = number,
            message = text
        }
    })
 
    if not isPhoneOpen then
        UpdateAppUnreadAdd('message', 1)
    end 
end)

RegisterNUICallback('SendText', function(data, cb)
    ESX.TriggerServerCallback('tqrp_phone:server:SendText', function(callback)
        cb(callback)
    end, data)
    TriggerEvent('InteractSound_CL:PlayOnAll', 'sms_send', 0.3)
end)

RegisterNUICallback('DeleteConversation', function(data, cb)
    ESX.TriggerServerCallback('tqrp_phone:server:DeleteConversation', function(callback)
        cb(callback)
    end, data)
end)