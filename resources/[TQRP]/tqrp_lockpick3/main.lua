ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

-- WYTRYCHY
local yyy1 = 0.36
local yyy2 = 0.36
local yyy3 = 0.36
local yyy4 = 0.36

local rrr1 = 152
local ggg1 = 212
local bbb1 = 224

local rrr2 = 152
local ggg2 = 212
local bbb2 = 224

local rrr3 = 152
local ggg3 = 212
local bbb3 = 224

local rrr4 = 152
local ggg4 = 212
local bbb4 = 224

local otwiera = false
local pin1 = false
local pin2 = false
local pin3 = false
local pin4 = false

local igrekPin1 = (math.random(3250, 3550) * 0.0001)
local igrekPin2 = (math.random(3250, 3550) * 0.0001)
local igrekPin3 = (math.random(3250, 3550) * 0.0001)
local igrekPin4 = (math.random(3250, 3550) * 0.0001)

--- Main car lock

Citizen.CreateThread(function()
	while true do
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
			local PlayerPed = PlayerPedId()
			local veh = GetVehiclePedIsTryingToEnter(PlayerPed)
			local lock = GetVehicleDoorLockStatus(veh)
			local pedd = GetPedInVehicleSeat(veh, -1)
			if pedd then
				SetPedCanBeDraggedOut(pedd, false)
			end
			if lock == 7 then
				SetVehicleDoorsLocked(veh, 2)
			elseif lock == 4 then
	        	ClearPedTasks(PlayerPed)
			end
		else
			Citizen.Wait(1000)
		end
	Citizen.Wait(10)
	end
end)

RegisterNetEvent('welldone_lockpick:open')
AddEventHandler('welldone_lockpick:open', function()
	local PlayerPed = PlayerPedId()
	local coords = GetEntityCoords(PlayerPed)
	local valid = IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0)
	if valid then
		TriggerServerEvent('welldone_lockpick:remove')
		TaskStartScenarioInPlace(PlayerPed, "PROP_HUMAN_BUM_BIN", 0, true)
		otwiera = true
		yyy1 = 0.36
		yyy2 = 0.36
		yyy3 = 0.36
		yyy4 = 0.36

		rrr1 = 152
		ggg1 = 212
		bbb1 = 224

		rrr2 = 152
		ggg2 = 212
		bbb2 = 224

		rrr3 = 152
		ggg3 = 212
		bbb3 = 224

		rrr4 = 152
		ggg4 = 212
		bbb4 = 224

		pin1 = false
		pin2 = false
		pin3 = false
		pin4 = false

		igrekPin1 = (math.random(3250, 3550) * 0.0001)
		igrekPin2 = (math.random(3250, 3550) * 0.0001)
		igrekPin3 = (math.random(3250, 3550) * 0.0001)
		igrekPin4 = (math.random(3250, 3550) * 0.0001)
	end
end)


