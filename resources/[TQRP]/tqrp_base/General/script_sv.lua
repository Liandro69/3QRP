
ESX = nil
local logs = "https://discordapp.com/api/webhooks/721724486008832050/jU4qd00xpFDpWqBimzbz9CkTJ565ufGr1hgun_HWkuvNKoR1vSzrXb9BztdKz_yj0h1i"
local logs1 = "https://discordapp.com/api/webhooks/728380047316222013/M9QZ_RUWo38AwPQv7f5Y4mES9KCtRQkjVXp-qisUXHM9maWza3-DKui7FsKNmM2Z--Tm"
local logs2 = "https://discordapp.com/api/webhooks/728398596940234804/mvMFiK5XLmLr2-qf06pllhF0rK9ysUO46tx5StnI6fBr9FzM_JERK1zIHjgKbtZqxipp"
local communityname = "3QRP Roleplay"
local communtiylogo = "https://i.imgur.com/e8VsdLL.jpg" --Must end with .png or .jpg
local blacklist = {
	[1] = "engine",
	[2] = "portas",
	[3] = "lock",
	[4] = "trunk",
	[5] = "in",
	[6] = "wheelchair",
	[7] = "save",
	[8] = "re",
	[9] = "hood",
    [10] = "pegar",
    [11] = "fechartelemovel",
    [12] = "fecharinventario",
    [13] = "notas",
    [14] = "dv",
    [15] = "tshirt",
    [16] = "fio",
    [17] = "colete",
    [18] = "roupa",
	[19] = "save",
	[20] = "mdt",
	[21] = "porta2"
}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


function kickAll()
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        xPlayer.kick("[3QRP] Restart automático. Podes entrar no servidor dentro de breves momentos.")
    end
end


local text15 = "RESTART AUTOMÁTICO EM 15 MINUTOS!"
local text10 = "RESTART AUTOMÁTICO EM 10 MINUTOS!"
local text5  = "RESTART AUTOMÁTICO EM 5 MINUTOS!"
local texti = "RESTART IMINENTE!"

function CronTask(d, h, m)
    TriggerClientEvent('mythic_notify:client:SendAlert', -1, {type = 'adm', text = text15 })
    TriggerClientEvent('InteractSound_CL:PlayOnOne', -1, "demo", 0.1)
    Wait(300000)
    TriggerClientEvent('mythic_notify:client:SendAlert', -1, {type = 'adm', text = text10 })
    TriggerClientEvent('InteractSound_CL:PlayOnOne', -1, "demo", 0.1)
    Wait(300000)
    TriggerClientEvent('mythic_notify:client:SendAlert', -1, {type = 'adm', text = text5 })
    TriggerClientEvent('InteractSound_CL:PlayOnOne', -1, "demo", 0.1)
    Wait(120000)
    TriggerClientEvent('mythic_notify:client:SendAlert', -1, {type = 'adm', text = texti })
    TriggerClientEvent('InteractSound_CL:PlayOnOne', -1, "demo", 0.1)
    Wait(60000)
    TriggerClientEvent('mythic_notify:client:SendAlert', -1, {type = 'adm', text = texti })
    TriggerClientEvent('InteractSound_CL:PlayOnOne', -1, "demo", 0.1)
    Wait(60000)
    TriggerClientEvent('mythic_notify:client:SendAlert', -1, {type = 'adm', text = texti })
    TriggerClientEvent('InteractSound_CL:PlayOnOne', -1, "demo", 0.1)
    Wait(30000)
    kickAll()
end



TriggerEvent('cron:runAt', 0, 45, CronTask)
TriggerEvent('cron:runAt', 3, 45, CronTask)
TriggerEvent('cron:runAt', 7, 45, CronTask)
TriggerEvent('cron:runAt', 11, 45, CronTask)
TriggerEvent('cron:runAt', 17, 45, CronTask)
TriggerEvent('cron:runAt', 20, 45, CronTask)



local validResourceList
local function collectValidResourceList()
    validResourceList = {}
    for i=0, (GetNumResources()-1), 1 do
        validResourceList[GetResourceByFindIndex(i)] = true
    end
