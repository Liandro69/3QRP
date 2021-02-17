-------------------------
--Written by Tościk#9715-
-------------------------
------------------CONFIG----------------------
local startX = 2190.445  --Where you get the pigs
local startY = 4981.941
local startZ = 41.517
---------------------------------------------
local slaughterX = 998.135   --Where you kil the pigs
local slaughterY = -2144.108
local slaughterZ = 29.529
---
local slaughterX2 = 996.870   --Where you kil the pigs
local slaughterY2 = -2143.121
local slaughterZ2 = 29.476
---
local packageX = 985.778    --Where you package the pigs
local packageY = -2117.039
local packageZ = 30.757
---
local packageX2 = 985.498   --Where you package the pigs 2
local packageY2 = -2121.712
local packageZ2 = 30.475
---
local sellX = 1194.148    --Where you sell them
local sellY = 2722.781
local sellZ = 38.623


---------------------------------
--------DON´T TPUCH NO RUSH------
---------------------------------
local pig1
local pig2
local pig3
local caught1 = 0
local caught2 = 0
local caught3 = 0
local numbercaught = 0
local share = false
local prop
local packeforacar = false
local cardboard
local meat
local packing = 0
--------------
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
---
Citizen.CreateThread(function()
local blip1 = AddBlipForCoord(startX, startY, startZ)
    SetBlipSprite (blip1, 126)
    SetBlipDisplay(blip1, 4)
    SetBlipScale  (blip1, 0.6)
    SetBlipColour (blip1, 23)
    SetBlipAsShortRange(blip1, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('3 Porquinhos')
    EndTextCommandSetBlipName(blip1)
local blip2 = AddBlipForCoord(slaughterX, slaughterY, slaughterZ)
    SetBlipSprite (blip2, 273)
    SetBlipDisplay(blip2, 4)
    SetBlipScale  (blip2, 0.7)
    SetBlipColour (blip2, 23)
    SetBlipAsShortRange(blip2, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Matadouro Porcos')
    EndTextCommandSetBlipName(blip2)
local blip3 = AddBlipForCoord(sellX, sellY, sellZ)
    SetBlipSprite (blip3, 478)
    SetBlipDisplay(blip3, 4)
    SetBlipScale  (blip3, 0.6)
    SetBlipColour (blip3, 23)
    SetBlipAsShortRange(blip3, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('O Labrego dos Porcos')
    EndTextCommandSetBlipName(blip3)
end)
---
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D2(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end
----Get the pigs
Citizen.CreateThread(function()

    while true do
	Citizen.Wait(7)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, startX, startY, startZ)
		--Uncoment this if you want markers
		if dist < 80.0 then
			if dist <= 5.0 then
			DrawText3D2(startX, startY, startZ, "~g~[E]~w~ Para apanhar porcos")
			DrawMarker(27, startX, startY, startZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
				if dist <= 0.5 then
					if IsControlJustPressed(0, 38) then -- "E"
					catchchicken()
					end
				end
			else
				Citizen.Wait(1000)
			end
		else
		 Citizen.Wait(8000)
		end
	end
end)

-------Packaging/Cutting

local Positions = {
	['Slaughter1'] = { ['hint'] = '~g~[E]~w~ Para empacotar costeletas', ['x'] = 985.778, ['y'] = -2117.039, ['z'] = 30.757 },
	['Slaughter2'] = { ['hint'] = '~g~[E]~w~ Para empacotar costeletas', ['x'] = 985.498, ['y'] = -2121.712, ['z'] = 30.475 }
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local plyCoords = GetEntityCoords(PlayerPedId())
        local distance1 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, slaughterX, slaughterY, slaughterZ)
        local distance2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, slaughterX2, slaughterY2, slaughterZ2)
        local distance3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, packageX, packageY, packageZ)
        local distance4 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, packageX2, packageY2, packageZ2)

		if distance1 < 80.0 then
            if distance1 <= 5.0 then
                DrawMarker(27, slaughterX, slaughterY, slaughterZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                DrawMarker(27, slaughterX2, slaughterY2, slaughterZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                DrawMarker(27, packageX, packageY, packageZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
				DrawMarker(27, packageX2, packageY2, packageZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
				DrawText3D2(slaughterX, slaughterY, slaughterZ, "~g~[E]~w~ Pra cortar o porco")
            end

		    if distance1 <= 2.5 then
                DrawText3D2(slaughterX, slaughterY, slaughterZ, "~g~[E]~w~ Pra cortar o porco")
            end

		    if distance1 <= 0.5 then
                if IsControlJustPressed(0, 38) then -- "E"
                    portofchicken(1)
                end
			end

			if distance2 <= 2.5 then
				DrawText3D2(slaughterX2, slaughterY2, slaughterZ2, "~g~[E]~w~ Pra cortar o porco")
			end

			if distance2 <= 0.5 then
				if IsControlJustPressed(0, 38) then -- "E"
					portofchicken(2)
				end
			end
			--
			if distance3 <= 2.5 and packing == 0 then
				DrawText3D2(packageX, packageY, packageZ, "~g~[E]~w~ Para empacotar o porco")
			elseif distance3 <= 2.5 and packing == 1 then
				DrawText3D2(packageX, packageY, packageZ, "~g~[G]~w~ Para parar de empacotar")
				DrawText3D2(packageX, packageY, packageZ+0.1, "~g~[E]~w~ Para continuar a empacotar")
			end

			if distance3 <= 5.5 then
				if IsControlJustPressed(0, 38) then
					PackPigs(1)
				elseif IsControlJustPressed(0, 47) then
					stoppacking(1)
				end
			end

			if distance4 <= 2.5 and packing == 0 then
				DrawText3D2(packageX2, packageY2, packageZ2, "~g~[E]~w~ Para empacotar o porco")
			elseif distance4 <= 2.5 and packing == 1 then
				DrawText3D2(packageX2, packageY2, packageZ2, "~g~[G]~w~ Para parar de empacotar")
				DrawText3D2(packageX2, packageY2, packageZ2+0.1, "~g~[E]~w~ Para continuar a empacotar")
			end

			if distance4 <= 0.5 then
				if IsControlJustPressed(0, 38) then -- "E"
					PackPigs(2)
				elseif IsControlJustPressed(0, 47) then
					stoppacking(2)
				end
			end

			if (distance1 > 5.0) and (distance2 > 5.0) and (distance3 > 5.0) and (distance4 > 5.0) then
				Citizen.Wait(1500)
			end

		else
			Citizen.Wait(10000)
		end
    end
end)

------

function stoppacking(position)
FreezeEntityPosition(GetPlayerPed(-1), false)
packeforacar = true
local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
proppig = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
packing = 0
while packeforacar do
Citizen.Wait(250)
local vehicle   = ESX.Game.GetVehicleInDirection()
local coords    = GetEntityCoords(GetPlayerPed(-1))
LoadDict('anim@heists@box_carry@')

	if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and packeforacar == true then
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	end

	if DoesEntityExist(vehicle) then
	packeforacar = false
	exports['mythic_notify']:SendAlert('inform', 'Guardas te os porcos')
	LoadDict('anim@heists@narcotics@trash')
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	Citizen.Wait(900)
	ClearPedTasks(GetPlayerPed(-1))
	DeleteEntity(proppig)
	end
end
end

function PackPigs(position)
local inventory = ESX.GetPlayerData().inventory
local count = 0
for i=1, #inventory, 1 do
	if inventory[i].name == 'slaughtered_pig' then
	count = inventory[i].count
	end
end
if(count > 0) then
	SetEntityHeading(GetPlayerPed(-1), 40.0)
	local PedCoords = GetEntityCoords(GetPlayerPed(-1))
	meat = CreateObject(GetHashKey('prop_cs_steak'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(meat, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0x49D9), 0.15, 0.0, 0.01, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
	cardboard = CreateObject(GetHashKey('prop_cs_clothes_box'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(cardboard, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.13, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
	packing = 1
	LoadDict("anim@heists@ornate_bank@grab_cash_heels")
	TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	--exports['taskbar']:taskBar(7500, 'A empacotar Costeletas')
	exports['mythic_progbar']:Progress({
		name = "embalar_porco",
		duration = 7500,
		label = "A embalar filetes...",
		useWhileDead = true,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	})
	Citizen.Wait(7500)
	TriggerServerEvent("tqrp:mataporco",2)
	exports['mythic_notify']:SendAlert('inform', 'Continua a empacotar ou mete os porcos no carro')
	ClearPedTasks(GetPlayerPed(-1))
	DeleteEntity(cardboard)
	DeleteEntity(meat)
else
exports['mythic_notify']:SendAlert('inform', 'N tens nada pra empacotar')
end
end
------
function portofchicken(position)
local inventory = ESX.GetPlayerData().inventory
local count = 0
for i=1, #inventory, 1 do
	if inventory[i].name == 'alive_pig' then
	count = inventory[i].count
	end
end
if(count > 0) then
local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
LoadDict(dict)
FreezeEntityPosition(GetPlayerPed(-1),true)
TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
local PedCoords = GetEntityCoords(GetPlayerPed(-1))
something1 = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
AttachEntityToEntity(something1, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
if position == 1 then
SetEntityHeading(GetPlayerPed(-1), 311.0)
--exports['taskbar']:taskBar(10000, 'A cortar o porco')
exports['mythic_progbar']:Progress({
	name = "embalar_porco",
	duration = 10000,
	label = "A cortar costeletas...",
	useWhileDead = true,
	canCancel = true,
	controlDisables = {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	},
})
TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'cutmeat', 0.2)
Citizen.Wait(10000)
pig = CreateObject(GetHashKey('prop_int_cf_chick_01'),-94.87, 6207.008, 30.08, true, true, true)
SetEntityRotation(pig,90.0, 0.0, 45.0, 1,true)
elseif position == 2 then
	exports['mythic_progbar']:Progress({
		name = "embalar_porco2",
		duration = 10000,
		label = "A cortar costeletas...",
		useWhileDead = true,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	})
TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'cutmeat', 0.2)
Citizen.Wait(10000)
SetEntityHeading(GetPlayerPed(-1), 222.0)
pig = CreateObject(GetHashKey('prop_int_cf_chick_01'),-100.39, 6201.56, 29.99, true, true, true)
SetEntityRotation(pig,90.0, 0.0, -45.0, 1,true)
end
exports['mythic_notify']:SendAlert('inform', 'Matas te um porco')
FreezeEntityPosition(GetPlayerPed(-1),false)
DeleteEntity(pig)
DeleteEntity(something1)
ClearPedTasks(GetPlayerPed(-1))
TriggerServerEvent("tqrp:mataporco",1)
else
exports['mythic_notify']:SendAlert('inform', 'N tens porcos')
end
end


function pinexit()
DoScreenFadeOut(500)
Citizen.Wait(500)
SetEntityCoordsNoOffset(GetPlayerPed(-1), startX+2, startY+2, startZ, 0, 0, 1)
if DoesEntityExist(pig1) or DoesEntityExist(pig2) or DoesEntityExist(pig3) then
DeleteEntity(pig1)
DeleteEntity(pig2)
DeleteEntity(pig3)
end
Citizen.Wait(500)
DoScreenFadeIn(500)

local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
proppig = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)

local givecars = true

while givecars do
Citizen.Wait(250)
local vehicle   = ESX.Game.GetVehicleInDirection()
local coords    = GetEntityCoords(GetPlayerPed(-1))
LoadDict('anim@heists@box_carry@')

	if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and givecars == true then
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	end

	if DoesEntityExist(vehicle) then
	givecars = false
	exports['mythic_notify']:SendAlert('inform', 'Guardas te os porcos')
	LoadDict('anim@heists@narcotics@trash')
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	Citizen.Wait(900)
	ClearPedTasks(GetPlayerPed(-1))
	DeleteEntity(proppig)
	TriggerServerEvent("tqrp:apanhagalinha2")
	end
end



end

function catchchicken()
DoScreenFadeOut(500)
Citizen.Wait(500)
SetEntityCoordsNoOffset(GetPlayerPed(-1), 2187.673,4978.846,41.441, 0, 0, 1)
RequestModel(GetHashKey('a_c_pig'))
while not HasModelLoaded(GetHashKey('a_c_pig')) do
Wait(1)
end
pig1 = CreatePed(26, "a_c_pig", 2186.3889160156,4964.1103515625,41.287548065186, 49.939, true, false)

pig2 = CreatePed(26, "a_c_pig", 2166.9494628906,4971.1884765625,41.373683929443, 197.279, true, false)
pig3 = CreatePed(26, "a_c_pig", 2163.5041503906,4954.1103515625,41.416160583496, 302.730, true, false)
TaskReactAndFleePed(pig1, GetPlayerPed(-1))
TaskReactAndFleePed(pig2, GetPlayerPed(-1))
TaskReactAndFleePed(pig3, GetPlayerPed(-1))
Citizen.Wait(500)
DoScreenFadeIn(500)
share = true
end
-----
function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(5)
		if share == true then
			local pig1Coords = GetEntityCoords(pig1)
			local pig2Coords = GetEntityCoords(pig2)
			local pig3Coords = GetEntityCoords(pig3)
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pig1Coords.x, pig1Coords.y, pig1Coords.z)
			local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pig2Coords.x, pig2Coords.y, pig2Coords.z)
			local dist3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pig3Coords.x, pig3Coords.y, pig3Coords.z)
				if numbercaught == 3 then
					caught1 = 0
					caught2 = 0
					caught3 = 0
					numbercaught = 0
					share = false
					exports['mythic_notify']:SendAlert('inform', 'Leva os porcos ao carro')
					pinexit()
				end

				if dist <= 1.0 then
					DrawText3D2(pig1Coords.x, pig1Coords.y, pig1Coords.z+0.5, "~o~[E]~b~ Apanha o porco")
					if IsControlJustPressed(0, 38) then
						caught1 = 1
						pigcaught()
					end
				elseif dist2 <= 1.0 then
					DrawText3D2(pig2Coords.x, pig2Coords.y, pig2Coords.z+0.5, "~o~[E]~b~ Apanha o porco")
					if IsControlJustPressed(0, 38) then
						caught2 = 1
						pigcaught()
					end
				elseif dist3 <= 1.0 then
					DrawText3D2(pig3Coords.x, pig3Coords.y, pig3Coords.z+0.5, "~o~[E]~b~ Apanha o porco")
					if IsControlJustPressed(0, 38) then
						caught3 = 1
						pigcaught()
					end
				end
				if (dist > 5.0 ) and (dist2 > 5.0 ) and (dist3 > 5.0 ) then
					Citizen.Wait(2000)
				end
		else
		Citizen.Wait(3000)
		end
	end
end)

local ragdoll = false

function pigcaught()
	LoadDict('move_jump')
	TaskPlayAnim(GetPlayerPed(-1), 'move_jump', 'dive_start_run', 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
	Citizen.Wait(600)
	SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	Citizen.Wait(1000)
	ragdoll = true
	local chanceofcatch = math.random(1,100)
	if chanceofcatch <= 60 then
			exports['mythic_notify']:SendAlert('inform', 'Conseguiste apanhar um porco')
			if caught1 == 1 then
				DeleteEntity(pig1)
				caught1 = 0
				numbercaught = numbercaught +1
			elseif caught2 == 1 then
				DeleteEntity(pig2)
				caught2 = 0
				numbercaught = numbercaught +1
			elseif caught3 == 1 then
				DeleteEntity(pig3)
				caught3 = 0
				numbercaught = numbercaught +1
			end
		else
		exports['mythic_notify']:SendAlert('error', 'Ahahaha o porco fugiu de outro porco')
	end
end


Citizen.CreateThread(function()
    while true do
	Citizen.Wait(7)
		if ragdoll then
			SetEntityHealth(PlayerPedId(), 200)
			TriggerEvent('mythic_hospital:client:ResetLimbs')
            TriggerEvent('mythic_hospital:client:RemoveBleed')
			ragdoll = false
		else
			Citizen.Wait(2000)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(7)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
	local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sellX, sellY, sellZ)
	if dist < 50.0 then
		if dist <= 2.5 then
			DrawMarker(27, sellX, sellY, sellZ-0.96, 0, 0, 0, 0, 0, 0, 2.20, 2.20, 2.20, 255, 255, 255, 200, 0, 0, 0, 0)
		end
		if dist <= 2.0 then
			DrawText3D2(sellX, sellY, sellZ+0.1, "[E] Vender Costeletas")
			if IsControlJustPressed(0, 38) then
				Sellpigi()
			end

		end
		if dist > 5.0 then
			Citizen.Wait(1500)
		end
	else
		Citizen.Wait(8000)
	end
	end
end)

function Sellpigi()
    local inventory = ESX.GetPlayerData().inventory
    local count = 0
    for i=1, #inventory, 1 do
    	if inventory[i].name == 'packaged_pig' then
    	count = inventory[i].count
    	end
	end

    if(count > 4) then
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
    local ped = GetPlayerPed(-1)
    proppig = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
    SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
    LoadDict('amb@medic@standing@tendtodead@idle_a')
    TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
    --exports['taskbar']:taskBar(5000, 'A vender as Costeletas')
    exports['mythic_progbar']:Progress({
    	name = "vender_porco",
    	duration = 5000,
    	label = "A vender embalagens...",
    	useWhileDead = true,
    	canCancel = true,
    	controlDisables = {
    		disableMovement = true,
    		disableCarMovement = true,
    		disableMouse = false,
    		disableCombat = true,
    	},
    })
    Citizen.Wait(5000)
    LoadDict('amb@medic@standing@tendtodead@exit')
    TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
    ClearPedTasksImmediately(ped)
    DeleteEntity(proppig)
    TriggerServerEvent("tqrp:mataporco",3)
    else
    exports['mythic_notify']:SendAlert('error', 'Não tens embalagens suficientes')
    end
end
