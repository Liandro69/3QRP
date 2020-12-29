local guiEnabled = false
local success = false
local action = nil
local trigger = nil

mythic_action = {
    name = "",
}

function DisplayNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent('lsrp-lockpick:StartLockpick')
AddEventHandler('lsrp-lockpick:StartLockpick', function(n, cb)

    TriggerEvent("mythic_progbar:client:progress", {
        name = "preparing_lockpick",
        duration = 5000,
        label = "Preparing Lockpick Set",
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
                tries = n,
                enable = true,
            })
            Citizen.CreateThread(function()
                while true do
                    if action == 'success' then
                    action = nil
                    cb(true)
                    ClearPedTasksImmediately(PlayerPedId())
                    break
                    elseif action == 'failed' then
                    action = nil
                    TriggerEvent("pNotify:SendNotification", {
                        text = "You <font color='red'>Failed</font> to lockpick",
                        type = "error",
                        queue = "joints",
                        timeout = 5000,
                        layout = "bottomCenter"
                    })
                    cb(false)
                    ClearPedTasksImmediately(PlayerPedId())
                    break
                    end
                    Citizen.Wait(10)
                end
            end)

        end
    end)

end)

RegisterNUICallback('escape', function(data, cb)
    SetNuiFocus(false)
    guiEnabled = false
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

            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate

            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        else
            Citizen.Wait(1500)
        end
        Citizen.Wait(10)
    end
end)