end
collectValidResourceList()
-- This makes sure that the resource list is always accurate
AddEventHandler("onResourceListRefresh", collectValidResourceList)
RegisterNetEvent("checkMyResources")
AddEventHandler("checkMyResources", function(givenList)
    for _, resource in ipairs(givenList) do
        if not validResourceList[resource] then
            local connect = {
                {
                    ["color"] = "8663711",
                    ["title"] = "CHEATER ALERT",
                    ["description"] = "Player: **"..name.."**\n Steam Hex: **"..steamhex.."**",
                    ["footer"] = {
                        ["text"] = communityname,
                        ["icon_url"] = communtiylogo,
                    },
                }
            }
        
            PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Big Yoda Server Logger", embeds = connect}), { ['Content-Type'] = 'application/json' })
            DropClient(source)
            break
        end
    end
end)

AddEventHandler("playerConnecting", function()
    local _source = source
    local identifier = GetPlayerIdentifiers(_source)
    local identifierDiscod = ""
    for k, v in ipairs(identifier) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscod = v
        end
    end
    if GetPlayerEndpoint(_source) ~= nil then
        MySQL.Async.execute('UPDATE users SET ip=@ip WHERE identifier=@identifier', {['@ip'] = tostring(GetPlayerEndpoint(_source)), ['@identifier'] = identifier[1]})
    end
    local name = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local steamhex = GetPlayerIdentifier(source)
    local connect = {
            {
                ["color"] = "8663711",
                ["title"] = "Conectado",
                ["description"] = "Player: **"..name.."**\n Steam Hex: **"..steamhex.."**\n Discord ID: **"..identifierDiscod.."**",
                ["footer"] = {
                    ["text"] = communityname,
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Xibo", embeds = connect}), { ['Content-Type'] = 'application/json' })
    
end)

RegisterServerEvent('Tackle:Server:TacklePlayer')
AddEventHandler('Tackle:Server:TacklePlayer', function(Tackled, ForwardVectorX, ForwardVectorY, ForwardVectorZ, Tackler)
	TriggerClientEvent("Tackle:Client:TacklePlayer", Tackled, ForwardVectorX, ForwardVectorY, ForwardVectorZ, Tackler)
end)

RegisterServerEvent("kickForBeingAnAFKDouchebag")
AddEventHandler("kickForBeingAnAFKDouchebag", function()
	DropPlayer(source, "Expulso! Motivo: AFK durante 5 minutos.")
end)

RegisterServerEvent('onlinetime_sql:time')
AddEventHandler('onlinetime_sql:time', function()
	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]
	MySQL.Async.fetchAll('SELECT * FROM times WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
		    TriggerClientEvent('onlinetime_sql:sendDados', _source, gotInfo[1].s, gotInfo[1].m, gotInfo[1].h, gotInfo[1].d)
		else
			local news = 0
			local newm = 0
		    local newh = 0
		    local newd = 0
			MySQL.Async.execute('INSERT INTO times (identifier, s, m, h, d) VALUES (@identifier,@s,@m,@h,@d)', {
				['@identifier'] = identifier, 
				['@s'] = news, 
				['@m'] = newm, 
				['@h'] = newh, 
				['@d'] = newd
			})
			TriggerClientEvent('onlinetime_sql:sendDados', _source, news, newm, newh, newd)
		end
	end)
	
end)
RegisterServerEvent('onyx:givecarkeys')
AddEventHandler('onyx:givecarkeys', function(closestplayer, plate)
    local vehPlate = plate
    local closestid = closestplayer
    TriggerClientEvent('onyx:updatePlates', closestid, vehPlate)
    TriggerClientEvent('mythic_notify:client:SendAlert', closestid, {type = 'success', text = 'Recebeste as chaves do carro!'})
end)


RegisterServerEvent('onyx:updateSearchedVehTable')
AddEventHandler('onyx:updateSearchedVehTable', function(plate)
    local vehPlate = plate
    TriggerClientEvent('onyx:returnSearchedVehTable', -1, vehPlate)
end)


RegisterServerEvent('onyx:updateSearchedVehTable')
AddEventHandler('onyx:updateSearchedVehTable', function(plate)
    local vehPlate = plate
    TriggerClientEvent('onyx:returnSearchedVehTable', -1, vehPlate)
end)

RegisterServerEvent('onyx:reqHotwiring')
AddEventHandler('onyx:reqHotwiring', function(plate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getInventoryItem('lockpick').count > 0 then
        TriggerClientEvent('onyx:beginHotwire', _source, plate)
        local rnd = math.random(1, 25)
        if rnd == 20 then
            xPlayer.removeInventoryItem('lockpick', 1)
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'A lockpick partiu-se'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'Não tens o necessário...'})
    end
end)

RegisterServerEvent('tqrp_kekke_tackle:tryTackle')
AddEventHandler('tqrp_kekke_tackle:tryTackle', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent('tqrp_kekke_tackle:getTackled', targetPlayer.source, source)
	TriggerClientEvent('tqrp_kekke_tackle:playTackle', source)
end)

RegisterServerEvent('onlinetime_sql:savetimedb')
AddEventHandler('onlinetime_sql:savetimedb', function(s, m, h, d)
	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]	
    MySQL.Async.execute('UPDATE times SET s=@s, m=@m, h=@h, d=@d WHERE identifier=@identifier', {['@s'] = s, ['@m'] = m, ['@h'] = h, ['@d'] = d, ['@identifier'] = identifier})
end)

