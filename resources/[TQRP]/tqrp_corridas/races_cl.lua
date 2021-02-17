-- DEFINITIONS AND CONSTANTS
local RACE_STATE_NONE = 0
local RACE_STATE_JOINED = 1
local RACE_STATE_RACING = 2
local RACE_STATE_RECORDING = 3
local RACE_CHECKPOINT_TYPE = 45
local RACE_CHECKPOINT_FINISH_TYPE = 9

-- Races and race status
local races = {}
local raceStatus = {
    state = RACE_STATE_NONE,
    index = 0,
    checkpoint = 0
}

-- Recorded checkpoints
local recordedCheckpoints = {}







-- Main command for races
RegisterCommand("corridas", function(source, args)
    if args[1] == "limpar" or args[1] == "sair" then
        -- If player is part of a race, clean up map and send leave event to server
        if raceStatus.state == RACE_STATE_JOINED or raceStatus.state == RACE_STATE_RACING then
            cleanupRace()
            TriggerServerEvent('StreetRaces:leaveRace_sv', raceStatus.index)
        end

        -- Reset state
        raceStatus.index = 0
        raceStatus.checkpoint = 0
        raceStatus.state = RACE_STATE_NONE
    elseif args[1] == "gravar" then
        -- Clear waypoint, cleanup recording and set flag to start recording
        SetWaypointOff()
        cleanupRecording()
        raceStatus.state = RACE_STATE_RECORDING
    elseif args[1] == "guardar" then
        -- Check name was provided and checkpoints are recorded
        local name = args[2]
        if name ~= nil and #recordedCheckpoints > 0 then
            -- Send event to server to save checkpoints
            TriggerServerEvent('StreetRaces:saveRace_sv', name, recordedCheckpoints)
        end
    elseif args[1] == "apagar" then
        -- Check name was provided and send event to server to delete saved race
        local name = args[2]
        if name ~= nil then
            TriggerServerEvent('StreetRaces:deleteRace_sv', name)
        end
    elseif args[1] == "lista" then
        -- Send event to server to list saved races
        TriggerServerEvent('StreetRaces:listRaces_sv')
    elseif args[1] == "carregar" then
        -- Check name was provided and send event to server to load saved race
        local name = args[2]
        if name ~= nil then
            TriggerServerEvent('StreetRaces:loadRace_sv', name)
        end
    elseif args[1] == "iniciar" then
        -- Parse arguments and create race
        local amount = tonumber(args[2])
        if amount then
            -- Get optional start delay argument and starting coordinates
            local startDelay = tonumber(args[3])
            startDelay = startDelay and startDelay*1000 or config_cl.joinDuration
            local startCoords = GetEntityCoords(PlayerPedId())

            -- Create a race using checkpoints or waypoint if none set
            if #recordedCheckpoints > 0 then
                -- Create race using custom checkpoints
                TriggerServerEvent('StreetRaces:createRace_sv', amount, startDelay, startCoords, recordedCheckpoints)
                flares(startCoords)
            elseif IsWaypointActive() then
                -- Create race using waypoint as the only checkpoint
                local waypointCoords = GetBlipInfoIdCoord(GetFirstBlipInfoId(8))
                local retval, nodeCoords = GetClosestVehicleNode(waypointCoords.x, waypointCoords.y, waypointCoords.z, 1)
                table.insert(recordedCheckpoints, {blip = nil, coords = nodeCoords})
                TriggerServerEvent('StreetRaces:createRace_sv', amount, startDelay, startCoords, recordedCheckpoints)
                flares(startCoords)
            end

            -- Set state to none to cleanup recording blips while waiting to join
            raceStatus.state = RACE_STATE_NONE
        end
    elseif args[1] == "cancelar" then
        -- Send cancel event to server
        TriggerServerEvent('StreetRaces:cancelRace_sv')
    else
        return
    end
end)

function flares(startCoords)
    ShootSingleBulletBetweenCoords(startCoords, startCoords - vector3(10.0001, 10.0001, 5.0001), 0, false, GetHashKey("weapon_flare"), 0, true, false, -1.0)
