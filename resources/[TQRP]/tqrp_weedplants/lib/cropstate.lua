local onServer = IsDuplicityVersion()
local cropstateMethods = {
    plant = function(instance, location, soil, stage)
        if onServer then
            stage = stage or 1
            MySQL.Async.insert("INSERT INTO `weedplants` (`x`, `y`, `z`, `soil`, `stage`) VALUES (@x, @y, @z, @soil, @stage);",
            {
                ['@x'] = location.x,
                ['@y'] = location.y,
                ['@z'] = location.z,
                ['@soil'] = soil,
                ['@stage'] = stage,
            },
            function(id)
                instance:import(id, location, stage, os.time(), soil)
                TriggerClientEvent('tqrp_uteknark:planted',-1, id, location, stage)
            end)
        else
            Citizen.Trace("Attempt to cropstate:plant on client. Not going to work.\n")
        end
    end,
    load = function(instance, callback)
        if onServer then
            MySQL.Async.fetchAll("SELECT `id`, `stage`, UNIX_TIMESTAMP(`time`) AS `time`, `x`, `y`, `z`, `soil` FROM `weedplants`;", 
            {},
            function(rows)
                Citizen.CreateThread(function()
                    for rownum,row in ipairs(rows) do
                        instance:import(row.id, vector3(row.x, row.y, row.z), row.stage, row.time, row.soil)
                        if rownum % 50 == 0 then
                            Citizen.Wait(10)
                        end
                    end
                    if callback then callback(#rows) end
                    instance.loaded = true
                end)
            end)
        else
            Citizen.Trace("Attempt to cropstate:load on client. Not going to work\n")
        end
    end,
    import = function(instance, id, location, stage, time, soil)
        local success, object = instance.octree:insert(location, 0.01, {id=id, stage=stage, time=time, soil=soil})
        if not success then
            print("not success")
        end
        instance.index[id] = object
    end,
    update = function(instance, id, stage)
        local plant = instance.index[id]
        plant.data.stage = stage
        if onServer then
            plant.data.time = os.time()
            MySQL.Async.execute("UPDATE `weedplants` SET `stage` = @stage WHERE `id` = @id LIMIT 1;",
            {
                ['@id'] = id,
                ['@stage'] = stage,
            }, function(_)
                TriggerClientEvent('tqrp_uteknark:update', -1, id, stage)
            end)
        elseif plant.data.object then
            if DoesEntityExist(plant.data.object) then
                DeleteObject(plant.data.object)
            end
            plant.data.object = nil
        end
    end,
    remove = function(instance, id)
        local object = instance.index[id]
        local location = object.bounds.location
        object.data.deleted = true
        if object.node then
            object.node:remove(object.oindex)
        end
        instance.index[id] = nil
        if onServer then
            MySQL.Async.execute("DELETE FROM `weedplants` WHERE `id` = @id LIMIT 1;",
            { ['@id'] = id },
            function()
                TriggerClientEvent('tqrp_uteknark:removePlant', -1, id)
                TriggerClientEvent('tqrp_uteknark:pyromaniac', -1, location)
            end)
        else
            if object.data.object then
                if DoesEntityExist(object.data.object) then
                    DeleteObject(object.data.object)
                end
                object.data.object = nil
            end
        end
    end,
    bulkData = function(instance, target)
        if onServer then
            target = target or -1
            while not instance.loaded do
                Citizen.Wait(1500)
            end
            local forest = {}
            for id, plant in pairs(instance.index) do
                if type(id) == 'number' then -- Because there is a key called `hashtable`!
                    table.insert(forest, {id=id, location=plant.bounds.location, stage=plant.data.stage})
                end
            end
            TriggerClientEvent('tqrp_uteknark:bulk_data', target, forest)
        else
            TriggerServerEvent('tqrp_uteknark:request_data')
        end
    end,
}

local cropstateMeta = {
    __newindex = function(instance, key, value)
    end,
    __index = function(instance, key)
        return instance._methods[key]
    end,
}

cropstate = {
    index = {
        hashtable = true,
    },
    octree = pOctree(vector3(0,1500,0),vector3(12000,12000,2000)),
    loaded = false,
    _methods = cropstateMethods,
}

setmetatable(cropstate,cropstateMeta)

if onServer then
    RegisterNetEvent('tqrp_uteknark:request_data')
    AddEventHandler ('tqrp_uteknark:request_data', function()
        cropstate:bulkData(source)
    end)
    
    RegisterNetEvent('tqrp_uteknark:remove')
    AddEventHandler ('tqrp_uteknark:remove', function(plantID, nearLocation)
        local src = source
        local plant = cropstate.index[plantID]
        if plant then
            local plantLocation = plant.bounds.location
            local distance = #( nearLocation - plantLocation)
            if distance <= Config.Distance.Interact then
                cropstate:remove(plantID)
                TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = _U('interact_destroyed'), length = 5000, style = {} })
                doScenario(src, 'Destroy', plantLocation)
            else
                Citizen.Trace(GetPlayerName(src)..' ('..src..') is too far away from '..plantID..' to remove it ('..distance'm)\n')
            end
        else
            Citizen.Trace(GetPlayerName(src)..' ('..src..') tried to remove plant '..plantID..': That plant does not exist!\n')
            TriggerClientEvent('tqrp_uteknark:remove', src, plantID)
        end
    end)

    RegisterNetEvent('tqrp_uteknark:frob')
    AddEventHandler ('tqrp_uteknark:frob', function(plantID, nearLocation)
        local src = source
        local plant = cropstate.index[plantID]
        if plant then
            local plantLocation = plant.bounds.location
            local distance = #( nearLocation - plantLocation)
            if distance <= Config.Distance.Interact then
                local stageData = Growth[plant.data.stage]
                if stageData.interact then
                    if stageData.yield then
                        local yield = math.random(Config.Yield[1], Config.Yield[2])
                        --local seeds = math.random(Config.YieldSeed[1], Config.YieldSeed[2])
                        if GiveItem(src, Config.Items.Product, yield) then
                            cropstate:remove(plantID)
                            doScenario(src, 'Frob', plantLocation)
                            --[[if seeds > 0 and GiveItem(src, Config.Items.Seed, seeds) then
                                makeToast(src, _U('interact_text'), _U('interact_harvested', yield, seeds))
                            else
                                makeToast(src, _U('interact_text'), _U('interact_harvested', yield, 0))
                            end]]
                        else
                            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = _U('interact_full', yield), length = 5000, style = {} })
                        end
                    else
                        if #Growth > plant.data.stage then
                            if not Config.Items.Tend or TakeItem(src, Config.Items.Tend) then
                               TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = _U('interact_tended'), length = 5000, style = {} })
                                cropstate:update(plantID, plant.data.stage + 1)
                                doScenario(src, 'Frob', plantLocation)
                            else
                                TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = _U('interact_missing_item'), length = 5000, style = {} })
                            end
                        end
                    end
                else
                    Citizen.Trace(GetPlayerName(src)..' ('..src..') tried to frob plant '..plantID..': That plant is in a non-frobbable stage!\n')
                end
            else
                Citizen.Trace(GetPlayerName(src)..' ('..src..') is too far away from '..plantID..' to frob it ('..distance'm)\n')
            end
        else
            Citizen.Trace(GetPlayerName(src)..' ('..src..') tried to frob plant '..plantID..': That plant does not exist!\n')
        end
    end)

else
    RegisterNetEvent('tqrp_uteknark:bulk_data')
    AddEventHandler ('tqrp_uteknark:bulk_data', function(forest)
        for i, plant in ipairs(forest) do
            cropstate:import(plant.id, plant.location, plant.stage)
        end
        cropstate.loaded = true
    end)

    RegisterNetEvent('tqrp_uteknark:planted')
    AddEventHandler ('tqrp_uteknark:planted', function(id, location, stage)
        cropstate:import(id, location, stage)
    end)
    
    RegisterNetEvent('tqrp_uteknark:update')
    AddEventHandler ('tqrp_uteknark:update', function(plantID, stage)
        cropstate:update(plantID, stage)
    end)

    RegisterNetEvent('tqrp_uteknark:removePlant')
    AddEventHandler ('tqrp_uteknark:removePlant', function(plantID)
        cropstate:remove(plantID)
    end)
end
