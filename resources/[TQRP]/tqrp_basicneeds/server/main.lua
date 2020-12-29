ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- SISTEMA DE CRAFT DESCOMENTAR QUANDO PRONTO

--[[Citizen.CreateThread(function()
	Citizen.Wait(0)
	local crafts = Config.Crafts
	for i = 1, #crafts do
		ESX.RegisterUsableItem(crafts[i].use, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			if HasItens(source, crafts[i].components) then
				for a, b in pairs(crafts[i].components) do
					xPlayer.removeInventoryItem(a, b)
				end
				TriggerClientEvent('tqrp_basicneeds:craft', source, crafts[i])
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário!' })
			end
		end)
	end
end)

function HasItens(source, itens)
	local sucess = false
	local xPlayer = ESX.GetPlayerFromId(source)
	for i, v in pairs(itens) do 
		if xPlayer.getInventoryItem(i).count >= (v == 0 and 1 or v) then
			sucess = true
		else
			return false
		end
		if next(itens,i) == nil then
			return sucess
		end
	end
end


RegisterNetEvent("tqrp_basicneeds:sucessCraft")
AddEventHandler("tqrp_basicneeds:sucessCraft", function(table)
	local xPlayer = ESX.GetPlayerFromId(source)
	for c, d in pairs(table.result) do
		xPlayer.addInventoryItem(c, d)
	end
end)]]


ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('tqrp_status:add', source, 'hunger', 200000)
	TriggerClientEvent('tqrp_basicneeds:onEat', source)
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)
	xPlayer.addInventoryItem('waterBottle', 1)
	TriggerClientEvent('tqrp_status:add', source, 'thirst', 200000)
	TriggerClientEvent('tqrp_status:add', source, 'hunger', 30000)
	TriggerClientEvent('tqrp_basicneeds:onDrink', source)
end)

ESX.RegisterUsableItem('icetea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('icetea', 1)

	TriggerClientEvent('tqrp_status:add', source, 'thirst', 100000)
	TriggerClientEvent('tqrp_status:add', source, 'hunger', 80000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkIceTea', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bebes te um Iced-Tea' })
end)

ESX.RegisterUsableItem('saucisson', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('saucisson', 1)

	TriggerClientEvent('tqrp_status:add', source, 'thirst', 200000)
	TriggerClientEvent('tqrp_status:add', source, 'hunger', 120000)
	TriggerClientEvent('tqrp_basicneeds:onEattaco', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Awww grande Tacooo' })
end)

ESX.RegisterUsableItem('coffee', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('coffee', 1)

	TriggerClientEvent('tqrp_status:add', source, 'thirst', 200000)
	TriggerClientEvent('tqrp_status:add', source, 'hunger', 40000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkCoffe', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bbeste um café' })
end)

ESX.RegisterUsableItem('energy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('energy', 1)

	TriggerClientEvent('tqrp_status:add', source, 'thirst', 200000)
	TriggerClientEvent('tqrp_status:add', source, 'hunger', 40000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkCoffe', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bebes te um Queenbull' })
end)

ESX.RegisterUsableItem('jager', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jager', 1)

	TriggerClientEvent('tqrp_status:add', source, 'hunger', 200000)
	TriggerClientEvent('tqrp_basicneeds:onEat', source)
	TriggerClientEvent("tqrp_status:add", source, "stress", 100000)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Aghh não comas isto assim' })
end)

ESX.RegisterUsableItem('jusfruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jusfruit', 1)

	TriggerClientEvent('tqrp_status:add', source, 'thirst', 200000)
	TriggerClientEvent('tqrp_status:add', source, 'hunger', 40000)
	TriggerClientEvent('tqrp_basicneeds:onDrink', source)
	--TriggerClientEvent('usameta',source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Um bom sabor da Selva' })
end)

