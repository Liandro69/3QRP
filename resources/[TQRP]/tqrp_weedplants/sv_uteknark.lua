ESX = nil
local oneSyncEnabled = true
--local verbose = false
local lastPlant = {}
local tickTimes = {}
local tickPlantCount = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped',function(why)
    lastPlant[source] = nil
end)

--[[function --log (...)
    local numElements = select('#',...)
    local elements = {...}
    local line = ''
    local prefix = '['..os.date("%H:%M:%S")..'] '
    suffix = '\n'
    local resourceName = '<'..GetCurrentResourceName()..'>'

    for i=1,numElements do
        local entry = elements[i]
        line = line..' '..tostring(entry)
    end
    Citizen.Trace(prefix..resourceName..line..suffix)
end]]

--[[function --verbose(...)
    if --verbose then
        --log(...)
    end
end]]

if not oneSyncEnabled then
    --log('OneSync not available: Will have to trust client for locations!')
end

function HasItem(who, what, count)
    count = count or 1
    if ESX == nil then
        --log("HasItem: No ESX Object!")
        return false
    end
    local xPlayer = ESX.GetPlayerFromId(who)
    if xPlayer == nil then
        --log("HasItem: Failed to resolve xPlayer from", who)
        return false
    end
    local itemspec =  xPlayer.getInventoryItem(what)
    if itemspec then
        if itemspec.count >= count then
            return true
        else
            return false
        end
    else
        --log("HasItem: Failed to get item data for item", what)
        return false
    end
end

function TakeItem(who, what, count)
    count = count or 1
    if ESX == nil then
        --log("TakeItem: No ESX Object!")
        return false
    end
    local xPlayer = ESX.GetPlayerFromId(who)
    if xPlayer == nil then
        --log("TakeItem: Failed to resolve xPlayer from", who)
        return false
    end
    local itemspec =  xPlayer.getInventoryItem(what)
    if itemspec then
        if itemspec.count >= count then
            xPlayer.removeInventoryItem(what, count)
            return true
        else
            return false
        end
    else
        --log("TakeItem: Failed to get item data for item", what)
        return false
    end
end

function GiveItem(who, what, count)
    count = count or 1
    if ESX == nil then
        --log("GiveItem: No ESX Object!")
        return false
    end
    local xPlayer = ESX.GetPlayerFromId(who)
    if xPlayer == nil then
        --log("GiveItem: Failed to resolve xPlayer from", who)
        return false
    end
    local itemspec =  xPlayer.getInventoryItem(what)
    if itemspec then
        if not itemspec.limit or itemspec.limit == -1 or itemspec.count + count <= itemspec.limit then
            xPlayer.addInventoryItem(what, count)
            return true
        else
            return false
        end
    else
        --log("GiveItem: Failed to get item data for item", what)
        return false
    end
end

function makeToast(target, subject, message)
    TriggerClientEvent('tqrp_uteknark:make_toast', target, subject, message)
end
function inChat(target, message)
    if target == 0 then
        --log(message)
    else
        TriggerClientEvent('chat:addMessage',target,{args={'UteKnark', message}})
    end
end

function plantSeed(location, soil)

    local hits = cropstate.octree:searchSphere(location, Config.Distance.Space)
    if #hits > 0 then
        return false
    end

    --verbose('Planting at',location,'in soil', soil)
    cropstate:plant(location, soil)
    return true
end

function doScenario(who, what, where)
    --verbose('Telling', who,'to',what,'at',where)
    TriggerClientEvent('tqrp_uteknark:do', who, what, where)
end

RegisterNetEvent('tqrp_uteknark:success_plant')
AddEventHandler ('tqrp_uteknark:success_plant', function(location, soil)
    local src = source
    if oneSyncEnabled and false then
        local ped = GetPlayerPed(src)
        ----log('ped:',ped)
        local pedLocation = GetEntityCoords(ped)
        ----log('pedLocation:',pedLocation)
        ----log('location:', location)
        local distance = #(pedLocation - location)
        if distance > Config.Distance.Interact then
            --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = _U('planting_too_far'), length = 5000, style = {} })
            return
        end
    end
    if soil and Config.Soil[soil] then
        local hits = cropstate.octree:searchSphere(location, Config.Distance.Space)
        if #hits == 0 then
            if TakeItem(src, Config.Items.Seed) then
                if plantSeed(location, soil) then
                    --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = _U('planting_text'), length = 2000, style = {} })
                    doScenario(src, 'Plant', location)
                    TriggerEvent("tqrp_base:serverlog", "[PLANTOU] " .. Config.Items.Seed, src, GetCurrentResourceName())
                else
                    GiveItem(src, Config.Items.Seed)
                    --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = _U('planting_failed'), length = 5000, style = {} })
                end
            else
                --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = _U('planting_no_seed'), length = 5000, style = {} })
            end
        else
            --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = _U('planting_too_close'), length = 5000, style = {} })
        end
    else
        --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = _U('planting_not_suitable_soil'), length = 5000, style = {} })
    end
