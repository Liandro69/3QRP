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
        print("run")
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