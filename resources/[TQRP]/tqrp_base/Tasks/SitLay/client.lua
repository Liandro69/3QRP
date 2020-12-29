-- // OPTIMIZE PAIR!
local ObjectAr = {}
local currObject = 0

-- // BASIC
local InUse = false
local IsTextInUse = false
local PlyLastPos = 0

-- // ANIMATION
local Anim = "sentado"
local AnimScroll = 0

-- // WHEN YOU ARE OUT OF RANGE, IT DOSENT TICK EVERY MS!
local canSleep = false

CreateThread(function()
    local sleep = 2000
    while true do
        Wait(sleep)
        if (InUse == false) and (canSleep == true) then
            plyCoords = GetEntityCoords(PlayerPedId(), 0)
            local oObject = nil
            for k, v in pairs(Config.objects.locations) do
                if v.object ~= nil then
                    oObject = GetClosestObjectOfType(plyCoords.x, plyCoords.y, plyCoords.z, 1.0, GetHashKey(v.object), 0, 0, 0)
                elseif v.hash ~= nil then
                    oObject = GetClosestObjectOfType(plyCoords.x, plyCoords.y, plyCoords.z, 1.0, v.hash, 0, 0, 0)
                end
                if (oObject ~= 0) then
                    local oObjectCoords = GetEntityCoords(oObject)
                    local ObjectDistance = #(vector3(oObjectCoords) - plyCoords)
                    if (ObjectDistance < 2) and DoesEntityExist(oObject) then
                        currObject = oObject
                        ObjectAr = {
                            fObject = oObject,
                            fObjectCoords = oObjectCoords,
                            fObjectcX = v.verticalOffsetX,
                            fObjectcY = v.verticalOffsetY,
                            fObjectcZ = v.verticalOffsetZ,
                            fObjectDir = v.direction,
                            fObjectIsBed = v.bed
                        }
                        sleep = 7
                        break
                    end
                else
                    sleep = 2000
                end
                Citizen.Wait(250)
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(7)
        canSleep = true
        if ObjectAr.fObject ~= nil then
            ply = PlayerPedId()
            plyCoords = GetEntityCoords(ply, 0)
            ObjectCoords = ObjectAr.fObjectCoords
            local ObjectDistance = #(vector3(ObjectCoords) - plyCoords)
            if (ObjectDistance < 1.8 and not InUse) then
                if (ObjectAr.fObjectIsBed) == true then
                    
                    --[[ ARROW RIGHT ]]
                    if IsControlJustPressed(0, 175) then -- right
                        if (AnimScroll ~= 2) then
                            AnimScroll = AnimScroll + 1
                        end
                        if AnimScroll == 1 then
                            Anim = "costas"
                        elseif AnimScroll == 2 then
                            Anim = "barriga para baixo"
                        end
                    end
                    
                    --[[ ARROW LEFT ]]
                    if IsControlJustPressed(0, 174) then -- left
                        if (AnimScroll ~= 0) then
                            AnimScroll = AnimScroll - 1
                        end
                        if AnimScroll == 1 then
                            Anim = "costas"
                        elseif AnimScroll == 0 then
                            Anim = "sentado"
                        end
                    end
                    
                    if not inUse then
                        DisplayHelpText("[~g~E~w~] para deitar" .. ' ' .. Anim .. '       ' .. "[~g~SETAS~w~] para trocar", GetEntityCoords(ObjectAr.fObject))
                    end
                    if IsControlJustPressed(0, Config.objects.ButtonToLayOnBed) then
                        TriggerServerEvent('ChairBedSystem:Server:Enter', ObjectAr, ObjectCoords)
                    end
                elseif not inUse then
                    DisplayHelpText("[~g~G~w~] para sentar", GetEntityCoords(ObjectAr.fObject))
                    if IsControlJustPressed(0, Config.objects.ButtonToSitOnChair) then
                        TriggerServerEvent('ChairBedSystem:Server:Enter', ObjectAr, ObjectCoords)
                    end
                end
            end
            
            if (inUse) then
                DisplayHelpText("[~g~F~w~] para levantar", GetEntityCoords(ObjectAr.fObject))
                if IsControlJustPressed(0, Config.objects.ButtonToStandUp) then
                    inUse = false
                    TriggerServerEvent('ChairBedSystem:Server:Leave', ObjectAr.fObjectCoords)
                    --FreezeEntityPosition(ObjectAr.fObject, false)
                    ClearPedTasksImmediately(ply)
                    FreezeEntityPosition(ply, false)
                    
                    local x, y, z = table.unpack(PlyLastPos)
                    if GetDistanceBetweenCoords(x, y, z, plyCoords) < 10 then
                        SetEntityCoords(ply, PlyLastPos)
                    end
                end
            end
        end
        if canSleep then
            Citizen.Wait(1500)
        end
    end
end)

