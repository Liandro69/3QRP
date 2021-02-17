ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

local vaultType = {}

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function OpenVaultInventoryMenu(data)
	if data.job == ESX.PlayerData.job.name or data.job == 'vault' then
		vaultType = data
		ESX.TriggerServerCallback(
			"monster_vault:getVaultInventory",
			function(inventory)
				if not inventory then
					exports['mythic_notify']:SendAlert('error', 'Não tens a chave deste cofre')
				else
					TriggerEvent("monster_inventoryhud:openVaultInventory", inventory)
				end
			end,
			data
		)
	else
		exports['mythic_notify']:SendAlert('error', "Não tens permissão para aceder a este cofre", 5500)
		Citizen.Wait(8000)
	end
end

Citizen.CreateThread(function()
    while ESX == nil or ESX.PlayerData == nil or ESX.PlayerData.job == nil do
        Citizen.Wait(1500)
    end
    for k,v in pairs(Config.Vault) do
		ESX.Game.SpawnLocalObject(Config.VaultBox, v.coords, function(obj)
			SetEntityHeading(obj, v.heading)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
		end)
	end
    
end)

-- Key controls
Citizen.CreateThread(function()
	local sleep = 1000
	while true do
		Citizen.Wait(sleep)
		if IsPedOnFoot(PlayerPedId()) then
			local coords = GetEntityCoords(PlayerPedId())
			for k,v in pairs(Config.Vault) do
				local dist = GetDistanceBetweenCoords(coords, v.coords, true)
				if dist < 2 then
					sleep = 10
					ESX.ShowHelpNotification("Pressiona E para abrir o cofre")
					if IsControlJustReleased(0, 38) then
						OpenVaultInventoryMenu({job = k, needItemLicense = v.needItemLicense, InfiniteLicense = v.InfiniteLicense})
					else
						break
					end
				else
					sleep = 1000
				end
			end	
		else
			Citizen.Wait(1500)
		end
	end
end)

function getMonsterVaultLicense()
	return vaultType
end