end

-- Client event for when a race is created
RegisterNetEvent("StreetRaces:createRace_cl")
AddEventHandler("StreetRaces:createRace_cl", function(index, amount, startDelay, startCoords, checkpoints)
    -- Create race struct and add to array
    local race = {
        amount = amount,
        started = false,
        startTime = GetGameTimer() + startDelay,
        startCoords = startCoords,
        checkpoints = checkpoints
    }
    races[index] = race
end)

-- Client event for loading a race
RegisterNetEvent("StreetRaces:loadRace_cl")
AddEventHandler("StreetRaces:loadRace_cl", function(checkpoints)
    -- Cleanup recording, save checkpoints and set state to recording
    cleanupRecording()
    recordedCheckpoints = checkpoints
    raceStatus.state = RACE_STATE_RECORDING

    -- Add map blips
    for index, checkpoint in pairs(recordedCheckpoints) do
        checkpoint.blip = AddBlipForCoord(checkpoint.coords.x, checkpoint.coords.y, checkpoint.coords.z)
        SetBlipColour(checkpoint.blip, config_cl.checkpointBlipColor)
        SetBlipAsShortRange(checkpoint.blip, true)
        ShowNumberOnBlip(checkpoint.blip, index)
    end

    -- Clear waypoint and add route for first checkpoint blip
    SetWaypointOff()
    SetBlipRoute(checkpoints[1].blip, true)
    SetBlipRouteColour(checkpoints[1].blip, config_cl.checkpointBlipColor)
end)

-- Client event for when a race is joined
RegisterNetEvent("StreetRaces:joinedRace_cl")
AddEventHandler("StreetRaces:joinedRace_cl", function(index)
    -- Set index and state to joined
    raceStatus.index = index
    raceStatus.state = RACE_STATE_JOINED

    -- Add map blips
    local race = races[index]
    local checkpoints = race.checkpoints
    for index, checkpoint in pairs(checkpoints) do
        checkpoint.blip = AddBlipForCoord(checkpoint.coords.x, checkpoint.coords.y, checkpoint.coords.z)
        SetBlipColour(checkpoint.blip, config_cl.checkpointBlipColor)
        SetBlipAsShortRange(checkpoint.blip, true)
        ShowNumberOnBlip(checkpoint.blip, index)
    end

    -- Clear waypoint and add route for first checkpoint blip
    SetWaypointOff()
    SetBlipRoute(checkpoints[1].blip, true)
    SetBlipRouteColour(checkpoints[1].blip, config_cl.checkpointBlipColor)
end)

-- Client event for when a race is removed
RegisterNetEvent("StreetRaces:removeRace_cl")
AddEventHandler("StreetRaces:removeRace_cl", function(index)
    -- Check if index matches active race
    if index == raceStatus.index then
        -- Cleanup map blips and checkpoints
        cleanupRace()

        -- Reset racing state
        raceStatus.index = 0
        raceStatus.checkpoint = 0
        raceStatus.state = RACE_STATE_NONE
    elseif index < raceStatus.index then
        -- Decrement raceStatus.index to match new index after removing race
        raceStatus.index = raceStatus.index - 1
    end
    
    -- Remove race from table
    table.remove(races, index)
end)

local active = false
RegisterNetEvent("fh4speed:toogle")
AddEventHandler("fh4speed:toogle", function(toogle)
	active = toogle
    if toogle then
        DisplayRadar(true)
        show()
    else
        SendNUIMessage({HideHud = true})
	end
end)