end)

--[[RegisterNetEvent('tqrp_uteknark:log')
AddEventHandler ('tqrp_uteknark:log',function(...)
    local src = source
    --log(src,GetPlayerName(src),...)
end)]]

RegisterNetEvent('tqrp_uteknark:test_forest')
AddEventHandler ('tqrp_uteknark:test_forest',function(forest)
    local src = source


    if IsPlayerAceAllowed(src, 'command.uteknark') then

        local soil
        for candidate, quality in pairs(Config.Soil) do
            soil = candidate
            if quality >= 1.0 then
                break
            end
        end

        --log(GetPlayerName(src),'('..src..') is magically planting a forest of',#forest,'plants')
        for i, tree in ipairs(forest) do
            cropstate:plant(tree.location, soil, tree.stage)
            if i % 25 == 0 then
                Citizen.Wait(10)
            end
        end
    else
        --log('OY!', GetPlayerName(src),'with ID',src,'tried to spawn a test forest, BUT IS NOT ALLOWED!')
    end
end)

function keyCount(tbl)
    local count = 0
    if type(tbl) == 'table' then
        for key, value in pairs(tbl) do
            count = count + 1
        end
    end
    return count
end

Citizen.CreateThread(function()
    local ESXTries = 60
    local itemsLoaded = false
    while not itemsLoaded and ESXTries > 0 do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
            if keyCount(ESX.Items) > 0 then
                itemsLoaded = true
                ESX.RegisterUsableItem(Config.Items.Seed, function(source)
                    local now = os.time()
                    local last = lastPlant[source] or 0
                    if now > last + (Config.ActionTime/1000) then
                        if HasItem(source, Config.Items.Seed) then
                            TriggerClientEvent('tqrp_uteknark:attempt_plant', source)
                            lastPlant[source] = now
                        else
                            --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = _U('planting_no_seed'), length = 5000, style = {} })
                        end
                    else
                        --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = _U('planting_too_fast'), length = 5000, style = {} })
                    end
                end)
            end
        end)
        Citizen.Wait(1500)
        ESXTries = ESXTries - 1
    end
end)

Citizen.CreateThread(function()
    local databaseReady = false
    while not databaseReady do
        Citizen.Wait(1500)
        local state = GetResourceState('mysql-async')
        if state == "started" then
            Citizen.Wait(1500)
            cropstate:load(function(plantCount)
                if plantCount == 1 then
                    --log('Uteknark loaded a single plant!')
                else
                    --log('Uteknark loaded',plantCount,'plants')
                end
            end)
            databaseReady = true
        end
    end

    while true do
        Citizen.Wait(10)
        local now = os.time()
        local begin = GetGameTimer()
        local plantsHandled = 0
        for id, plant in pairs(cropstate.index) do
            if type(id) == 'number' then -- Because of the whole "hashtable = true" thing
                local stageData = Growth[plant.data.stage]
                local growthTime = (stageData.time * 60 * Config.TimeMultiplier)
                local soilQuality = Config.Soil[plant.data.soil] or 1.0

                if stageData.interact then
                    local relevantTime = plant.data.time + ((growthTime / soilQuality) * Config.TimeMultiplier)
                    if now >= relevantTime then
                        --verbose('Plant',id,'has died: No interaction in time')
                        cropstate:remove(id)
                    end
                else
                    local relevantTime = plant.data.time + ((growthTime * soilQuality) * Config.TimeMultiplier)
                    if now >= relevantTime then
                        if plant.data.stage < #Growth then
                            --verbose('Plant',id,'has grown to stage',plant.data.stage + 1)
                            cropstate:update(id, plant.data.stage + 1)
                        else
                            --verbose('Plant',id,'has died: Ran out of stages')
                            cropstate:remove(id)
                        end
                    end
                end

                plantsHandled = plantsHandled + 1
                if plantsHandled % 10 == 0 then
                    Citizen.Wait(10)
                end
            end
        end

        tickPlantCount = plantsHandled
        local tickTime = GetGameTimer() - begin
        table.insert(tickTimes, tickTime)
        while #tickTimes > 20 do
            table.remove(tickTimes, 1)
        end
    end
end)

