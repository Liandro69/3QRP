RegisterNetEvent('mythic_hospital:client:RPCheckPos')
AddEventHandler('mythic_hospital:client:RPCheckPos', function()
    TriggerServerEvent('mythic_hospital:server:RPRequestBed', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('mythic_hospital:client:RPSendToBed')
AddEventHandler('mythic_hospital:client:RPSendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    SetBedCam()

    Citizen.CreateThread(function()
        local scaleform = InBedTooltip('instructional_buttons', false)
        while bedOccupyingData ~= nil do
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            if IsControlJustReleased(0, Config.Keys.GetUp) then
                LeaveBed()
            end
            Citizen.Wait(1)
        end
    end)
    Citizen.CreateThread(function()
        while bedOccupying ~= nil do
            Citizen.Wait(70000)
            local oPlayer = PlayerPedId()
            local health = GetEntityHealth(oPlayer)
            if health <= 199 then
                SetEntityHealth(oPlayer,health+1)
            end
        end
    end)
end)

RegisterNetEvent('mythic_hospital:client:SendToBed')
AddEventHandler('mythic_hospital:client:SendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    SetBedCam()

    Citizen.CreateThread(function ()
        Citizen.Wait(5)
        local player = PlayerPedId()

        exports['mythic_notify']:SendAlert('inform', Config.Strings.BeingTreated)
        exports['mythic_progbar']:Progress({
            name = "hospital",
            duration = Config.AIHealTimer * 1000,
            label = "A receber tratamento",
            useWhileDead = true,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(status)
            if not status then
                TriggerServerEvent('mythic_hospital:server:EnteredBed')
            end
        end)
    end)
end)

RegisterNetEvent('mythic_hospital:client:ForceLeaveBed')
AddEventHandler('mythic_hospital:client:ForceLeaveBed', function()
    LeaveBed()
end)