function show()
	Citizen.CreateThread(function()
		while active do
			Wait(10)
	
			playerPed = GetPlayerPed(-1)
			
			if playerPed then
				
				playerCar = GetVehiclePedIsIn(playerPed, false)
				
				if playerCar and GetPedInVehicleSeat(playerCar, -1) == playerPed then
					carRPM                    = GetVehicleCurrentRpm(playerCar)
					carSpeed                  = GetEntitySpeed(playerCar)
					carGear                   = GetVehicleCurrentGear(playerCar)
					carIL                     = GetVehicleIndicatorLights(playerCar)
					carLS_r, carLS_o, carLS_h = GetVehicleLightsState(playerCar)
					
					SendNUIMessage({
						ShowHud             = true,
						CurrentCarRPM       = carRPM,
						CurrentCarGear      = carGear,
						CurrentCarSpeed     = carSpeed,
						CurrentCarKmh       = math.ceil(carSpeed * 3.6),
						CurrentCarMph       = math.ceil(carSpeed * 2.236936),
						CurrentCarIL        = carIL,
						CurrentCarHandbrake = carHandbrake,
						CurrentCarBrake     = carBrakePressure,
						CurrentCarLS_r      = carLS_r,
						CurrentCarLS_o      = carLS_o,
						CurrentCarLS_h      = carLS_h,
						PlayerID            = GetPlayerServerId(GetPlayerIndex())
					})
                else
					SendNUIMessage({HideHud = true})
				end
			end
        end
        SendNUIMessage({HideHud = true})
	end)
end

