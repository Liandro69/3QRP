local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local TextMarker = true

vehicleWashStations = {
	{ ['x'] = 26.5906, ['y'] = -1392.0261, ['z'] = 29.3634 },
	{ ['x'] = 167.1034, ['y'] = -1719.4704, ['z'] = 29.2916 },
	{ ['x'] = -699.6325, ['y'] = -932.7043, ['z'] = 19.0139 },
	{ ['x'] = 1362.5385, ['y'] = 3592.1274, ['z'] = 34.9211 }
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
	LoadScript()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('tqrp_carwash:clean')
AddEventHandler('tqrp_carwash:clean', function()

	local plyPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(plyPed, false)
    local timer = 5 * 1000

    FreezeEntityPosition(vehicle, true)
    TriggerEvent('mythic_notify:notify', 'inform', 'Irão limpar a tua viatura. Aguarda.')
    TextMarker = false
    Citizen.Wait(timer)
    WashDecalsFromVehicle(vehicle, 1.0)
    SetVehicleDirtLevel(vehicle, 0.0)
    FreezeEntityPosition(vehicle, false)
    TriggerEvent('mythic_notify:notify', 'inform', 'A tua viatura encontra-se limpa.')
    TextMarker = true

end)

function washVeh()
	ESX.TriggerServerCallback('tqrp_carwash:hasMoney', function(hasMoney)
		if hasMoney then
			TriggerEvent('tqrp_carwash:clean')
			TriggerServerEvent('tqrp_carwash:removeMoney')
		else
			TriggerEvent('mythic_notify:notify', 'error', 'Não tens dinheiro suficiente.')
		end	
	end)	
end	

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local scale = 0.5
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

function LoadScript()
	Citizen.Wait(1000)
	LoadBlips()
end	

function LoadBlips()

	Citizen.CreateThread(function ()
		Citizen.Wait(0)
		for i = 1, #vehicleWashStations do
			StationCoords = vehicleWashStations[i]
			stationBlip = AddBlipForCoord(StationCoords['x'], StationCoords['y'], StationCoords['z'])
			SetBlipSprite(stationBlip, 100)
			SetBlipSprite(stationBlip, 100)
			SetBlipScale(stationBlip,1.0)
			SetBlipAsShortRange(stationBlip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Lavagem Automática')
			EndTextCommandSetBlipName(stationBlip) 
		end
	end)

	Citizen.CreateThread(function()
		while true do

			local sleep = 4500

			for i = 1, #vehicleWashStations do

				StationCoords = vehicleWashStations[i]

				local plyPed = GetPlayerPed(-1)
			
				local plyCoords = GetEntityCoords(PlayerPedId())

				local distance = GetDistanceBetweenCoords(plyCoords, StationCoords['x'], StationCoords['y'], StationCoords['z'], true)

				local vehicle = GetVehiclePedIsIn(plyPed, false)

				if GetPedInVehicleSeat(vehicle, -1) == plyPed then

					if TextMarker and distance < 15 then
						sleep = 7
						DrawMarker(27,StationCoords['x'], StationCoords['y'], StationCoords['z'] - 1, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					end	

					if TextMarker and distance < 3 then
						sleep = 7
						DrawText3D(StationCoords['x'], StationCoords['y'], StationCoords['z'], 'Pressiona [~g~E~w~] para limpar a viatura')
					end
					if distance < 2 then
						if IsControlJustReleased(0, Keys['E']) then
							washVeh()
						end
					end
				end
			end
			Citizen.Wait(sleep)
		end
	end)
end	