ESX = nil
local HaveBagOnHead = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function UseBaG()
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  if closestPlayer ~= -1 or closestDistance < 2.0 then 
 --   if not HaveBagOnHead then
      TriggerServerEvent('tqrp_saco:server:useBag', GetPlayerServerId(closestPlayer))
  --  else
  --    TriggerServerEvent('tqrp_saco:server:removeBag', GetPlayerServerId(closestPlayer))
    end
  end

end

RegisterNetEvent('tqrp_saco:use') 
AddEventHandler('tqrp_saco:use', function()
    UseBaG()
end)

RegisterNetEvent('tqrp_saco:client:putBag') 
AddEventHandler('tqrp_saco:client:putBag', function()
    local playerPed = PlayerPedId()
    BagProp = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(BagProp, playerPed, GetPedBoneIndex(playerPed, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) 
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openGeneral'})
    HaveBagOnHead = true
end)    

AddEventHandler('playerSpawned', function() 
  DeleteEntity(BagProp)
  SetEntityAsNoLongerNeeded(BagProp)
  SendNUIMessage({type = 'closeAll'})
  HaveBagOnHead = false
end)

RegisterNetEvent('tqrp_saco:client:removeBag') 
AddEventHandler('tqrp_saco:client:removeBag', function()
    DeleteEntity(BagProp)
    SetEntityAsNoLongerNeeded(BagProp)
    SendNUIMessage({type = 'closeAll'})
    HaveBagOnHead = false
end)

