---======================---
---Written by Tościk#9715---          -----   ENGLISH VERSION BY RENGER | WWW.FIVEMLEAK.COM    -----
---======================---
local MiejsceMisji =  {x = -68.26197509766, y = -1208.81979064941, z = 28.1252947998} --<< miejsce gdzie jest marker z misją
local dealerCoords =  {x = -68.26, y = -1208.81, z = 28.12}  							--<< miejsce gdzie stoi dealer NPC
local pojazdCoords1 = {x = -1327.479736328, y = -86.045326232910, z = 49.31}  		--<< ponizej koordynaty do randomowego respienia się pojazdu
local pojazdCoords2 = {x = -2075.888183593, y = -233.73908996580, z = 21.10}
local pojazdCoords3 = {x = -972.1781616210, y = -1530.9045410150, z = 4.890}
local pojazdCoords4 = {x = 798.18426513672, y = -1799.8173828125, z = 29.33}
local pojazdCoords5 = {x = 1247.0718994141, y = -344.65634155273, z = 69.08}
local BronKierowca = "WEAPON_PISTOL" 		--<< broń w jaką ma być wyposażony kierowca
local BronPasazer = "WEAPON_PISTOL"  			--<< broń w jaką ma być wyposażony strażnik
local CzasDetonacji = 20 * 1000 			--<< czas detonacji bomby po podłożeniu, domyślnie 20 sekund
local czasPakowania = 30 * 1000 			--<< czas pakowania gotówki do torby, domyślnie 30 sekund
----------------------tego nizej nie ruszaj------------------------------
local prop
local wyjebalo = 0
local wysadzony = 0
local oznaczenie
local transport
local zrespione = 0
local ZrespTuPojazd = nil
local dealer
local ostrzezenie = 0
local blip
--------------------------------------------------------
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

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local scale = 0.30
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(8)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false) 
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, MiejsceMisji.x, MiejsceMisji.y, MiejsceMisji.z)

			if dist <= 25.0  then
				if not DoesEntityExist(dealer) then
				RequestModel("s_m_y_dealer_01")
				while not HasModelLoaded("s_m_y_dealer_01") do
				Wait(10)
				end
				dealer = CreatePed(26, "s_m_y_dealer_01", dealerCoords.x, dealerCoords.y, dealerCoords.z, 268.9422, false, false)
				SetEntityHeading(dealer, 1.8)
				SetBlockingOfNonTemporaryEvents(dealer, true)
				TaskStartScenarioInPlace(dealer, "WORLD_HUMAN_AA_SMOKE", 0, false)
				end
				
			else
			Citizen.Wait(1500)
			end

            if dist <= 1.0 then
				DrawText3D(MiejsceMisji.x, MiejsceMisji.y, MiejsceMisji.z, "~g~[E]~b~ Para aceitar a tarefa ")
				if IsControlJustPressed(0, Keys['E']) then
				ESX.TriggerServerCallback('tqrp_base:getJobsOnline', function(ems, police)
					if police > 0 then
						TriggerServerEvent("napadtransport:akceptujto")	
					else
						exports['mythic_notify']:SendAlert('error', 'Ação impossível de momento!')
					end
				end)
				Citizen.Wait(500)
				end
            end

end
end)
---
Citizen.CreateThread(function()
	while true do
		while zrespione == 1 do
			local transporterCoords = GetEntityCoords(transport) 
			TriggerServerEvent('napadtransport:zawiadompsy', transporterCoords)
			Citizen.Wait(5000)	
		end	
	Citizen.Wait(10000)	
	end
end)



function PowiadomPsy()
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	playerX = tonumber(string.format("%.2f", x))
    playerY = tonumber(string.format("%.2f", y))
    playerZ = tonumber(string.format("%.2f", z))
	--	TriggerServerEvent('napadtransport:zawiadompsy', playerX, playerY, playerZ)
	TriggerServerEvent("tqrp_outlawalert:Vangelico",
	'police', "Assalto à carrinha forte", "Desconhecido", "person", "gps_fixed", 1, 
	playerX, playerY, playerZ, 140, 75, "10-90")
	Citizen.Wait(500)
end

