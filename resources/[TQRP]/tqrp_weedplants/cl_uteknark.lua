ESX = nil
local table = table
local plantingTargetOffset = vector3(0,2,-3)
local plantingSpaceAbove = vector3(0,0,Config.Distance.Above)
local rayFlagsLocation = 17
local rayFlagsObstruction = 273
local activePlants = {}
local selling = false
local secondsRemaining
local sold = false
local playerHasDrugs = nil
local pedIsTryingToSellDrugs = false
local dst = nil
local registerStrings = {
    'status_active',
    'status_passive',
}

--SELLLL PART

--[[ Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/venderdroga', 'Vender droga a locais.')
end)


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

--TIME TO SELL
Citizen.CreateThread(function()
	while true do
        if selling then
            TriggerEvent("mythic_progbar:client:progress", {
                name = "unique_action_name",
                duration = Config.TimeToSell*1000,
                label = "A negociar...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }
            }, function (status)
                if not status then
                    local pid = PlayerPedId()
                    RequestAnimDict("mp_safehouselost@")
                    while (not HasAnimDictLoaded("mp_safehouselost@")) do
                        Citizen.Wait(10)
                    end
                    
                     if IsEntityPlayingAnim(ped, "mp_safehouselost@", "package_dropoff", 3) then

                     TaskPlayAnim(pid, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)

                     else

                     TaskPlayAnim(pid, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)

                    end
                    attachModel = GetHashKey("prop_drug_package_02")
                    SetCurrentPedWeapon(PlayerPedId(), 0xA2719263)
                    local bone = GetPedBoneIndex(PlayerPedId(), 28422)
                    RequestModel(attachModel)
                    while not HasModelLoaded(attachModel) do
                        Citizen.Wait(100)
                    end
                    closestEntity = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
                    AttachEntityToEntity(closestEntity, PlayerPedId(), bone, 0.02, 0.02, -0.08, 270.0, 180.0, 0.0, 1, 1, 0, true, 2, 1)
                    Citizen.Wait(2300)
                    if DoesEntityExist(closestEntity) then
                        DeleteEntity(closestEntity)
                    end
                    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), 1)
                    selling = false
                    SetEntityAsMissionEntity(oldped)
                    SetPedAsNoLongerNeeded(oldped)
                    FreezeEntityPosition(oldped,false)
                    StopAnimTask(pid, "mp_common","givetake1_a", 1.0)
                    playerHasDrugs = false
                    sold = false
                    TriggerServerEvent('sellDrugs')
                end
                  if not status then
                    local pid = PlayerPedId()
                    RequestAnimDict("mp_common")
                    while (not HasAnimDictLoaded("mp_common")) do
                        Citizen.Wait(10)
                    end
                    TaskPlayAnim(pid,"mp_common","givetake1_a",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
                    attachModel = GetHashKey("prop_drug_package_02")
                    SetCurrentPedWeapon(PlayerPedId(), 0xA2719263)
                    local bone = GetPedBoneIndex(PlayerPedId(), 28422)
                    RequestModel(attachModel)
                    while not HasModelLoaded(attachModel) do
                        Citizen.Wait(100)
                    end
                    closestEntity = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
                    AttachEntityToEntity(closestEntity, PlayerPedId(), bone, 0.02, 0.02, -0.08, 270.0, 180.0, 0.0, 1, 1, 0, true, 2, 1)
                    Citizen.Wait(1500)
                    if DoesEntityExist(closestEntity) then
                        DeleteEntity(closestEntity)
                    end
                    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), 1)
                    selling = false
                    SetEntityAsMissionEntity(oldped)
                    SetPedAsNoLongerNeeded(oldped)
                    FreezeEntityPosition(oldped,false)
                    StopAnimTask(pid, "mp_common","givetake1_a", 1.0)
                    playerHasDrugs = false
                    sold = false
                    TriggerServerEvent('sellDrugs')
                end
            end)
            selling = false
        else
            Citizen.Wait(1500)
        end
		Citizen.Wait(1500)
	end
end) ]]

