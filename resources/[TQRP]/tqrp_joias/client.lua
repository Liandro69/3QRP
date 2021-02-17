local ESX, leftdoor, rightdoor= nil, nil, nil
local IsBusy, HasNotified, shockingevent,policeclosed, IsAbleToRob, HasAlreadyEnteredArea = false,false,false,false,false,false
local CopsOnline = 0
local Loaded = false
Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	while PlayerData.job == nil do
		Citizen.Wait(10)
	end
end)

RegisterCommand('fecharloja', function(source, args, rawCommand)
	if Config.AllowPoliceStoreClose then
		ply = PlayerPedId()
		plyloc = GetEntityCoords(ply)
		local ispolice = false
		for i, v in pairs(Config.PoliceJobs) do
			if PlayerData.job.name == v then
				ispolice = true
				break
			end
		end
		if GetDistanceBetweenCoords(plyloc, -631.9449, -237.8447, 38.07262, true) < 5.0 and ispolice then
			TriggerServerEvent('tqrp_joias:closestore')
		elseif ispolice then
			--ESX.ShowNotification('You must be standing near door to force the store closed!')
			exports['mythic_notify']:SendAlert('inform', 'Tens que estar perto da porta para fecha-la')
		end
	end
end)

RegisterNetEvent('tqrp_joias:policeclosure')
AddEventHandler('tqrp_joias:policeclosure', function()
	policeclosed = true
	storeclosed = false
	IsAbleToRob = false
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent('tqrp_joias:loadconfig')
end)

RegisterNetEvent('tqrp_joias:resetcases')
AddEventHandler('tqrp_joias:resetcases', function(list)
	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -622.2496, -230.8000, 38.05705, true)  < 20.0  then
		for i, v in pairs(Config.CaseLocations) do
			if v.Broken then
				RemoveModelSwap(v.Pos.x, v.Pos.y, v.Pos.z, 0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
			end
		end
	end
	Config.CaseLocations = list
	HasNotified = false
	policeclosed = false
	storeclosed = false
	IsAbleToRob = false
	HasAlreadyEnteredArea = false
end)

RegisterNetEvent('tqrp_joias:setcase')
AddEventHandler('tqrp_joias:setcase', function(casenumber, switch)
	Config.CaseLocations[casenumber].Broken = switch
	HasAlreadyEnteredArea = false
end)