RegisterNetEvent('napadtransport:infodlalspd')
AddEventHandler('napadtransport:infodlalspd', function(coordenadas)	
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
	RemoveBlip(blip)	
	blip = AddBlipForCoord(coordenadas.x, coordenadas.y, coordenadas.z)
	SetBlipSprite(blip, 67)
	SetBlipColour(blip, 3)
	SetBlipFlashes(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Carrinha Forte')
	EndTextCommandSetBlipName(blip)
	end
end)

function NotyfikacjaMisja()
PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
 exports['mythic_notify']:SendAlert('success', 'Carrinha marcada no GPS!')
end


RegisterNetEvent('napadtransport:Pozwolwykonac')
AddEventHandler('napadtransport:Pozwolwykonac', function()
NotyfikacjaMisja()
ClearPedTasks(dealer)
TaskWanderStandard(dealer, 100,100)
local losujCoordy = math.random(1,5)
if losujCoordy == 1 then
ZrespTuPojazd = pojazdCoords1
elseif losujCoordy == 2 then
ZrespTuPojazd = pojazdCoords2
elseif losujCoordy == 3 then
ZrespTuPojazd = pojazdCoords3
elseif losujCoordy == 4 then
ZrespTuPojazd = pojazdCoords4
elseif losujCoordy == 5 then
ZrespTuPojazd = pojazdCoords5
end

RequestModel(GetHashKey('stockade'))
while not HasModelLoaded(GetHashKey('stockade')) do
Citizen.Wait(10)
end

SetNewWaypoint(ZrespTuPojazd.x, ZrespTuPojazd.y)
ClearAreaOfVehicles(ZrespTuPojazd.x, ZrespTuPojazd.y, ZrespTuPojazd.z, 15.0, false, false, false, false, false) 
				
transport = CreateVehicle(GetHashKey('stockade'), ZrespTuPojazd.x, ZrespTuPojazd.y, ZrespTuPojazd.z, -2.436,  996.786, 25.1887, true, true)
TriggerServerEvent("tqrp_outlawalert:Vangelico",
'police', "Escolta Requisitada pela Group6", "Desconhecido", "person", "gps_fixed", 1,
ZrespTuPojazd.x, ZrespTuPojazd.y, ZrespTuPojazd.z, 67, 69, "10-65")
SetEntityAsMissionEntity(transport)
SetEntityHeading(transport, 52.00)
oznaczenie = AddBlipForEntity(transport)
SetBlipSprite(oznaczenie, 67)
SetBlipColour(oznaczenie, 1)
SetBlipFlashes(oznaczenie, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString('Carrinha Forte')
EndTextCommandSetBlipName(oznaczenie)
--

RequestModel("s_m_m_security_01")
while not HasModelLoaded("s_m_m_security_01") do
Wait(10)
end

local pilot = CreatePedInsideVehicle(transport, 1, "s_m_m_security_01", -1, true, true)
local nawigator = CreatePedInsideVehicle(transport, 1, "s_m_m_security_01", 0, true, true)
SetPedFleeAttributes(pilot, 0, 0)
SetPedCombatAttributes(pilot, 46, 1)
SetPedCombatAbility(pilot, 100)
SetPedCombatMovement(pilot, 2)
SetPedCombatRange(pilot, 2)
SetPedKeepTask(pilot, true)
GiveWeaponToPed(pilot, GetHashKey(BronKierowca),250,false,true)
SetPedAsCop(pilot, true)
--
SetPedFleeAttributes(nawigator, 0, 0)
SetPedCombatAttributes(nawigator, 46, 1)
SetPedCombatAbility(nawigator, 100)
SetPedCombatMovement(nawigator, 2)
SetPedCombatRange(nawigator, 2)
SetPedKeepTask(nawigator, true)
TaskEnterVehicle(nawigator,transport,-1,0,1.0,1)
GiveWeaponToPed(nawigator, GetHashKey(BronPasazer),250,false,true)
SetPedAsCop(nawigator, true)

TaskVehicleDriveWander(pilot, transport, 80.0, 443)
zrespione = 1
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(8)
		
		if zrespione == 1 then

			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local transCoords = GetEntityCoords(transport) 

            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, transCoords.x, transCoords.y, transCoords.z)
			if dist <= 55.0  then
			DrawMarker(0, transCoords.x, transCoords.y, transCoords.z+4.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 135, 31, 35, 100, 1, 0, 0, 0)
				if ostrzezenie == 0 then
				ostrzezenie = 1
				exports['mythic_notify']:SendAlert('inform', 'Elimina os alvos antes de atacares a carga!')
				end
			else
			Citizen.Wait(500)
			end
			
			if dist <= 4.5 and wysadzony == 0 then
				hintToDisplay('Pressiona ~INPUT_DETONATE~ para colocar a carga explosiva!')
				if IsControlJustPressed(0, Keys['G']) then 
				SprawdzInformacjePojazdowe()
				Citizen.Wait(500)
				end
			end
			
			
		else
		Citizen.Wait(1500)
		end
end
end)

function SprawdzInformacjePojazdowe()
if IsVehicleStopped(transport) then
	if IsVehicleSeatFree(transport, -1) and IsVehicleSeatFree(transport, 0) and IsVehicleSeatFree(transport, 1) then
	wysadzony = 1
	RequestAnimDict('anim@heists@ornate_bank@thermal_charge_heels')
	while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge_heels') do
	Citizen.Wait(50)
	end
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	prop = CreateObject(GetHashKey('prop_c4_final_green'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.06, 0.0, 0.06, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
	SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"),true)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@ornate_bank@thermal_charge_heels', "thermal_charge", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
	DetachEntity(prop)
	AttachEntityToEntity(prop, transport, GetEntityBoneIndexByName(transport, 'door_pside_r'), -0.7, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	exports['mythic_notify']:SendAlert('inform', 'A carga está prestes a explodir!')
	FreezeEntityPosition(GetPlayerPed(-1), false)
	Citizen.Wait(CzasDetonacji)
	local transCoords = GetEntityCoords(transport)
	SetVehicleDoorBroken(transport, 2, false)
	SetVehicleDoorBroken(transport, 3, false)
	AddExplosion(transCoords.x,transCoords.y,transCoords.z, 'EXPLOSION_TANKER', 2.0, true, false, 2.0)
	ApplyForceToEntity(transport, 0, transCoords.x,transCoords.y,transCoords.z, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
	wyjebalo = 1
	exports['mythic_notify']:SendAlert('success', 'Podes começar a recolher o dinheiro!')
	RemoveBlip(oznaczenie)
	PowiadomPsy()
	else
	exports['mythic_notify']:SendAlert('error', 'O veículo deve estar vazio para acomodar a carga!')
	end
else
	exports['mythic_notify']:SendAlert('error', 'O veículo deve estar vazio para acomodar a carga!')

end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(8)
		
		if wyjebalo == 1 then
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local transCoords = GetEntityCoords(transport) 
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, transCoords.x, transCoords.y, transCoords.z)

			if dist > 45.0 then
			Citizen.Wait(500)
			end
			
			if dist <= 4.5 then
				hintToDisplay('Pressiona ~INPUT_PICKUP~ para começares a recolher o dinheiro')
				if IsControlJustPressed(0, Keys['E']) then 
				wyjebalo = 0
				ZabieranieSiana()
				Citizen.Wait(500)
				end
			end
		else
		Citizen.Wait(1500)
		end
end
end)

function ZabieranieSiana()
RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
Citizen.Wait(50)
end
local PedCoords = GetEntityCoords(GetPlayerPed(-1))
torba = CreateObject(GetHashKey('prop_cs_heist_bag_02'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
AttachEntityToEntity(torba, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
FreezeEntityPosition(GetPlayerPed(-1), true)
exports['mythic_notify']:SendAlert('success', 'Puseste o dinheiro na mala!')
Citizen.Wait(czasPakowania)
DeleteEntity(torba)
ClearPedTasks(GetPlayerPed(-1))
FreezeEntityPosition(GetPlayerPed(-1), false)
SetPedComponentVariation(GetPlayerPed(-1), 5, 45, 0, 2)
TriggerServerEvent("napadtransport:graczZrobilnapad")
wyjebalo = 0
wysadzony = 0
zrespione = 0
Citizen.Wait(2500)
end

