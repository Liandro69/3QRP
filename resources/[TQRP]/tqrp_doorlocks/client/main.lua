ESX					= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	-- Update the door list
	ESX.TriggerServerCallback('tqrp_doorlock:getDoorInfo', function(doorInfo, count)
		for localID = 1, count, 1 do
			if doorInfo[localID] ~= nil then
				Config.DoorList[doorInfo[localID].doorID].locked = doorInfo[localID].state
			end
		end
	end)
end)


RegisterNetEvent('tqrp_doorlock:currentlyhacking')
AddEventHandler('tqrp_doorlock:currentlyhacking', function(mycb)
	mycb = true
	TriggerEvent("mhacking:show") --This line is where the hacking even starts
	TriggerEvent("mhacking:start",7,19,mycb) --This line is the difficulty and tells it to start. First number is how long the blocks will be the second is how much time they have is.
end)

function DrawText3DTest(coords, text, size)

    local onScreen,_x,_y=World3dToScreen2d(coords.x,coords.y,coords.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(size, size)
        SetTextFont(6)
        SetTextProportional(1.2)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

RegisterNetEvent( 'dooranim' )
AddEventHandler( 'dooranim', function()
    
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "anim@heists@keycard@" ) 
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(450)
    ClearPedTasks(PlayerPedId())

end)

function isKeyDoor(num)
    if num == 0 then
        return false
    end
    if doorID.objName == "prop_gate_prison_01" then
        return false
    end
    if doorTypes[num]["doorType"] == "v_ilev_fin_vaultdoor" then
        return false
    end
    if doorTypes[num]["doorType"] == "hei_prop_station_gate" then
        return false
    end
    return true
end

Citizen.CreateThread(function()
	local sleep = 500
	while true do
		Citizen.Wait(sleep)
		local playerCoords = GetEntityCoords(PlayerPedId())

		for i=1, #Config.DoorList do
			local doorID   = Config.DoorList[i]
			local distance = GetDistanceBetweenCoords(playerCoords, doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, true)

			local maxDistance = 1.25
			if doorID.distance then
				maxDistance = doorID.distance
			end

			if (distance < (maxDistance+55)) then
				--if (distance < (maxDistance+25)) then
					--if (distance < (maxDistance+5)) then

						sleep = 5
						local isAuthorized = IsAuthorized(doorID)
						ApplyStateLock(doorID)
						local size = 1

						if doorID.size then
							size = doorID.size
						end
						if (distance < maxDistance) then
							if  IsControlJustReleased(1,  38) and isAuthorized then
								if doorID.locked == true then
									local active = true
									local swingcount = 0
									TriggerEvent("dooranim")
									doorID.locked = false
									while active do
										Citizen.Wait(7)

										locked, heading = GetStateOfClosestDoorOfType(GetHashKey(doorID.objName, doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z)) 
										heading = math.ceil(heading * 100) 
										DrawText3DTest(doorID.textCoords, "A Destrancar", size)
										
										local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, true)
										local dst2 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1830.45, 2607.56, 45.59,true)

										if heading < 1.5 and heading > -1.5 then
											swingcount = swingcount + 1
										end             
										if dist > 150.0 or swingcount > 100 or dst2 < 200.0 then
											active = false
										end
									end

								elseif doorID.locked == false then

									local active = true
									local swingcount = 0
									TriggerEvent("dooranim")
									doorID.locked = true
									while active do
										Citizen.Wait(1)
										DrawText3DTest(doorID.textCoords, "A Trancar", size)
										swingcount = swingcount + 1
										if swingcount > 100 then
											active = false
										end
									end

								end
								TriggerServerEvent('tqrp_doorlock:updateState', i, doorID.locked)
							end

							if doorID.locked and isAuthorized then 
								closestString = "[~g~E~w~] - ~r~TRANCADA"
								DrawText3DTest(doorID.textCoords, closestString, size) 
							elseif doorID.locked == false and isAuthorized then 
								closestString = "[~g~E~w~] - ~g~DESTRANCADA"
								DrawText3DTest(doorID.textCoords, closestString, size) 
							end
							break
						end
					--else
					--	sleep = 500
					--end
			---	else
			--		sleep = 1500
			--	end
			else
				sleep = 2500
			end
		end
	end
end)

function IsAuthorized(doorID)
	if ESX.PlayerData.job == nil then
		return false
	end

	for i=1, #doorID.authorizedJobs, 1 do
		if doorID.authorizedJobs[i] == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end

function ApplyStateLock(doorID)
	local objName
	if tonumber(doorID.objName) ~= nil then
		objName = doorID.objName
	else
		objName = GetHashKey(doorID.objName)
	end
	local closeDoor = GetClosestObjectOfType(doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, 1.0, objName, false, false, false)

	if doorID.locked == false then
		NetworkRequestControlOfEntity(closeDoor)
		FreezeEntityPosition(closeDoor, false)
	else
		local locked, heading = GetStateOfClosestDoorOfType(objName, doorID.objCoords.x,doorID.objCoords.y,doorID.objCoords.z, locked, heading)
		if heading > -0.01 and heading < 0.01 then
			NetworkRequestControlOfEntity(closeDoor)
			FreezeEntityPosition(closeDoor, true)
		end
	end
end


-- Set state for a door
RegisterNetEvent('tqrp_doorlock:setState')
AddEventHandler('tqrp_doorlock:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)







