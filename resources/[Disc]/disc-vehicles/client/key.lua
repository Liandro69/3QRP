function GiveKey(vehicle)
    if not vehicles[vehicle].key then
        vehicles[vehicle].key = true
        exports['mythic_notify']:SendAlert('success', 'You got Keys')
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if IsControlJustReleased(1, 303) then
            local vehicle = ESX.Game.GetVehicleInDirection()
            if IsPedInAnyVehicle(PlayerPedId()) then
                vehicle = GetVehiclePedIsIn(PlayerPedId())
            end
            TrackVehicle(vehicle)
            Citizen.Wait(100)
            if DoesEntityExist(vehicle) then
                if vehicles[vehicle] and vehicles[vehicle].key then
                    ToggleLock(vehicle)
                else
                    exports['mythic_notify']:SendAlert('error', 'You do not own the keys to this vehicle')
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        for k, v in pairs(vehicles) do
            Citizen.Wait(10)
            if v.state == nil then
                v.state = false
            end
            SetVehicleEngineOn(k, v.state, true)
        end
    end
end)

RegisterNetEvent('disc-vehicles:setKey')
AddEventHandler('disc-vehicles:setKey', function(vehicle, hasKey)
    vehicles[vehicle].key = hasKey
end)