ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)


RegisterCommand("helpnui", function(source, args, rawCommand)
	SetNuiFocus( false, false )
	SendNUIMessage({
		showPlayerMenu = false
	})

end)


RegisterNetEvent('lockpick:openlockpick')
AddEventHandler('lockpick:openlockpick', function()
	SetNuiFocus( true, true )
	SendNUIMessage({
		showPlayerMenu = true
	})

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer

	item = false

	for i=1, #PlayerData.inventory, 1 do
		if PlayerData.inventory[i].name == 'lockpick' then
			if PlayerData.inventory[i].count > 0 then
				item = true
			end
		end
	end

end)

RegisterNetEvent('lockpick:addcalc')
AddEventHandler('lockpick:addcalc', function()
	item = true
end)

RegisterNetEvent('lockpick:removecalc')
AddEventHandler('lockpick:removecalc', function()
	item = false
end)