local txd = CreateRuntimeTxd('Lockpick')
local tx = CreateRuntimeTextureFromImage(txd, 'Lockpick', "background.png")

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if otwiera then
			local PlayerPed = PlayerPedId()
			
			---------
			-- TŁO --
			---------

			DrawRect(0.9325, 0.3725, 0.113, 0.1915, 0, 0, 0, 255)
			DrawSprite('Lockpick', 'Lockpick', 0.9325, 0.3725, 0.113, 0.1915, 0.0, 255, 255, 255, 180)

			----------
			-- PINY --
			----------

			-- Od prawej

			-- Pierwszy Pin
			DrawRect(0.972, yyy1, 0.004, 0.04, rrr1, ggg1, bbb1, 180)
			-- Drugi Pin
			DrawRect(0.959, yyy2, 0.004, 0.04, rrr2, ggg2, bbb2, 180)
			-- Trzeci Pin
			DrawRect(0.9455, yyy3, 0.004, 0.04, rrr3, ggg3, bbb3, 180)
			-- Czwarty Pin
			DrawRect(0.932, yyy4, 0.004, 0.04, rrr4, ggg4, bbb4, 180)

			
			-- Instrukcja
			local coords = GetEntityCoords(PlayerPed)
			ESX.Game.Utils.DrawText3D(coords, "[~g~E~s~] - MOVE O PIN~n~[~g~H~s~] - DAS LOCK NO PIN~n~[~g~X~s~] - CANCELAR", 0.6)

			-- Blokada "X"
			DisableControlAction(0, 73, true)

			if IsDisabledControlJustPressed(0, 73) then
				otwiera = false
				pin1 = false
				pin2 = false
				pin3 = false
				pin4 = false
				rrr1 = 152
				ggg1 = 212
				bbb1 = 224
				rrr2 = 152
				ggg2 = 212
				bbb2 = 224
				rrr3 = 152
				ggg3 = 212
				bbb3 = 224
				rrr4 = 152
				ggg4 = 212
				bbb4 = 224
				yyy1 = 0.36
				yyy2 = 0.36
				yyy3 = 0.36
				yyy4 = 0.36
				DisableControlAction(0, 73, false)
				igrekPin1 = (math.random(3250, 3550) * 0.0001)
				igrekPin2 = (math.random(3250, 3550) * 0.0001)
				igrekPin3 = (math.random(3250, 3550) * 0.0001)
				igrekPin4 = (math.random(3250, 3550) * 0.0001)
				ClearPedTasksImmediately(PlayerPed)
			end
		else
			Citizen.Wait(1500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if otwiera then
			local PlayerPed = PlayerPedId()
			if not pin1 and not pin2 and not pin3 and not pin4 then
				if (yyy1 <= igrekPin1) and (igrekPin1 - 0.004 <= yyy1) then
					rrr1 = 76
					ggg1 = 175
					bbb1 = 0
					if IsControlJustPressed(0, 74) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'PinSucc', 0.1)
						pin1 = true
						yyy1 = 0.33
						rrr1 = 14
						ggg1 = 113
						bbb1 = 139
					end
				else
					rrr1 = 152
					ggg1 = 212
					bbb1 = 224
					if IsControlJustPressed(0, 74) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'PinFail', 0.1)
						rrr1 = 175
						ggg1 = 0
						bbb1 = 0
						Citizen.Wait(50)
						rrr1 = 152
						ggg1 = 212
						bbb1 = 224
						Citizen.Wait(50)
						rrr1 = 175
						ggg1 = 0
						bbb1 = 0
						Citizen.Wait(50)
						rrr3 = 152
						ggg3 = 212
						bbb3 = 224
					end
				end
			elseif pin1 and not pin2 and not pin3 and not pin4 then
				if (yyy2 <= igrekPin2) and (igrekPin2 - 0.004 <= yyy2) then
					rrr2 = 76
					ggg2 = 175
					bbb2 = 0
					if IsControlJustPressed(0, 74) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'PinSucc', 0.1)
						pin2 = true
						yyy2 = 0.33
						rrr2 = 14
						ggg2 = 113
						bbb2 = 139
					end
				else
					rrr2 = 152
					ggg2 = 212
					bbb2 = 224
					if IsControlJustPressed(0, 74) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'PinFail', 0.1)
						rrr2 = 175
						ggg2 = 0
						bbb2 = 0
						Citizen.Wait(50)
						rrr2 = 152
						ggg2 = 212
						bbb2 = 224
						Citizen.Wait(50)
						rrr2 = 175
						ggg2 = 0
						bbb2 = 0
						Citizen.Wait(50)
						rrr2 = 152
						ggg2 = 212
						bbb2 = 224
						pin1 = false
					end
				end
			elseif pin1 and pin2 and not pin3 and not pin4 then
				if (yyy3 <= igrekPin3) and (igrekPin3 - 0.004 <= yyy3) then
					rrr3 = 76
					ggg3 = 175
					bbb3 = 0
					if IsControlJustPressed(0, 74) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'PinSucc', 0.1)
						pin3 = true
						yyy3 = 0.33
						rrr3 = 14
						ggg3 = 113
						bbb3 = 139
					end
				else
					rrr3 = 152
					ggg3 = 212
					bbb3 = 224
					if IsControlJustPressed(0, 74) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'PinFail', 0.1)
						rrr3 = 175
						ggg3 = 0
						bbb3 = 0
						Citizen.Wait(50)
						rrr3 = 152
						ggg3 = 212
						bbb3 = 224
						Citizen.Wait(50)
						rrr3 = 175
						ggg3 = 0
						bbb3 = 0
						Citizen.Wait(50)
						rrr3 = 152
						ggg3 = 212
						bbb3 = 224
						pin2 = false
					end
				end
			elseif pin1 and pin2 and pin3 and not pin4 then
				if (yyy4 <= igrekPin4) and (igrekPin4 - 0.004 <= yyy4) then
					rrr4 = 76
					ggg4 = 175
					bbb4 = 0
					if IsControlJustPressed(0, 74) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'PinSucc', 0.1)
						pin4 = true
						yyy4 = 0.33
						rrr4 = 14
						ggg4 = 113
						bbb4 = 139
					end
				else
					rrr4 = 152
					ggg4 = 212
					bbb4 = 224
					if IsControlJustPressed(0, 74) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'PinFail', 0.1)
						rrr4 = 175
						ggg4 = 0
						bbb4 = 0
						Citizen.Wait(50)
						rrr4 = 152
						ggg4 = 212
						bbb4 = 224
						Citizen.Wait(50)
						rrr4 = 175
						ggg4 = 0
						bbb4 = 0
						Citizen.Wait(50)
						rrr4 = 152
						ggg4 = 212
						bbb4 = 224
						pin3 = false
					end
				end
			end
		else
			Citizen.Wait(1500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if otwiera then
			local PlayerPed = PlayerPedId()
		
			----------------
			-- PORUSZANIE --
			----------------

			if not pin1 and not pin2 and not pin3 and not pin4 then
				if IsControlJustPressed(0, 38) then
					if (yyy1 - 0.003) >= (0.36 - 0.04) then
						yyy1 = yyy1 - 0.003
						Citizen.Wait(10)
						if (yyy1 - 0.003) >= (0.36 - 0.04) then
							yyy1 = yyy1 - 0.003
							Citizen.Wait(10)
							if (yyy1 - 0.003) >= (0.36 - 0.04) then
								yyy1 = yyy1 - 0.003
								Citizen.Wait(10)
								if (yyy1 - 0.003) >= (0.36 - 0.04) then
									yyy1 = yyy1 - 0.003
									Citizen.Wait(10)
									if (yyy1 - 0.003) >= (0.36 - 0.04) then
										yyy1 = yyy1 - 0.003
										Citizen.Wait(10)
									end
								end
							end
						end
					end
				end
			elseif pin1 and not pin2 and not pin3 and not pin4 then
				if IsControlJustPressed(0, 38) then
					if (yyy2 - 0.003) >= (0.36 - 0.04) then
						yyy2 = yyy2 - 0.003
						Citizen.Wait(10)
						if (yyy2 - 0.003) >= (0.36 - 0.04) then
							yyy2 = yyy2 - 0.003
							Citizen.Wait(10)
							if (yyy2 - 0.003) >= (0.36 - 0.04) then
								yyy2 = yyy2 - 0.003
								Citizen.Wait(10)
								if (yyy2 - 0.003) >= (0.36 - 0.04) then
									yyy2 = yyy2 - 0.003
									Citizen.Wait(10)
									if (yyy2 - 0.003) >= (0.36 - 0.04) then
										yyy2 = yyy2 - 0.003
										Citizen.Wait(10)
									end
								end
							end
						end
					end
				end
			elseif pin1 and pin2 and not pin3 and not pin4 then
				if IsControlJustPressed(0, 38) then
					if (yyy3 - 0.003) >= (0.36 - 0.04) then
						yyy3 = yyy3 - 0.003
						Citizen.Wait(10)
						if (yyy3 - 0.003) >= (0.36 - 0.04) then
							yyy3 = yyy3 - 0.003
							Citizen.Wait(10)
							if (yyy3 - 0.003) >= (0.36 - 0.04) then
								yyy3 = yyy3 - 0.003
								Citizen.Wait(10)
								if (yyy3 - 0.003) >= (0.36 - 0.04) then
									yyy3 = yyy3 - 0.003
									Citizen.Wait(10)
									if (yyy3 - 0.003) >= (0.36 - 0.04) then
										yyy3 = yyy3 - 0.003
										Citizen.Wait(10)
									end
								end
							end
						end
					end
				end
			elseif pin1 and pin2 and pin3 and not pin4 then
				if IsControlJustPressed(0, 38) then
					if (yyy4 - 0.003) >= (0.36 - 0.04) then
						yyy4 = yyy4 - 0.003
						Citizen.Wait(10)
						if (yyy4 - 0.003) >= (0.36 - 0.04) then
							yyy4 = yyy4 - 0.003
							Citizen.Wait(10)
							if (yyy4 - 0.003) >= (0.36 - 0.04) then
								yyy4 = yyy4 - 0.003
								Citizen.Wait(10)
								if (yyy4 - 0.003) >= (0.36 - 0.04) then
									yyy4 = yyy4 - 0.003
									Citizen.Wait(10)
									if (yyy4 - 0.003) >= (0.36 - 0.04) then
										yyy4 = yyy4 - 0.003
										Citizen.Wait(10)
									end
								end
							end
						end
					end
				end
			elseif pin1 and pin2 and pin3 and pin4 then
				otwiera = false
				pin1 = false
				pin2 = false
				pin3 = false
				pin4 = false
				rrr1 = 152
				ggg1 = 212
				bbb1 = 224
				rrr2 = 152
				ggg2 = 212
				bbb2 = 224
				rrr3 = 152
				ggg3 = 212
				bbb3 = 224
				rrr4 = 152
				ggg4 = 212
				bbb4 = 224
				yyy1 = 0.36
				yyy2 = 0.36
				yyy3 = 0.36
				yyy4 = 0.36

				
				-- Otwieranie samochodu
				local coords    = GetEntityCoords(PlayerPed)
				local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
				local plate = GetVehicleNumberPlateText(vehicle)

				SetVehicleDoorsLocked(vehicle, 1)
				PlayVehicleDoorOpenSound(vehicle, 0)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
				ClearPedTasksImmediately(PlayerPed)
				DisableControlAction(0, 73, false)
				ESX.ShowNotification('Fechadura Arrombada!')

				igrekPin1 = (math.random(3250, 3550) * 0.0001)
				igrekPin2 = (math.random(3250, 3550) * 0.0001)
				igrekPin3 = (math.random(3250, 3550) * 0.0001)
				igrekPin4 = (math.random(3250, 3550) * 0.0001)
			end
		else
			Citizen.Wait(1500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if otwiera then
			local PlayerPed = PlayerPedId()
			if not pin1 then
				if yyy1 < 0.36 then
					yyy1 = yyy1 + 0.0002
				end
			end
			if not pin2 then
				if yyy2 < 0.36 then
					yyy2 = yyy2 + 0.0002
				end
			end
			if not pin3 then
				if yyy3 < 0.36 then
					yyy3 = yyy3 + 0.0002
				end
			end
			if not pin4 then
				if yyy4 < 0.36 then
					yyy4 = yyy4 + 0.0002
				end
			end
		else
			Citizen.Wait(1500)
		end
	end
end)