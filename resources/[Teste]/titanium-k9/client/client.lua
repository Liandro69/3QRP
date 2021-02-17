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
PlayerData = nil

local golfBall = nil
local KUnit = {
	dogData = nil,
	dogPed = nil,
	dogBlip = nil,
	dogAutoFollow = true,
	dogAttackingOrOther = false,
	dogAttackTarget = nil,
	dogBall = false,
	dogStats = {
		thirst = 100,
		hunger = 100,
		play = 100
	},
	dogCar = {
		isInCar = false,
		vehicle = nil,
		seatNumber = 0
	},
	isDogBusy = false
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	if PlayerData.job.name == 'police' then
		CreateBlip()
	end

	RequestModel(GetHashKey("a_c_husky"))
	RequestModel(GetHashKey("a_c_rottweiler"))
	RequestModel(GetHashKey("a_c_chop"))
end)

Citizen.CreateThread(function()
	while true do
		if PlayerData and PlayerData.job.name == 'police' then
			playerpedcoords = GetEntityCoords(GetPlayerPed(-1))
		end

		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15)	
		if PlayerData then
			if PlayerData.job.name == 'police' then
				for i=1, #Config.Zoness, 1 do
					local zoneID = Config.Zoness[i]
					if GetDistanceBetweenCoords(playerpedcoords, zoneID.coord, true) < 6.0 then
						DrawMarker(27, zoneID.coord.x, zoneID.coord.y, zoneID.coord.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 80, 80, 200, 150, false, false, 0, false, nil, nil, false)
					
						if GetDistanceBetweenCoords(playerpedcoords, zoneID.coord, true) < 1.0 then
							ESX.ShowHelpNotification('Pressiona ~INPUT_CONTEXT~ para tirar unidade canina')
							if IsControlJustReleased(0, 51) then
								Citizen.Wait(50)
								BrowseAnimals(zoneID)
								Citizen.Wait(150)
							end
						end
					end
				end
			end
		end
	end
end)

function BrowseAnimals(zoneID)
	local elem = {}

	if DoesEntityExist(KUnit.dogPed) then
		ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'browse', {
				title    = 'Unidades k9 Disponiveis',
				align    = 'bottom-right',
				elements = {
					{label = "Devolver o K-9 ao Dep", value = "return"}
				}
			}, function(data, menu)
				ReturnDog()
				menu.close()
			end, function(data, menu)
				menu.close()
			end)
	else
		ESX.TriggerServerCallback('lspdk9:getDogs', function(cb)
			for i=1, #cb,1 do
				if cb[i].isInHouse and PlayerData.job.grade >= cb[i].grade then
					table.insert(elem, {label = cb[i].name, value = cb[i]})
				end
			end

			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'browse', {
				title    = 'K-9 Disponivél',
				align    = 'bottom-right',
				elements = elem
			}, function(data, menu)
				CheckDog(data.current.value, zoneID)
			end, function(data, menu)
				menu.close()
			end)
		end, zoneID.label)
	end
end

function CheckDog(dog, zone)
	local ped = CreatePed(5, GetHashKey(dog.model), zone.dog.coord.x, zone.dog.coord.y, zone.dog.coord.z-0.95, zone.dog.heading, false)

	while not DoesEntityExist(ped) do
		ped = CreatePed(5, GetHashKey(dog.model), zone.dog.coord.x, zone.dog.coord.y, zone.dog.coord.z-0.95, zone.dog.heading, false)
		Citizen.Wait(500)
	end

	SpawnCam(zone.cam, ped)

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dogStation', {
		title    = 'Unidade K-9',
		align    = 'bottom-right',
		elements = {
			{label = "============== Acçoes =============", value = "blank"},
			{label = "Leva o cão de serviço", value = "getDog"},
			{label = "=========== Estados ===========", value = "blank"},
			{label = '<span style="color:#eb8888;">Vida : '..'100'..'%</span>', value = "blank"},
			{label = '<span style="color:#eb8888;">Sede : '..MathfRound(dog.dogStats.thirst)..'%</span>', value = "blank"},
			{label = '<span style="color:#eb8888;">Fome : '..MathfRound(dog.dogStats.hunger)..'%</span>', value = "blank"},
			{label = '<span style="color:#eb8888;">Treino : '..MathfRound(dog.dogStats.play)..'%</span>', value = "blank"},
		}
	}, function(data, menu)
		if data.current.value == "getDog" then
			TriggerServerEvent('lspdk9:getDog', dog, zone.label, zone.dog.spawn)
			DeleteEntity(ped)
			RenderScriptCams(false, false, 0, true, true)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)

	while DoesEntityExist(ped) do
		if IsControlJustReleased(0, 177) then
			DeleteEntity(ped)
			RenderScriptCams(false, false, 0, true, true)
			Citizen.Wait(25)
		end

		FreezeEntityPosition(ped, true)
		DrawTxt("~b~[K-9] ~w~ - "..dog.name, 0.51, 0.8)

		Citizen.Wait(2)
	end
