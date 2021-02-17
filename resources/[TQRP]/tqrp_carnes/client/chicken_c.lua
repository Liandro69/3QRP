------------------CONFIG----------------------
local startX = 2388.725  --Where you get the Chiken from
local startY = 5044.985
local startZ = 46.304
---------------------------------------------
local cutfilletX = -96.007   --Where you cut the fillets
local cutfilletY = 6206.92
local cutfilletZ = 31.02
---
local cutfilletX2 = -100.64   --Where you cut the fillets 2
local cutfilletY2 = 6202.30
local cutfilletZ2 = 31.02
---
local packageX = -106.44    --Where you package
local packageY = 6204.29
local packageZ = 31.02
---
local packageX2 = -104.20   --Where you package 2
local packageY2 = 6206.45
local packageZ2 = 31.02
---
local sellX = -1177.17    --Where you sell it
local sellY = -890.68
local sellZ = 13.79


--------------------------------------------------
--------ONLY EDIT IF YOU KNOW WHAT UR DOING-------
--------------------------------------------------
local chicken1
local chicken2
local chicken3
local Zfrango1 = 0
local Zfrango2 = 0
local Zfrango3 = 0
local captured = 0
local share = false
local prop
local packegeoncar = false
local box
local meat
local packeges = 0
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
local lapaniek = AddBlipForCoord(startX, startY, startZ)
    SetBlipSprite (lapaniek, 126)
    SetBlipDisplay(lapaniek, 4)
    SetBlipScale  (lapaniek, 0.6)
    SetBlipColour (lapaniek, 46)
    SetBlipAsShortRange(lapaniek, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Galiheiras')
    EndTextCommandSetBlipName(lapaniek)
local rzeznia = AddBlipForCoord(cutfilletX, cutfilletY, cutfilletZ)
    SetBlipSprite (rzeznia, 273)
    SetBlipDisplay(rzeznia, 4)
    SetBlipScale  (rzeznia, 0.7)
    SetBlipColour (rzeznia, 46)
    SetBlipAsShortRange(rzeznia, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Matadouro')
    EndTextCommandSetBlipName(rzeznia)
local skupk = AddBlipForCoord(sellX, sellY, sellZ)
    SetBlipSprite (skupk, 478)
    SetBlipDisplay(skupk, 4)
    SetBlipScale  (skupk, 0.6)
    SetBlipColour (skupk, 46)
    SetBlipAsShortRange(skupk, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('KFC')
    EndTextCommandSetBlipName(skupk)
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
    SetTextFont(3)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end

----Gather Chicken
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(7)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, startX, startY, startZ)
		if dist < 80.0 then
			if dist <= 2.5 then
			DrawMarker(27, startX, startY, startZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
			else
			Citizen.Wait(3000)
			end

			if dist <= 2.5 then
			DrawText3D2(startX, startY, startZ, "~g~[E]~w~ Para apanhar galinhas")
			end

			if dist <= 0.5 then
				if IsControlJustPressed(0, 38) then -- "E"
				LapKurczaka()
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
-------Cut Chicken
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(4)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, cutfilletX, cutfilletY, cutfilletZ)
		local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, cutfilletX2, cutfilletY2, cutfilletZ2)
		local distP = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, packageX, packageY, packageZ)
		local distP2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, packageX2, packageY2, packageZ2)
		if dist < 80.0 then
			if (dist < 5.0) or (dist2 < 5.0) or (distP < 5.0) or (distP2 < 5.0) then
			DrawMarker(27, cutfilletX, cutfilletY, cutfilletZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
			DrawMarker(27, cutfilletX2, cutfilletY2, cutfilletZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
			DrawMarker(27, packageX, packageY, packageZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
			DrawMarker(27, packageX2, packageY2, packageZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
			DrawText3D2(cutfilletX, cutfilletY, cutfilletZ, "~g~[E]~w~ Para cortar filetes")
			DrawText3D2(cutfilletX2, cutfilletY2, cutfilletZ2, "~g~[E]~w~ Para cortar filetes")
			DrawText3D2(packageX, packageY, packageZ, "~g~[E]~w~ Para empacotar frangos")
			end

			if dist <= 0.5 then
				if IsControlJustPressed(0, 38) then -- "E"
				CortarCarne(1)
				end
			end

			if dist2 <= 0.5 then
				if IsControlJustPressed(0, 38) then -- "E"
				CortarCarne(2)
				end
			end

			--
			if distP <= 2.5 and packeges == 1 then
				DrawText3D2(packageX, packageY, packageZ, "~g~[G]~w~ Para parar de ampacotar")
				DrawText3D2(packageX, packageY, packageZ+0.1, "~g~[E]~w~ Para continuar a empacotar")
			end

			if distP <= 0.5 then
				if IsControlJustPressed(0, 38) then
				EmbalarCarne(1)
				elseif IsControlJustPressed(0, 47) then
				EmpacotarCarne(1)
				end
			end

			if distP2 <= 2.5 and packeges == 0 then
				DrawText3D2(packageX2, packageY2, packageZ2, "~g~[E]~w~ Para empacotar frangos")
			elseif distP2 <= 2.5 and packeges == 1 then
				DrawText3D2(packageX2, packageY2, packageZ2, "~g~[G]~w~ Para parar de ampacotar")
				DrawText3D2(packageX2, packageY2, packageZ2+0.1, "~g~[E]~w~ Para continuar a empacotar")
			end

			if distP2 <= 0.5 then
				if IsControlJustPressed(0, 38) then -- "E"
					EmbalarCarne(2)
				elseif IsControlJustPressed(0, 47) then
					EmpacotarCarne(2)
				end
			end

			if (dist > 5.0) and (dist2 > 5.0) and (distP > 5.0) and (distP2 > 5.0) then
				Citizen.Wait(1500)
			end
		else
			Citizen.Wait(8000)
		end
	end
end)
------

function EmpacotarCarne(position)
FreezeEntityPosition(GetPlayerPed(-1), false)
packegeoncar = true
local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
packeges = 0
while packegeoncar do
Citizen.Wait(250)
local vehicle   = ESX.Game.GetVehicleInDirection()
local coords    = GetEntityCoords(GetPlayerPed(-1))
LoadDict('anim@heists@box_carry@')

	if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and packegeoncar == true then
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	end

	if DoesEntityExist(vehicle) then
	packegeoncar = false
	exports['mythic_notify']:SendAlert('success', 'Guardas te os frangos')
	LoadDict('anim@heists@narcotics@trash')
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	Citizen.Wait(900)
	ClearPedTasks(GetPlayerPed(-1))
	DeleteEntity(prop)
	end
end
end

function EmbalarCarne(position)
local inventory = ESX.GetPlayerData().inventory
local count = 0
for i=1, #inventory, 1 do
	if inventory[i].name == 'slaughtered_chicken' then
	count = inventory[i].count
	end
end
if(count > 0) then
	SetEntityHeading(GetPlayerPed(-1), 40.0)
	local PedCoords = GetEntityCoords(GetPlayerPed(-1))
	meat = CreateObject(GetHashKey('prop_cs_steak'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(meat, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0x49D9), 0.15, 0.0, 0.01, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
	box = CreateObject(GetHashKey('prop_cs_clothes_box'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(box, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.13, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
	packeges = 1
	LoadDict("anim@heists@ornate_bank@grab_cash_heels")
	TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	--exports['taskbar']:taskBar(7500, 'A embalar os filetes')
	exports['mythic_progbar']:Progress({
		name = "embalar_carne",
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
	TriggerServerEvent("tqrp:mataagalinha",2)
	exports['mythic_notify']:SendAlert('success', 'Continua a embalar ou vai guardar ao carro')
	ClearPedTasks(GetPlayerPed(-1))
	DeleteEntity(box)
	DeleteEntity(meat)
else
exports['mythic_notify']:SendAlert('error', 'N tens nada pra guardar')
end
end
------
function CortarCarne(position)
    local inventory = ESX.GetPlayerData().inventory
    local count = 0
    local PedCoords = GetEntityCoords(GetPlayerPed(-1))
    local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
    for i=1, #inventory, 1 do
    	if inventory[i].name == 'alive_chicken' then
    	count = inventory[i].count
    	end
	end

    if(count > 0) then
    LoadDict(dict)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
    knife = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
    AttachEntityToEntity(knife, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
	if position == 1 then
		exports['mythic_progbar']:Progress({
			name = "cortar_carne",
			duration = 5000,
			label = "A cortar filetes...",
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
	SetEntityHeading(GetPlayerPed(-1), 309.39)
	propchicken = CreateObject(GetHashKey('prop_int_cf_chick_01'),-94.87, 6207.008, 30.05, true, true, true)
	SetEntityRotation(propchicken,90.0, 0.0, 45.0, 1,true)
	Citizen.Wait(5000)
	elseif position == 2 then
		exports['mythic_progbar']:Progress({
			name = "cortar_carne2",
			duration = 5000,
			label = "A cortar filetes...",
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
    SetEntityHeading(GetPlayerPed(-1), 222.0)
    propchicken = CreateObject(GetHashKey('prop_int_cf_chick_01'),-100.39, 6201.56, 29.99, true, true, true)
	SetEntityRotation(propchicken,90.0, 0.0, -45.0, 1,true)
	Citizen.Wait(5000)
    end
    exports['mythic_notify']:SendAlert('success', 'Matas te um frango')
    FreezeEntityPosition(GetPlayerPed(-1),false)
    DeleteEntity(propchicken)
    DeleteEntity(knife)
    ClearPedTasks(GetPlayerPed(-1))
    TriggerServerEvent("tqrp:mataagalinha",1)
    else
    exports['mythic_notify']:SendAlert('success', 'Não tens frangos')
    end
end


function TepnijWyjscie()
DoScreenFadeOut(500)
Citizen.Wait(500)
SetEntityCoordsNoOffset(GetPlayerPed(-1), startX+2, startY+2, startZ, 0, 0, 1)
if DoesEntityExist(chicken1) or DoesEntityExist(chicken2) or DoesEntityExist(chicken3) then
DeleteEntity(chicken1)
DeleteEntity(chicken2)
DeleteEntity(chicken3)
end
Citizen.Wait(500)
DoScreenFadeIn(500)

local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)

local haveBox = true

while haveBox do
Citizen.Wait(250)
local vehicle   = ESX.Game.GetVehicleInDirection()
local coords    = GetEntityCoords(GetPlayerPed(-1))
LoadDict('anim@heists@box_carry@')

	if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and haveBox == true then
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	end

	if DoesEntityExist(vehicle) then
	haveBox = false
	exports['mythic_notify']:SendAlert('success', 'Guardas te os frangos')
	LoadDict('anim@heists@narcotics@trash')
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	Citizen.Wait(900)
	ClearPedTasks(GetPlayerPed(-1))
	DeleteEntity(prop)
	TriggerServerEvent("tqrp:apanhagalinha")
	end
end



end

function LapKurczaka()
DoScreenFadeOut(500)
Citizen.Wait(500)
SetEntityCoordsNoOffset(GetPlayerPed(-1), 2385.963, 5047.333, 46.400, 0, 0, 1)
RequestModel(GetHashKey('a_c_hen'))
while not HasModelLoaded(GetHashKey('a_c_hen')) do
Wait(1)
end
chicken1 = CreatePed(26, "a_c_hen", 2370.262, 5052.913, 46.437, 276.351, true, false)

chicken2 = CreatePed(26, "a_c_hen", 2372.040, 5059.604, 46.444, 223.595, true, false)
chicken3 = CreatePed(26, "a_c_hen", 2379.192, 5062.992, 46.444, 195.477, true, false)
TaskReactAndFleePed(chicken1, GetPlayerPed(-1))
TaskReactAndFleePed(chicken2, GetPlayerPed(-1))
TaskReactAndFleePed(chicken3, GetPlayerPed(-1))
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
	local chicken1Coords = GetEntityCoords(chicken1)
	local chicken2Coords = GetEntityCoords(chicken2)
	local chicken3Coords = GetEntityCoords(chicken3)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chicken1Coords.x, chicken1Coords.y, chicken1Coords.z)
	local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chicken2Coords.x, chicken2Coords.y, chicken2Coords.z)
	local dist3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chicken3Coords.x, chicken3Coords.y, chicken3Coords.z)

	if captured == 3 then
	Zfrango1 = 0
	Zfrango2 = 0
	Zfrango3 = 0
	captured = 0
	share = false
	exports['mythic_notify']:SendAlert('success', 'Leva a caixa ao carro')
	TepnijWyjscie()
	end

	if dist <= 1.0 then
	DrawText3D2(chicken1Coords.x, chicken1Coords.y, chicken1Coords.z+0.5, "~o~[E]~b~ Apanhar a galinha")
		if IsControlJustPressed(0, 38) then
		Zfrango1 = 1
		ZostalZlapany()
		end
	elseif dist2 <= 1.0 then
		DrawText3D2(chicken2Coords.x, chicken2Coords.y, chicken2Coords.z+0.5, "~o~[E]~b~  Apanhar a galinha")
		if IsControlJustPressed(0, 38) then
		Zfrango2 = 1
		ZostalZlapany()
		end
	elseif dist3 <= 1.0 then
		DrawText3D2(chicken3Coords.x, chicken3Coords.y, chicken3Coords.z+0.5, "~o~[E]~b~  Apanhar a galinha")
		if IsControlJustPressed(0, 38) then
		Zfrango3 = 1
		ZostalZlapany()
		end
	end
	if (dist > 5.0 ) and  (dist2 > 5.0 ) and  (dist3 > 5.0 ) then
		Citizen.Wait(1000)
	end
else
Citizen.Wait(3000)
end
end
end)

local ragdoll = false

function ZostalZlapany()
	LoadDict('move_jump')
	TaskPlayAnim(GetPlayerPed(-1), 'move_jump', 'dive_start_run', 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
	Citizen.Wait(600)
	SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	Citizen.Wait(1000)
	ragdoll = true
	local szansaZlapania = math.random(1,100)
	if szansaZlapania <= 60 then
			exports['mythic_notify']:SendAlert('success', 'Apanhas te uma Galinha')
			if Zfrango1 == 1 then
				DeleteEntity(chicken1)
				Zfrango1 = 0
				captured = captured +1
			elseif Zfrango2 == 1 then
				DeleteEntity(chicken2)
				Zfrango2 = 0
				captured = captured +1
			elseif Zfrango3 == 1 then
				DeleteEntity(chicken3)
				Zfrango3 = 0
				captured = captured +1
			end
		else
		exports['mythic_notify']:SendAlert('error', 'Ahahah a Galinha fugiu')
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
			Citizen.Wait(3000)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(7)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sellX, sellY, sellZ)
	if dist < 80.0 then
		if dist <= 2.5 then
		--Uncomment if you want markers
		DrawMarker(27, sellX, sellY, sellZ-0.96, 0, 0, 0, 0, 0, 0, 2.20, 2.20, 2.20, 255, 255, 255, 200, 0, 0, 0, 0)
		else
		Citizen.Wait(3000)
		end

		if dist <= 2.0 then
		DrawText3D2(sellX, sellY, sellZ+0.1, "[E] Vender frango empacotado")
			if IsControlJustPressed(0, 38) then
			VenderFrangos()
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

function VenderFrangos()
local inventory = ESX.GetPlayerData().inventory
local count = 0
for i=1, #inventory, 1 do
	if inventory[i].name == 'packaged_chicken' then
	count = inventory[i].count
	end
end
if(count > 4) then
local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
local ped = GetPlayerPed(-1)
prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
LoadDict('amb@medic@standing@tendtodead@idle_a')
TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
--exports['taskbar']:taskBar(5000, 'A Vender o frango')
exports['mythic_progbar']:Progress({
	name = "vender_carne",
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
TriggerServerEvent("tqrp:mataagalinha",3)
ClearPedTasksImmediately(ped)
DeleteEntity(prop)
else
exports['mythic_notify']:SendAlert('success', 'N tens embalagens suficientes pra vender')
end
end
