RegisterServerEvent('mythic_hospital:server:AttemptHiddenRevive')
AddEventHandler('mythic_hospital:server:AttemptHiddenRevive', function()
    local src = source
    math.randomseed(os.time())
    local luck = math.random(100) < Config.HiddenRevChance

    local totalBill = CalculateBill(GetCharsInjuries(src), Config.HiddenInjuryBase)
    
    if BillPlayer(src, totalBill) then
        if luck then
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { text = 'Recebeste tratamento e já te sentes melhor.', type = 'inform', style = { ['background-color'] = '#760036' }})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { text = 'Recebeste tratamento mas certas coisas não correram como planeado.', type = 'inform', length = 10000, style = { ['background-color'] = '#760036' }})
        end
        RecentlyUsedHidden[source] = os.time() + 180000
        TriggerClientEvent('mythic_hospital:client:FinishServices', src, true, luck)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { text = 'Só falo com o dinheiro em mão...', type = 'error'})
        TriggerClientEvent('mythic_hospital:client:NoCash', src)
    end
end)