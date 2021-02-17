ESX = nil 
local joblist = {}
local resettime = nil
local policeclosed = false
local cops = 0
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tqrp_joias:closestore')
AddEventHandler('tqrp_joias:closestore', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ispolice = false
	for i, v in pairs(Config.PoliceJobs) do
		if xPlayer.job.name == v then
			ispolice = true
			break
		end
	end
    if ispolice and resettime ~= nil then
        TriggerClientEvent('tqrp_joias:policeclosure', -1)
        policeclosed = true
    elseif ispolice and resettime == nil then
        --TriggerClientEvent('esx:showNotification', _source, 'Store does not appear to be damaged - unable to force closed!')
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "A loja não está danificada",length = 6500})          
    else
        --TriggerClientEvent('esx:showNotification', _source, 'Only Law enforcment or Vangelico staff can decide if store is closed!')
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "Só a policia pode trancar estas portas",length = 6500})       
    end
end)

RegisterServerEvent('tqrp_joias:playsound')
AddEventHandler('tqrp_joias:playsound', function(x,y,z, soundtype)
    TriggerClientEvent('tqrp_joias:playsound', -1, x, y, z, soundtype)
end)

RegisterServerEvent('tqrp_joias:setcase')
AddEventHandler('tqrp_joias:setcase', function(casenumber, switch)
    _source = source
    if not Config.CaseLocations[casenumber].Broken then
        Config.CaseLocations[casenumber].Broken  = true
        TriggerEvent('tqrp_joias:RestTimer')
        TriggerClientEvent('tqrp_joias:setcase', -1, casenumber, true)
        TriggerEvent('tqrp_joias:AwardItems', _source)
    end
end)

RegisterServerEvent('tqrp_joias:loadconfig')
AddEventHandler('tqrp_joias:loadconfig', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local buildlist = {id = _source,job = xPlayer.job.name,}
    table.insert(joblist, buildlist)
    TriggerClientEvent('tqrp_joias:loadconfig', _source, Config.CaseLocations)
    if policeclosed then
        TriggerClientEvent('tqrp_joias:policeclosure', _source)
    end
end)

AddEventHandler('tqrp_joias:RestTimer', function()
    if resettime == nil then
        totaltime = Config.ResetTime * 60
        resettime = os.time() + totaltime

        while os.time() < resettime do
            Citizen.Wait(2350)
        end

        for i, v in pairs(Config.CaseLocations) do
            v.Broken = false
        end
        TriggerClientEvent('tqrp_joias:resetcases', -1, Config.CaseLocations)
        resettime = nil
        policeclosed = false
    end
end)

AddEventHandler('tqrp_joias:AwardItems', function(serverid)
    local xPlayer = ESX.GetPlayerFromId(serverid)
    local randomitem = math.random(1,100)
    for i, v in pairs(Config.ItemDrops) do 
        if randomitem <= v.chance then
            randomamount = math.random(1, v.max)
            sourceItem = xPlayer.getInventoryItem(v.name)
            if sourceItem.limit ~= nil then
                if sourceItem.limit ~= -1 and (sourceItem.count + randomamount) > sourceItem.limit then
                    if sourceItem.count < sourceItem.limit then
                        randomamount = sourceItem.limit - sourceItem.count
                        xPlayer.addInventoryItem(v.name, randomamount)
                    else
                        TriggerClientEvent('esx:showNotification', _source, 'Not enough room in your inventory to carry more '.. sourceItem.label)
                    end
                else
                    xPlayer.addInventoryItem(v.name, randomamount)
                end
                break
            else
                xPlayer.addInventoryItem(v.name, randomamount)
                break
            end
        end
    end
end)
