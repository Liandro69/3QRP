drawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
  
	local scale = 0.3
   
	if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

showPercent = function(time)
	percent = true
	Percent()
	TimeLeft = 0
	repeat
	TimeLeft = TimeLeft + 1
	Citizen.Wait(time)
	until(TimeLeft == 100)
	percent = false
end

openBin = function(entity)
	searching = true
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_SHOPPING_CART", 0, true)
	exports['mythic_progbar']:Progress({
		name = "ko",
		duration = 15000,
		label = "A vasculhar...",
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = false,
		},
	}, function(status)
		if not status then
			cachedBins[entity] = true
			searching = false
			ClearPedTasks(PlayerPedId())
			TriggerServerEvent('Trashsearch:getItem')
		end
	end)
	--[[SetEntityAsMissionEntity(entity ,true, true)
	while not NetworkHasControlOfEntity(entity) do 
		NetworkRequestControlOfEntity(entity);
		Wait(0); 
	end
	local coords = GetEntityCoords(entity)
	local heading = GetEntityHeading(entity)
	if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
		SetEntityAsMissionEntity(entity, true, true)
		DeleteObject(entity)
		DeleteEntity(entity)
	end
	while DoesEntityExist(entity) do
		Citizen.Wait(0)
	end
	prop = CreateObject(GetHashKey(entity2), coords.x, coords.y, coords.z,  true,  true, false)
	PlaceObjectOnGroundProperly(prop)
	SetEntityHeading(prop, heading)]]
end

function Percent()
	Citizen.CreateThread(function ()
		while percent do
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			for i = 1, #closestBin do
				local x = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(closestBin[i]), false, false, false)
				local entity = nil        
				if DoesEntityExist(x) then
					sleep  = 5
					entity = x
					bin    = GetEntityCoords(entity)
					drawText3D(bin.x, bin.y, bin.z + 1.5, TimeLeft .. '~g~%~s~')
					break
				else
					sleep = 1000
				end
			end
			Citizen.Wait(10)
		end
	end)
end