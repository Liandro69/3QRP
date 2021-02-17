ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

RegisterServerEvent('Trashsearch:getItem')
AddEventHandler('Trashsearch:getItem', function()

    local luck = math.random(1,8)
	local xPlayer = ESX.GetPlayerFromId(source)
    if luck < 5 then

		items = {
			[1] = {Item = 'terra', Percent = 5},
			[2] = {Item = 'emptybottleglass', Percent = 2},
			[3] = {Item = 'wire', Percent = 5},
			[4] = {Item = 'bobbypin', Percent = 3},
			[5] = {Item = 'cascadebanana', Percent = 3},
			[6] = {Item = 'stone', Percent = 7},
			[7] = {Item = 'ducttape', Percent = 5},
			[8] = {Item = 'batteri', Percent = 6},
			[9] = {Item = 'fabric', Percent = 6},
			[10] = {Item = 'borracha', Percent = 2},
			[11] = {Item = 'rope', Percent = 5},
			[12] = {Item = 'anchor', Percent = 5},
			[12] = {Item = 'acidbat', Percent = 5}
		}
		local player = ESX.GetPlayerFromId(source)
		local Variety = math.random(1,2)
		for i=1, Variety, 1 do
			local randomItems = items[math.random(#items)]
			local quantity = math.random(1,randomItems.Percent)
			local itemfound = ESX.GetItemLabel(randomItems.Item)
			if xPlayer.canCarryItem(randomItems.Item, quantity) then
				player.addInventoryItem(randomItems.Item, quantity)
				if itemfound ~= nil then
				end
			else
				sendNotification(source, 'Inventário cheio! ', 'error')
				break
			end
		end
	elseif luck <= 7 then
		items = {
			[1] = {Item = 'water', Percent = 2},
			[2] = {Item = 'stone', Percent = 10},
			[3] = {Item = 'bread', Percent = 2},
			[4] = {Item = 'cascadebanana', Percent = 6}
		}
		local player = ESX.GetPlayerFromId(source)
		local Variety = math.random(1,2)
		for i=1, Variety, 1 do
			local randomItems = items[math.random(#items)]
			local quantity = math.random(1,randomItems.Percent)
			local itemfound = ESX.GetItemLabel(randomItems.Item)
			if xPlayer.canCarryItem(randomItems.Item, quantity) then
				player.addInventoryItem(randomItems.Item, quantity)
				if itemfound ~= nil then
				--	sendNotification(source, 'Encontrastte '.. quantity ..' '.. itemfound , 'success', 2500)
				end
			else
				sendNotification(source, 'Inventário cheio! ', 'error')
				break
			end
		end
	else
		sendNotification(source, 'O caixote está vazio! ', 'error')
	end

end)