local EMSConnected, PoliceConnected, SheriffConnected = 0,0,0

--[[Citizen.CreateThread(function()
    while true do
        local xPlayers = ESX.GetPlayers()
        EMSConnected = 0
        PoliceConnected = 0
        MechanoConnected = 0
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer ~= nil then
                if xPlayer.job.name == 'ambulance' then
                    EMSConnected = EMSConnected + 1
                elseif xPlayer.job.name == 'police' then
                    PoliceConnected = PoliceConnected + 1
                elseif xPlayer.job.name == 'mechanic' then
                    MechanoConnected = MechanoConnected + 1
                end
            end
		end
        Citizen.Wait(60000)
    end
end)]]

ESX.RegisterServerCallback('tqrp_base:getJobsOnline', function(source, cb)
	cb(EMSConnected, PoliceConnected, SheriffConnected)
end)

RegisterServerEvent('tqrp_base:updateJobs')
AddEventHandler('tqrp_base:updateJobs', function(table)
    PoliceConnected = 0
    EMSConnected = 0
    SheriffConnected = 0
    for i = 1, #table, 1 do
        if table[i].isCop == 'police' then
            PoliceConnected = PoliceConnected + 1 
        elseif table[i].isCop == 'sheriff' then
            SheriffConnected = SheriffConnected + 1 
        else
            EMSConnected = EMSConnected + 1 
        end
    end
end)

local robbed = false

RegisterServerEvent('tqrp_base:setRobbed')
AddEventHandler('tqrp_base:setRobbed', function(state)
    robbed = state
end)

ESX.RegisterServerCallback('tqrp_base:getRobbed', function(source, cb)
	cb(robbed)
end)

-- SERVER script, requires OneSync!
AddEventHandler('explosionEvent', function(sender, ev)
    local disconnect = {
        {
            ["color"] = "8663711",
            ["title"] = "EXPLOSION",
            ["description"] = "**" .. GetPlayerName(sender) .. '**\n ' .. json.encode(ev)..'**',
            ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
            },
        }
    }

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Xibo", embeds = disconnect}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('tqrp_base:AlertJob')
AddEventHandler('tqrp_base:AlertJob', function(job, msg, tipo)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == job then
            TriggerClientEvent("pNotify:SendNotification", source, {
	            text = msg,
	            type = tipo,
	            queue = "lmao",
	            timeout = 2500,
	            layout = "centerRight"
	        })
        end
    end
end)