end

RegisterNetEvent("lspdk9:spawnDog")
AddEventHandler("lspdk9:spawnDog", function(dog, label, spawn)
	KUnit.dogData = dog
	KUnit.dogPed = CreatePed(5, GetHashKey(dog.model), spawn.x, spawn.y, spawn.z-0.95, 0.0, true)
	KUnit.dogLabel = label
	SetCanAttackFriendly(KUnit.dogPed, false)
	KUnit.dogStats = dog.dogStats

	dogBlip = AddBlipForEntity(KUnit.dogPed)
	SetBlipSprite (dogBlip, 463)
	SetBlipDisplay(dogBlip, 4)
	SetBlipScale  (dogBlip, 1.2)
	SetBlipColour (dogBlip, 25)
	SetBlipAsShortRange(dogBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString("K9 | "..dog.name)
	EndTextCommandSetBlipName(dogBlip)	

	local cTask = false

	SetCanAttackFriendly(KUnit.dogPed, false, false)
	--GiveWeaponToPed(GetPlayerPed(-1), "WEAPON_BALL", 1, false, true)

	while DoesEntityExist(KUnit.dogPed) do		
		if IsControlJustReleased(0, Config.Controls["Open_Dog_Menu"]) then
			OpenDogMenu()
			Citizen.Wait(25)
		end

		if KUnit.dogAutoFollow then
			if GetDistanceBetweenCoords(GetEntityCoords(KUnit.dogPed), GetEntityCoords(GetPlayerPed(-1)), true) < 4.0 and cTask == true then
				SetPedKeepTask(KUnit.dogPed, false)
				cTask = false
				
				if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then	
					SitDogInVeh(GetVehiclePedIsUsing(GetPlayerPed(-1)))
				end
			end
		
			if GetDistanceBetweenCoords(GetEntityCoords(KUnit.dogPed), GetEntityCoords(GetPlayerPed(-1)), true) > 4.0 and cTask == false then
				cTask = true
				if IsDogSittingInVehicle() and (GetEntitySpeed(GetPlayerPed(-1) * 3.6) < 40.0 ) then	
					OutDogFromVeh(KUnit.dogCar.vehicle)
				end
				TaskGoToEntity(KUnit.dogPed, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
				SetPedKeepTask(KUnit.dogPed, true)							
			end
		elseif not KUnit.dogAutoFollow then
			if not KUnit.dogBall then
				SetPedKeepTask(KUnit.dogPed, false)

				local lib, anim = "creatures@rottweiler@amb@world_dog_sitting@idle_a", "idle_b"

				if not IsEntityPlayingAnim(KUnit.dogPed, lib, anim, 3) and not IsDogSittingInVehicle() and not KUnit.dogAttackingOrOther then
					ESX.Streaming.RequestAnimDict(lib, function()
						local lC = GetEntityCoords(KUnit.dogPed)
						local lR = GetEntityRotation(KUnit.dogPed)
						TaskPlayAnim(KUnit.dogPed, lib, anim, 8.2, -8.2, -1, 1, 0, false, false, false)
					end)
				end
			end
			
			cTask = false
		end

		if not IsDogSittingInVehicle() then
			ESX.Game.Utils.DrawText3D(vector3(GetEntityCoords(KUnit.dogPed).x, GetEntityCoords(KUnit.dogPed).y, GetEntityCoords(KUnit.dogPed).z+0.5), '~b~[K-9]~w~ - '..dog.name, 1.0)
		
			if IsEntityInWater(KUnit.dogPed) then
				ESX.Streaming.RequestAnimDict("creatures@rottweiler@swim@", function()
					TaskPlayAnim(KUnit.dogPed, "creatures@rottweiler@swim@", "swim", 8.0, -8.0, -1, 0, 0, false, false, false)
				end)
			end
		else
			ESX.Streaming.RequestAnimDict("missexile2", function()
				TaskPlayAnim(KUnit.dogPed, "missexile2", "chop_sit_in_baller_ps", 8.0, -8.0, -1, 0, 0, false, false, false)
			end)			
		end

		Citizen.Wait(2)
	end
end)

function OpenDogMenu()
	local health = (GetEntityHealth(KUnit.dogPed) / GetEntityMaxHealth(KUnit.dogPed) * 100)

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dogMenu', {
		title    = 'K-9 | '..KUnit.dogData.name,
		align    = 'bottom-right',
		elements = {
			{label = "=========== Statystyki ===========", value = "blank"},
			{label = '<span style="color:#eb8888;">Zdrowie : '..MathfRound(health)..'%</span>', value = "blank"},
			{label = '<span style="color:#eb8888;">Pragnienie : '..MathfRound(KUnit.dogStats.thirst)..'%</span>', value = "blank"},
			{label = '<span style="color:#eb8888;">Głód : '..MathfRound(KUnit.dogStats.hunger)..'%</span>', value = "blank"},
			{label = '<span style="color:#eb8888;">Rozrywka : '..MathfRound(KUnit.dogStats.play)..'%</span>', value = "blank"},
			{label = '=========== Potrzeby ===========', value = "blank"},
			{label = '<span style="color:#eb8888;">Daj wodę</span>', value = "givewater"},
			{label = '<span style="color:#eb8888;">Daj jedzenie</span>', value = "givefood"},
			{label = '============ Akcje =============', value = "blank"},
			{label = '<span style="color:#ebb188;">Sprawdź obywatela | Narkotyki</span>', value = "searchplayer"},
			{label = '<span style="color:#ebb188;">Sprawdź pojazd | Narkotyki</span>', value = "searchcar"},
			{label = '<span style="color:#ebb188;">Atakuj</span>', value = "attack"},
			{label = '<span style="color:#ebb188;">Przywołaj</span>', value = "whistle"},
			{label = '<span style="color:#ebb188;">Siadaj</span>', value = "stay"},			
			{label = '=========== Zabawy ============', value = "blank"},
			{label = '<span style="color:#88eb8a;">Przynieś piłkę</span>', value = "getball"},
			{label = '<span style="color:#88eb8a;">Pogłaskaj</span>', value = "petting"},
		}
	}, function(data, menu)
		if data.current.value == "searchplayer" then
			local players      = ESX.Game.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 3.5)
			local playersInArea = {}
			for i=1, #players, 1 do
				if players[i] ~= PlayerId() then
					table.insert(playersInArea, {
						label = "Sprawdź - "..GetPlayerName(players[i]),
						player = players[i]
					})
				end
			end

			ESX.UI.Menu.CloseAll()

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'subDogMenu', {
				title    = 'K-9 | '..KUnit.dogData.name,
				align    = 'bottom-right',
				elements = playersInArea
			}, function(data, menu)
				if GetDistanceBetweenCoords(GetPlayerPed(-1), GetPlayerPed(data.current.player), true) < 3.0 and not isDogBusy then
					isDogBusy = true

					TaskGoToEntity(KUnit.dogPed, GetPlayerPed(data.current.player), -1, 1.0, 10.0, 1073741824.0, 0)

					Citizen.Wait(2000)

					ESX.TriggerServerCallback('lspdk9:checkPlayerInventory', function(cb)
						if cb == true then
							local lib, anim, facial = "misschop_vehicle@back_of_van", "chop_growl", "chop_growl_facial"

							ESX.Streaming.RequestAnimDict(lib, function()
								TaskPlayAnim(KUnit.dogPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
								PlayFacialAnim(KUnit.dogPed, facial, lib)
							end)

							ESX.ShowNotification('~b~Zachowanie psa wskazuje na znalezienie substancji.')
						elseif cb == false then
							ESX.ShowNotification('~b~Pies nie wyczuł żadnych substancji.')
						end

						isDogBusy = false
					end, GetPlayerServerId(data.current.player))

					ESX.UI.Menu.CloseAll()
				end
			end, function(data, menu)
				menu.close()
			end)

		elseif data.current.value == "givefood" then
			ESX.TriggerServerCallback('lspdk9:checkPlayerHasItem', function(cb)
				if cb == true then
					if tonumber(KUnit.dogStats.hunger) < 100 then
						if (tonumber(KUnit.dogStats.hunger) + 25) > 100 then
							KUnit.dogStats.hunger = 100
						else
							KUnit.dogStats.hunger = KUnit.dogStats.hunger+15
						end

						ESX.ShowNotification('~b~Dałeś wodę psu!')
					end
				elseif cb == false then
					ESX.ShowNotification('~b~Nie posiadasz jedzenia!')
				end
			end, 'bread')
		elseif data.current.value == "givewater" then
			ESX.TriggerServerCallback('lspdk9:checkPlayerHasItem', function(cb)
				if cb == true then
					if tonumber(KUnit.dogStats.thirst) < 100 then
						if (tonumber(KUnit.dogStats.thirst) + 25) > 100 then
							KUnit.dogStats.thirst = 100
						else
							KUnit.dogStats.thirst = KUnit.dogStats.thirst+25
						end

						ESX.ShowNotification('~b~Dałeś wodę psu!')
					end
				elseif cb == false then
					ESX.ShowNotification('~b~Nie posiadasz wody!')
				end
			end, 'water')
		elseif data.current.value == "searchcar" then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)

			if DoesEntityExist(vehicle) and not isDogBusy then
				if GetDistanceBetweenCoords(GetEntityCoords(KUnit.dogPed), GetEntityCoords(vehicle), true) < 6.0 then
					isDogBusy = true

					local forward = GetEntityForwardVector(vehicle)
					local x, y, z = table.unpack(GetEntityCoords(vehicle) + forward * -2.2)
					TaskGoToCoordAnyMeans(KUnit.dogPed, x, y, z, 1.0, 0, 0, 786603, 0.0)
					Citizen.Wait(3500)
					SetEntityHeading(KUnit.dogPed, GetEntityHeading(vehicle))
					ESX.TriggerServerCallback('lspdk9:searchCar', function(callback)
						SetVehicleDoorOpen(vehicle, 5, false, false)
						Citizen.Wait(8000)

						if callback == true then
							local lib, anim, facial = "misschop_vehicle@back_of_van", "chop_growl", "chop_growl_facial"

							ESX.Streaming.RequestAnimDict(lib, function()
								TaskPlayAnim(KUnit.dogPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
								PlayFacialAnim(KUnit.dogPed, facial, lib)
							end)

							ESX.ShowNotification('~b~Zachowanie psa wskazuje na znalezienie substancji.')
						elseif callback == false then
							ESX.ShowNotification('~b~Pies nie znalazł żadnych substancji.')
						end

						SetVehicleDoorShut(vehicle, 5, false)
						isDogBusy = false
					end, GetVehicleNumberPlateText(vehicle))
				else
					ESX.ShowNotification('~b~Pies za daleko pojazdu.')
				end
			end
		elseif data.current.value == "attack" then
			local players      = ESX.Game.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 15.0)
			local playersInArea = {}
			for i=1, #players, 1 do
				if players[i] ~= PlayerId() then
					table.insert(playersInArea, {
						label = "Atakuj - "..GetPlayerName(players[i]),
						player = players[i]
					})
				end
			end

			ESX.UI.Menu.CloseAll()

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'subDogMenu', {
				title    = 'K-9 | '..KUnit.dogData.name,
				align    = 'bottom-right',
				elements = playersInArea
			}, function(data, menu)
				if KUnit.dogAttackTarget == nil then
					KUnit.dogAttackTarget = GetPlayerServerId(data.current.player)
					KUnit.dogAttackingOrOther = true
					KUnit.dogAutoFollow = false

					TriggerServerEvent('lspdk9:RequestStreamCoords', KUnit.dogAttackTarget)
					TaskGoToEntity(KUnit.dogPed, GetPlayerPed(data.current.player), -1, 1.0, 10.0, 1073741824.0, 0)
					SetPedKeepTask(KUnit.dogPed, true)	
				end
			end, function(data, menu)
				menu.close()
			end)
		elseif data.current.value == "whistle" and not isDogBusy then
			isDogBusy = true
			KUnit.dogAttackingOrOther = false
			KUnit.dogAutoFollow = true	
			KUnit.dogBall = false	
			
			if GetDistanceBetweenCoords(GetEntityCoords(KUnit.dogPed), GetEntityCoords(GetPlayerPed(-1)), true) < 4.0 then
				SetPedKeepTask(KUnit.dogPed, false)
				cTask = false
				
				if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then	
					SitDogInVeh(GetVehiclePedIsUsing(GetPlayerPed(-1)))
				end
			end

			RequestAnimDict("rcmnigel1c")

			while not HasAnimDictLoaded("rcmnigel1c") do
				Citizen.Wait(100)
			end

			TaskPlayAnim(GetPlayerPed(-1), "rcmnigel1c", "hailing_whistle_waive_a", 2.7, 2.7, 3000, 48, 0, 0, 0, 0)	
			Citizen.Wait(3500)
			isDogBusy = false		
		elseif data.current.value == "stay" then
			KUnit.dogAutoFollow = false
		elseif data.current.value == "petting" then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(KUnit.dogPed), true) < 1.5 and not isDogBusy then	
				isDogBusy = true							
				local forward   = GetEntityForwardVector(GetPlayerPed(-1))
				xD, yD, zD   = table.unpack(GetEntityCoords(GetPlayerPed(-1)) + forward * 0.90)			
				SetEntityCoords(KUnit.dogPed, xD, yD, zD-1.0, 0.0, 0.0, 0.0, false)

				local heading = GetEntityHeading(GetPlayerPed(-1))
				local newheading = 0
				if(heading >= 180) then
					newheading = heading + 180.0
				else
					newheading = heading - 180.0
				end
				SetEntityHeading(KUnit.dogPed, newheading)

				--ANIM
				local lib, anim, anim2 = "creatures@rottweiler@tricks@", "petting_chop", "petting_franklin"

				ESX.Streaming.RequestAnimDict(lib, function()
					TaskPlayAnim(KUnit.dogPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
					TaskPlayAnim(GetPlayerPed(-1), lib, anim2, 8.0, -8.0, -1, 0, 0, false, false, false)
				end)

				if tonumber(KUnit.dogStats.play) < 100 then
					if (tonumber(KUnit.dogStats.play) + 25) > 100 then
						KUnit.dogStats.play = 100
					else
						KUnit.dogStats.play = KUnit.dogStats.play+5
					end
				end
				Citizen.Wait(2000)
				isDogBusy = false
			else
				ESX.ShowNotification('~b~Jesteś za daleko psa by wykonać akcję!')
			end
		elseif data.current.value == "getball" then
			if not KUnit.dogBall then
				golfBall = GetClosestObjectOfType(GetEntityCoords(GetPlayerPed(-1)), 200.0, GetHashKey('w_am_baseball'))

				if DoesEntityExist(golfBall) then
					NetworkRegisterEntityAsNetworked(golfBall)

					KUnit.dogBall = true
					KUnit.dogAutoFollow = false

					local ballC = GetEntityCoords(golfBall)

					TaskGoToCoordAnyMeans(KUnit.dogPed, ballC, 5.0, 0, 0, 786603, 0xbf800000)

					if tonumber(KUnit.dogStats.play) < 100 then
						if (tonumber(KUnit.dogStats.play) + 25) > 100 then
							KUnit.dogStats.play = 100
						else
							KUnit.dogStats.play = KUnit.dogStats.play+15
						end
					end
				else
					ESX.ShowNotification('~b~Nie ma rzuconej piłki!')
				end
			else
				ESX.ShowNotification('~b~Pies już pobiegł po piłkę!')
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end	

local stream = false
RegisterNetEvent('lspdk9:startStreamCoords')
AddEventHandler('lspdk9:startStreamCoords', function(target)
	stream = true

	while stream == true do
		TriggerServerEvent('lspdk9:StreamCoords', target, GetEntityCoords(GetPlayerPed(-1)))
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('lspdk9:stopStreamCoords')
AddEventHandler('lspdk9:stopStreamCoords', function()
	stream = false
end)

local attackCoords = nil
RegisterNetEvent('lspdk9:respondToCoordsStream')
AddEventHandler('lspdk9:respondToCoordsStream', function(coords)
	attackCoords = coords
end)

local haveball = false
local leavingCar = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if DoesEntityExist(KUnit.dogPed) then
			if IsPedInCombat(KUnit.dogPed, GetPlayerPed(-1)) or IsPedInMeleeCombat(KUnit.dogPed) then
				ClearPedTasksImmediately(KUnit.dogPed)
			end
			SetCanAttackFriendly(KUnit.dogPed, false, false)
			SetPedRelationshipGroupDefaultHash(KUnit.dogPed, GetHashKey('CIVMALE'))
			SetPedCanBeTargetted(KUnit.dogPed, false)
			SetEntityAsMissionEntity(KUnit.dogPed, true,true)
		end

		if DoesEntityExist(KUnit.dogPed) and DoesEntityExist(KUnit.dogCar.vehicle) and leavingCar == true then
			SetEntityNoCollisionEntity(KUnit.dogPed, KUnit.dogCar.vehicle, true)
		end

		if DoesEntityExist(KUnit.dogPed) and KUnit.dogAttackTarget ~= nil and KUnit.dogAttackingOrOther == true then			
			SetPedMoveRateOverride(KUnit.dogPed, 1.8)

			while attackCoords == nil do
				Citizen.Wait(50)
			end

			if GetDistanceBetweenCoords(GetEntityCoords(KUnit.dogPed), attackCoords, true) < 1.5 then
				local lib, anim, anim2 = "creatures@rottweiler@melee@", "dog_hit_from_back", "victim_takedown_from_back"

					Citizen.Wait(50)

					ESX.Streaming.RequestAnimDict(lib, function()					
						TaskPlayAnim(KUnit.dogPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
						TriggerServerEvent('lspdk9:syncAnim', KUnit.dogAttackTarget, lib, anim2)
					end)

					Citizen.Wait(3000)
					TriggerServerEvent('lspdk9:StopStreamCoords', KUnit.dogAttackTarget)
					KUnit.dogAttackTarget = nil 
					KUnit.dogAttackingOrOther = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		if DoesEntityExist(KUnit.dogPed) then
			if not KUnit.dogAttackingOrOther and KUnit.dogAttackTarget ~= nil then
				local cH = GetEntityMaxHealth(KUnit.dogPed)
				SetEntityHealth(KUnit.dogPed, cH)
				SetEntityCanBeDamaged(KUnit.dogPed, false)
			end
		end

		if DoesEntityExist(KUnit.dogPed) and KUnit.dogBall and DoesEntityExist(golfBall) and haveball == false then
			if GetDistanceBetweenCoords(GetEntityCoords(KUnit.dogPed), GetEntityCoords(golfBall), true) < 1.0 then
				haveball = true

				local boneIndex = GetPedBoneIndex(KUnit.dogPed, 17188)
				AttachEntityToEntity(golfBall, KUnit.dogPed, boneIndex, 0.120, 0.010, 0.010, 5.0, 150.0, 0.0, true, true, false, true, 1, true)
				
				KUnit.dogAutoFollow = true
			end
		end

		if DoesEntityExist(KUnit.dogPed) and KUnit.dogBall and DoesEntityExist(golfBall) and haveball == true then
			if GetDistanceBetweenCoords(GetEntityCoords(KUnit.dogPed), GetEntityCoords(GetPlayerPed(-1)), true) < 1.5 then
				ESX.ShowHelpNotification('Pressiona ~INPUT_CONTEXT~ para pegar na bola.')
				if IsControlJustReleased(0, 51) then
					haveball = false
					KUnit.dogBall = false
					KUnit.dogAutoFollow = true
					while DoesEntityExist(golfBall) do
						DetachEntity(golfBall,false,false)
						Citizen.Wait(50)
						SetEntityAsMissionEntity(golfBall)
						DeleteEntity(golfBall)
						Citizen.Wait(1)
					end
					GiveWeaponToPed(GetPlayerPed(-1), "WEAPON_BALL", 1, false, true)
					Citizen.Wait(250)
				end
			end
		end
	end
end)

RegisterNetEvent('lspdk9:syncAnim')
AddEventHandler('lspdk9:syncAnim', function(lib, anim)
	SetPedToRagdoll(GetPlayerPed(-1), 15000, 15000, 0, true, true, false)
end)

-- ANTY DV 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if DoesEntityExist(KUnit.dogPed) and IsDogSittingInVehicle() then
			if not DoesEntityExist(KUnit.dogCar.vehicle) or not IsPedSittingInVehicle(KUnit.dogPed, KUnit.dogCar.vehicle) then
				KUnit.dogCar.isInCar = false
				KUnit.dogCar.seatNumber = 0
				KUnit.dogCar.vehicle = nil
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if DoesEntityExist(KUnit.dogPed) then
			KUnit.dogStats.thirst = KUnit.dogStats.thirst-Config.ThirstMinus
			KUnit.dogStats.hunger = KUnit.dogStats.hunger-Config.HungryMinus
			KUnit.dogStats.play   = KUnit.dogStats.play-Config.PlayMinus

			if tonumber(KUnit.dogStats.thirst) < 10 then
				local lib, anim, facial = "misschop_vehicle@back_of_van", "chop_growl", "chop_growl_facial"

				ESX.Streaming.RequestAnimDict(lib, function()
					TaskPlayAnim(KUnit.dogPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
					PlayFacialAnim(KUnit.dogPed, facial, lib)
				end)

				ESX.ShowNotification('~b~Twój pies potrzebuje wody!')
			end

			if tonumber(KUnit.dogStats.hunger) < 5 then
				local lib, anim, facial = "misschop_vehicle@back_of_van", "chop_growl", "chop_growl_facial"

				ESX.Streaming.RequestAnimDict(lib, function()
					TaskPlayAnim(KUnit.dogPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
					PlayFacialAnim(KUnit.dogPed, facial, lib)
				end)

				ESX.ShowNotification('~b~Twój pies potrzebuje jedzenia!')
			end

			if tonumber(KUnit.dogStats.play) < 2 then
				local lib, anim, facial = "misschop_vehicle@back_of_van", "chop_growl", "chop_growl_facial"

				ESX.Streaming.RequestAnimDict(lib, function()
					TaskPlayAnim(KUnit.dogPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
					PlayFacialAnim(KUnit.dogPed, facial, lib)
				end)

				ESX.ShowNotification('~b~Twój pies potrzebuje zabawy!')
			end

			if (tonumber(KUnit.dogStats.hunger) <= 1) or (KUnit.dogStats.thirst <= 1) then
				ReturnDogHospital()
			end
		end
	end
end)

MathfRound = function(number)
	return number - (number % 1)
end

ReturnDog = function()
	TriggerServerEvent('lspdk9:returnDog', KUnit.dogData.name, KUnit.dogLabel, KUnit.dogStats)
	DeleteEntity(KUnit.dogPed)

	golfBall = nil
	KUnit = {
		dogData = nil,
		dogPed = nil,
		dogBlip = nil,
		dogAutoFollow = true,
		dogAttackingOrOther = false,
		dogAttackTarget = nil,
		dogBall = false,
		dogStats = {
			thirst = 100,
			hunger = 100,
			play = 100
		},
		dogCar = {
			isInCar = false,
			vehicle = nil,
			seatNumber = 0
		},
		isDogBusy = false
	}
end

ReturnDogHospital = function()
	TriggerServerEvent('lspdk9:returnDogHosp', KUnit.dogData.name, KUnit.dogLabel, KUnit.dogStats)
	DeleteEntity(KUnit.dogPed)

	ESX.ShowNotification('~r~Twój pies trafił w ciężkim stanie do weterynaża.')

	golfBall = nil
	KUnit = {
		dogData = nil,
		dogPed = nil,
		dogBlip = nil,
		dogAutoFollow = true,
		dogAttackingOrOther = false,
		dogAttackTarget = nil,
		dogBall = false,
		dogStats = {
			thirst = 100,
			hunger = 100,
			play = 100
		},
		dogCar = {
			isInCar = false,
			vehicle = nil,
			seatNumber = 0
		},
		isDogBusy = false
	}
end

SitDogInVeh = function(veh)
	if not KUnit.dogCar.isInCar then		
		for i=-1, GetVehicleMaxNumberOfPassengers(GetVehiclePedIsUsing(GetPlayerPed(-1))) do
			if IsVehicleSeatFree(GetVehiclePedIsUsing(GetPlayerPed(-1)), i) then
				ApplyDogToSeat(i, GetVehiclePedIsUsing(GetPlayerPed(-1)))
				break
			end
		end
	end
end

OutDogFromVeh = function(veh)
	if IsEntityAttachedToEntity(KUnit.dogPed, veh) then
		SetVehicleDoorOpen(veh, KUnit.dogCar.seatNumber+1, false, false)
		Citizen.Wait(500)
		SetEntityCoords(KUnit.dogPed, GetEntityCoords(GetPlayerPed(-1)), false, false, false, false)
		Citizen.Wait(500)
		SetVehicleDoorShut(veh, KUnit.dogCar.seatNumber+1, false)

		KUnit.dogCar.isInCar = false
		KUnit.dogCar.seatNumber = 0
		KUnit.dogCar.vehicle = nil	
	end
end

ApplyDogToSeat = function(seat, veh)
	if (seat >= 2) or (seat == -2) or not (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then else		
		SetVehicleDoorOpen(veh, seat+1, false, false)
		Citizen.Wait(500)

		KUnit.dogCar.isInCar = true
		KUnit.dogCar.seatNumber = seat
		KUnit.dogCar.vehicle = veh

		TaskEnterVehicle(KUnit.dogPed, veh, 0, 1.0, 3, 0)

		while not IsPedSittingInVehicle(KUnit.dogPed, veh) do
			TaskWarpPedIntoVehicle(KUnit.dogPed, veh, seat)
			Citizen.Wait(50)
		end

		Citizen.Wait(500)
		SetVehicleDoorShut(veh, seat+1, false)		
	end
end

IsDogSittingInVehicle = function()
	return KUnit.dogCar.isInCar
end

function SpawnCam(cam, entity)
	RenderScriptCams(false, false, 0, true, true) -- OFF
	local camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)	
	SetCamCoord(camera, cam.coord.x, cam.coord.y, cam.coord.z)
	SetCamRot(camera, cam.rot.x, cam.rot.y, cam.rot.z)	
	if DoesEntityExist(entity) then
		SetCamFov(camera, 40.0)
		PointCamAtEntity(camera, entity, 0.0, 0.0, 0.0, true)
	end
	RenderScriptCams(true, false, 0, true, true)
end

function DrawTxt(text, x, y)
	SetTextFont(1)
	SetTextProportional(1)
	SetTextScale(0.0, 1.2)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextJustification(0)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

--BLIPS
function CreateBlip()
	--[[for i=1, #Config.Zoness, 1 do
		local blip = AddBlipForCoord(Config.Zoness[i].coord)

		SetBlipSprite (blip, 273)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 29)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("K9 Unit")
		EndTextCommandSetBlipName(blip)
	end]]
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if DoesEntityExist(KUnit.dogPed) then
			DeleteEntity(KUnit.dogPed)
		end

		if DoesEntityExist(golfBall) then
			DeleteEntity(golfBall)
		end

		if DoesBlipExist(KUnit.blip) then
			RemoveBlip(KUnit.blip)
		end
	end
end)