-- Main thread
Citizen.CreateThread(function()
    -- Loop forever and update every frame
    local close = false
    while true do
        Citizen.Wait(7)
        close = false
        local player = PlayerPedId()
        if IsPedInAnyVehicle(player, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(player, false), -1) == player  then
            -- Player is racing
            if raceStatus.state == RACE_STATE_RACING then
                -- Initialize first checkpoint if not set
                local race = races[raceStatus.index]
                if raceStatus.checkpoint == 0 then
                    -- Increment to first checkpoint
                    raceStatus.checkpoint = 1
                    local checkpoint = race.checkpoints[raceStatus.checkpoint]

                    -- Create checkpoint when enabled
                    if config_cl.checkpointRadius > 0 then
                        local checkpointType = raceStatus.checkpoint < #race.checkpoints and RACE_CHECKPOINT_TYPE or RACE_CHECKPOINT_FINISH_TYPE
                        checkpoint.checkpoint = CreateCheckpoint(checkpointType, checkpoint.coords.x,  checkpoint.coords.y, checkpoint.coords.z, 0, 0, 0, config_cl.checkpointRadius, 255, 255, 0, 127, 0)
                        SetCheckpointCylinderHeight(checkpoint.checkpoint, config_cl.checkpointHeight, config_cl.checkpointHeight, config_cl.checkpointRadius)
                    end

                    -- Set blip route for navigation
                    SetBlipRoute(checkpoint.blip, true)
                    SetBlipRouteColour(checkpoint.blip, config_cl.checkpointBlipColor)
                else
                    -- Check player distance from current checkpoint
                    -- Get player position and vehicle
                    local position = GetEntityCoords(player)
                    local checkpoint = race.checkpoints[raceStatus.checkpoint]
                    if GetDistanceBetweenCoords(position.x, position.y, position.z, checkpoint.coords.x, checkpoint.coords.y, 0, false) < config_cl.checkpointProximity then
                        -- Passed the checkpoint, delete map blip and checkpoint
                        RemoveBlip(checkpoint.blip)
                        if config_cl.checkpointRadius > 0 then
                            DeleteCheckpoint(checkpoint.checkpoint)
                        end
                        
                        -- Check if at finish line
                        if raceStatus.checkpoint == #(race.checkpoints) then
                            -- Play finish line sound
                            PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds")

                            -- Send finish event to server
                            local currentTime = (GetGameTimer() - race.startTime)
                            TriggerServerEvent('StreetRaces:finishedRace_sv', raceStatus.index, currentTime)
                            
                            -- Reset state
                            raceStatus.index = 0
                            raceStatus.state = RACE_STATE_NONE
                        else
                            -- Play checkpoint sound
                            PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")

                            -- Increment checkpoint counter and get next checkpoint
                            raceStatus.checkpoint = raceStatus.checkpoint + 1
                            local nextCheckpoint = race.checkpoints[raceStatus.checkpoint]

                            -- Create checkpoint when enabled
                            if config_cl.checkpointRadius > 0 then
                                local checkpointType = raceStatus.checkpoint < #race.checkpoints and RACE_CHECKPOINT_TYPE or RACE_CHECKPOINT_FINISH_TYPE
                                nextCheckpoint.checkpoint = CreateCheckpoint(checkpointType, nextCheckpoint.coords.x,  nextCheckpoint.coords.y, nextCheckpoint.coords.z, 0, 0, 0, config_cl.checkpointRadius, 255, 255, 0, 127, 0)
                                SetCheckpointCylinderHeight(nextCheckpoint.checkpoint, config_cl.checkpointHeight, config_cl.checkpointHeight, config_cl.checkpointRadius)
                            end

                            -- Set blip route for navigation
                            SetBlipRoute(nextCheckpoint.blip, true)
                            SetBlipRouteColour(nextCheckpoint.blip, config_cl.checkpointBlipColor)
                        end
                    end
                end

                -- Draw HUD when it's enabled
                if config_cl.hudEnabled then
                    -- Draw time and checkpoint HUD above minimap
                    local timeSeconds = (GetGameTimer() - race.startTime)/1000.0
                    local timeMinutes = math.floor(timeSeconds/60.0)
                    timeSeconds = timeSeconds - 60.0*timeMinutes
                    Draw2DText(config_cl.hudPosition.x, config_cl.hudPosition.y, ("~y~%02d:%06.3f"):format(timeMinutes, timeSeconds), 0.5)
                    local checkpoint = race.checkpoints[raceStatus.checkpoint]
                    local position = GetEntityCoords(player)
                    local checkpointDist = math.floor(GetDistanceBetweenCoords(position.x, position.y, position.z, checkpoint.coords.x, checkpoint.coords.y, 0, false))
                    Draw2DText(config_cl.hudPosition.x, config_cl.hudPosition.y + 0.04, ("~y~CHECKPOINT %d/%d (%dm)"):format(raceStatus.checkpoint, #race.checkpoints, checkpointDist), 0.4)
                end
            -- Player has joined a race
            elseif raceStatus.state == RACE_STATE_JOINED then
                -- Check countdown to race start
                local race = races[raceStatus.index]
                local currentTime = GetGameTimer()
                local count = race.startTime - currentTime
                local vehicle = GetVehiclePedIsIn(player, false)
                if count <= 0 then
                    raceStatus.state = RACE_STATE_RACING
                    raceStatus.checkpoint = 0
                    FreezeEntityPosition(vehicle, false)
                elseif count <= config_cl.freezeDuration then
                    Draw2DText(0.5, 0.4, ("~y~%d"):format(math.ceil(count/1000.0)), 3.0)
                    FreezeEntityPosition(vehicle, true)
                else
                    -- Draw 3D start time and join text
                    local temp, zCoord = GetGroundZFor_3dCoord(race.startCoords.x, race.startCoords.y, 9999.9, 1)
                    Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+1.0, ("Corrida por ~g~$%d~w~ a começar em ~y~%d~w~s"):format(race.amount, math.ceil(count/1000.0)))
                    Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+0.80, "~g~Juntou-se")
                end
            -- Player is not in a race
            else
                for index, race in pairs(races) do
                    -- Get current time and player proximity to start
                    local currentTime = GetGameTimer()
                    local position = GetEntityCoords(player)
                    local proximity = GetDistanceBetweenCoords(position.x, position.y, position.z, race.startCoords.x, race.startCoords.y, race.startCoords.z, true)
                    if proximity < config_cl.joinProximity then
                        close = true
                        -- When in proximity and race hasn't started draw 3D text and prompt to join
                        if currentTime < race.startTime then
                            -- Draw 3D text
                            local count = math.ceil((race.startTime - currentTime)/1000.0)
                            local temp, zCoord = GetGroundZFor_3dCoord(race.startCoords.x, race.startCoords.y, 9999.9, 0)
                            Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+1.0, ("Faz uma corrida por ~g~$%d~w~ a começar em ~y~%d~w~s"):format(race.amount, count))
                            Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+0.80, "Pressiona [~g~E~w~] pra te juntares")

                            -- Check if player enters the race and send join event to server
                            if IsControlJustReleased(1, config_cl.joinKeybind) then
                                TriggerServerEvent('StreetRaces:joinRace_sv', index)
                                break
                            end
                        end
                    end
                end
                if not close then
                    Citizen.Wait(1500)
                end
            end  
        else
            Citizen.Wait(1500)
        end
    end
