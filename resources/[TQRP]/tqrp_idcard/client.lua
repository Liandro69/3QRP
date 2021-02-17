local open = false

-- Open ID card
RegisterNetEvent('tqrp_idcard:open')
AddEventHandler('tqrp_idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(10)
		if open then
			if IsControlJustReleased(0, 322) or IsControlJustReleased(0, 177) then
				SendNUIMessage({
					action = "close"
				})
				open = false
			end
		else
			Citizen.Wait(1500)
		end
	end
end)
