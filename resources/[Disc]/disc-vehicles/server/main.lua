ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

--[[ESX.RegisterUsableItem('lockpickcar', function(source)
    TriggerClientEvent('disc-vehicles:useLockpick', source)
end)]]