end)

-- Checkpoint recording thread
Citizen.CreateThread(function()
    -- Loop forever and record checkpoints every 100ms
    while true do
        Citizen.Wait(100)
        
        -- When recording flag is set, save checkpoints
        if raceStatus.state == RACE_STATE_RECORDING then
            -- Create new checkpoint when waypoint is set
            if IsWaypointActive() then
                -- Get closest vehicle node to waypoint coordinates and remove waypoint
                local waypointCoords = GetBlipInfoIdCoord(GetFirstBlipInfoId(8))
                local retval, coords = GetClosestVehicleNode(waypointCoords.x, waypointCoords.y, waypointCoords.z, 1)
                SetWaypointOff()

                -- Check if coordinates match any existing checkpoints
                for index, checkpoint in pairs(recordedCheckpoints) do
                    if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, checkpoint.coords.x, checkpoint.coords.y, checkpoint.coords.z, false) < 1.0 then
                        -- Matches existing checkpoint, remove blip and checkpoint from table
                        RemoveBlip(checkpoint.blip)
                        table.remove(recordedCheckpoints, index)
                        coords = nil

                        -- Update existing checkpoint blips
                        for i = index, #recordedCheckpoints do
                            ShowNumberOnBlip(recordedCheckpoints[i].blip, i)
                        end
                        break
                    end
                end

                -- Add new checkpoint
                if (coords ~= nil) then
                    -- Add numbered checkpoint blip
                    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                    SetBlipColour(blip, config_cl.checkpointBlipColor)
                    SetBlipAsShortRange(blip, true)
                    ShowNumberOnBlip(blip, #recordedCheckpoints+1)

                    -- Add checkpoint to array
                    table.insert(recordedCheckpoints, {blip = blip, coords = coords})
                end
            end
        else
            -- Not recording, do cleanup
            cleanupRecording()
        end
    end
end)

-- Helper function to clean up race blips, checkpoints and status
function cleanupRace()
    -- Cleanup active race
    if raceStatus.index ~= 0 then
        -- Cleanup map blips and checkpoints
        local race = races[raceStatus.index]
        local checkpoints = race.checkpoints
        for _, checkpoint in pairs(checkpoints) do
            if checkpoint.blip then
                RemoveBlip(checkpoint.blip)
            end
            if checkpoint.checkpoint then
                DeleteCheckpoint(checkpoint.checkpoint)
            end
        end

        -- Set new waypoint to finish if racing
        if raceStatus.state == RACE_STATE_RACING then
            local lastCheckpoint = checkpoints[#checkpoints]
            SetNewWaypoint(lastCheckpoint.coords.x, lastCheckpoint.coords.y)
        end

        -- Unfreeze vehicle
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        FreezeEntityPosition(vehicle, false)
    end
end

-- Helper function to clean up recording blips
function cleanupRecording()
    -- Remove map blips and clear recorded checkpoints
    for _, checkpoint in pairs(recordedCheckpoints) do
        RemoveBlip(checkpoint.blip)
        checkpoint.blip = nil
    end
    recordedCheckpoints = {}
end

-- Draw 3D text at coordinates
function Draw3DText(x, y, z, text)
    -- Check if coords are visible and get 2D screen coords
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        -- Calculate text scale to use
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = 1.2*(1/dist)*(1/GetGameplayCamFov())*100

        -- Draw text on screen
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-- Draw 2D text on screen
function Draw2DText(x, y, text, scale)
    -- Draw text on screen
    SetTextFont(6)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
------------------------------------------------ REBOQUE PRANCHA -------------------------------------------------------------------



local DECOR = {
    FLOAT = 1,
    BOOL = 2,
    INT = 3,
    UNK = 4,
    TIME = 5,
}

local DECORATORS = {
    ["flatbed3_bed"] = DECOR.INT, -- The bed entity
    ["flatbed3_car"] = DECOR.INT, -- The car entity
    ["flatbed3_attached"] = DECOR.BOOL, -- Is a car attached?
    ["flatbed3_lowered"] = DECOR.BOOL, -- Is the bed lowered?
    ["flatbed3_state"] = DECOR.INT, -- Multi-state for the bed
}

for k,v in next, DECORATORS do
    DecorRegister(k, v)
end

function lerp(a, b, t)
	return a + (b - a) * t
end

-- Value controlling all movement
local LERP_VALUE = 0.0

local lastFlatbed = nil
local lastBed = nil

--local raisedOffset = vector3(0.0, -3.8, 0.25)
local backOffset = {vector3(0.0, -4.0, 0.0), vector3(0.0, 0.0, 0.0)}
local loweredOffset = {vector3(0.0, -0.4, -1.0), vector3(12.0, 0.0, 0.0)}
local raisedOffset = {vector3(0.0, -3.8, 0.45), vector3(0.0, 0.0, 0.0)}

local attachmentOffset = {vector3(0.0, 1.5, 0.3), vector3(0.0, 0.0, 0.0)}

local bedController = {vector3(-2.5, -3.8, -1.0), vector3(0.0, 0.0, 0.0)}

function getVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y,
            coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10,
            PlayerPedId(), 0)
    local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

