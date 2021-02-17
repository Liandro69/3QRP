
----------------------------------------------------------------------------------------------
-----------------------------------------CREDITS:---------------------------------------------
----------------------------------------------------------------------------------------------
--[[
VG_Fishing
Copyright (C) 2018  lyrics

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.


-----------------------------------------------------------------------------------------------
This Script was built on top of a Version of the Fishingscript of FiveM-Forum-User Kuzkay.
His allowence was given.

Also i used code of Thaisen69 AnchorBoat Script https://github.com/Thaisen69/AnchorBoat
And of course the great script InteractSound from Scott: https://forum.fivem.net/t/release-play-custom-sounds-for-interactions/8282
aaand NativeUI: https://forum.fivem.net/t/release-nativeui-port-for-p/4902

Created by lyrics --> VG-Community (LivingInLosSantos)
-----------------------------------------------------------------------------------------------

Biggest difference:
- sounds
- uses nativeUI for the shopsystem instead of tqrp_shops, but still uses esx for fishing and items to be compatible with esx
- knife has to be bought in order to be allowed to process fish and use/sell it
- no visible mapmarkers for illegal stuff (shark sellpoint)
- boat has anchor
- no boat rent avaible, as in our community we decided that you should use your bought boat, so it has a purpose
- other markers

..and some other small things.
Also i made fish eatable on our server, you should do that too.









]]



----------------------------------------------------------------------------------------------
--------------------------------------FRAMEWORK INIT------------------------------------------
----------------------------------------------------------------------------------------------

ESX	= nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
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
-----------------------------------------------
-------------- GLOBAL VARIABLES ---------------
-----------------------------------------------
local playerPed     	= PlayerPedId()
local isInBaitShopMenu  = false
local currentBaitshop   = {}
local shopMenu
local anchored = false
local boat = nil
local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0
local bait = "none"

-----------------------------------------------
-------------------- SHOP ---------------------
-----------------------------------------------
local marker = {
  --{title="Angelshop", colour=2, id=498, x = 1694.823, y = 3755.388, z = 34.705, rot = 249.654, radius = 1.5},
}


