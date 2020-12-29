
-- EDITED BY B1G --]]

ESX = nil
local delivery = ""
local starteduber = false
local hasdelivery = false
local disablepressE = false
local disablepressH = false
local uberdeliveryamount = 0
local uberdeliveryblip = nil
local number = nil 
local reward = 0
local deliverydoor = false -- This is simply to display if they are on that delivery
local deliveryporch = false
local doorknocked = false  -- if player has knocked on the door 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    local scale = 0.3

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 500
		DrawRect(_x, _y + 0.0150, 0.030 + factor , 0.030, 66, 66, 66, 150)
    end
end

RegisterCommand('aceitaruber', function(source, args, rawCommand)
	if starteduber and hasdelivery then
		SetDestination(number)
		exports['mythic_notify']:SendAlert('success', 'Pedido: '..delivery)
	end
end)

RegisterCommand('recusaruber', function(source, args, rawCommand)
	if starteduber and hasdelivery then
		hasdelivery = false
		removeblips()
		exports['mythic_notify']:SendAlert('error', 'PEDIDO RECUSADO - Vamos procurar outro!')
	end
end)

function generateList()
	while starteduber do
		Citizen.Wait(1500)
		if starteduber and not hasdelivery then
			cooldown = math.random(10000,40000)
			Citizen.Wait(cooldown)
			if not starteduber then
				return
			end
			TriggerEvent('InteractSound_CL:PlayOnOne', 'pager', 0.4)
			exports['mythic_notify']:SendAlert('success', 'Nova entrega')
			number = math.random(1,#DeliveryLocations)
			delivery = ""
			ESX.TriggerServerCallback('tqrp_uber:GenerateList', function(list)
				if list then
					reward = 0
					for i=1, #list do 
						delivery = delivery .. list[i].quantity.. " " .. list[i].itemfound.. " "
						reward = reward + (list[i].Payout*list[i].quantity)
					end
				end
				exports['mythic_notify']:SendAlert("inform", "Pedido: "..delivery)
			end)
			hasdelivery = true
		end
	end
end

function removeblips()
	RemoveBlip(uberdeliveryblip)
	ClearGpsPlayerWaypoint()
end

function rewarduber(quantity)
	if ispedhomechance == 1 then
		TriggerServerEvent('tqrp_uber:pay', (quantity + math.random(4,9)))
		exports['mythic_notify']:SendAlert('inform', 'Recebeste uma Gorjeta')
	elseif ispedhomechance ~= 1 then
		TriggerServerEvent('tqrp_uber:pay', quantity)
	end
	exports['mythic_notify']:SendAlert('success', 'Encomenda entregue!')
	removeblips()
	hasdelivery = false
	disablepressE = false
	disablepressH = false
	deliv = nil
	blipdestination = false
	doorknocked = false
end

function SetDestination(number)
	checkDistance()
	uberdelivery = true
	deliverydoor = true
	uberdeliveryblip = AddBlipForCoord(DeliveryLocations[number]["x"], DeliveryLocations[number]["y"], DeliveryLocations[number]["z"])
	SetBlipSprite(uberdeliveryblip, 1)
	SetBlipColour(uberdeliveryblip, 16742399)
	SetBlipScale(uberdeliveryblip, 0.6)
	SetNewWaypoint(DeliveryLocations[number]["x"], DeliveryLocations[number]["y"])
end

function lockdrop()
	Citizen.CreateThread(function ()
		while droppingpackage do
			Citizen.Wait(10)
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)
	
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 44	, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 49, true) -- Also 'enter'?
	
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167	, true) -- Job
	
			DisableControlAction(0, 236, true) -- Disable changing view
			DisableControlAction(0, 319, true) -- Disable looking behind
			DisableControlAction(0, 323, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
	
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
	
			DisableControlAction(2, 36, true) -- Disable going stealth
	
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
end

function checkDistance()
	Citizen.CreateThread(function ()
		while starteduber do
			Citizen.Wait(7)
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), DeliveryLocations[number]["x"], DeliveryLocations[number]["y"], DeliveryLocations[number]["z"], true ) < 1.2 and deliverydoor and hasdelivery then
				if doorknocked == false and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), DeliveryLocations[number]["x"], DeliveryLocations[number]["y"], DeliveryLocations[number]["z"], true ) < 1.2 then
					DrawText3Ds(DeliveryLocations[number]["x"], DeliveryLocations[number]["y"], DeliveryLocations[number]["z"] + 0.3, Knock)
				end 
			
				if(IsControlJustPressed(1, 311)) and not deliveryporch and not disablepressE then -- KEY K
					ESX.TriggerServerCallback('tqrp_uber:HasEverything', function(has)
						if has then
							disablepressE = true
							PlayAnimation(PlayerPedId(), "timetable@jimmy@doorknock@", "knockdoor_idle")
							Citizen.Wait(1500)
							TriggerEvent('InteractSound_CL:PlayOnOne', 'door', 0.8)
							Citizen.Wait(2500)
							doorknocked = true
							ispedhomechance = math.random(1,2)
							if ispedhomechance == 1 then	
								TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true) -- Because IT FITSSSSSSS - 99kr
								droppingpackage = true
								lockdrop()
								Citizen.Wait(10)
								TriggerEvent("mythic_progbar:client:progress", {
									name = "teste",
									duration = math.random(6000,12000),
									label = "A entregar pacote...",
									useWhileDead = false,
									canCancel = true,
									controlDisables = {
										disableMovement = true,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									}
								}, function(status)
									if not status then
										ClearPedTasks(PlayerPedId(-1))
										deliverydoor = false
										hasdelivery = false
										removeblips()
										rewarduber(reward)
										droppingpackage = false
									end
								end)
							else
								doorknocked = true
								deliveryporch = true
							end
						else
							exports['mythic_notify']:SendAlert('inform', 'O Pedido não estava correto')
							deliverydoor = false
							hasdelivery = false
							removeblips()
							droppingpackage = false
						end
					end)
				end
				
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), DeliveryLocations[number]["x2"], DeliveryLocations[number]["y2"], DeliveryLocations[number]["z2"], true ) < 4.0 and deliveryporch and hasdelivery then
					DrawText3Ds(DeliveryLocations[number]["x2"], DeliveryLocations[number]["y2"], DeliveryLocations[number]["z2"] + 0.3, Delivery)
					if(IsControlJustPressed(1, 311)) and not disablepressH then -- KEY K
						disablepressH = true
						local player = PlayerId()
						local plyPed = GetPlayerPed(player)
						local plyPos = GetEntityCoords(plyPed, false)
						droppingpackage = true
						lockdrop()
						TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
						Citizen.Wait(10)
						TriggerEvent("mythic_progbar:client:progress", {
							name = "unique_action_name",
							duration = math.random(6000,12000),
							label = "A deixar pacote...",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							}
							}, function(status)
							if not status then
								ClearPedTasks(PlayerPedId())
								ClearPedTasks(PlayerPedId(-1))
								local PackageDeliveryObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), plyPos.x, plyPos.y, plyPos.z, true)
								PlaceObjectOnGroundProperly(PackageDeliveryObject)
								removeblips()
								rewarduber(reward)
								deliveryporch = false
								droppingpackage = false
							end
						end)
					end
				end
			end	
		end
	end)
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
		Citizen.CreateThread(function()
			RequestAnimDict(dict)

			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(100)
			end

			if settings == nil then
				TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
			else 
				local speed = 1.0
				local speedMultiplier = -1.0
				local duration = 1.0
				local flag = 0
				local playbackRate = 0

				if settings["speed"] ~= nil then
					speed = settings["speed"]
				end

				if settings["speedMultiplier"] ~= nil then
					speedMultiplier = settings["speedMultiplier"]
				end

				if settings["duration"] ~= nil then
					duration = settings["duration"]
				end

				if settings["flag"] ~= nil then
					flag = settings["flag"]
				end

				if settings["playbackRate"] ~= nil then
					playbackRate = settings["playbackRate"]
				end

				TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
			end

			RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end) -- Prevents RAM LEAKS :)