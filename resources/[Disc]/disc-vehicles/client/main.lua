ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(10)
    end
    
    ESX.PlayerData = ESX.GetPlayerData()

    while ESX.PlayerData == nil do
        Citizen.Wait(10)
    end

    
end)

vehicles = {}

function TrackVehicle(vehicle, key, state)
    if vehicle ~= nil and vehicles[vehicle] == nil then
        vehicles[vehicle] = {
            locked = true,
            key = key,
            state = state,
            plate = GetVehicleNumberPlateText(vehicle)
        }
        TriggerServerEvent('disc-vehicles:checkKey', vehicle, vehicles[vehicle].plate)
    end
end