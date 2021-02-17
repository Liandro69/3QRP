--[[
    PLEASE LEAVE THIS INTACT
    Lockpicking MiniGame Coded by Chris Rogers for GTAV Use
    Original Javascript was used from CodePen https://codepen.io/anon/pen/ydOeLo
    Copyright 2019 All Rights Reserved
    Please Do not Rename the resource, i use the name to see how many people are using the resource on statistics.
]]

ESX = nil
local guiEnabled = false
local success = false
local action = nil
local trigger = nil
local npins = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

function DisplayNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent('lsrp-lockpick:StartLockpickfo')
AddEventHandler('lsrp-lockpick:StartLockpickfo', function(cb)
    ESX.TriggerServerCallback('lsrp-lockpickfo:getBobbyPins', function(pins, screwdriver)
        if screwdriver > 0 then
        if pins > 0 then
    TriggerEvent("mythic_progbar:client:progress", {
        name = "preparing_lockpick",
        duration = 3000,
        label = "Preparing Tools",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
        },
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
        }
    }, function(status)
        if not status then
            SetNuiFocus(true)
            guiEnabled = true
            SendNUIMessage({
                type = "enableui",
                pins = pins,
                enable = true,
            })
            Citizen.CreateThread(function()
                while true do
                    if action == 'success' then
                    action = nil
                    cb(true)
                    break
                    elseif action == 'failed' then
                    action = nil
                    TriggerEvent("pNotify:SendNotification", {
                        text = "All of your your <font color='yellow'>BobbyPins</font> have <font color='red'>broke</font>",
                        type = "error",
                        queue = "lockpickfo",
                        timeout = 5000,
                        layout = "bottomCenter"
                    })
                    cb(false)
                    break
                    end
                    Citizen.Wait(10)
                end
            end)

        end
    end)    

    else
        TriggerEvent("pNotify:SendNotification", {
            text = "You do not have any <font color='red'>Bobby Pins</font>",
            type = "error",
            queue = "lockpickfo",
            timeout = 5000,
            layout = "bottomCenter"
        })
    end
    else
        TriggerEvent("pNotify:SendNotification", {
            text = "You do not have a <font color='red'>Screwdriver</font>",
            type = "error",
            queue = "lockpickfo",
            timeout = 5000,
            layout = "bottomCenter"
        })        
    end
    end, source)



end)

RegisterNUICallback('escape', function(data, cb)
    SetNuiFocus(false)
    guiEnabled = false
    cb('ok')
end)

RegisterNUICallback('removepin', function(data, cb)
    TriggerServerEvent('lsrp-lockpickfo:removePin')
    cb('ok')
end)

RegisterNUICallback('process', function(data, cb)
    SetNuiFocus(false)
    guiEnabled = false
    if data.state then
        action = 'success'
    else
        action = 'failed'
    end
    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        if guiEnabled then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown

            --DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate

            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click",
                    pins = npins
                })
            end
        else
            Citizen.Wait(1500)
        end
        Citizen.Wait(10)
    end
end)