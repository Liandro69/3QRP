ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local hospitalCheckin = {x = 306.99, y = -595.19, z = 43.28, h = 250.5}

local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil

local cam = nil

local inBedDict = "anim@gangops@morgue@table@"
local inBedAnim = "ko_front"
local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'

function PrintHelpText(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(10)
    end

    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    SetEntityInvincible(PlayerPedId(), false)
    SetEntityHeading(PlayerPedId(), bedOccupyingData.h - 90)
    TaskPlayAnim(PlayerPedId(), getOutDict , getOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('mythic_hospital:server:LeaveBed', bedOccupying)
    FreezeEntityPosition(bedObject, false)

    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
end

RegisterNetEvent('mythic_hospital:client:RPCheckPos')
AddEventHandler('mythic_hospital:client:RPCheckPos', function()
    TriggerServerEvent('mythic_hospital:server:RPRequestBed', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('mythic_hospital:client:RPSendToBed')
AddEventHandler('mythic_hospital:client:RPSendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z-1.0)

    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(10)
    end

    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)
    SetEntityInvincible(PlayerPedId(), true)
end)

RegisterNetEvent('mythic_hospital:client:SendToBed')
AddEventHandler('mythic_hospital:client:SendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data
    local playerPed = PlayerPedId()

    --bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    --FreezeEntityPosition(bedObject, true)
    TriggerEvent('tqrp_ambulancejob:revive')
    Citizen.Wait(850)
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(10)
    end
    SetEntityCoords(playerPed, data.x, data.y, data.z-1.0, false, false, false, false)
    Citizen.Wait(250)
    TaskPlayAnim(playerPed, inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(playerPed, data.h)
    FreezeEntityPosition(playerPed, true)
    --SetEntityInvincible(playerPed, true)

    --cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    --SetCamActive(cam, true)
    --RenderScriptCams(true, false, 1, true, true)
    --AttachCamToPedBone(cam, playerPed, 31085, 0, 0, 1.0 , true)
    --SetCamFov(cam, 90.0)
    --SetCamRot(cam, -90.0, 0.0, GetEntityHeading(playerPed) + 180, true)
    --SetEntityCoords(playerPed, data.x, data.y, data.z-1.0, false, false, false, false)
    TriggerEvent('smerfikubrania:koszulka')
    TriggerEvent('smerfikubrania:spodnie')
    TriggerEvent('smerfikubrania:buty')
    Citizen.CreateThread(function ()
        Citizen.Wait(10)
        exports['mythic_progbar']:Progress({
            name = "hp",
            duration = Config.AIHealTimer * 1000,
            label = "A Receber ajuda...",
            useWhileDead = true,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }
        }, function(status)
            if not status then
                TriggerServerEvent('mythic_hospital:server:EnteredBed')
                Citizen.Wait(500)
                ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
                TriggerServerEvent('tqrp_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_ambulance', "Despesas Médicas", 150)
            end
        end)
    end)
    
end)

RegisterNetEvent('mythic_hospital:client:FinishServices')
AddEventHandler('mythic_hospital:client:FinishServices', function()
	local player = PlayerPedId()
	
	if IsPedDeadOrDying(player) then
		local playerPos = GetEntityCoords(player, true)
		NetworkResurrectLocalPlayer(playerPos, true, true, false)
	end

    TriggerEvent('tqrp_ambulancejob:revive')
    SetPlayerSprint(PlayerId(), true)
    SetEntityHealth(player, GetEntityMaxHealth(player))
    TriggerEvent('mythic_hospital:client:RemoveBleed')
    TriggerEvent('mythic_hospital:client:ResetLimbs')
    exports['mythic_notify']:SendAlert('inform', 'Recebeste Alta Hospitalar')
    FreezeEntityPosition(player, false)
    LeaveBed()
end)

RegisterNetEvent('mythic_hospital:client:ForceLeaveBed')
AddEventHandler('mythic_hospital:client:ForceLeaveBed', function()
    LeaveBed()
end)

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)

    local scale = 0.29

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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            local plyCoords = GetEntityCoords(PlayerPedId(), 0)
            local distance = #(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z) - plyCoords)
            if distance < 10 then
                DrawMarker(27, hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z - 0.99, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                if distance < 3.5 then
                    DrawText3Ds(hospitalCheckin.x, hospitalCheckin.y, (hospitalCheckin.z + 0.25), 'Pressiona [~g~E~w~] para realizar uma consulta')
                    if IsControlJustReleased(0, 38) then
                        if (GetEntityHealth(PlayerPedId()) < 200) or (IsInjuredOrBleeding()) or IsPedDeadOrDying() then
                            ESX.TriggerServerCallback('tqrp_base:getJobsOnline', function(ems, police, mechano)
                                if ems < 1 then
                                    exports['mythic_progbar']:Progress({
                                        name = "hospital_action",
                                        duration = 15000,
                                        label = "A ser analisado...",
                                        useWhileDead = true,
                                        canCancel = true,
                                        controlDisables = {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                        },
                                        animation = {
                                            animDict = "missheistdockssetup1clipboard@base",
                                            anim = "base",
                                            flags = 49,
                                        }--[[,
                                        prop = {
                                            model = "p_amb_clipboard_01",
                                            bone = 18905,
                                            coords = { x = 0.10, y = 0.02, z = 0.08 },
                                            rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                        },
                                        propTwo = {
                                            model = "prop_pencil_01",
                                            bone = 58866,
                                            coords = { x = 0.12, y = 0.0, z = 0.001 },
                                            rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                        }]],
                                    }, function(status)
                                        if not status then
                                            TriggerServerEvent('mythic_hospital:server:RequestBed')
                                        end
                                    end)
                                else
                                    exports['mythic_notify']:SendAlert('error', 'Tens médicos em serviço! Vou chamá-los!')
                                    TriggerEvent('tqrp_outlawalert:exportName', function(name)
                                        TriggerServerEvent("tqrp_outlawalert:send911", nil, 'ambulance', "Central 911", name .. " - Necessito de uma consulta no Hospital!", "person", "gps_fixed", 1, hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z, 153, 2, "911")
                                    end)
                                end
                            end)
                        else
                            exports['mythic_notify']:SendAlert('error', 'Estás bem de saúde')
                        end
                    end
                end
            else
                Citizen.Wait(1500)
            end
        else
            Citizen.Wait(1500)
        end
    end
end)