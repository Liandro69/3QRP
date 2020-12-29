ESX               = nil
local usersRadios = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('radio', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
  TriggerClientEvent('ls-radio:use', source)
  table.insert( usersRadios, xPlayer )

end)


-- checking is player have item

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1500)
    for i=1, #usersRadios, 1 do
        local xPlayer = usersRadios[i]
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('radio').count == 0 then
              TriggerClientEvent('ls-radio:onRadioDrop', xPlayer.source)
              table.remove(usersRadios, i)
            end
        end
    end
  end
end)
