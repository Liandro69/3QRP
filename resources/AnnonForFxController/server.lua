local realhash = "ctKdO0OLsG"

RegisterCommand("announce", function(source, args, raw) 
    local hash = args[1] 
    if hash == realhash then    
    local scaleType, time, font = tonumber(args[2]), tonumber(args[3]), args[4]
    local extraArgs
    if tonumber(args[4]) then
        extraArgs = 4
    else
        extraArgs = 3
    end
    for i = 1, extraArgs do table.remove(args, 1) end
    TriggerClientEvent("Scaleform:Announce", -1, scaleType, time, font,
                       table.concat(args, " "))
    end
end, false)

RegisterCommand("kickplayerforfxcontroller", function(source, args, raw)
    -- if IsPlayerAceAllowed(source,"command")then
    local hash, id = args[1], tonumber(args[2])
    local reason = string.gsub(raw, args[1], "")
    reason = string.gsub(reason, args[2], "")
    reason = string.gsub(reason, "kickplayerforfxcontroller", "")
    if realhash == hash then DropPlayer(id, reason) end
end, false)

local text15 = "RESTART AUTOMÁTICO EM 15 MINUTOS!"
local text10 = "RESTART AUTOMÁTICO EM 10 MINUTOS!"
local text5  = "RESTART AUTOMÁTICO EM 5 MINUTOS!"


function CronTask(d, h, m)
    TriggerClientEvent('mythic_notify:client:SendAlert', -1, {type = 'adm', text = text15 })
    TriggerClientEvent('InteractSound_CL:PlayOnOne', -1, "demo", 0.1)
    Wait(300000)
    TriggerClientEvent('mythic_notify:client:SendAlert', -1, {type = 'adm', text = text10 })
    TriggerClientEvent('InteractSound_CL:PlayOnOne', -1, "demo", 0.1)
    Wait(300000)
    TriggerClientEvent('mythic_notify:client:SendAlert', -1, {type = 'adm', text = text5 })
    TriggerClientEvent('InteractSound_CL:PlayOnOne', -1, "demo", 0.1)
end
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    TriggerEvent('cron:runAt', 0, 45, CronTask)
    TriggerEvent('cron:runAt', 3, 45, CronTask)
    TriggerEvent('cron:runAt', 7, 45, CronTask)
    TriggerEvent('cron:runAt', 11, 45, CronTask)
    TriggerEvent('cron:runAt', 17, 45, CronTask)
    TriggerEvent('cron:runAt', 20, 45, CronTask)
end)
