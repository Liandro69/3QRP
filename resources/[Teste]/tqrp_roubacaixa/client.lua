
ESX = nil
local timing, isPlayerWhitelisted = math.ceil(1 * 60000), false

local Device
local copsOnline
local RobbingATM = false
local HackingATM = false

local streetName
local _

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)


-- Refresh police online:
function refreshPlayerWhitelisted()
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end

	if Config.PoliceDatabaseName == ESX.PlayerData.job.name then
		return true
	end

	return false
end

-- Core Thread Function:
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(7)
		local pos = GetEntityCoords(PlayerPedId())
		if not RobbingATM then
			if not HackingATM then
				for k,v in pairs(Config.ATMs) do
					if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) <= 1.5 then
						DrawText3Ds(v.x,v.y,v.z, "Insere a pen ~g~[G]~s~ para ~r~Roubar~s~ a ~y~ATM~s~")
						if IsControlJustPressed(0, 47) then
							startRobbingATM()
							break;
						end
					end
				end
			end
		end
	end
end)

-- Starting ATM Robbery:
function startRobbingATM()
	ESX.TriggerServerCallback("tqrp_roubacaixa:isRobbingPossible", function(cooldownATM)
		if not cooldownATM then
			ESX.TriggerServerCallback('tqrp_roubacaixa:getOnlinePoliceCount', function(policeCount)
				if policeCount then
					ESX.TriggerServerCallback('tqrp_roubacaixa:getHackerDevice', function(hackerDevice)
						if hackerDevice then
							RobbingATM = true
							TriggerServerEvent("tqrp_roubacaixa:CooldownATM")
							FreezeEntityPosition(player,true)
							local player = PlayerPedId()
							local playerPos = GetEntityCoords(player)

							-- animation 1:
							local animDict = "random@atmrobberygen@male"
							local animName = "idle_a"

							RequestAnimDict(animDict)
							while not HasAnimDictLoaded(animDict) do
								Citizen.Wait(0)
							end

							if Config.PoliceNotfiyEnabled == true and not HasNotified then
								--TriggerServerEvent('tqrp_roubacaixa:PoliceNotify',playerPos,streetName)
								local playerCoords = GetEntityCoords(PlayerPedId())
								TriggerServerEvent("tqrp_outlawalert:Vangelico",
									'police', "Alarme Caixa", "Desconhecido", "person", "gps_fixed", 1,
									playerCoords.x, playerCoords.y, playerCoords.z, 439, 75, "10-90"
								)
								HasNotified = true
							end

							--exports['progressBars']:startUI(12000, "CONNECTING DEVICE")
							exports['mythic_progbar']:Progress({
								name = "housrob",
								duration = 30000,
								label = "A inserir virus no sistema... ",
								useWhileDead = false,
								canCancel = true,
								controlDisables = {},
							  }, function(status)
								if not status then
									exports["datacrack"]:Start(5)
								end
							end)
							TaskStartScenarioInPlace(player, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
							TaskPlayAnim(player,animDict,animName,3.0,0.5,-1,31,1.0,0,0)
							Citizen.Wait(30000)
							HackingATM = true
						else
							RobbingATM = false
						end
					end)
				else
					RobbingATM = false
				end
			end)
		else
			RobbingATM = false
		end
	end)
end

--O evento de Hackear
AddEventHandler("datacrack", function(success) -- evento a ser dado trigger
	-- o codigo para a função:
	local player = PlayerPedId()
    FreezeEntityPosition(player,false)
	if success then
		TriggerServerEvent("tqrp_roubacaixa:success")
		ClearPedTasks(player)
		ClearPedSecondaryTask(player)
        --ESX.ShowHelpNotification('Hack complete!', false, true, 5000)
        exports['mythic_notify']:SendAlert('inform', 'Hack Completo')
    else
		--ESX.ShowHelpNotification('Hack failed!', false, true, 5000)
		exports['mythic_notify']:SendAlert('inform', 'Hack Falhado')
	end
	ClearPedTasks(player)
	ClearPedSecondaryTask(player)
	RobbingATM = false
	HackingATM = false
end)



-- Draw 3D text Function:
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