--[[ local canSell = false
local looping = false

function Sell()
    canSell = true
    if not looping then
        sellDrugzzz()
    end
end


RegisterCommand(
	"venderdroga",
	function()
	Sell()
	end
)

--Show help notification ("PRESS E...")
RegisterNetEvent('playerhasdrugs')
AddEventHandler('playerhasdrugs', function()
	playerHasDrugs = true
end)

function sellDrugzzz()
    Citizen.CreateThread(function()
        local player = PlayerPedId()
        local playerloc = GetEntityCoords(player, 0)
        local handle, ped = FindFirstPed()
        looping = true
        repeat
            success, ped = FindNextPed(handle)
            local pos = GetEntityCoords(ped)
            dst = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
            local distanceFromCity = GetDistanceBetweenCoords(Config.CityPoint.x, Config.CityPoint.y, Config.CityPoint.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
            if IsPedInAnyVehicle(PlayerPedId()) == false then
                if distanceFromCity < Config.DistanceFromCity then
                    if DoesEntityExist(ped) then
                        if not IsPedDeadOrDying(ped) then
                            local pedType = GetPedType(ped)
                            if pedType ~= 28 and IsPedAPlayer(ped) == false then
                                if dst <= 1 and ped ~= PlayerPedId() and ped ~= oldped and canSell then
                                    canSell = false
                                    playerHasDrugs = false
                                    local cops = nil
                                    ESX.TriggerServerCallback('tqrp_base:getJobsOnline', function(ems, police, mechano)
                                        cops = police
                                    end)
                                    while cops == nil do
                                        Citizen.Wait(100)
                                    end
                                    if cops >= Config.CopsRequiredToSell then
                                        playerHasDrugs = nil
                                        TriggerServerEvent('check')
                                        while playerHasDrugs == nil do
                                            Citizen.Wait(100)
                                        end 
                                        if playerHasDrugs and sold == false and selling == false then
                                            --PED REJECT OFFER
                                            local random = math.random(1, Config.PedRejectPercent)
                                            TaskTurnPedToFaceEntity(PlayerPedId(), ped, 1)
                                            if random == Config.PedRejectPercent then
                                                exports['mythic_notify']:SendAlert('error', 'FDP Disse que não quer nada disto')
                                                oldped = ped
                                                --PED CALLING COPS
                                                if Config.CallCops then
                                                    local randomReport = math.random(1, Config.CallCopsPercent)
                                                    if randomReport == Config.CallCopsPercent then
                                                        local playerCoords = GetEntityCoords(PlayerPedId())
                                                        DecorSetInt(PlayerPedId(), "IsOutlaw", 2)
                                                        TriggerServerEvent("tqrp_outlawalert:drugsaleInProgress",
                                                            'police', "Venda Ilegal", "Desconhecido", "person", "gps_fixed", 1, 
                                                            playerCoords.x, playerCoords.y, playerCoords.z, 140, 75, "10-10"
                                                        )
                                                    end
                                                end
                                                TriggerEvent("sold")
                                            --PED ACCEPT OFFER
                                            else
                                                SetEntityAsMissionEntity(ped)
                                                ClearPedTasks(ped)
                                                FreezeEntityPosition(ped,true)
                                                oldped = ped
                                                TaskStandStill(ped, 9)
                                                pos1 = GetEntityCoords(ped)
                                                TriggerEvent("sellingdrugs")
                                            end
                                        else
                                            print("1")
                                        end
                                    else
                                        exports["mythic_notify"]:SendAlert("error", "Não podes fazer isso agora")
                                    end
                                    
                                end
                            end
                        else
                            canSell = false
                        end
                    else
                        canSell = false
                        Citizen.Wait(1500)
                    end
                else
                    canSell = false
                    Citizen.Wait(1500)
                end
            else
                canSell = false
                Citizen.Wait(1500)
            end
        until not success and not canSell
        looping = false
        EndFindPed(handle)
    end)

end ]]



-- TESTE TESTE
--[[
Citizen.CreateThread(function()
	while true do
		Wait(10)
        if selling then
			--TOO FAR
			if dst > 5 then
                exports['mythic_notify']:SendAlert('inform', 'Ele ficou com medo de ti')
				selling = false
				SetEntityAsMissionEntity(oldped)
				SetPedAsNoLongerNeeded(oldped)
				FreezeEntityPosition(oldped,false)
			end
        else
            Citizen.Wait(1500)
        end
	end
end)
--]]
--[[ RegisterNetEvent('sellingdrugs')
AddEventHandler('sellingdrugs', function()
	secondsRemaining = Config.TimeToSell + 1
	selling = true
end)

RegisterNetEvent('sold')
AddEventHandler('sold', function()
	sold = false
	selling = false
	secondsRemaining = 0
end)
 ]]
--Info that you dont have drugs
--[[ RegisterNetEvent('nomoredrugs')
AddEventHandler('nomoredrugs', function()
    --exports.pNotify:SendNotification({text = "Não tens mais droga para vender", type = "alert", layout="topRight" ,timeout = 5000})
    exports['mythic_notify']:SendAlert('inform', 'N tens mais droga pra vender')
	playerHasDrugs = false
	sold = false
	selling = false
	secondsRemaining = 0
end) ]]

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())

	local scale = 0.3

	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(6)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
	end