RegisterNetEvent('tqrp_base:roblog')
AddEventHandler('tqrp_base:roblog', function(cena, text, color)

    local name = GetPlayerName(source)
    local identifier = GetPlayerIdentifiers(source)
    local embedlog = {
        {
            ["color"] = "2558648",
            ["title"] = cena,
            ["description"] = "**" .. name .. '**\n ' .. identifier[1] .. '\n '..text,
            ["footer"] = {
                ["text"] = "3QRP Roleplay",
                ["icon_url"] = "https://i.imgur.com/e8VsdLL.jpg",
            },
        }
    }

    PerformHttpRequest(logs1, function(err, text, headers) end, 'POST', json.encode({username = "Xibo", embeds = embedlog}), { ['Content-Type'] = 'application/json' })
end)

RegisterNetEvent('tqrp_base:buylog')
AddEventHandler('tqrp_base:buylog', function(cena, text, color)

    local name = GetPlayerName(source)
    local identifier = GetPlayerIdentifiers(source)
    local embedlog = {
        {
            ["color"] = color,
            ["title"] = cena,
            ["description"] = "**" .. name .. '**\n ' .. identifier[1] .. '\n ' .. text,
            ["footer"] = {
                ["text"] = "3QRP Roleplay",
                ["icon_url"] = "https://i.imgur.com/e8VsdLL.jpg",
            },
        }
    }
    PerformHttpRequest(logs2, function(err, text, headers) end, 'POST', json.encode({username = "Xibo", embeds = embedlog}), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent('tqrp_base:serverlog')
AddEventHandler('tqrp_base:serverlog', function(text, source, resource)
    local log = false
    for i = 1, #blacklist do
        if string.match(text, blacklist[i]) then
            if resource ~= "es_extended" then
                log = false
                break
            else
                log = true
            end
        else
            log = true
        end
    end
    if log then
        local time = os.date("%d/%m/%Y %X")
        local name = GetPlayerName(source)
        local identifier = GetPlayerIdentifiers(source)
        local res = GetCurrentResourceName()
        if name ~= nil and identifier[1] ~= nil then
            local data = "[".. resource .. "]: " .. time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text
            local content = LoadResourceFile(res, "log.txt")
            local newContent = content .. '\r\n' .. data
            SaveResourceFile(res, "log.txt", newContent, -1)
            local disconnect = {
                    {
                        ["color"] = "8663711",
                        ["title"] = res,
                        ["description"] = "**" .. name .. '**\n ' .. identifier[1] .. '\n' .. text,
                        ["footer"] = {
                            ["text"] = communityname,
                            ["icon_url"] = communtiylogo,
                        },
                    }
                }

                PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Xibo", embeds = disconnect}), { ['Content-Type'] = 'application/json' })

        end
    end
end)

RegisterServerEvent('tqrp_base:intrunk')
AddEventHandler('tqrp_base:intrunk', function(target) 
    TriggerClientEvent('tqrp_base:intrunk', target) 
end)

RegisterServerEvent('tqrp_base:outtrunk')
AddEventHandler('tqrp_base:outtrunk', function(target) 
    TriggerClientEvent('tqrp_base:outtrunk', target) 
end)

-- HELPER FUNCTIONS
function cashbalance(player)
    local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = player})
    local result = MySQL:getResults(executed_query, {'money'}, "identifier")
    return tonumber(result[1].cashbalance)
end

MySQL.ready(function()
    local xPlayers = ESX.GetPlayers()
    EMSConnected = 0
    PoliceConnected = 0
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer ~= nil then
            if xPlayer.job.name == 'ambulance' then
                EMSConnected = EMSConnected + 1
            elseif xPlayer.job.name == 'police' then
                PoliceConnected = PoliceConnected + 1
            end
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local steamhex = GetPlayerIdentifier(source)
local disconnect = {
        {
            ["color"] = "8663711",
            ["title"] = "Disconnect",
            ["description"] = "Player: **"..name.."** \nReason: **"..reason.."**\n Steam Hex: **"..steamhex.."**",
	        ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
            },
        }
    }

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Xibo", embeds = disconnect}), { ['Content-Type'] = 'application/json' })
end)

ESX.RegisterUsableItem('gasmask', function(source)
	TriggerClientEvent('gasMask', source) 
end)



