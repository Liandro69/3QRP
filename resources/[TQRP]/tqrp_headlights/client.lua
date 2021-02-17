local display = false
local display2 = false
local lastplate = 1

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterCommand("headlights", function(source, args)
    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1),false)))
        local props = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(GetPlayerPed(-1),false))
        if plate ~= lastplate then
            if props.modXenon ~= nil and props.modXenon ~= -1 then
                lastplate = plate
                SetDisplay(not display)
            else
                exports["mythic_notify"]:SendAlert("error", "Não tens Xenons RGB equipados!")
            end
        else
            SetDisplay(not display)
        end   
    end
end)

RegisterCommand("neons", function(source, args)
    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1),false)))
        local props = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(GetPlayerPed(-1),false))
        if plate ~= lastplate then
            if props.neonEnabled[1] == 1 or props.neonEnabled[2] == 1 or props.neonEnabled[3] == 1 or props.neonEnabled[4] == 1 then
                lastplate = plate
                SetDisplay2(not display2)
            else
                exports["mythic_notify"]:SendAlert("error", "Não tens Neons RGB equipados!")
            end
        else
            SetDisplay2(not display2)
        end   
    end
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
    SetDisplay2(false)
end)

RegisterNUICallback("setcolor", function(data)
    --print(data.color)
   -- local plate = ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1),false)))
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1)), 22, true)
    SetVehicleHeadlightsColour(GetVehiclePedIsIn(GetPlayerPed(-1)), tonumber(data.color))
	--TriggerServerEvent('matif_headlights:set', plate, data.color)
end)

RegisterNUICallback("setcolor2", function(data)
    print(data.r, data.g, data.b)
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
    SetVehicleNeonLightsColour(veh, tonumber(data.r), tonumber(data.g), tonumber(data.b))
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

function SetDisplay2(bool)
    display2 = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui2",
        status = bool,
    })
end

