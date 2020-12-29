ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Lockpicks
--ESX.RegisterUsableItem('lockpick', function(source)
--	local _source = source
--    local xPlayer = ESX.GetPlayerFromId(_source)
--    
--    --TriggerClientEvent('lsrp-items:getplayerloc', _source)
--    TriggerClientEvent('tqrp_lockpick:onUse', _source)
--    --TriggerClientEvent('lsrp-motels2:initiateRobbery', _source)
--end)

ESX.RegisterUsableItem('screwdriver', function(source)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('lsrp-banks:forceCashierDoor', _source)
    TriggerClientEvent("ILRP_radialmenu:RemovePlate", _source)
end)

-- Hacking Tools
ESX.RegisterUsableItem('usbhack', function(source)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('lsrp-banks:initiateCashierRobbery', _source)

end)

ESX.RegisterUsableItem('rolling_paper', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    hasWeed = xPlayer.getInventoryItem('trimmedweed').count
    hasPapers = xPlayer.getInventoryItem('rolling_paper').count

        if hasWeed >= Config.requiredWeed and hasPapers >= Config.requiredPapers then

            TriggerClientEvent('lsrp-items:rolljoint', source)

        else

            if hasWeed < Config.requiredWeed and hasPapers >= Config.requiredPapers then

            TriggerClientEvent("pNotify:SendNotification", _source, {
                text = "Precisas de <font color='red'>"..Config.requiredWeed.."</font> erva",
                type = "error",
                queue = "joints",
                timeout = 5000,
                layout = "bottomCenter"
            })

            elseif hasPapers < Config.requiredPapers and hasWeed >= Config.requiredWeed then

            TriggerClientEvent("pNotify:SendNotification", _source, {
                text = "Precisas de <font color='red'>"..Config.requiredPapers.."</font> Mortalhas",
                type = "error",
                queue = "joints",
                timeout = 5000,
                layout = "bottomCenter"
            })

            else

                TriggerClientEvent("pNotify:SendNotification", _source, {
                    text = "Precisas de <font color='red'>"..Config.requiredPapers.."</font> Mortalhas e <font color='red'>"..Config.requiredWeed.."</font> de erva",
                    type = "error",
                    queue = "joints",
                    timeout = 5000,
                    layout = "bottomCenter"
                })  

            end
        
        end

end)

--[[ Fake Number Plates
ESX.RegisterUsableItem('numberplate', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('tqrp_fakeplates:putonvehicle', _source)    
end)]]

ESX.RegisterUsableItem('bankkey', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('lsrp-banks:initiateCardReader', _source)
    TriggerClientEvent('lsrp-banks:initiateVault', _source)
    TriggerClientEvent('lsrp-banks:initiateVaultGate', _source) 
end)




-------------------------------------------------
----------------- SERVER EVENTS -----------------
-------------------------------------------------

RegisterServerEvent('lsrp-items:rolljoints')
AddEventHandler('lsrp-items:rolljoints', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    hasWeed = xPlayer.getInventoryItem('trimmedweed').count
    hasPapers = xPlayer.getInventoryItem('rolling_paper').count

    if hasWeed >= 5 and hasPapers >= 5 then
        xPlayer.removeInventoryItem('trimmedweed', Config.requiredWeed)
        xPlayer.removeInventoryItem('rolling_paper', Config.requiredPapers)
        xPlayer.addInventoryItem('joint', Config.awardedJoints)
    end
end)