--[[local SellFishblip = AddBlipForCoord(Config.SellFish.x, Config.SellFish.y, Config.SellFish.z)
SetBlipSprite(SellFishblip, 68)
SetBlipColour(SellFishblip, 15)
SetBlipScale(SellFishblip, 0.0)
SetBlipAsShortRange(SellFishblip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Fischverkauf")
EndTextCommandSetBlipName(SellFishblip)]]--


--[[local blipFishingShop = AddBlipForCoord(1694.8238525391, 3755.3889160156, 34.705341339111)
SetBlipSprite(blipFishingShop, 68)
SetBlipColour(blipFishingShop, 15)
SetBlipScale(blipFishingShop, 0.0)
SetBlipAsShortRange(blipFishingShop, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Angelshop")
EndTextCommandSetBlipName(blipFishingShop)]]--



function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

RegisterNetEvent('vg_fishing:message')
AddEventHandler('vg_fishing:message', function(text)
	--ShowNotification(text)
	exports['mythic_notify']:SendAlert('success', text)
end, false)


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	local sleep = 1500
	while true do
		sleep = 1500

		local playerPed = PlayerPedId()

		local playerCoords = GetEntityCoords(PlayerPedId())
		if (GetDistanceBetweenCoords(playerCoords, Config.FishingShop.x, Config.FishingShop.y, Config.FishingShop.z, true) < 10.0) then
			sleep = 10
			--DrawMarker(27, Config.FishingShop.x, Config.FishingShop.y, Config.FishingShop.z+ 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.radius, Config.Marker.radius, Config.Marker.radius, Config.Marker.colour.r, Config.Marker.colour.g, Config.Marker.colour.b, Config.Marker.colour.a, false, false, 2, false, false, false, false)
			for k,v in pairs(marker) do
				if (GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < v.radius/2) then
					isInBaitShopMenu = true
					currentBaitshop = v
					break
				else
					isInBaitShopMenu = false
					currentBaitshop = {}
				end
			end
		end

		if (GetDistanceBetweenCoords(playerCoords, Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) < 10.0) then
			sleep = 10
			Draw3DText(Config.SellFish.x, Config.SellFish.y, Config.SellFish.z + 0.5, 'Tens ai peixe fresquinho?')
		end

		if (GetDistanceBetweenCoords(playerCoords, Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, true) < 5.0) then
			sleep = 10
			Draw3DText(Config.SellShark.x, Config.SellShark.y, Config.SellShark.z + 0.5, 'Socio tens ai algum tubarão?')

		end

		if IsPedInAnyBoat(playerPed) then
			boat  = GetVehiclePedIsIn(playerPed, true)
			if IsVehicleEngineOn(boat) then
				anchored = false
			end
		end

		if IsControlJustPressed(1, 182) and not IsPedInAnyVehicle(playerPed) and boat ~= nil then
			if not anchored then
				SetBoatAnchor(boat, true)
				TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Anchordown", 0.6)
				exports['mythic_progbar']:Progress({
					name = "ligacao_direta",
					duration = 6000,
					label = "A baixar/recolher a ancora...",
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
				Citizen.Wait(6000)
				--ShowNotification("Anker geworfen")
				exports['mythic_notify']:SendAlert('success', 'Ancora baixada')
				ClearPedTasks(playerPed)
			else
				TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Anchorup", 0.6)
				exports['mythic_progbar']:Progress({
					name = "ligacao_direta",
					duration = 6000,
					label = "A baixar/recolher a ancora...",
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
				Citizen.Wait(6000)
				SetBoatAnchor(boat, false)
				--ShowNotification("Anker eingeholt")
				exports['mythic_notify']:SendAlert('success', 'Ancora recolhida')
				ClearPedTasks(playerPed)
			end
			anchored = not anchored
		end

		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 3 then
			TriggerServerEvent('vg_fishing:startSelling', "fish")
			Citizen.Wait(4000)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, true) <= 5 then
			TriggerServerEvent('vg_fishing:startSelling', "shark")
			Citizen.Wait(4000)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z, true) <= 3 then
			TriggerServerEvent('vg_fishing:startSelling', "turtle")
			Citizen.Wait(4000)
		end

		Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(600)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(10)
		if fishing then

			if IsControlJustReleased(0,44) then
				input = 1
			end
			if IsControlJustReleased(0,32) then
				input = 2
			end
			if IsControlJustReleased(0,38) then
				input = 3
			end
			if IsControlJustReleased(0,34) then
				input = 4
			end
			if IsControlJustReleased(0,8) then
				input = 5
			end
			if IsControlJustReleased(0,9) then
				input = 6
			end



			if IsControlJustReleased(0, Keys['X']) then
				ClearPedTasksImmediately(playerPed)
				fishing = false
				--ShowNotification("~r~Paraste de pescar")
				exports['mythic_notify']:SendAlert('error', 'Paraste de Pescar!')
			end
			if fishing then
				playerPed = PlayerPedId()
				local pos = GetEntityCoords(PlayerPedId())
				if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 or IsPedInAnyVehicle(PlayerPedId()) then
				
				else
					fishing = false
					--ShowNotification("~r~Stopped fishing")
					exports['mythic_notify']:SendAlert('error', 'Paraste de Pescar!')
				end
				if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
					--ShowNotification("~r~Stopped fishing")
					exports['mythic_notify']:SendAlert('error', 'Paraste de Pescar!')
					Citizen.Wait(2000)
				end
			end


			if pausetimer > 3 then
				input = 99
			end

			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerServerEvent('vg_fishing:catch', bait)
				else
					--ShowNotification("~r~Fish got free")
					exports['mythic_notify']:SendAlert('error', 'O peixe fugiu!')
				end
			end
		else
			Citizen.Wait(1500)
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		local wait = math.random(Config.FishTime.a , Config.FishTime.b)
		Wait(wait)
		if fishing then
			pause = true
			correct = math.random(1,6)
			--ShowNotification("~g~O peixe mordeu o isco \n ~h~Pressiona " .. correct .. " para apanha lo")
			exports['mythic_notify']:SendAlert('success', 'O peixe mordeu o isco \n ~h~Pressiona '  .. correct .. ' para apanha lo')
			input = 0
			pausetimer = 0
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('vg_fishing:break')
AddEventHandler('vg_fishing:break', function()
	fishing = false
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('vg_fishing:spawnPed')
AddEventHandler('vg_fishing:spawnPed', function()
	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
	while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
		Citizen.Wait( 1 )
	end
	local pos = GetEntityCoords(PlayerPedId())

	local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
end)

RegisterNetEvent('vg_fishing:setbait')
AddEventHandler('vg_fishing:setbait', function(bool)
	bait = bool
end)

RegisterNetEvent('vg_fishing:fishstart')
AddEventHandler('vg_fishing:fishstart', function()
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(playerPed)
	if IsPedInAnyVehicle(playerPed) then
		ShowNotification("~y~Não podes pescar em um veiculo")
	else
		if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -2400 or pos.x >= 4300 then
			ShowNotification("~g~Pesca comecou")
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_FISHING", 0, true)
			TriggerEvent('vg_fishing:playSound', "fishing_start")
			fishing = true
		else
			ShowNotification("~y~Tens que ir para mais longe")
		end
	end
end, false)

RegisterNetEvent('vg_fishing:playSound')
AddEventHandler('vg_fishing:playSound', function(sound)
	local clientNetId = GetPlayerServerId(PlayerId())
	TriggerServerEvent("InteractSound_SV:PlayOnOne", clientNetId, sound, 0.5)
end)

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 68)
end