end

--END OF SELL PART

for i,entry in ipairs(registerStrings) do
    AddTextEntry('uteknark_'..entry, _U(entry))
end

function interactHelp(stage,action)
    BeginTextCommandDisplayHelp('uteknark_status_active')
    AddTextComponentInteger(stage)
    AddTextComponentInteger(#Growth)
    AddTextComponentSubstringPlayerName(action)
    EndTextCommandDisplayHelp(0, false, false, 1)
end
function passiveHelp(stage,status)
    BeginTextCommandDisplayHelp('uteknark_status_passive')
    AddTextComponentInteger(stage)
    AddTextComponentInteger(#Growth)
    AddTextComponentSubstringPlayerName(status)
    EndTextCommandDisplayHelp(0, false, false, 1)
end

function makeToast(subject,message)
    local dict = 'bkr_prop_weed'
    local icon = 'prop_cannabis_leaf_dprop_cannabis_leaf_a'
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict)
        while not HasStreamedTextureDictLoaded(dict) do
            Citizen.Wait(10)
        end
    end

    -- BeginTextCommandThefeedPost("STRING")
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(message)
    --EndTextCommandThefeedPostMessagetext(
    SetNotificationMessage(
        dict, -- texture dict
        icon, -- texture name
        true, -- fade
        0, -- icon type
        'UteKnark', -- Sender
        subject
    )
    --EndTextCommandThefeedPostTicker(
    DrawNotification(
        false, -- important
        false -- has tokens
    )
    SetStreamedTextureDictAsNoLongerNeeded(icon)
end

function serverlog(...)
    TriggerServerEvent('tqrp_uteknark:log',...)
end

RegisterNetEvent('tqrp_uteknark:make_toast')
AddEventHandler ('tqrp_uteknark:make_toast', function(subject,message)
    makeToast(subject, message)
end)


function flatEnough(surfaceNormal)
    local x = math.abs(surfaceNormal.x)
    local y = math.abs(surfaceNormal.y)
    local z = math.abs(surfaceNormal.z)
    return (
        x <= Config.MaxGroundAngle
        and
        y <= Config.MaxGroundAngle
        and
        z >= 1.0 - Config.MaxGroundAngle
    )
end

function getPlantingLocation(visible)

    -- TODO: Refactor this *monster*, plx!
    local ped = PlayerPedId()

    if IsPedInAnyVehicle(ped) then
        return false, 'planting_in_vehicle' -- The rest can all nil out
    end

    local playerCoord = GetEntityCoords(ped)
    local target = GetOffsetFromEntityInWorldCoords(ped, plantingTargetOffset)
    local testRay = StartShapeTestRay(playerCoord, target, rayFlagsLocation, ped, 7) -- This 7 is entirely cargo cult. No idea what it does.
    local _, hit, hitLocation, surfaceNormal, material, _ = GetShapeTestResultEx(testRay)

    if hit == 1 then
        debug('Material:', material)
        debug('Hit location:', hitLocation)
        debug('Surface normal:', surfaceNormal)

        if Config.Soil[material] then
            debug('Soil quality:',Config.Soil[material])
            if flatEnough(surfaceNormal) then
                local plantDistance = #(playerCoord - hitLocation)
                debug(plantDistance)
                if plantDistance <= Config.Distance.Interact then
                    local hits = cropstate.octree:searchSphere(hitLocation, Config.Distance.Space)
                    if #hits > 0 then
                        debug('Found another plant too close')
                        if visible then
                            for i, hit in ipairs(hits) do
                                DrawLine(hitLocation, hit.bounds.location, 255, 0, 255, 100)
                            end
                            DebugSphere(hitLocation, 0.1, 255, 0, 255, 100)
                            DrawLine(playerCoord, hitLocation, 255, 0, 255, 100)
                        end
                        return false, 'planting_too_close', hitLocation, surfaceNormal, material
                    else
                        if visible then
                            DebugSphere(hitLocation, 0.1, 0, 255, 0, 100)
                            DrawLine(playerCoord, hitLocation, 0, 255, 0, 100)
                        end
                        local aboveTarget = hitLocation + plantingSpaceAbove
                        local aboveRay = StartShapeTestRay(hitLocation, aboveTarget, rayFlagsObstruction, ped, 7)
                        local _,hitAbove,hitAbovePoint = GetShapeTestResult(aboveRay)
                        if hitAbove == 1 then
                            if visible then
                                debug('Obstructed above')
                                DrawLine(hitLocation, hitAbovePoint, 255, 0, 0, 100)
                                DebugSphere(hitAbovePoint, 0.1, 255, 0, 0, 100)
                            end
                            return false, 'planting_obstructed', hitLocation, surfaceNormal, material
                        else
                            if visible then
                                DrawLine(hitLocation, aboveTarget, 0, 255, 0, 100)
                                DebugSphere(hitAbovePoint, 0.1, 255, 0, 0, 100)
                                debug('~g~planting OK')
                            end
                            return true,'planting_ok', hitLocation, surfaceNormal, material
                        end
                    end
                else
                    if visible then
                        DebugSphere(hitLocation, 0.1, 0, 128, 0, 100)
                        DrawLine(playerCoord, hitLocation, 0, 128, 0, 100)
                        debug('Target too far away')
                    end
                    return false, 'planting_too_far', hitLocation, surfaceNormal, material
                end
            else
                if visible then
                    DebugSphere(hitLocation, 0.1, 0, 0, 255, 100)
                    DrawLine(playerCoord, hitLocation, 0, 0, 255, 100)
                    debug('Location too steep')
                end
                return false, 'planting_too_steep', hitLocation, surfaceNormal, material
            end
        else
            if visible then
                debug('Not plantable soil')
                DebugSphere(hitLocation, 0.1, 255, 255, 0, 100)
                DrawLine(playerCoord, hitLocation, 255, 255, 0, 100)
            end
            return false, 'planting_not_suitable_soil', hitLocation, surfaceNormal, material
        end
    else
        if visible then
            debug('Ground not found')
            DrawLine(playerCoord, target, 255, 0, 0, 255)
        end
        return false, 'planting_too_steep', hitLocation, surfaceNormal, material
    end

end

function GetHeadingFromPoints(a, b)

    if not a or not b then
        return 0.0
    end
    if a.x == b.x and a.y == b.y then
        return 0.0
    end
    if #(a - b) < 1 then
        return 0.0
    end

    local theta = math.atan(b.x - a.x,a.y - b.y)
    if theta < 0.0 then
        theta = theta + (math.pi * 2)
    end
    return math.deg(theta) + 180 % 360
end

local inScenario = false
local WEAPON_UNARMED = 'WEAPON_UNARMED'
local lastAction = 0
function RunScenario(name, facing)
    local playerPed = PlayerPedId()
    ClearPedTasks(playerPed)
    SetCurrentPedWeapon(playerPed, WEAPON_UNARMED)
    if facing then
        local heading = GetHeadingFromPoints(GetEntityCoords(playerPed), facing)
        SetEntityHeading(playerPed, heading)
        Citizen.Wait(10) -- So it syncs before we start the scenario!
    end
    TaskStartScenarioInPlace(playerPed, name, 0, true)
    inScenario = true
end

RegisterNetEvent('tqrp_uteknark:do')
AddEventHandler ('tqrp_uteknark:do', function(scenarioName, location)
    if Config.Scenario[scenarioName] then
        print("Got order for scenario " .. scenarioName)
        Citizen.CreateThread(function()
            local begin = GetGameTimer()
            RunScenario(Config.Scenario[scenarioName], location)
            while GetGameTimer() <= begin + Config.ScenarioTime do
                Citizen.Wait(10)
            end
            if inScenario then
                ClearPedTasks(PlayerPedId())
            end
            inScenario = false
            print("Scenario "..scenarioName.." ends")
        end)
    else
        print("Got ordered to do invalid scenario "..scenarioName)
    end
end)

RegisterNetEvent('tqrp_uteknark:attempt_plant')
AddEventHandler ('tqrp_uteknark:attempt_plant', function()
    local plantable, message, location, _, soil = getPlantingLocation()
    if plantable then
        TriggerServerEvent('tqrp_uteknark:success_plant', location, soil)
        lastAction = GetGameTimer()
    end
end)

function DrawIndicator(location, color)
    local range = 1.0
    DrawMarker(
        6, -- type (6 is a vertical and 3D ring)
        location,
        0.0, 0.0, 0.0, -- direction (?)
        -90.0, 0.0, 0.0, -- rotation (90 degrees because the right is really vertical)
        range, range, range, -- scale
        color[1], color[2], color[3], color[4],
        false, -- bob
        false, -- face camera
        2, -- dunno, lol, 100% cargo cult
        false, -- rotates
        0, 0, -- texture
        false -- Projects/draws on entities
    )
end

Citizen.CreateThread(function()
    local drawDistance = Config.Distance.Draw
    drawDistance = drawDistance * 1.01 -- So they don't fight about it, culling is at a slightly longer range
    while true do
        local now = GetGameTimer()
        local playerPed = PlayerPedId()
        if #activePlants > 0 then
            local myLocation = GetEntityCoords(playerPed)
            local closestDistance
            local closestPlant
            local closestIndex
            for i,plant in ipairs(activePlants) do
                local distance = #(plant.at - myLocation)
                if not DoesEntityExist(plant.object) then
                    table.remove(activePlants, i)
                elseif distance > drawDistance then
                    DeleteObject(plant.object)
                    plant.node.data.object = nil
                    table.remove(activePlants, i)
                elseif not closestDistance or distance < closestDistance then
                    closestDistance = distance
                    closestPlant = plant
                    closestIndex = i
                end
            end
            if closestDistance and not IsPedInAnyVehicle(playerPed) then
                if closestDistance <= Config.Distance.Interact then
                    local stage = Growth[closestPlant.stage]
                    --DrawIndicator(closestPlant.at + stage.marker.offset, stage.marker.color)
                    DisableControlAction(0, 44, true) -- Disable INPUT_COVER, as it's used to destroy plants
                    if now >= lastAction + Config.ActionTime then
                        if IsDisabledControlJustPressed(0, 44) then
                            lastAction = now
                            table.remove(activePlants, closestIndex)
                            DeleteObject(closestPlant.object)
                            TriggerServerEvent('tqrp_uteknark:remove', closestPlant.id, myLocation)
                        else
                            if stage.interact then
                                interactHelp(closestPlant.stage, _U(stage.label))
                                if IsControlJustPressed(0, 38) then
                                    lastAction = now
                                    TriggerServerEvent('tqrp_uteknark:frob', closestPlant.id, myLocation)
                                end
                            else
                                passiveHelp(closestPlant.stage, _U(stage.label))
                            end
                        end
                    end
                end
            end
            Citizen.Wait(10)
        else
            Citizen.Wait(1500)
        end
    end
end)

Citizen.CreateThread(function()
    local drawDistance = Config.Distance.Draw
    while true do
        local here = GetEntityCoords(PlayerPedId())
        cropstate.octree:searchSphereAsync(here, drawDistance, function(entry)
            if not entry.data.object and not entry.data.deleted then
                local stage = entry.data.stage or 1
                local model = Growth[stage].model
                if not model or not IsModelValid(model) then
                    Citizen.Trace(tostring(model).." is not a valid model!\n")
                    model = 'prop_mp_cone_01'
                end
                if not HasModelLoaded(model) then
                    RequestModel(model)
                    local begin = GetGameTimer()
                    while not HasModelLoaded(model) and GetGameTimer() < begin + 2500 do
                        Citizen.Wait(10)
                    end
                end
                if not HasModelLoaded(model) then
                    Citizen.Trace("Failed to load model for growth stage " .. stage ..", but will retry shortly!\n")
                    Citizen.Wait(2500)
                else
                    local offset = Growth[stage].offset or vector3(0,0,0)
                    local weed = CreateObject(model, entry.bounds.location + offset, false, false, false)
                    local heading = math.random(0,359) * 1.0
                    SetEntityHeading(weed, heading)
                    FreezeEntityPosition(weed, true)
                    SetEntityCollision(weed, false, true)
                    SetEntityLodDist(weed, math.floor(drawDistance))
                    table.insert(activePlants, {node=entry, object=weed, at=entry.bounds.location, stage=stage, id=entry.data.id})
                    entry.data.object = weed
                    SetModelAsNoLongerNeeded(model)
                end
            end
        end, true)
        Citizen.Wait(8000)
    end
end)


function deleteActivePlants()
    for i,plant in ipairs(activePlants) do
        if DoesEntityExist(plant.object) then
            DeleteObject(plant.object)
        end
    end
    activePlants = {}
end


AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        deleteActivePlants()
        if inScenario then
            ClearPedTasksImmediately(PlayerPedId())
        end
    end
end)

RegisterNetEvent('tqrp_uteknark:toggle_debug')
AddEventHandler ('tqrp_uteknark:toggle_debug', function()
    if not debug.active then
        serverlog('enabled debugging')
        debug.active = true
    else
        serverlog('disabled debugging')
        debug.active = false
    end
end)

RegisterNetEvent('tqrp_uteknark:pyromaniac')
AddEventHandler ('tqrp_uteknark:pyromaniac',function(location)
    if Config.Burn.Enabled then
        local myLocation = GetEntityCoords(PlayerPedId())
        if not location then
            location = myLocation + vector3(0,0,-1) -- Because the ped location is one meter off the ground.
        end
        if #(location - myLocation) <= Config.Distance.Draw then
            Citizen.CreateThread(function()
                local begin = GetGameTimer()
                if not HasNamedPtfxAssetLoaded(Config.Burn.Effect) then
                    RequestNamedPtfxAsset(Config.Burn.Collection)
                    while not HasNamedPtfxAssetLoaded(Config.Burn.Collection) and GetGameTimer() <= begin + Config.Burn.Duration do
                        Citizen.Wait(10)
                    end
                    if not HasNamedPtfxAssetLoaded(Config.Burn.Collection) then
                        print("UteKnark failed to load particle effects asset "..Config.Burn.Collection)
                    end
                end
                UseParticleFxAsset(Config.Burn.Collection)
                local handle = StartParticleFxLoopedAtCoord(Config.Burn.Effect, location + Config.Burn.Offset, Config.Burn.Rotation, Config.Burn.Scale * 1.0, false, false, false)
                while GetGameTimer() <= begin + Config.Burn.Duration do
                    Citizen.Wait(10)
                end
                StopParticleFxLooped(handle, 0)
                RemoveNamedPtfxAsset(Config.Burn.Collection)
            end)
        end
    end
end)

Citizen.CreateThread(function()
    local ready = false
    while true do
        if ready then
            if NetworkIsSessionStarted() then
                ready = true
                cropstate:bulkData()
            else
                Citizen.Wait(1500)
            end
        else
            Citizen.Wait(1500) -- PODE DAR ERRO
        end
        Citizen.Wait(10)
    end
end)

RegisterNetEvent('tqrp_uteknark:groundmat')
AddEventHandler ('tqrp_uteknark:groundmat', function()
    local plantable, message, where, normal, material = getPlantingLocation(true)
    TriggerEvent("chat:addMessage", {args={'Ground material', material}})
    serverlog('Ground material:',material)

    if Config.Soil[material] then
        local quality = Config.Soil[material]
        TriggerEvent("chat:addMessage", {args={'Soil quality', quality}})
        serverlog('Soil quality:', quality)
    else
        TriggerEvent("chat:addMessage", {args={'Material not whitelisted'}})
        serverlog('Material not whitelisted')
    end
end)

RegisterNetEvent('tqrp_uteknark:test_forest')
AddEventHandler ('tqrp_uteknark:test_forest',function(count, randomStage)
    local origin = GetEntityCoords(PlayerPedId())

    TriggerEvent("chat:addMessage", {args={'UteKnark','Target forest size: '..count}})
    local column = math.ceil(math.sqrt(count))
    TriggerEvent("chat:addMessage", {args={'UteKnark','Column size: '..column}})

    local offset = (column * Config.Distance.Space)/2
    offset = vector3(-offset, -offset, 5)
    local cursor = origin + offset
    local planted = 0
    local forest = {}
    while planted < count do
        local found, Z = GetGroundZFor_3dCoord(cursor.x, cursor.y, cursor.z, false)
        if found then
            local stage = (planted % #Growth) + 1
            if randomStage then
                stage = math.random(#Growth)
            end
            table.insert(forest, {location=vector3(cursor.x, cursor.y, Z), stage=stage})
        end
        cursor = cursor + vector3(0, Config.Distance.Space, 0)
        planted = planted + 1
        if planted % column == 0 then
            Citizen.Wait(10)
            cursor = cursor + vector3(Config.Distance.Space, -(Config.Distance.Space * column), 0)
        end
    end
    TriggerEvent("chat:addMessage", {args={'UteKnark', 'Actual viable locations: '..#forest}})
    TriggerServerEvent('tqrp_uteknark:test_forest', forest)
end)
