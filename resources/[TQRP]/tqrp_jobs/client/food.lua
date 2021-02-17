X.Plant = function(seed, coords)
	Citizen.CreateThread(function()
		X.startScenario("WORLD_HUMAN_GARDENER_PLANT")
		--if X.IsPlanting == true then
		--	while (true)
		--	do
		--		Citizen.Wait(10)
		--		DisableControlAction(0, 289, true) -- Inventory
		--		DisableControlAction(0, 157, true) -- 1
		--		DisableControlAction(0, 158, true) -- 2
		--		DisableControlAction(0, 160, true) -- 3
		--		DisableControlAction(0, 164, true) -- 4
		--		DisableControlAction(0, 165, true) -- 5
		--	end
        --end
		TriggerEvent('mythic_progbar:client:progress', {
			name = 'plant_seed',
			duration = 20000,
			label = 'A Plantar...',
			useWhileDead = false,
			canCancel = false,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = true,
				disableCombat = true,
				disableInventory = false,
			},
			animation = {
				animDict = "WORLD_HUMAN_GARDENER_PLANT",
				anim = "loop",
			},
			prop = {
				model = "",
			}
		}, function(status)
			if not status then
				ClearPedTasks(ped)
				exports['mythic_notify']:SendAlert('inform', 'Plantas te algo.')
			end
		end)
		Citizen.Wait((Config.SecondNeededToPlant - 20)* 1000)
		Citizen.Wait(20 * 1000)
		ClearPedTasks(PlayerPedId())
		ESX.Game.SpawnObject(seed.object, coords, function(object)
			FreezeEntityPosition(object,true)
		end)
		X.IsPlanting = false
	end)
end



X.RemoveLowPlant = function(coords, id, seed)
	Citizen.CreateThread(function()
		local object, distance = ESX.Game.GetClosestObject(Config.Seeds[seed].object, coords)
		if distance <= 4 then
			X.startScenario("WORLD_HUMAN_GARDENER_PLANT")
			Citizen.Wait((Config.SecondNeededToPlant - 25)* 1000)
			ClearPedTasks(PlayerPedId())
			Citizen.Wait(25 * 1000)
			TriggerServerEvent('tm1_stores:removePlant', id, coords)
			SetEntityAsMissionEntity(object, false, true)
			Citizen.Wait(20 * 1000)
			X.IsPlanting = false
		else
			exports["mythic_notify"]:SendAlert("error", "A planta só te deu folhas...")
			TriggerServerEvent('tm1_stores:removePlant', id, coords)
		end
	end)
end

X.HarvestPlant = function(coords, id, seed)
	Citizen.CreateThread(function()
		local object, distance = ESX.Game.GetClosestObject(Config.Seeds[seed].object, coords)
		if distance <= 4 then
			X.startScenario("WORLD_HUMAN_GARDENER_PLANT")
			Citizen.Wait((Config.SecondNeededToPlant - 3)* 1000)
			TriggerServerEvent('tm1_stores:harvestPlant', id, Config.Seeds[seed])
			ClearPedTasks(PlayerPedId())
			Citizen.Wait(3 * 1000)
			ESX.Game.DeleteObject(object)
			Citizen.Wait(2 * 1000)
			X.IsPlanting = false
		else
			exports["mythic_notify"]:SendAlert("error", "A planta só te deu folhas...")
			TriggerServerEvent('tm1_stores:removePlant', id, coords)
		end
	end)
end

X.IsThisSeedAllowed = function(seed, ph)
	for k,v in pairs(ph.seedsAllowed) do
		if v == seed then
			return true
		end
	end

	return false
end

X.AddWater = function(id, quantity)
	Citizen.CreateThread(function()
		print("start cenario")
		TriggerServerEvent('tm1_stores:addWater', id, quantity)
		X.startScenario("CODE_HUMAN_MEDIC_KNEEL")
		Citizen.Wait(5* 1000)
		ClearPedTasks(PlayerPedId())
		X.IsPlanting = false
	end)
end

X.AddFertilizer = function(id, quantity)
	Citizen.CreateThread(function()
		TriggerServerEvent('tm1_stores:addFertilizer', id, quantity)
		X.startScenario("CODE_HUMAN_MEDIC_KNEEL")
		Citizen.Wait(5* 1000)
		ClearPedTasks(PlayerPedId())
		X.IsPlanting = false
	end)
end

X.OpenSeedMenu = function()
	local elements = Config.SeedShop
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'warehouse_load', {
		title    = Local.seedShop,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value then
			TriggerServerEvent('tm1_stores:buyItem', data.current.value, data.current.price)
		end
	end,
	function(data, menu)
		menu.close()
	end
	)
end

X.Draw3DTextPlants = function(v)
	if v.rot > 0 then
		if v.percent < 100 then
			X.DrawText3D({x = v.x, y = v.y, z = v.z + 2}, "~w~["..Local[v.seed].."~w~] : "..v.percent.."%")
		else
			X.DrawText3D({x = v.x, y = v.y, z = v.z + 2}, "~w~["..Local[v.seed].."~w~] : ~g~"..Local.ready)
		end
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.85}, "~w~[~b~"..Local.water2.."~w~] : "..v.water.."L")
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.7}, "~w~[~y~"..Local.fertilizer.."~w~] : "..v.fertilizer.."%")
	end
	if v.rot > 50 then
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.55}, "~w~[~g~"..Local.state.."~w~] : "..v.rot.."%")
	elseif v.rot > 25 then
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.55}, "~w~[~y~"..Local.state.."~w~] : "..v.rot.."%")
	elseif v.rot > 12 then
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.55}, "~w~[~o~"..Local.state.."~w~] : "..v.rot.."%")
	elseif v.rot > 0 then
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.55}, "~w~[~r~"..Local.state.."~w~] : "..v.rot.."%")
	else
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.55}, "~w~[~r~"..Local.rotten.."~w~]")
	end
end