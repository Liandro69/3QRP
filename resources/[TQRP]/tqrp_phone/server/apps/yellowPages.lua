local Advertisements = {}

function CreateAd(adData, src)
    if  Advertisements[adData.id] ~= nil then
        return false
    else
        Advertisements[adData.id] = adData
        TriggerClientEvent('tqrp_phone:client:RecieveNewYellow', -1, Advertisements[adData.id])
        return true
    end
end

function DeleteAd(source)
    local src = source
        if src ~= nil then
            Advertisements[src] = nil
            TriggerClientEvent('tqrp_phone:client:RemoveNewYellow', -1, src)
        else
            return false
        end
    return true
end

RegisterServerEvent('tqrp_phone:server:GetAds')
AddEventHandler('tqrp_phone:server:GetAds', function()
    local src = source
    TriggerClientEvent('tqrp_phone:client:SetupData', src, {{ name = 'ads', data = Advertisements }})
end)

ESX.RegisterServerCallback('tqrp_phone:server:NewYellowPages', function(source, cb, data)
    local src = source
    cb(CreateAd({
        id = src,
        author = data.author,
        num = data.number,
        time = data.time,
        pageText = data.message
    }, src))
end)


ESX.RegisterServerCallback('tqrp_phone:server:DeleteAd', function(source, cb, data)
    cb(DeleteAd(source))
end)