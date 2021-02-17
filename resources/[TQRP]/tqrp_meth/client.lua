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
local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0
local run = false
ESX = nil

local LastCar

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('tqrp_meth:stop')
AddEventHandler('tqrp_meth:stop', function()
	started = false
	DisplayHelpText("~r~Produção parou...")
	FreezeEntityPosition(LastCar, false)
end)
RegisterNetEvent('tqrp_meth:stopfreeze')
AddEventHandler('tqrp_meth:stopfreeze', function(id)
	FreezeEntityPosition(id, false)
end)

RegisterNetEvent('tqrp_meth:notify')
AddEventHandler('tqrp_meth:notify', function(message)
	exports['mythic_notify']:SendAlert('inform', message)
end)

RegisterNetEvent('tqrp_meth:startprod')
AddEventHandler('tqrp_meth:startprod', function()
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	print('Started Meth production')
	exports['mythic_notify']:SendAlert('success', "A produção começou.")
	SetPedIntoVehicle(PlayerPedId(), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('tqrp_meth:blowup')
AddEventHandler('tqrp_meth:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)
end)


RegisterNetEvent('tqrp_meth:smoke')
AddEventHandler('tqrp_meth:smoke', function(posx, posy, posz, bool)
	if bool == 'a' then
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("ent_amb_smoke_gaswork", posx, posy, posz + 3.2, 0.0, 0.0, 0.0, 6.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		Citizen.Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)

RegisterNetEvent('tqrp_meth:drugged')
AddEventHandler('tqrp_meth:drugged', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(PlayerPedId(), true)
	SetPedMovementClipset(PlayerPedId(), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(PlayerPedId(), true)

	Citizen.Wait(300000)
	ClearTimecycleModifier()
end)

RegisterCommand("meta", function()
	run = true
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		while run do	
			Citizen.Wait(10)
			playerPed = PlayerPedId()
			local pos = GetEntityCoords(PlayerPedId())
			if IsPedInAnyVehicle(playerPed) then
				
				CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId())
				car = GetVehiclePedIsIn(playerPed, false)
				LastCar = GetVehiclePedIsUsing(playerPed)
				local model = GetEntityModel(CurrentVehicle)
				local modelName = GetDisplayNameFromVehicleModel(model)
				if modelName == 'JOURNEY' and car then

						if GetPedInVehicleSeat(car, -1) == playerPed then
							if started == false then
								if displayed == false then
									DisplayHelpText("Pressiona ~INPUT_CELLPHONE_CAMERA_FOCUS_LOCK~ para começares a produzir a droga.")
									displayed = true
								end
							end
							if IsControlJustReleased(0, Keys['L']) then
								--if pos.y >= 3500 then
									if IsVehicleSeatFree(CurrentVehicle, 3) then
										TriggerServerEvent('tqrp_meth:start')	
										progress = 0
										pause = false
										selection = 0
										quality = 0
										
									else
										exports['mythic_notify']:SendAlert('error',"O lugar está ocupado.")
									end
							--	else
							--	exports['mythic_notify']:SendAlert('error',"Tens que estar mais longe da cidade.")
							--	end
							end
						end
				end	
			else
					if started then
						started = false
						displayed = false
						TriggerEvent('tqrp_meth:stop')
						print('Stopped making drugs')
						FreezeEntityPosition(LastCar,false)
					end
			end
			
			if started == true then
				
				if progress < 96 then
					Citizen.Wait(6000)
					if not pause and IsPedInAnyVehicle(playerPed) then
						progress = progress +  1
						exports['mythic_notify']:SendAlert('inform',"A produzir metanfetamina  " ..progress.. " %")
						Citizen.Wait(6000) 
					end
					--
					--   EVENT 1
					--
					if progress > 22 and progress < 24 then
						pause = true
						if selection == 0 then
							exports['mythic_notify']:SendAlert('inform',"O tubo de gás propano furou o que fazes?")
							exports['mythic_notify']:SendAlert('inform',"Pressiona Q para usar fita adesiva.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona W para deixar estar.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona E para o substituires.")
							exports['mythic_notify']:SendAlert('inform',"Escolhe uma opção!")
						end
						if selection == 1 then
							print("Slected 1")
							exports['mythic_notify']:SendAlert('success',"A fita adesiva meio que parou a fuga!")
							quality = quality - 3
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							exports['mythic_notify']:SendAlert('error',"O tubo explodiu!")
							TriggerServerEvent('tqrp_meth:blow', pos.x, pos.y, pos.z)
							SetVehicleEngineHealth(CurrentVehicle, 0.0)
							quality = 0
							started = false
							displayed = false
							ApplyDamageToPed(PlayerPedId(), 10, false)
							print('Stopped making drugs')
						end
						if selection == 3 then
							print("Slected 3")
							exports['mythic_notify']:SendAlert('success',"Boa! O tubo não estava em boa condição!")
							pause = false
							quality = quality + 5
						end
					end
					--
					--   EVENT 5
					--
					if progress > 30 and progress < 32 then
						pause = true
						if selection == 0 then
							exports['mythic_notify']:SendAlert('inform',"Deixaste cair acetona no chão... O que fazes?")
							exports['mythic_notify']:SendAlert('inform',"Pressiona Q para abrires a janela para sair o cheiro.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona W para não fazer nada.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona E para colocares uma máscara de gás.")
							exports['mythic_notify']:SendAlert('inform',"Escolhe uma opção!")
						end
						if selection == 1 then
							print("Slected 1")
							exports['mythic_notify']:SendAlert('success',"Abriste as janelas para sair o cheiro acetona.")
							quality = quality - 1
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							exports['mythic_notify']:SendAlert('error',"Ficaste drogado por inalar a sucata.")
							pause = false
							TriggerEvent('tqrp_meth:drugged')
						end
						if selection == 3 then
							print("Slected 3")
							exports['mythic_notify']:SendAlert('success',"Uma solução eficaz...")
							SetPedPropIndex(playerPed, 1, 26, 7, true)
							pause = false
						end
					end
					--
					--   EVENT 2
					--
					if progress > 38 and progress < 40 then
						pause = true
						if selection == 0 then
							exports['mythic_notify']:SendAlert('inform',"A metanfetamina está a ficar sólida... O que fazes?")
							exports['mythic_notify']:SendAlert('inform',"Pressiona Q para aumentar a pressão.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona W para aumentar a temperatura.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona E para baixar a temperatura.")
							exports['mythic_notify']:SendAlert('inform',"Escolhe uma opção!")
						end
						if selection == 1 then
							print("Slected 1")
							exports['mythic_notify']:SendAlert('success',"Aumentaste a pressão e o gás começou a escapar, diminuiste e ficou tranquilo!")
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							exports['mythic_notify']:SendAlert('success',"Aumentaste a temperatura e pareceu uma boa solução!")
							quality = quality + 5
							pause = false
						end
						if selection == 3 then
							print("Slected 3")
							exports['mythic_notify']:SendAlert('success',"Diminuir a temperatura piorou a situação da metanfetamina!")
							pause = false
							quality = quality -4
						end
					end
					--
					--   EVENT 8 - 3
					--
					if progress > 41 and progress < 43 then
						pause = true
						if selection == 0 then
							exports['mythic_notify']:SendAlert('inform',"Puseste demasiada acetona... O que fazes?")
							exports['mythic_notify']:SendAlert('inform',"Pressiona Q para não fazer nada.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona W para tentares remover a acetona com uma seringa.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona E para adicionar mais lítio para compensar.")
							exports['mythic_notify']:SendAlert('inform',"Escolhe uma opção!")
						end
						if selection == 1 then
							print("Slected 1")
							exports['mythic_notify']:SendAlert('success',"A metanfetamina está a cheirar demasiado a acetona.")
							quality = quality - 3
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							exports['mythic_notify']:SendAlert('success',"Meio que funcionou mas continua com demasiada acetona.")
							pause = false
							quality = quality - 1
						end
						if selection == 3 then
							print("Slected 3")
							exports['mythic_notify']:SendAlert('success',"Bem jogado! Conseguiste balancear a reação química e funcionou!")
							pause = false
							quality = quality + 3
						end
					end
					--
					--   EVENT 3
					--
					if progress > 46 and progress < 49 then
						pause = true
						if selection == 0 then
							exports['mythic_notify']:SendAlert('inform',"Encontraste corante alimentar... O que fazes?")
							exports['mythic_notify']:SendAlert('inform',"Pressiona Q para adicionar à mistura.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona W para mandares fora.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona E para beberes.")
							exports['mythic_notify']:SendAlert('inform',"Escolhe uma opção!")

						end
						if selection == 1 then
							print("Slected 1")
							exports['mythic_notify']:SendAlert('success',"Boa ideia! As pessoas gostam de cores.")
							quality = quality + 4
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							exports['mythic_notify']:SendAlert('success',"Ok. Pode estragar o sabor da metanfetamina.")
							pause = false
						end
						if selection == 3 then
							print("Slected 3")
							exports['mythic_notify']:SendAlert('success',"Ficaste um bocado tonto.")
							pause = false
						end
					end
					--
					--   EVENT 4
					--
					if progress > 55 and progress < 58 then
						pause = true
						if selection == 0 then
							exports['mythic_notify']:SendAlert('inform',"O filtro está sujo... O que fazes?")
							exports['mythic_notify']:SendAlert('inform',"Pressiona Q para limpares com ar comprimido.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona W para substituires o filtro.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona E para limpares com a escova de dentes.")
							exports['mythic_notify']:SendAlert('inform',"Escolhe uma opção!")
						end
						if selection == 1 then
							print("Slected 1")
							exports['mythic_notify']:SendAlert('success',"Ficaste um bocado tonto.")
							quality = quality - 2
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							exports['mythic_notify']:SendAlert('success',"Provavelmente a melhor opção.")
							pause = false
							quality = quality + 3
						end
						if selection == 3 then
							print("Slected 3")
							exports['mythic_notify']:SendAlert('success',"Funcionou bem mas continua um pouco sujo.")
							pause = false
							quality = quality - 1
						end
					end
					--
					--   EVENT 5
					--
					if progress > 58 and progress < 60 then
						pause = true
						if selection == 0 then
							exports['mythic_notify']:SendAlert('inform',"Deixaste cair acetona no chão... O que fazes?")
							exports['mythic_notify']:SendAlert('inform',"Pressiona Q para abrires a janela para sair o cheiro.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona W para não fazer nada.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona E para colocares uma máscara de gás.")
							exports['mythic_notify']:SendAlert('inform',"Escolhe uma opção!")
						end
						if selection == 1 then
							print("Slected 1")
							exports['mythic_notify']:SendAlert('success',"Abriste as janelas para sair o cheiro acetona.")
							quality = quality - 1
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							exports['mythic_notify']:SendAlert('error',"Ficaste drogado por inalar a sucata.")
							pause = false
							TriggerEvent('tqrp_meth:drugged')
						end
						if selection == 3 then
							print("Slected 3")
							exports['mythic_notify']:SendAlert('success',"Uma solução eficaz...")
							SetPedPropIndex(playerPed, 1, 26, 7, true)
							pause = false
						end
					end
					--
					--   EVENT 1 - 6
					--
					if progress > 63 and progress < 65 then
						pause = true
						if selection == 0 then
							exports['mythic_notify']:SendAlert('inform',"A metanfetamina está a ficar sólida... O que fazes?")
							exports['mythic_notify']:SendAlert('inform',"Pressiona Q para aumentar a pressão.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona W para aumentar a temperatura.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona E para baixar a temperatura.")
							exports['mythic_notify']:SendAlert('inform',"Escolhe uma opção!")
						end
						if selection == 1 then
							print("Slected 1")
							exports['mythic_notify']:SendAlert('success',"Aumentaste a pressão e o gás começou a escapar, diminuiste e ficou tranquilo!")
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							exports['mythic_notify']:SendAlert('success',"Aumentaste a temperatura e pareceu uma boa solução!")
							quality = quality + 5
							pause = false
						end
						if selection == 3 then
							print("Slected 3")
							exports['mythic_notify']:SendAlert('success',"Diminuir a temperatura piorou a situação da metanfetamina!")
							pause = false
							quality = quality -4
						end
					end
					--
					--   EVENT 4 - 7
					--
					if progress > 71 and progress < 73 then
						pause = true
						if selection == 0 then
							exports['mythic_notify']:SendAlert('inform',"O filtro está sujo... O que fazes?")
							exports['mythic_notify']:SendAlert('inform',"Pressiona Q para limpares com ar comprimido.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona W para substituires o filtro.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona E para limpares com a escova de dentes.")
							exports['mythic_notify']:SendAlert('inform',"Escolhe uma opção!")
						end
						if selection == 1 then
							print("Slected 1")
							exports['mythic_notify']:SendAlert('success',"Ficaste um bocado tonto.")
							quality = quality - 2
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							exports['mythic_notify']:SendAlert('success',"Provavelmente a melhor opção.")
							pause = false
							quality = quality + 3
						end
						if selection == 3 then
							print("Slected 3")
							exports['mythic_notify']:SendAlert('success',"Funcionou bem mas continua um pouco sujo.")
							pause = false
							quality = quality - 1
						end
					end
					--
					--   EVENT 8
					--
					if progress > 76 and progress < 78 then
						if selection == 0 then
							exports['mythic_notify']:SendAlert('inform',"Puseste demasiada acetona... O que fazes?")
							exports['mythic_notify']:SendAlert('inform',"Pressiona Q para não fazer nada.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona W para tentares remover a acetona com uma seringa.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona E para adicionar mais lítio para compensar.")
							exports['mythic_notify']:SendAlert('inform',"Escolhe uma opção!")
						end
						if selection == 1 then
							print("Slected 1")
							exports['mythic_notify']:SendAlert('success',"A metanfetamina está a cheirar demasiado a acetona.")
							quality = quality - 3
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							exports['mythic_notify']:SendAlert('success',"Meio que funcionou mas continua com demasiada acetona.")
							pause = false
							quality = quality - 1
						end
						if selection == 3 then
							print("Slected 3")
							exports['mythic_notify']:SendAlert('success',"Bem jogado! Conseguiste balancear a reação química e funcionou!")
							pause = false
							quality = quality + 3
						end
					end
					--
					--   EVENT 9
					--
					if progress > 82 and progress < 84 then
						pause = true
						if selection == 0 then
							exports['mythic_notify']:SendAlert('inform',"Precisas de cagar... O que fazes?")
							exports['mythic_notify']:SendAlert('inform',"Pressiona Q para aguentares.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona W para ires lá fora cagar.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona E para cagares aí dentro.")
							exports['mythic_notify']:SendAlert('inform',"Escolhe uma opção!")
						end
						if selection == 1 then
							print("Slected 1")
							exports['mythic_notify']:SendAlert('success',"Boa! Tens que trabalhar, cagas depois!")
							quality = quality + 1
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							exports['mythic_notify']:SendAlert('error',"Saíste da caravana e enquanto isso o vidro caiu e entornou no chão!")
							pause = false
							quality = quality - 2
						end
						if selection == 3 then
							print("Slected 3")
							exports['mythic_notify']:SendAlert('success',"Boa! Agora isto cheira a merda...")
							pause = false
							quality = quality - 1
						end
					end
					--
					--   EVENT 10
					--
					if progress > 88 and progress < 90 then
						pause = true
						if selection == 0 then
							exports['mythic_notify']:SendAlert('inform',"Queres adicionar bocados de vidro à mistura, para parecer que tem mais?")
							exports['mythic_notify']:SendAlert('inform',"Pressiona Q para colocar.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona W para não colocar.")
							exports['mythic_notify']:SendAlert('inform',"Pressiona E para adicionares a metanfetamina ao vidro.")
							exports['mythic_notify']:SendAlert('inform',"Escolhe uma opção!")
						end
						if selection == 1 then
							print("Slected 1")
							exports['mythic_notify']:SendAlert('success',"Conseguiste mais algum produto.")
							quality = quality + 1
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							exports['mythic_notify']:SendAlert('success',"És um bom traficante, produto de alta qualidade!")
							pause = false
							quality = quality + 1
						end
						if selection == 3 then
							print("Slected 3")
							exports['mythic_notify']:SendAlert('success',"Isso já é demasiado!")
							pause = false
							quality = quality - 1
						end
					end
					
					if IsPedInAnyVehicle(playerPed) then
						TriggerServerEvent('tqrp_meth:make', pos.x,pos.y,pos.z)
						if pause == false then
							selection = 0
							quality = quality + 1
							progress = progress +  math.random(1, 2)
							exports['mythic_notify']:SendAlert('inform',"A produzir metanfetamina  " ..progress.. " %")
						end
					else
						TriggerEvent('tqrp_meth:stop')
					end

				else
					TriggerEvent('tqrp_meth:stop')
					progress = 100
					exports['mythic_notify']:SendAlert('inform',"A produzir metanfetamina  " ..progress.. " %")
					exports['mythic_notify']:SendAlert('success',"Produção acabou!")
					TriggerServerEvent('tqrp_meth:finish', quality)
					FreezeEntityPosition(LastCar, false)
				end	
				
			end
		end	
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		while run do
			Citizen.Wait(3000)
			if IsPedInAnyVehicle(PlayerPedId()) then
			else
				run= false
				if started then
					started = false
					displayed = false
					TriggerEvent('tqrp_meth:stop')
					print('Stopped making drugs')
					FreezeEntityPosition(LastCar,false)
				end		
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		while run do
		Citizen.Wait(10)		
		if pause == true then
			if IsControlJustReleased(0, Keys['Q']) then
				selection = 1
			end
			if IsControlJustReleased(0, Keys['W']) then
				selection = 2

			end
			if IsControlJustReleased(0, Keys['E']) then
				selection = 3
			end
		end
	end
	end
end)




