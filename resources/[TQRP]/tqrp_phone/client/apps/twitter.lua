RegisterNUICallback('NewTweet', function(data, cb)
    ESX.TriggerServerCallback('tqrp_phone:server:NewTweet', function(callback)
        cb(callback)
    end, data)
	--TriggerServerEvent('tqrp_phone:server:NewTweet', 'NewTweet', data.author, data.message, data.mentions, data.hashtags)
end)

RegisterNetEvent('tqrp_phone:client:RecieveNewTweet')
AddEventHandler('tqrp_phone:client:RecieveNewTweet', function(tweet)
    SendNUIMessage({
        action = 'receiveTweet',
        data = tweet
    })
end)

RegisterNUICallback('DeleteTweet', function( data, cb )
    ESX.TriggerServerCallback('tqrp_phone:server:DeleteTweet', function(callback)
        cb(callback)
    end, data)
	--TriggerServerEvent('tqrp_phone:server:DeleteTweet', 'DeleteTweet', data.author, data.message)
end)

RegisterNetEvent('tqrp_phone:client:RemoveTweet')
AddEventHandler('tqrp_phone:client:RemoveTweet', function(identifier, cData)
    SendNUIMessage({
        action = 'removeTweet',
        data = {
        	identifier = identifier,
            author = cData.author,
            message = cData.message
        }
    })
end)