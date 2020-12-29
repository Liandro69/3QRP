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

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function(dead)
    local source = source
    local totalBill = CalculateBill(GetCharsInjuries(source), Config.InjuryBase)

    if not dead then
        if BillPlayer(source, totalBill) then
            for k, v in pairs(beds) do
                if not v.taken then
                    v.taken = true
                    bedsTaken[source] = k
                    TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
                    return
                end
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { text = 'Não tens dinehro suficiente. ['.. totalBill ..']', type = 'error'})
            return
        end
    else
        for k, v in pairs(beds) do
            if not v.taken then
                v.taken = true
                bedsTaken[source] = k
                TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
                return
            end
        end
    end
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não existem macas disponíveis' })
end)

RegisterServerEvent('mythic_hospital:server:RPRequestBed')
AddEventHandler('mythic_hospital:server:RPRequestBed', function(plyCoords)
    local src = source
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('mythic_hospital:client:RPSendToBed', src, k, v)
                return
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', src, { text = 'Maca ocupada.', type = 'error'})
            end
        end
    end

    if not foundbed then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { text = 'Nenhuma maca por perto.', type = 'error'})
    end
end)

RegisterServerEvent('mythic_hospital:server:EnteredBed')
AddEventHandler('mythic_hospital:server:EnteredBed', function()
    local src = source
    local totalBill = CalculateBill(GetCharsInjuries(src), Config.InjuryBase)

    TriggerClientEvent('mythic_notify:client:SendAlert', src, { text = 'Recebeste tratamento e já te sentes melhor', type = 'inform', style = { ['background-color'] = '#760036' }})
    TriggerClientEvent('mythic_hospital:client:FinishServices', src, false, true)
end)

RegisterServerEvent('mythic_hospital:server:LeaveBed')
AddEventHandler('mythic_hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)