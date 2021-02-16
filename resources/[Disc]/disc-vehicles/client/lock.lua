Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsTryingToEnter(playerPed)
        if DoesEntityExist(vehicle) then
            TrackVehicle(vehicle)
            local driver = GetPedInVehicleSeat(vehicle, -1)
            if DoesEntityExist(driver) and driver ~= playerPed then
                local random = math.random(100)
                if IsEntityDead(driver) then
                    GiveKey(vehicle)
                end
                if random <= Config.NPCStealPercentage then
                    setVehicleLockStatus(vehicle, false)
                else
                    TaskReactAndFleePed(driver, playerPed)
                    SetVehicleDoorsLocked(vehicle, getVehicleLockStatus(vehicle))
                end
            else
                SetVehicleDoorsLocked(vehicle, getVehicleLockStatus(vehicle))
            end
        end
    end
end)

function getVehicleLockStatus(vehicle)
    local v = vehicles[vehicle]
    if v.locked and IsPedInAnyVehicle(PlayerPedId()) then
        return 4
    elseif v.locked then
        return 2
    else
        return 0
    end
end

function setVehicleLockStatus(vehicle, flag)
    vehicles[vehicle].locked = flag
    SetVehicleDoorsLocked(vehicle, flag)
end

function ToggleLock(vehicle)
    vehicles[vehicle].locked = not vehicles[vehicle].locked
    SetVehicleDoorsLocked(vehicle, vehicles[vehicle].locked)
    ESX.Streaming.RequestAnimDict('anim@mp_player_intmenu@key_fob@', function()
        TaskPlayAnim(PlayerPedId(), 'anim@mp_player_intmenu@key_fob@', 'fob_click', 8.0, -8, -1, 0, 0, 0, 0, 0)
    end)
    if vehicles[vehicle].locked then
        exports['mythic_notify']:SendAlert('success', 'Locked ' .. vehicles[vehicle].plate)
    else
        exports['mythic_notify']:SendAlert('success', 'Unlocked ' .. vehicles[vehicle].plate)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local playerPed = PlayerPedId()
        local player = PlayerId()
        if IsPlayerFreeAiming(player) then
            local foundEntity, entity = GetEntityPlayerIsFreeAimingAt(player)
            if foundEntity and IsEntityAPed(entity) and IsPedInAnyVehicle(entity) then
                local coords = GetEntityCoords(entity)
                local playerCoords = GetEntityCoords(playerPed)
                if GetDistanceBetweenCoords(coords, playerCoords) < 10 then
                    local steal = math.random(100)
                    local vehicle = GetVehiclePedIsIn(entity)
                    TrackVehicle(vehicle, true, GetIsVehicleEngineRunning(vehicle))
                    Citizen.Wait(100)
                    local speed = GetEntitySpeed(vehicle) * 3.6
                    if steal <= Config.NPCStealPercentage and speed < 10 then
                        Citizen.CreateThread(function()
                            TaskLeaveAnyVehicle(entity)
                            while IsPedInAnyVehicle(entity) do
                                Citizen.Wait(100)
                            end
                            ESX.Streaming.RequestAnimDict('cover@first_person@weapon@grenade', function()
                                TaskPlayAnim(entity, 'cover@first_person@weapon@grenade', 'low_l_throw_long_facecover', 8.0, -8, -1, 48, 0, 0, 0, 0)
                            end)
                            while IsEntityPlayingAnim(entity, 'cover@first_person@weapon@grenade', 'low_l_throw_long_facecover', 0) do
                                Citizen.Wait(100)
                            end
                            GiveKey(vehicle)
                            TaskReactAndFleePed(entity, playerPed)
                        end)
                    else
                        TaskReactAndFleePed(entity, playerPed)
                    end
                end
            end
        else
            Citizen.Wait(1500)
        end
    end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if IsControlJustReleased(0, 244) then
            local playerPed = PlayerPedId()
            if IsPedInAnyVehicle(playerPed) then
                local vehicle = GetVehiclePedIsIn(playerPed)
                TrackVehicle(vehicle, false, GetIsVehicleEngineRunning(vehicle))
                Citizen.Wait(100)
                if vehicles[vehicle].state then
                    vehicles[vehicle].state = not vehicles[vehicle].state
                    exports['mythic_notify']:SendAlert('success', 'Turned Off')
                elseif vehicles[vehicle].key then
                    vehicles[vehicle].state = not vehicles[vehicle].state
                    if vehicles[vehicle].state then
                        exports['mythic_notify']:SendAlert('success', 'Turned On')
                    else
                        exports['mythic_notify']:SendAlert('success', 'Turned Off')
                    end
                end
            end
        end
    end
end)