ESX.RegisterUsableItem('balstoize', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('balstoize', 1)

	TriggerClientEvent('tqrp_status:remove', source, 'thirst', 200000)
	--TriggerClientEvent('tqrp_status:add', source, 'hunger', 40000)
	--TriggerClientEvent('tqrp_basicneeds:onDrink', source)
	TriggerClientEvent('usameta',source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Let´s go numa trip' })
end)

ESX.RegisterUsableItem('forumdrive', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('forumdrive', 1)

	TriggerClientEvent('tqrp_status:remove', source, 'thirst', 200000)
	--TriggerClientEvent('tqrp_status:add', source, 'hunger', 40000)
	--TriggerClientEvent('tqrp_basicneeds:onDrink', source)
	TriggerClientEvent('forumd',source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Boa vibe' })
end)

ESX.RegisterUsableItem('clip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('clip', 1)

	TriggerClientEvent('tqrp_status:remove', source, 'thirst', 200000)
	--TriggerClientEvent('tqrp_status:add', source, 'hunger', 40000)
	--TriggerClientEvent('tqrp_basicneeds:onDrink', source)
	TriggerClientEvent('hostia',source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Pai Nosso' })
end)

ESX.RegisterUsableItem('md', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('md', 1)

	TriggerClientEvent('tqrp_status:remove', source, 'thirst', 200000)
	TriggerClientEvent('usa2', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Ca estrica' })

end)

-- Bar stuff
ESX.RegisterUsableItem('wine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('wine', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 100000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkWine', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('beer', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('beer', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 150000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkBeer', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('vodka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodka', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 350000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkVodka', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('whisky', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 250000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkWhisky', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('tequila', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('tequila', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 200000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkTequila', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('milk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('milk', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', -100000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkMilk', source)
end)

-- Disco Stuff
ESX.RegisterUsableItem('gintonic', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('gintonic', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 150000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkGin', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('absinthe', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('absinthe', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 400000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkAbsinthe', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('golem', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('golem', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('whiskycoca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whiskycoca', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('vodkaenergy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodkaenergy', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('vodkafruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodkafruit', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('rhumfruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhumfruit', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
	--TriggerClientEvent('esx:showNotification', source, _U('used_rhumfruit'))
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bebes te um Cuba Livre' })
end)

ESX.RegisterUsableItem('martini', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('martini', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
	--TriggerClientEvent('esx:showNotification', source, _U('used_martini'))
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bebes te um Martini' })
end)

ESX.RegisterUsableItem('rhum', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhum', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 100000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
	--TriggerClientEvent('esx:showNotification', source, _U('used_rhum'))
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bebes te um Rum' })
end)

ESX.RegisterUsableItem('teqpaf', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('teqpaf', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
	--TriggerClientEvent('esx:showNotification', source, _U('used_teqpaf'))
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bebes te um Cuba Livre' })
end)

ESX.RegisterUsableItem('rhumcoca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhumcoca', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
	--TriggerClientEvent('esx:showNotification', source, _U('used_rhumcoca'))
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bebes te um Cuba Livre' })
end)

ESX.RegisterUsableItem('mojito', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('mojito', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
	--TriggerClientEvent('esx:showNotification', source, "Bebes te um Mojito")
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bebes te um Mojito' })
end)

ESX.RegisterUsableItem('mixapero', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('mixapero', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('metreshooter', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('metreshooter', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('jagercerbere', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jagercerbere', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

ESX.RegisterUsableItem('champagne', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('champagne', 1)

	TriggerClientEvent('tqrp_status:add', source, 'drunk', 50000)
	TriggerClientEvent('tqrp_basicneeds:onDrinkChampagne', source)
	TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
end)

-- Cigarett
ESX.RegisterUsableItem('cigarett', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')

		if lighter.count > 0 then
			xPlayer.removeInventoryItem('cigarett', 1)
			TriggerClientEvent('tqrp_cigarett:startSmoke', source)
			Citizen.Wait(30000) -- wait a bit so stress won't change instantly and animation can be played
			TriggerClientEvent("tqrp_status:remove", source, "stress", 250000)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~isqueiro'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Não tens isqueiro' })
		end
end)

-- Para pano limpar carros
ESX.RegisterUsableItem('fabric', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end
	xPlayer.removeInventoryItem('fabric', 1)
	TriggerClientEvent('tqrp_base:clearVehicle', source)
end)

--[[
	
-- Para as Perolas - 25/05/2020
ESX.RegisterUsableItem('shell_a', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('fishingknife').count >= 1 and xPlayer.getInventoryItem('fabric').count >= 5 and xPlayer.getInventoryItem('shell_a').count >= 5 then

		TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A abrir as ostras...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('shell_a', 5)
					xPlayer.removeInventoryItem('fabric', 5)
					xPlayer.removeInventoryItem('fishingknife', 1)
					xPlayer.addInventoryItem('pearl_b', math.random(12, 16))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para o Aluminio - 25/05/2020
	ESX.RegisterUsableItem('screw', function(source)

		local xPlayer = ESX.GetPlayerFromId(source)

		while not xPlayer do
			Citizen.Wait(10);
			ESX.GetPlayerFromId(source);
		end

	if xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1 and xPlayer.getInventoryItem('blowtorch').count >= 1 and xPlayer.getInventoryItem('screw').count >= 10 then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A fundir o metal...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('screw', 10)
					xPlayer.addInventoryItem('scrapmetal', math.random(5, 7))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para o Aluminio 2 - 25/05/2020
	ESX.RegisterUsableItem('carbon_piece', function(source)

		local xPlayer = ESX.GetPlayerFromId(source)

		while not xPlayer do
			Citizen.Wait(10);
			ESX.GetPlayerFromId(source);
		end

	if xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1 and xPlayer.getInventoryItem('blowtorch').count >= 1 and xPlayer.getInventoryItem('carbon_piece').count >= 5 and xPlayer.getInventoryItem('iron_piece').count >= 5 then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A fundir o metal...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('carbon_piece', 5)
					xPlayer.removeInventoryItem('iron_piece', 5)
					xPlayer.addInventoryItem('scrapmetal', math.random(2, 5))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para o Aluminio - 25/05/2020
	ESX.RegisterUsableItem('nail', function(source)

		local xPlayer = ESX.GetPlayerFromId(source)

		while not xPlayer do
			Citizen.Wait(10);
			ESX.GetPlayerFromId(source);
		end

	if xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1 and xPlayer.getInventoryItem('blowtorch').count >= 1 and xPlayer.getInventoryItem('nail').count >= 10 then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A fundir o metal...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('nail', 10)
					xPlayer.addInventoryItem('scrapmetal', math.random(4, 5))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Borracha - 25/05/2020
ESX.RegisterUsableItem('pine_wood', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('blowtorch').count >= 1 and xPlayer.getInventoryItem('pine_wood').count >= 30 and xPlayer.getInventoryItem('water').count >= 3 then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 30000,
				label = "A extrair algo da madeira...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			},nil)
					xPlayer.removeInventoryItem('pine_wood', 30)
					xPlayer.removeInventoryItem('water', 3)
					xPlayer.addInventoryItem('borracha', math.random(9, 11))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Cabo de Borracha - 25/05/2020
ESX.RegisterUsableItem('borracha', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('fishingknife').count >= 1 and xPlayer.getInventoryItem('borracha').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 20000,
				label = "A cortar a borracha...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('borracha', 1)
					xPlayer.addInventoryItem('cabplastico', math.random(1,2))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Chave de Fendas - 25/05/2020
ESX.RegisterUsableItem('cabplastico', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1 and xPlayer.getInventoryItem('cabplastico').count >= 1 and xPlayer.getInventoryItem('lingot_iron').count >= 1 and xPlayer.getInventoryItem('ducttape').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A martelar umas peças...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('lingot_iron', 1)
					xPlayer.removeInventoryItem('ducttape', 1)
					xPlayer.removeInventoryItem('cabplastico', 1)
					xPlayer.addInventoryItem('screwdriver', 2)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Faca Utilitaria - 25/05/2020
ESX.RegisterUsableItem('lamina', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1 and xPlayer.getInventoryItem('screwdriver').count >= 1 and xPlayer.getInventoryItem('screw').count >= 2 and xPlayer.getInventoryItem('cabplastico').count >= 1 and xPlayer.getInventoryItem('lamina').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 20000,
				label = "A montar a faca...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			},nil)
					xPlayer.removeInventoryItem('screw', 2)
					xPlayer.removeInventoryItem('cabplastico', 1)
					xPlayer.removeInventoryItem('lamina', 1)
					xPlayer.addInventoryItem('fishingknife', 1)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Cobre - 25/05/2020
ESX.RegisterUsableItem('wire', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1 and xPlayer.getInventoryItem('wire').count >= 2 and xPlayer.getInventoryItem('lingot_iron').count >= 1 and xPlayer.getInventoryItem('blowtorch').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 20000,
				label = "A fundir metal...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			},nil)
					xPlayer.removeInventoryItem('wire', 2)
					xPlayer.removeInventoryItem('lingot_iron', 1)
					xPlayer.addInventoryItem('copper', math.random(2, 3))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Cobre 2 - 25/05/2020
ESX.RegisterUsableItem('lingot_gold', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1  and xPlayer.getInventoryItem('lingot_iron').count >= 1 and xPlayer.getInventoryItem('lingot_gold').count >= 1 and xPlayer.getInventoryItem('blowtorch').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 10000,
				label = "A fundir metal...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('lingot_iron', 1)
					xPlayer.removeInventoryItem('lingot_gold', 1)
					xPlayer.addInventoryItem('copper', math.random(2, 3))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Maçarico - 25/05/2020
ESX.RegisterUsableItem('lingot_carbon', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('WEAPON_WRENCH').count >= 1 and xPlayer.getInventoryItem('lighter').count >= 2 and xPlayer.getInventoryItem('copper').count >= 2 and xPlayer.getInventoryItem('lingot_carbon').count >= 1 and xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1   then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 30000,
				label = "A fazer maçarico...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			},nil)
					xPlayer.removeInventoryItem('lingot_carbon', 1)
					xPlayer.removeInventoryItem('copper', 2)
					xPlayer.removeInventoryItem('lighter', 2)
					xPlayer.addInventoryItem('blowtorch', 2)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Arame - 25/05/2020
ESX.RegisterUsableItem('lingot_iron', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('lingot_iron').count >= 1 and xPlayer.getInventoryItem('blowtorch').count >= 1  and xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1   then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 20000,
				label = "A moldar o ferro...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('lingot_iron', 1)
					xPlayer.addInventoryItem('wire', math.random(2,4))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Lithium - 25/05/2020
ESX.RegisterUsableItem('batteri', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('batteri').count >= 20 and xPlayer.getInventoryItem('emptybottleglass').count >= 10 and xPlayer.getInventoryItem('fishingknife').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 20000,
				label = "A misturar as cenas...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('batteri', 20)
					xPlayer.removeInventoryItem('emptybottleglass', 10)
					xPlayer.addInventoryItem('lithium', math.random(12, 18))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Kit Reparaçoes - 25/05/2020
ESX.RegisterUsableItem('lithium', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('screwdriver').count >= 1 and xPlayer.getInventoryItem('lithium').count >= 1 and xPlayer.getInventoryItem('borracha').count >= 1 and xPlayer.getInventoryItem('WEAPON_WRENCH').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 30000,
				label = "A montar kit reparação...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('screwdriver', 1)
					xPlayer.removeInventoryItem('lithium', 1)
					xPlayer.removeInventoryItem('borracha', 1)
					xPlayer.addInventoryItem('fixkit', 1)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Café
ESX.RegisterUsableItem('graodecafe', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('graodecafe').count >= 10 and xPlayer.getInventoryItem('water').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A fazer o cafézinho...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('graodecafe', 10)
					xPlayer.removeInventoryItem('water', 1)
					xPlayer.addInventoryItem('coffee', math.random(5, 6))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Terra - 25/05/2020
ESX.RegisterUsableItem('stone', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('stone').count >= 10 and xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A escascar pedra...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('stone', 10)
					xPlayer.addInventoryItem('terra', math.random(5, 8))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Gancho de Cabelo - 25/05/2020
ESX.RegisterUsableItem('iron_piece', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('iron_piece').count >= 2 and xPlayer.getInventoryItem('copper').count >= 4 and xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A improvisar gancho...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('copper', 4)
					xPlayer.removeInventoryItem('iron_piece', 2)
					xPlayer.addInventoryItem('bobbypin', 2)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Garrava de vidro - 25/05/2020
ESX.RegisterUsableItem('terra', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('terra').count >= 20 and xPlayer.getInventoryItem('waterBottle').count >= 1 and xPlayer.getInventoryItem('blowtorch').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A fazer garrafa de vidro...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('terra', 20)
					xPlayer.removeInventoryItem('waterBottle', 1)
					xPlayer.addInventoryItem('emptybottleglass', 18)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Pilhas - 25/05/2020
ESX.RegisterUsableItem('gold_piece', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('gold_piece').count >= 10 and xPlayer.getInventoryItem('copper').count >= 10 and xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1 and xPlayer.getInventoryItem('fishingknife').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A improvisar pilhas...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('gold_piece', 10)
					xPlayer.removeInventoryItem('copper', 10)
					xPlayer.addInventoryItem('batteri', math.random(59, 61))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Fertilizer 25 - 25/05/2020
ESX.RegisterUsableItem('fish', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('fish').count >= 15 and xPlayer.getInventoryItem('jager').count >= 5 and  xPlayer.getInventoryItem('fishingknife').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A fazer uns tacos...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
				xPlayer.removeInventoryItem('fish', 15)
				xPlayer.removeInventoryItem('jager', 5)
				xPlayer.addInventoryItem('saucisson', 5)
	else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Fertilizer 50 - 25/05/2020
ESX.RegisterUsableItem('cascadebanana', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('fish').count >= 10 and xPlayer.getInventoryItem('fertilizer_25').count >= 5 and xPlayer.getInventoryItem('cascadebanana').count >= 5 and xPlayer.getInventoryItem('fishingknife').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A misturar merda fixe...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('fish', 10)
					xPlayer.removeInventoryItem('fertilizer_25', 5)
					xPlayer.removeInventoryItem('cascadebanana', 5)
					xPlayer.addInventoryItem('highgradefert', 18)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Pentrite - 19/06/2020
ESX.RegisterUsableItem('acidbat', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('acidbat').count >= 20 and xPlayer.getInventoryItem('borracha').count >= 20 and xPlayer.getInventoryItem('fishingknife').count >= 1  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A misturar merdas...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('acidbat', 20)
					xPlayer.removeInventoryItem('borracha', 20)
					xPlayer.removeInventoryItem('fishingknife', 1)
					xPlayer.addInventoryItem('Pentrite', 1)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para corpo de Tec-9 - 28/05/2020
ESX.RegisterUsableItem('arma_armacaopistola', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('arma_armacaopistola').count >= 8 and xPlayer.getInventoryItem('WEAPON_HAMMER').count >= 1 and xPlayer.getInventoryItem('scrapmetal').count >= 5 and xPlayer.getInventoryItem('blowtorch').count >= 1 and xPlayer.getInventoryItem('WEAPON_WRENCH').count >= 1 then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A criar uma ferramenta topo de gama...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('arma_armacaopistola', 5)
					xPlayer.removeInventoryItem('scrapmetal', 5)
					xPlayer.removeInventoryItem('blowtorch', 1)
					xPlayer.addInventoryItem('tec9_body', 1)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para balas - 19/06/2020
ESX.RegisterUsableItem('Pentrite', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('Pentrite').count >= 1 and xPlayer.getInventoryItem('copper').count >= 5 and xPlayer.getInventoryItem('carbon_piece').count >= 5 and xPlayer.getInventoryItem('fishingknife').count >= 1 then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A misturar merdas...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('Pentrite', 1)
					xPlayer.removeInventoryItem('copper', 5)
					xPlayer.removeInventoryItem('carbon_piece', 5)
					xPlayer.removeInventoryItem('fishingknife', 1)
					xPlayer.addInventoryItem('disc_ammo_pistol', 8)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para colete pequeno - 19/06/2020
ESX.RegisterUsableItem('bobbypin', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('bobbypin').count >= 1 and xPlayer.getInventoryItem('copper').count >= 1 and xPlayer.getInventoryItem('ducttape').count >= 1 and xPlayer.getInventoryItem('fishingknife').count >= 1 and xPlayer.getInventoryItem('fabric').count >= 2  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A coser cenas...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('bobbypin', 1)
					xPlayer.removeInventoryItem('copper', 1)
					xPlayer.removeInventoryItem('fabric', 2)
					xPlayer.removeInventoryItem('ducttape', 1)
					xPlayer.addInventoryItem('SmallArmor', 2)
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Bandage - 26/06/2020
ESX.RegisterUsableItem('rope', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('rope').count >= 5 and xPlayer.getInventoryItem('ducttape').count >= 5 and xPlayer.getInventoryItem('bobbypin').count >= 5 and xPlayer.getInventoryItem('fishingknife').count >= 1 and xPlayer.getInventoryItem('fabric').count >= 5  then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A enrolar cenas...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('rope', 5)
					xPlayer.removeInventoryItem('ducttape', 5)
					xPlayer.removeInventoryItem('fabric', 5)
					xPlayer.removeInventoryItem('bobbypin', 5)
					xPlayer.addInventoryItem('bandage', math.random(9, 10))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)

-- Para Bandage - 26/06/2020
ESX.RegisterUsableItem('anchor', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Citizen.Wait(10);
		ESX.GetPlayerFromId(source);
	end

	if xPlayer.getInventoryItem('anchor').count >= 10 and xPlayer.getInventoryItem('bagofdope').count >= 20 and xPlayer.getInventoryItem('fishingknife').count >= 1 then
			TriggerClientEvent("mythic_progbar:client:progress", source, {
				name = "unique_action_name",
				duration = 15000,
				label = "A fazer merdas...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a"
				},
				prop = {}
			}, nil)
					xPlayer.removeInventoryItem('anchor', 10)
					xPlayer.removeInventoryItem('bagofdope', 5)
					xPlayer.addInventoryItem('md', math.random(1, 4))
		else
			--TriggerClientEvent('esx:showNotification', source, ('Não tens ~r~maçarico'))
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não tens o material necessário' })
		end
end)
]]
-- // ## DROGAS ## // --

ESX.RegisterUsableItem('meth1g', function(source)
	TriggerClientEvent('clientUsesCoke', player)
end)

ESX.RegisterUsableItem('coke1g', function(source)
	if not CheckedStartedDrugs(GetPlayerIdentifier(source)) then
	TriggerEvent("tqrp_newDrugs:startDrugsTimer",source)
	TriggerClientEvent("tqrp_drugs:activate_coke",source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("coke1g",1)
	else
	 	TriggerClientEvent("esx:showNotification",source,string.format("You can ~r~consume~s~ another ~y~drug~s~ in: ~b~%s seconds~s~",GetTimeForDrugs(GetPlayerIdentifier(source))))
	end
end)

ESX.RegisterUsableItem('joint2g', function(source)
	if not CheckedStartedDrugs(GetPlayerIdentifier(source)) then
	TriggerEvent("tqrp_newDrugs:startDrugsTimer",source)
	TriggerClientEvent("tqrp_drugs:activate_weed",source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("joint2g",1)
	else
	 	TriggerClientEvent("esx:showNotification",source,string.format("You can ~r~consume~s~ another ~y~drug~s~ in: ~b~%s seconds~s~",GetTimeForDrugs(GetPlayerIdentifier(source))))
	end
end)


TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local target = tonumber(args[1])

		-- is the argument a number?
		if target ~= nil then

			-- is the number a valid player?
			if GetPlayerName(target) then
				print('[tqrp_BASICNEEDS]: ' .. GetPlayerName(source) .. ' [HEAL PLAYER]')
				TriggerClientEvent('tqrp_basicneeds:healPlayer', target)
				TriggerClientEvent('chatMessage', target, "HEAL", {223, 66, 244}, "You have been healed!")
			else
				TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Player not found!")
			end
		else
			TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Incorrect syntax! You must provide a valid player ID")
		end
	else
		-- heal source
		print('[tqrp_BASICNEEDS] ' .. GetPlayerName(source) .. '[HEALED HIMSELF]')
		TriggerClientEvent('tqrp_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Insufficient Permissions.")
end, {help = "Heal a player, or yourself - restores thirst, hunger and health."})