Citizen.CreateThread(function()
    RequestModel("inm_flatbed_base")
    while not HasModelLoaded("inm_flatbed_base") do
        Wait(0)
    end
    
    while true do
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, true)
        local waitFlat = 5000
        
        if veh and GetEntityModel(veh) ~= GetHashKey("flatbed3") then
            veh = lastFlatbed
        else
            waitFlat = 5000
        end

        if lastFlatbed then
            if not DoesEntityExist(lastFlatbed) then
                waitFlat = 5
                if lastBed then
                    if DoesEntityExist(lastBed) then
                        DeleteEntity(lastBed)
                        lastBed = nil
                    end
                end
                lastFlatbed = nil
            end
        end
        if veh and DoesEntityExist(veh) and GetEntityModel(veh) == GetHashKey("flatbed3") and NetworkHasControlOfEntity(veh) then
            waitFlat = 5
            lastFlatbed = veh
            local rightDir, fwdDir, upDir, pos = GetEntityMatrix(veh)

            if not DecorExistOn(veh, "flatbed3_bed") or DecorGetInt(veh, "flatbed3_bed") == 0 then
                DecorSetInt(veh, "flatbed3_bed", 0)
                local bed = CreateObjectNoOffset("inm_flatbed_base", pos, true, 0, 1)

                if DoesEntityExist(bed) then
                    local bedNet = ObjToNet(bed)
                    DecorSetInt(veh, "flatbed3_bed", bedNet)

                end
            else
                SetVehicleExtra(veh, 1, not false)
            end
            local bedNet = DecorGetInt(veh, "flatbed3_bed")
            local bed = nil
            if bedNet ~= 0 then
                bed = NetToObj(bedNet)
                lastBed = bed

                if not DecorExistOn(veh, "flatbed3_attached") then
                    DecorSetBool(veh, "flatbed3_attached", false)
                end
                local attached = DecorGetBool(veh, "flatbed3_attached")

                if not DecorExistOn(veh, "flatbed3_lowered") then
                    DecorSetBool(veh, "flatbed3_lowered", true)
                end
                local lowered = DecorGetBool(veh, "flatbed3_lowered")

                if not DecorExistOn(veh, "flatbed3_state") then
                    DecorSetInt(veh, "flatbed3_state", 0)
                end
                local state = DecorGetInt(veh, "flatbed3_state")

                if not DecorExistOn(veh, "flatbed3_car") then
                    DecorSetInt(veh, "flatbed3_car", 0)
                end
                local carNet = DecorGetInt(veh, "flatbed3_car")
                local car = nil
                if carNet ~= 0 then
                    car = NetToVeh(carNet)
                end

                local data = bedController
                local x = pos.x + (fwdDir.x * data[1].x) + (rightDir.x * data[1].y) + (upDir.x * data[1].z)
                local y = pos.y + (fwdDir.y * data[1].x) + (rightDir.y * data[1].y) + (upDir.y * data[1].z)
                local z = pos.z + (fwdDir.z * data[1].x) + (rightDir.z * data[1].y) + (upDir.z * data[1].z)
                local controllerPos = vector3(x, y, z)

                if state == 0 then
                    -- Raised
                    if lowered then
                        DetachEntity(bed, 0, 0)
                        AttachEntityToEntity(bed, veh, GetEntityBoneIndexByName(veh, "chassis"), raisedOffset[1], raisedOffset[2], 0, 0, 1, 0, 0, 1)

                        DecorSetBool(veh, "flatbed3_lowered", false)
                        lowered = false
                    end
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), trye), controllerPos, true) < 4.0 then
                    	DrawText3DFlatbet(x,y,z+1.0, "~g~[E]~w~ descer plataforma")
                    	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), trye), controllerPos, true) < 2.0 then
	                        if IsControlJustPressed(0, 38) then
	                            state = 1
	                            DecorSetInt(veh, "flatbed3_state", state)
	                        end
	                    end
                    end
                elseif state == 1 then
                    -- Moving back
                    local offsetPos = raisedOffset[1]
                    local offsetRot = raisedOffset[2]

                    offsetPos = offsetPos + vector3(lerp(0.0, backOffset[1].x, LERP_VALUE), lerp(0.0, backOffset[1].y, LERP_VALUE), lerp(0.0, backOffset[1].z, LERP_VALUE))
                    offsetRot = offsetRot + vector3(lerp(0.0, backOffset[2].x, LERP_VALUE), lerp(0.0, backOffset[2].y, LERP_VALUE), lerp(0.0, backOffset[2].z, LERP_VALUE))

                    DetachEntity(bed, 0, 0)
                    AttachEntityToEntity(bed, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)

                    LERP_VALUE = LERP_VALUE + (1.0 * Timestep()) / 4.0

                    if LERP_VALUE >= 1.0 then
                        state = state + 1
                        DecorSetInt(veh, "flatbed3_state", state)
                        LERP_VALUE = 0.0
                    end
                elseif state == 2 then
                    -- Lowering
                    local offsetPos = raisedOffset[1] + backOffset[1]
                    local offsetRot = raisedOffset[2] + backOffset[2]

                    offsetPos = offsetPos + vector3(lerp(0.0, loweredOffset[1].x, LERP_VALUE), lerp(0.0, loweredOffset[1].y, LERP_VALUE), lerp(0.0, loweredOffset[1].z, LERP_VALUE))
                    offsetRot = offsetRot + vector3(lerp(0.0, loweredOffset[2].x, LERP_VALUE), lerp(0.0, loweredOffset[2].y, LERP_VALUE), lerp(0.0, loweredOffset[2].z, LERP_VALUE))

                    DetachEntity(bed, 0, 0)
                    AttachEntityToEntity(bed, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)

                    LERP_VALUE = LERP_VALUE + (1.0 * Timestep()) / 2.0

                    if LERP_VALUE >= 1.0 then
                        state = state + 1
                        DecorSetInt(veh, "flatbed3_state", state)
                        LERP_VALUE = 0.0
                    end
                elseif state == 3 then
                    -- Lowered
                    if not lowered then
                        local offsetPos = raisedOffset[1] + backOffset[1] + loweredOffset[1]
                        local offsetRot = raisedOffset[2] + backOffset[2] + loweredOffset[2]
                        DetachEntity(bed, 0, 0)
                        AttachEntityToEntity(bed, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)
                        DecorSetBool(veh, "flatbed3_lowered", true)
                        lowered = true
                    end

                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), trye), controllerPos, true) < 4.0 then
                    	DrawText3DFlatbet(x,y,z+1.0, "~g~[E]~w~ subir plataforma | ~g~[H]~w~ fixar veículo")
                    	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), trye), controllerPos, true) < 2.0 then
	                        if IsControlJustPressed(0, 38) then
	                            state = 4
	                            DecorSetInt(veh, "flatbed3_state", state)
	                        end
	                        if IsControlJustPressed(0, 74) then
	                            if attached then
	                                DetachEntity(car, 0, 1)
	                                car = nil
	                                DecorSetInt(veh, "flatbed3_car", 0)
	                                attached = false
	                                DecorSetBool(veh, "flatbed3_attached", attached)
	                            else
	                                local bedPos = GetEntityCoords(bed, false)
	                                local newCar = getVehicleInDirection(bedPos + vector3(0.0, 0.0, 0.25), bedPos + vector3(0.0, 0.0, 2.25))
	                                local newCar = GetVehiclePedIsIn(PlayerPedId(), true)
	                                if newCar then
	                                    local carPos = GetEntityCoords(newCar, false)
					    				NetworkRequestControlOfEntity(newCar)
					    				while not NetworkHasControlOfEntity(newCar) do Wait(0) end
	                                    AttachEntityToEntity(newCar, bed, 0, attachmentOffset[1] + vector3(0.0, 0.0, carPos.z - bedPos.z - 0.50), attachmentOffset[2], 0, 0, false, 0, 0, 1)
	                                    car = newCar
	                                    DecorSetInt(veh, "flatbed3_car", VehToNet(newCar))
	                                    attached = true
	                                    DecorSetBool(veh, "flatbed3_attached", attached)
	                                end
	                            end
	                        end
	                    end
                    end


                elseif state == 4 then
                    -- Raising
                    local offsetPos = raisedOffset[1] + backOffset[1]
                    local offsetRot = raisedOffset[2] + backOffset[2]

                    offsetPos = offsetPos + vector3(lerp(loweredOffset[1].x, 0.0, LERP_VALUE), lerp(loweredOffset[1].y, 0.0, LERP_VALUE), lerp(loweredOffset[1].z, 0.0, LERP_VALUE))
                    offsetRot = offsetRot + vector3(lerp(loweredOffset[2].x, 0.0, LERP_VALUE), lerp(loweredOffset[2].y, 0.0, LERP_VALUE), lerp(loweredOffset[2].z, 0.0, LERP_VALUE))

                    DetachEntity(bed, 0, 0)
                    AttachEntityToEntity(bed, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)

                    LERP_VALUE = LERP_VALUE + (1.0 * Timestep()) / 2.0

                    if LERP_VALUE >= 1.0 then
                        state = state + 1
                        DecorSetInt(veh, "flatbed3_state", state)
                        LERP_VALUE = 0.0
                    end
                elseif state == 5 then
                    -- Moving forward
                    local offsetPos = raisedOffset[1]
                    local offsetRot = raisedOffset[2]

                    offsetPos = offsetPos + vector3(lerp(backOffset[1].x, 0.0, LERP_VALUE), lerp(backOffset[1].y, 0.0, LERP_VALUE), lerp(backOffset[1].z, 0.0, LERP_VALUE))
                    offsetRot = offsetRot + vector3(lerp(backOffset[2].x, 0.0, LERP_VALUE), lerp(backOffset[2].y, 0.0, LERP_VALUE), lerp(backOffset[2].z, 0.0, LERP_VALUE))

                    DetachEntity(bed, 0, 0)
                    AttachEntityToEntity(bed, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)

                    LERP_VALUE = LERP_VALUE + (1.0 * Timestep()) / 4.0

                    if LERP_VALUE >= 1.0 then
                        state = 0
                        DecorSetInt(veh, "flatbed3_state", state)
                        LERP_VALUE = 0.0
                    end
                else
                    state = 0
                    DecorSetInt(veh, "flatbed3_state", state)
                end

                if not IsPedInVehicle(ped, veh, true) then

                end
            end
        end

        Wait(waitFlat)
    end
end)

function DrawText3DFlatbet(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextEntry("STRING")
  SetTextCentre(1)
  SetTextColour(255, 255, 255, 255)
  SetTextOutline()
  
  AddTextComponentString(text)
  DrawText(_x, _y)

  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 31, 31, 31, 155)
end