RegisterNetEvent('tqrp_joias:loadconfig')
AddEventHandler('tqrp_joias:loadconfig', function(casestatus)
	while not DoesEntityExist(PlayerPedId()) do
		Citizen.Wait(100)
	end
	Config.CaseLocations = casestatus
	if GetDistanceBetweenCoords(plyloc, -622.2496, -230.8000, 38.05705, true)  < 20.0 then
		for i, v in pairs(Config.CaseLocations) do
			if v.Broken then
				CreateModelSwap(v.Pos.x, v.Pos.y, v.Pos.z, 0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
			end
		end
	end
end)

RegisterNetEvent('tqrp_joias:playsound')
AddEventHandler('tqrp_joias:playsound', function(x,y,z, soundtype)
	ply = PlayerPedId()
	plyloc = GetEntityCoords(ply)
	if GetDistanceBetweenCoords(plyloc,x,y,z,true) < 20.0 then
		if soundtype == 'break' then
			PlaySoundFromCoord(-1, "Glass_Smash", x,y,z, 0, 0, 0)
		elseif soundtype == 'nonbreak' then
			PlaySoundFromCoord(-1, "Drill_Pin_Break", x,y,z, "DLC_HEIST_FLEECA_SOUNDSET", 0, 0, 0)
		end
	end
end)

AddEventHandler('tqrp_joias:EnteredArea', function()
	for i, v in pairs(Config.CaseLocations) do
		if v.Broken then
			CreateModelSwap(v.Pos.x, v.Pos.y, v.Pos.z, 0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
		end
	end
end)

AddEventHandler('tqrp_joias:LeftArea', function()
	for i, v in pairs(Config.CaseLocations) do
		if v.Broken then
			RemoveModelSwap(v.Pos.x, v.Pos.y, v.Pos.z, 0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
		end
	end
end)

function UnAuthJob()
	while ESX == nil do
		Citizen.Wait(10)
	end
	local UnAuthjob = false
	for i,v in pairs(Config.UnAuthJobs) do
		if PlayerData.job.name == v then
			UnAuthjob = true
			break
		end
	end

	return UnAuthjob
end

function DrawText3Ds(x,y,z, text)
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
end

Citizen.CreateThread(function ()
	while true do 
		if IsInArea then
			ESX.TriggerServerCallback('tqrp_base:getJobsOnline', function(ems, police, mechano)
				Loaded = false
				CopsOnline = police
				Loaded = true
			end)
			Citizen.Wait(30000)
		else
			Citizen.Wait(15000)
		end
		Citizen.Wait(10)
	end
end)

Citizen.CreateThread( function()
	while true do 
		ply = PlayerPedId()
		plyloc = GetEntityCoords(ply)
		IsInArea = false
		
		if GetDistanceBetweenCoords(plyloc, -622.2496, -230.8000, 38.05705, true)  < 20.0 then
			IsInArea = true
		end

		while Loaded == false and IsInArea do
			Citizen.Wait(500)
		end

		if IsInArea and not HasAlreadyEnteredArea then
			TriggerEvent('tqrp_joias:EnteredArea')
			shockingevent = false
			if Config.Closed and not (CopsOnline >= Config.MinPolice) and not policeclosed then
				leftdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_l"), false, false, false)
				rightdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_r1"), false, false, false)			
				ClearAreaOfPeds(-622.2496, -230.8000, 38.05705, 10.0, 1)
				storeclosed = true
				HasNotified = false
			elseif not Config.Closed and CopsOnline >= Config.MinPolice and not policeclosed then
				leftdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_l"), false, false, false)
				rightdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_r1"), false, false, false)			
				storeclosed = false
				Citizen.Wait(100)
				freezedoors(false)
				IsAbleToRob = true
				HasNotified = false
			end
			HasAlreadyEnteredArea = true
		end

		if not IsInArea and HasAlreadyEnteredArea then
			TriggerEvent('tqrp_joias:LeftArea')
			HasAlreadyEnteredArea = false
			shockingevent = false
			IsAbleToRob = false
			storeclosed = false
			HasNotified = false
		end
		
		if Config.Closed and not (CopsOnline >= Config.MinPolice) and not storeclosed and not policeclosed then
			Citizen.Wait(1250)
		else
			Citizen.Wait(3250)
		end

		if not IsInArea and not HasAlreadyEnteredArea then
			Citizen.Wait(1500)
		end
	end
end)

function hasgun()
	hasweapon = false
	local _, weaponname = GetCurrentPedWeapon(ply)
	for index, weapon in pairs (Config.AllowedWeapons) do
		if GetHashKey(weapon.name) == weaponname then
			hasweapon = weapon
			break 
		end
	end
	return hasweapon
end

function freezedoors(status)
	FreezeEntityPosition(leftdoor, status)
	FreezeEntityPosition(rightdoor, status)
end

Citizen.CreateThread( function()
	while true do 
		sleep = 1500
		while storeclosed do
			ply = PlayerPedId()
			plyloc = GetEntityCoords(ply)
			if GetDistanceBetweenCoords(plyloc, -622.2496, -230.8000, 38.05705, true)  < 10.0 then
				DoScreenFadeOut(1250)
				Citizen.Wait(1500)
				SetEntityCoords(PlayerPedId(), -673.1831, -227.6621, 36.11,0,0,0,true)
				DoScreenFadeIn(1250)
				--ESX.ShowNotification('Vangelico Jewelry is now Closed!')
				exports['mythic_notify']:SendAlert('inform', 'A loja do Vangelico esta agora fechada')
			end
			Citizen.Wait(10)
			sleep = 0
			freezedoors(true)	
			if GetDistanceBetweenCoords(plyloc, -632.81, -237.9, 38.08, false) < 2.0 then
				DrawText3Ds(- 631.4819, -237.6632, 39.07612, 'Loja Fechada')
			else
				Citizen.Wait(1500)
            end
		end

		while policeclosed do
			ply = PlayerPedId()
			plyloc = GetEntityCoords(ply)
			if GetDistanceBetweenCoords(plyloc, -622.2496, -230.8000, 38.05705, true)  < 10.0 then
				DoScreenFadeOut(1250)
				Citizen.Wait(1500)
				SetEntityCoords(PlayerPedId(), -673.1831, -227.6621, 36.11,0,0,0,true)
				DoScreenFadeIn(1250)
				--ESX.ShowNotification('Vangelico Jewelry is now Closed for cleanup!')
				exports['mythic_notify']:SendAlert('inform', 'A loja está agora fechada para remodelaçoes')
			end
			Citizen.Wait(10)
			sleep = 0
			freezedoors(true)	
			if GetDistanceBetweenCoords(plyloc, -632.81, -237.9, 38.08, false) < 2.0 then
				DrawText3Ds(- 631.4819, -237.6632, 39.07612, 'A loja está agora fechada para remodelaçoes')
			else
				Citizen.Wait(1500)
			end
				
		end

		while IsAbleToRob and not UnAuthJob() and hasgun() do
			sleep = 1500
			ply = PlayerPedId()
			plyloc = GetEntityCoords(ply)
			for i, v in pairs(Config.CaseLocations) do
				if GetDistanceBetweenCoords(plyloc, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0  and not v.Broken and not IsBusy then
					sleep = 5
					DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z + 0.5, 'Pressiona ~g~E~w~ pra tentar partir')
					if IsControlJustPressed(0, 38) and not IsBusy and not IsPedWalking(ply) and not IsPedRunning(ply) and not IsPedSprinting(ply) then
						local policenotify = math.random(1,100)
						if not shockingevent  then
							AddShockingEventAtPosition(99, v.Pos.x, v.Pos.y, v.Pos.z,25.0)
							shockingevent = true
						end
						IsBusy = true				
						TaskTurnPedToFaceCoord(ply, v.Pos.x, v.Pos.y, v.Pos.z, 1250)
						if not HasAnimDictLoaded("missheist_jewel") then
							RequestAnimDict("missheist_jewel") 
						end
						while not HasAnimDictLoaded("missheist_jewel") do 
						Citizen.Wait(10)
						end
						TaskPlayAnim(ply, 'missheist_jewel', 'smash_case', 1.0, -1.0,-1,1,0,0, 0,0)
						local breakchance = math.random(1, 100)
						TriggerServerEvent("big_skills:addStress", 10000)
						if breakchance <= hasweapon.chance then
							if policenotify <= Config.PoliceNotifyBroken and not HasNotified then
								local playerCoords = GetEntityCoords(PlayerPedId())
								TriggerServerEvent("tqrp_outlawalert:Vangelico",
									'police', "Alarme Vangelico", "Desconhecido", "person", "gps_fixed", 1, 
									playerCoords.x, playerCoords.y, playerCoords.z, 439, 75, "10-90"
								)
								HasNotified = true
							end
							TriggerServerEvent('tqrp_base:roblog','Assalto à Vangelico','Partiu uma Montra - ID: '..i, 36124)
							Citizen.Wait(2100)
							TriggerServerEvent('tqrp_joias:playsound', v.Pos.x, v.Pos.y, v.Pos.z, 'break')
							CreateModelSwap(v.Pos.x, v.Pos.y, v.Pos.z,  0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
							ClearPedTasksImmediately(ply)
							TriggerServerEvent("tqrp_joias:setcase", i, true)	
							TriggerEvent("tqrp_provas:criarProvaCL_ID", v.Pos.x, v.Pos.y, v.Pos.z)
						else
							Citizen.Wait(2100)
							TriggerServerEvent('tqrp_joias:playsound', v.Pos.x, v.Pos.y, v.Pos.z, 'nonbreak')
							ClearPedTasksImmediately(ply)
							if policenotify <= Config.PoliceNotifyNonBroken and not HasNotified then
								local playerCoords = GetEntityCoords(PlayerPedId())
								TriggerServerEvent("tqrp_outlawalert:Vangelico",
									'police', "Alarme Vangelico", "Desconhecido", "person", "gps_fixed", 1, 
									playerCoords.x, playerCoords.y, playerCoords.z, 439, 75, "10-90"
								)
								HasNotified = true
							end
							TriggerServerEvent("big_skills:addStress", 30000)
						end
						Citizen.Wait(1250)
						IsBusy = false			
					end
				end
			end
			Citizen.Wait(sleep)
		end
		Citizen.Wait(sleep)
	end
end)