CreateThread(function()
	while Config.Healing ~= 0 do
		Citizen.Wait(Config.Healing*1000)
		if inUse == true then
            if ObjectAr.fObjectIsBed == true then
                local oPlayer = PlayerPedId()
				local health = GetEntityHealth(oPlayer)
				if health <= 199 then
					SetEntityHealth(oPlayer,health+1)
				end
			end
		end
	end
end)

RegisterNetEvent('ChairBedSystem:Client:Animation')
AddEventHandler('ChairBedSystem:Client:Animation', function(v, objectcoords)
    local object = v.fObject
    local vertx = v.fObjectcX
    local verty = v.fObjectcY
    local vertz = v.fObjectcZ
    local dir = v.fObjectDir
    local isBed = v.fObjectIsBed
    local objectcoords = objectcoords
    
    local ped = PlayerPedId()
    PlyLastPos = GetEntityCoords(ped)
    --FreezeEntityPosition(object, true)
    FreezeEntityPosition(ped, true)
    inUse = true
    if isBed == false then
        if Config.objects.SitAnimation.dict ~= nil then
            SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
            SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
            local dict = Config.objects.SitAnimation.dict
            local anim = Config.objects.SitAnimation.anim
            
            AnimLoadDict(dict, anim, ped)
        else
            TaskStartScenarioAtPosition(ped, Config.objects.SitAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + dir, 0, true, true)
        end
    else
        if Anim == 'costas' then
            if Config.objects.BedBackAnimation.dict ~= nil then
                SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
                SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
                local dict = Config.objects.BedBackAnimation.dict
                local anim = Config.objects.BedBackAnimation.anim
                
                Animation(dict, anim, ped)
            else
                TaskStartScenarioAtPosition(ped, Config.objects.BedBackAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + dir, 0, true, true
            )
            end
        elseif Anim == 'barriga para baixo' then
            if Config.objects.BedStomachAnimation.dict ~= nil then
                SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
                SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
                local dict = Config.objects.BedStomachAnimation.dict
                local anim = Config.objects.BedStomachAnimation.anim
                
                Animation(dict, anim, ped)
            else
                TaskStartScenarioAtPosition(ped, Config.objects.BedStomachAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + dir, 0, true, true)
            end
        elseif Anim == "sentado" then
            if Config.objects.BedSitAnimation.dict ~= nil then
                SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
                SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
                local dict = Config.objects.BedSitAnimation.dict
                local anim = Config.objects.BedSitAnimation.anim
                
                Animation(dict, anim, ped)
            else
                TaskStartScenarioAtPosition(ped, Config.objects.BedSitAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + 180.0, 0, true, true)
            end
        end
    end
end)

function DisplayHelpText(text, coords)
    DrawText3DTest(coords, text, 0.25)
    canSleep = false
end

function DrawText3DTest(coords, text, size)

    local onScreen,_x,_y=World3dToScreen2d(coords.x,coords.y,coords.z+0.5)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(size, size)
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

function Animation(dict, anim, ped)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    
    TaskPlayAnim(ped, dict, anim, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
end
