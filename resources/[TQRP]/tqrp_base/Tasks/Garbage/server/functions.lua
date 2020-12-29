sendNotification = function(xSource, message, messageType)
    TriggerClientEvent('mythic_notify:client:SendAlert', xSource, { type = messageType, text = message })
end