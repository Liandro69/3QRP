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

PlayerData = {}

local jailTime = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	LoadTeleporters()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	PlayerData = newData

	Citizen.Wait(25000)

	ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailTime", function(inJail, newJailTime)
		if inJail then

			jailTime = newJailTime

			JailLogin()
		end
	end)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent("esx-qalle-jail:openJailMenu")
AddEventHandler("esx-qalle-jail:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(newJailTime)
	jailTime = newJailTime

	Cutscene()
end)

RegisterNetEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function()
	jailTime = 0

	UnJail()
end)

function JailLogin()
	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)

	exports['mythic_notify']:SendAlert('inform', 'Basaste sem cumprir a tua pena? Agora levas o dobro!')


	InJail()
end

function UnJail()
	InJail()

	SetEntityCoords(PlayerPedId(), 1843.7734375,2586.8701171875,45.711929321289)

	ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
	SetPlayerInvincible(PlayerPedId(), false)
	exports['mythic_notify']:SendAlert('success', 'Foste solto, boa sorte ai fora!')

end

function InJail()

	--Jail Timer--
	SetPlayerInvincible(PlayerPedId(), true)
	Citizen.CreateThread(function()

		while jailTime > 0 do

			jailTime = jailTime - 1

			exports['mythic_notify']:SendAlert('inform', 'Tu tens ' .. jailTime ..' meses restantes na tua pena' )

			TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime)

			if jailTime == 0 then
				UnJail()

				TriggerServerEvent("esx-qalle-jail:updateJailTime", 0)
			end

			Citizen.Wait(60000)
		end

	end)

	--Jail Timer--

	--Prison Work
	--[[

	Citizen.CreateThread(function()
		while jailTime > 0 do

			local sleepThread = 500

			local Packages = Config.PrisonWork["Packages"]

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for posId, v in pairs(Packages) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 10.0 then

					sleepThread = 5

					local PackageText = "Pack"

					if not v["state"] then
						PackageText = "Já foi Levado"
					end

					ESX.Game.Utils.DrawText3D(v, "[E] " .. PackageText, 0.4)

					if DistanceCheck <= 1.5 then

						if IsControlJustPressed(0, 38) then

							if v["state"] then
								PackPackage(posId)
							else
								exports['mythic_notify']:SendAlert('inform', 'Já levas-te esse pacote')
							end

						end

					end

				end

			end

			Citizen.Wait(sleepThread)

		end
	end)]]

	--Prison Work--

end
--[[
function LoadTeleporters()
	Citizen.CreateThread(function()
		while true do

			local sleepThread = 3500

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for p, v in pairs(Config.Teleports) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 7.5 then

					sleepThread = 5

					ESX.Game.Utils.DrawText3D(v, "[E] Abrir Porta", 0.4)

					if DistanceCheck <= 1.0 then
						if IsControlJustPressed(0, 38) then
							TeleportPlayer(v)
						end
					end
				end
			end

			Citizen.Wait(sleepThread)

		end
	end)
end

function PackPackage(packageId)
	local Package = Config.PrisonWork["Packages"][packageId]

	LoadModel("prop_cs_cardbox_01")

	local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), Package["x"], Package["y"], Package["z"], true)

	PlaceObjectOnGroundProperly(PackageObject)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false)

	local Packaging = true
	local StartTime = GetGameTimer()

	while Packaging do

		Citizen.Wait(1)

		local TimeToTake = 60000 * 1.20 -- Minutes
		local PackPercent = (GetGameTimer() - StartTime) / TimeToTake * 100

		if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
			DeleteEntity(PackageObject)

			exports['mythic_notify']:SendAlert('inform', 'Cancelado!')

			Packaging = false
		end

		if PackPercent >= 100 then

			Packaging = false

			DeliverPackage(PackageObject)

			Package["state"] = false
		else
			ESX.Game.Utils.DrawText3D(Package, "A Empacotar... " .. math.ceil(tonumber(PackPercent)) .. "%", 0.4)
		end

	end
end

function DeliverPackage(packageId)
	if DoesEntityExist(packageId) then
		AttachEntityToEntity(packageId, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true

	LoadAnim("anim@heists@box_carry@")

	while Packaging do

		Citizen.Wait(10)

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if not IsEntityAttachedToEntity(packageId, PlayerPedId()) then
			Packaging = false
			DeleteEntity(packageId)
		else
			local DeliverPosition = Config.PrisonWork["DeliverPackage"]
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, DeliverPosition["x"], DeliverPosition["y"], DeliverPosition["z"], true)

			ESX.Game.Utils.DrawText3D(DeliverPosition, "[E] Deixar Pacote", 0.4)

			if DistanceCheck <= 2.0 then
				if IsControlJustPressed(0, 38) then
					DeleteEntity(packageId)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false

					TriggerServerEvent("esx-qalle-jail:prisonWorkReward")
				end
			end
		end

	end

end


]]
function OpenJailMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "Menu da Prisão",
			align    = 'center',
			elements = {
				{ label = "Aprisionar a pessoa mais perto", value = "jail_closest_player" },
				{ label = "Soltar Pessoa", value = "unjail_player" }
			}
		},
	function(data, menu)

		local action = data.current.value

		if action == "jail_closest_player" then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "Tempo de Prisão (minutos aka meses)"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
					exports['mythic_notify']:SendAlert('inform', 'tempo tem que ser em minutos!')
            	else
              		menu2.close()

              		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              		if closestPlayer == -1 or closestDistance > 3.0 then
                		exports['mythic_notify']:SendAlert('inform', 'Sem ninguém por perto!')
					else
						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "Razão da detenção"
							},
						function(data3, menu3)

						  	local reason = data3.value

						  	if reason == nil then
								exports['mythic_notify']:SendAlert('inform', 'Tens que meter algo aqui!')
						  	else
								menu3.close()

								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

								if closestPlayer == -1 or closestDistance > 3.0 then
									exports['mythic_notify']:SendAlert('inform', 'Sem ninguém por perto!')
								else
								  	TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason)
								end

						  	end

						end, function(data3, menu3)
							menu3.close()
						end)
              		end

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "unjail_player" then

			local elements = {}

			ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(playerArray)

				if #playerArray == 0 then
					exports['mythic_notify']:SendAlert('inform', 'Prisão tá vazia!')
					return
				end

				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = "Prisioneiro: " .. playerArray[i].name .. " | Sentença: " .. playerArray[i].jailTime .. " meses", value = playerArray[i].identifier })
				end

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'jail_unjail_menu',
					{
						title = "Soltar Pessoa",
						align = "center",
						elements = elements
					},
				function(data2, menu2)

					local action = data2.current.value

					TriggerServerEvent("esx-qalle-jail:unJailPlayer", action)

					menu2.close()

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
		menu.close()
	end)
end


RegisterNetEvent("tqrp_base:procurar")
AddEventHandler("tqrp_base:procurar", function()
	local PlayerPed = PlayerPedId()
	local coords = GetEntityCoords(PlayerPed)

    for i = 1, #Config.Search do
		if #(coords - Config.Search[i].coords) < 1 then
			TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_SHOPPING_CART", 0, true)
			exports['mythic_progbar']:Progress({
				name = "searchPrisa",
				duration = 60000,
				label = "A procurar",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = false,
				},
				prop = {},
				}, function(status)
				if not status then
					TriggerServerEvent("tqrp_jail:search", i, Config.Search[i].isSearched)
					ClearPedTasks(PlayerPed)
				end
			end)
		end
    end
end)