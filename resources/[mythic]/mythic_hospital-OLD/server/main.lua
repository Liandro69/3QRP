local beds = {
    --- CAMAS LADO EM FRENTE A PORTA ----
    { x = 314.51, y = -584.12, z = 43.89, h = 345.16, taken = false, model = 1631638868 },
    { x = 311.51, y = -584.12, z = 43.89, h = 345.16, taken = false, model = 1631638868 },
    { x = 317.51, y = -584.12, z = 43.89, h = 345.16, taken = false, model = 1631638868 },
    { x = 307.72, y = -581.79, z = 43.89, h = 345.16, taken = false, model = 1631638868 },
    { x = 322.51, y = -584.12, z = 43.89, h = 345.16, taken = false, model = 1631638868 }, 
    ---- CAMAS LADO PORTA -----
    { x = 324.51, y = -528.8,  z = 43.89, h = 157.15, taken = false, model = 1631638868 },
    { x = 314.09, y = -578.12, z = 43.89, h = 157.15, taken = false, model = 1631638868 },
    { x = 309.51, y = -577.12, z = 43.89, h = 157.15, taken = false, model = 1631638868 },
    { x = 319.16, y = -581.15, z = 43.89, h = 157.15, taken = false, model = 1631638868 }
}

local bedsTaken = {}
local injuryBasePrice = 100

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não há camas disponíveis' })
end)

RegisterServerEvent('mythic_hospital:server:RPRequestBed')
AddEventHandler('mythic_hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('mythic_hospital:client:RPSendToBed', source, k, v)
                return
            else
                TriggerEvent('mythic_chat:server:System', source, 'Essa cama está ocupada')
            end
        end
    end

    if not foundbed then
        TriggerEvent('mythic_chat:server:System', source, 'Not Near A Hospital Bed')
    end
end)

RegisterServerEvent('mythic_hospital:server:EnteredBed')
AddEventHandler('mythic_hospital:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)

    local totalBill = injuryBasePrice

    if injuries ~= nil then
        for k, v in pairs(injuries.limbs) do
            if v.isDamaged then
                totalBill = totalBill + (injuryBasePrice * v.severity)
            end
        end

        if injuries.isBleeding > 0 then
            totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        end
    end

    -- YOU NEED TO IMPLEMENT YOUR FRAMEWORKS BILLING HERE
    TriggerClientEvent('mythic_hospital:client:FinishServices', src)
end)

RegisterServerEvent('mythic_hospital:server:LeaveBed')
AddEventHandler('mythic_hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)