local commands = {
    debug = function(source, args)
    end,
    stage = function(source, args)
        if args[1] and string.match(args[1], "^%d+$") then
            local plant = tonumber(args[1])
            if cropstate.index[plant] then
                if args[2] and string.match(args[2], "^%d+$") then
                    local stage = tonumber(args[2])
                    if stage > 0 and stage <= #Growth then
                        --log(source,GetPlayerName(source),'set plant',plant,'to stage',stage)
                        cropstate:update(plant, stage)
                    else
                        inChat(source, string.format("%i is an invalid stage", stage))
                    end
                else
                    inChat(source, "What stage?")
                end
            else
                inChat(source,string.format("Plant %i does not exist!", plant))
            end
        else
            inChat(source, "What plant, you say?")
        end
    end,
    forest = function(source, args)
        if source == 0 then
            --log('Forests can\'t grow in a console, buddy!')
        else

            local count = #Growth * #Growth
            if args[1] and string.match(args[1], "%d+$") then
                count = tonumber(args[1])
            end

            local randomStage = false
            if args[2] then randomStage = true end

            TriggerClientEvent('tqrp_uteknark:test_forest', source, count, randomStage)

        end
    end,
    stats = function(source, args)
        if cropstate.loaded then
            local totalTime = 0
            for i,time in ipairs(tickTimes) do
                totalTime = totalTime + time
            end
            local tickTimeAverage = totalTime / #tickTimes
            inChat(source, string.format("Tick time average: %.1fms", tickTimeAverage))
            inChat(source, string.format("Plant count: %i", tickPlantCount))
        else
            inChat(source,'Not loaded yet')
        end
    end,
    groundmat = function(source, args)
        if source == 0 then
            --log('Console. The ground material is CONSOLE.')
        else
            TriggerClientEvent('tqrp_uteknark:groundmat', source)
        end
    end,
    pyro = function(source, args)
        if source == 0 then
            --log('You can\'t really test particle effects on the console.')
        else
            TriggerClientEvent('tqrp_uteknark:pyromaniac', source)
        end
    end,
}
--[[ RegisterServerEvent('sellDrugs')
AddEventHandler('sellDrugs', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local weedqty = xPlayer.getInventoryItem('bagofdope').count
    local weedqtySingle = xPlayer.getInventoryItem('bagofmeth').count
	local x = 0
	local blackMoney = 0
	local drugType = nil
	if Config.SellWeed and weedqty > 0 or Config.SellWeed and weedqtySingle > 0 then
		if weedqty > 0 and Config.SellPooch then
			drugType = 'bagofdope'
			if weedqty == 1 then
				x = 1
			elseif weedqty == 2 then
				x = math.random(1,2)
			elseif weedqty == 3 then
				x = math.random(1,3)
			elseif weedqty == 4 then
                x = math.random(1,4)
            elseif weedqty == 5 then
                x = math.random(2,5)
            elseif weedqty == 6 then
				x = math.random(4,6)
			elseif weedqty >= 8 then
				x = math.random(6,8)
            end
		elseif weedqtySingle > 0 and Config.SellSingle then
			drugType = 'bagofmeth'
			if weedqtySingle == 1 then
				x = 1
			elseif weedqtySingle == 2 then
				x = math.random(1,2)
			elseif weedqtySingle == 3 then
				x = math.random(1,3)
			elseif weedqtySingle == 4 then
				x = math.random(1,4)
			elseif weedqtySingle >= 5 then
                x = math.random(1,5)
            elseif weedqtySingle == 5 then
                x = math.random(2,5)
            elseif weedqtySingle == 6 then
				x = math.random(4,6)
			elseif weedqtySingle >= 7 then
				x = math.random(4,7)
			end
		end
	else
		TriggerClientEvent('nomoredrugs', _source)
		return
	end

	if drugType== 'bagofdope' then	--pooch
        blackMoney = math.random(19,24)  * x
    else
        blackMoney = math.random(36,40) * x
	end

	if drugType ~= nil then
		xPlayer.removeInventoryItem(drugType, x)
	end
	xPlayer.addMoney(blackMoney)
    TriggerClientEvent('sold', _source)

    --TriggerEvent("tqrp_base:serverlog", "[VENDA DROGA] +" .. blackMoney, _source, GetCurrentResourceName())

	 TriggerClientEvent("pNotify:SendNotification", _source, {
            text = '<p>Produto vendido com sucesso</p><p>Recebeste <span style="color: blue">'..blackMoney.." €",
            type = "success",
            queue = "lmao",
            timeout = 5000,
            layout = "centerRight"
        })
	TriggerClientEvent('esx:showNotification', _source, _U('you_have_sold') .. '~b~'..x..'~w~' .. _U(drugtype) .. blackMoney .. '$')
end) ]]

--[[ RegisterServerEvent('check')
AddEventHandler('check', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if Config.SellWeed then
        local weedqty = xPlayer.getInventoryItem('bagofdope').count
        local weedqtySingle = xPlayer.getInventoryItem('bagofmeth').count
        if Config.SellPooch and weedqty > 0 or Config.SellSingle and weedqtySingle > 0 then
            TriggerClientEvent('playerhasdrugs', _source)
            return
        end
    end
    TriggerClientEvent('nomoredrugs', _source)
end)
 ]]