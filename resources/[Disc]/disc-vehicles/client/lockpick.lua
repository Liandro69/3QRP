RegisterNetEvent('disc-vehicles:useLockpick')
AddEventHandler('disc-vehicles:useLockpick', function()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed) then
        local vehicle = GetVehiclePedIsIn(playerPed)
        TrackVehicle(vehicle, false, GetIsVehicleEngineRunning(vehicle))
        if not vehicles[vehicle].state then
            exports['mythic_notify']:SendAlert('inform', 'Starting Hotwire')
            exports['mythic_progbar']:Progress({
                name = "ligacao_direta",
                duration = math.floor(self.CookTimerA * 60 * 1000),
                label = "A arrancar painel...",
                useWhileDead = true,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {},
                prop = {},
                propTwo = {},
            })
            Citizen.Wait(5000)
            exports['mythic_progbar']:Progress({
                name = "ligacao_direta",
                duration = math.floor(self.CookTimerA * 60 * 1000),
                label = "A cortar os fios...",
                useWhileDead = true,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {},
                prop = {},
                propTwo = {},
            })
            Citizen.Wait(1500)
            exports['mythic_notify']:SendAlert('success', 'Hotwire completed')
        end
    else
        local vehicle = ESX.Game.GetVehicleInDirection()
        if vehicle then
            TrackVehicle(vehicle)
            Citizen.Wait(100)
            if not vehicles[vehicle].key then
                LockPick(playerPed, vehicle)
            end
        end
    end
end)

function LockPick(playerPed, veh)
    Citizen.CreateThread(function()
        ESX.Streaming.RequestAnimDict('missheistfbisetup1', function()
            TaskPlayAnim(playerPed, 'missheistfbisetup1', 'unlock_loop_janitor', 8.0, -8, -1, 49, 0, 0, 0, 0)
        end)
        inAnimation = true
        Citizen.Wait(Config.LockpickTime)
        ClearPedTasksImmediately(playerPed)
        PlayVehicleDoorOpenSound(veh, 0)
        ToggleLock(veh)
        isLockPicking = false
        exports['mythic_notify']:SendAlert('success', 'Door is open!')
    end)
end