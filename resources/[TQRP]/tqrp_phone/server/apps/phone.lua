Calls = {}

function CreateCallRecord(sender, receiver, state)

end

AddEventHandler('playerDropped', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local myData = getIdentity(src)

    local mPlayer = GetPlayerIdentifiers(src)[1]
    if mPlayer ~= nil and myData ~= nil then
        if Calls[myData.phone_number] ~= nil then
            local tPlayer = (Calls[myData.phone_number].number)
            if tPlayer ~= nil then
                TriggerClientEvent('tqrp_phone:client:EndCall', src)
            else
                Calls[Calls[myData.phone_number].number]= nil
            end
            Calls[myData.phone_number] = nil
        end
    end
end)

RegisterServerEvent('tqrp_phone:server:SetUpHistory')
AddEventHandler('tqrp_phone:server:SetUpHistory', function()
local src = source
local MyNumber = getNumberPhone(GetPlayerIdentifiers(src)[1])
    Citizen.CreateThread(function()
        MySQL.Async.fetchAll('SELECT * FROM phone_calls WHERE (sender = @number AND sender_deleted = 0) OR (receiver = @number AND receiver_deleted = 0) LIMIT 50', {['@number'] = MyNumber} 
           , function(result) 
            TriggerClientEvent('tqrp_phone:client:SetupData', src, {{ name = 'history', data = result }})
        end)
    end)
end)
 

ESX.RegisterServerCallback('tqrp_phone:server:CreateCall', function(source, cb, data)
    local src = source
    local player = ESX.GetPlayerFromId(source)
    local myData = getIdentity(src)
    data.number = tonumber(data.number)
    myData.phone_number = tonumber(myData.phone_number)
    local numbersid = getIdentifierByPhoneNumber(data.number)
    local otherplayer
    if numbersid ~= nil then
        otherplayer = ESX.GetPlayerFromIdentifier(numbersid).source
    else
        otherplayer = nil
    end

    Citizen.Wait(500)
    local tPlayer = numbersid
    if tPlayer ~= nil then
        if data.number ~= myData.phone_number then
            if Calls[data.number] ~= nil then
                cb(-3)
                MySQL.Async.fetchAll('SELECT * FROM phone_contacts WHERE number = @number AND identifier = @identifier', { ['number'] = myData.phone_number, ['identifier'] = numbersid }, function(contact)
                    if contact ~= nil then
                        TriggerClientEvent('mythic_notify:client:SendAlert', otherplayer, {type = 'inform', text = contact[1].name .. ' tentou te ligar'})
                    elseif not contact ~= nil then
                        TriggerClientEvent('mythic_notify:client:SendAlert', otherplayer, {type = 'inform', text = myData.phone_number .. ' tentou te ligar'})
                    end
                end)
            else
                MySQL.Async.insert('INSERT INTO phone_calls (sender, receiver, status, anon) VALUES(@sender, @receiver, @status, @anon)', {
                    ['sender'] = myData.phone_number,
                    ['receiver'] = data.number,
                    ['status'] = 0,
                    ['anon'] = data.nonStandard
                }, function(insertId)
                    if insertId then
                        cb(1)
                        
                        TriggerClientEvent('tqrp_phone:client:CreateCall', src, myData.phone_number)
                        TriggerClientEvent('tqrp_phone:client:AddToHistory', src, myData.phone_number, data.number, 0,  data.nonStandard)
                        TriggerClientEvent('tqrp_phone:client:AddToHistory', otherplayer, myData.phone_number, data.number, 0,  data.nonStandard)
                        if data.nonStandard and not contact ~= nil then
                            TriggerClientEvent('tqrp_phone:client:ReceiveCall', otherplayer, 'Desconhecido')
                            TriggerClientEvent('mythic_notify:client:SendAlert', otherplayer, {type = 'inform', text = 'Estás a receber uma chamada em número anónimo', lenght = 30000  })
                        elseif data.nonStandard and contact ~= nil then
                            TriggerClientEvent('tqrp_phone:client:ReceiveCall', otherplayer, 'Desconhecido')
                            TriggerClientEvent('mythic_notify:client:SendAlert', otherplayer, {type = 'inform', text = 'Estás a receber uma chamada em número anónimo', lenght = 30000  })
                        elseif not data.nonStandard and contact ~= nil then
                            TriggerClientEvent('tqrp_phone:client:ReceiveCall', otherplayer, myData.phone_number)
                            TriggerClientEvent('mythic_notify:client:SendAlert', otherplayer, {type = 'inform', text = 'Estás a receber uma chamada de: '.. contact[1].name, lenght = 30000  })
                        elseif not data.nonStandard and not contact ~= nil then
                            TriggerClientEvent('tqrp_phone:client:ReceiveCall', otherplayer, myData.phone_number)
                            TriggerClientEvent('mythic_notify:client:SendAlert', otherplayer, {type = 'inform', text = 'Estás a receber uma chamada de: '.. myData.phone_number, lenght = 30000  })
                        end

                        Calls[myData.phone_number] = {
                            number = data.number,
                            status = 0,
                            record = insertId
                        }
                        Calls[data.number] = {
                            number = myData.phone_number,
                            status = 0,
                            record = insertId
                        }
                    else
                        cb(-1)
                    end
                end)
            end
        else
            cb(-2)
        end
    else
        cb(-1)
    end
end)

ESX.RegisterServerCallback('tqrp_phone:server:DeleteCallRecord', function(source, cb, data)
local src = source
local player = ESX.GetPlayerFromId(source)
local myData = getIdentity(src)
    
        MySQL.Async.fetchAll('SELECT * FROM phone_calls WHERE id = @id', { ['@id'] = data.id }, function(record)
            if record[1] ~= nil then
                if record[1].sender == myData.phone_number then
                    MySQL.Async.execute('UPDATE phone_calls SET sender_deleted = 1 WHERE id = @id AND sender = @phone', { ['@id'] = data.id, ['@phone'] = myData.phone_number }, function(status)
                        if status > 0 then
                            cb(true)
                        else
                            cb(false)
                        end
                    end)
                else
                    MySQL.Async.execute('UPDATE phone_calls SET receiver_deleted = 1 WHERE id = @id AND receiver = @phone', { ['@id'] = data.id, ['@phone'] = myData.phone_number }, function(status)
                        if status > 0 then
                            cb(true)
                        else
                            cb(false)
                        end
                    end)
                end
            else
                cb(false)
            end
        end)
    end)
    
--[[
RegisterServerEvent('tqrp_phone:server:ToggleHold')
AddEventHandler('tqrp_phone:server:ToggleHold', function(call)
    local src = source
    local tPlayer = (Calls[call.number].number)
    local numbersid = getIdentifierByPhoneNumber(tPlayer)
    local numbersid2 = getIdentifierByPhoneNumber(mPlayer)
    local otherplayer = ESX.GetPlayerFromIdentifier(numbersid).source
    TriggerClientEvent('tqrp_phone:client:OtherToggleHold', otherplayer)
    TriggerEvent("tqrp_phone:server:ToggleHold2", call)
end)

RegisterServerEvent('tqrp_phone:server:ToggleHold2')
AddEventHandler('tqrp_phone:server:ToggleHold2', function(call)
    local src = source
    local mPlayer = (Calls[Calls[call.number].number].number)
    local numbersid2 = getIdentifierByPhoneNumber(mPlayer)
    local otherplayer2 = ESX.GetPlayerFromIdentifier(numbersid2).source
    TriggerClientEvent('tqrp_phone:client:OtherToggleHold', otherplayer2)
end)]]

RegisterServerEvent('tqrp_phone:server:AcceptCall')
AddEventHandler('tqrp_phone:server:AcceptCall', function()
local src = source
local player = ESX.GetPlayerFromId(source)
local myData = getIdentity(src)
myData['phone_number'] = tonumber(myData.phone_number)
    
    if Calls[myData.phone_number] ~= nil then
        local numbersid = getIdentifierByPhoneNumber(Calls[myData.phone_number].number)
        local otherplayer = ESX.GetPlayerFromIdentifier(numbersid)-- erro
        local tPlayer = (Calls[myData.phone_number].number)
        if tPlayer ~= nil and otherplayer ~= nil then
            if (Calls[myData.phone_number].number ~= nil) and (Calls[Calls[myData.phone_number].number].number ~= nil) then
                Calls[Calls[myData.phone_number].number].status = 1
                Calls[myData.phone_number].status = 1
                
                TriggerClientEvent('tqrp_phone:client:AcceptCall', src, (tonumber(otherplayer.source) + 12640), false)
                TriggerClientEvent('tqrp_phone:client:AcceptCall', tonumber(otherplayer.source), (tonumber(otherplayer.source) + 12640), true)
            else
                Calls[Calls[myData.phone_number].number] = nil
                Calls[myData.phone_number] = nil
                TriggerClientEvent('tqrp_phone:client:EndCall', src)
                TriggerClientEvent('tqrp_phone:client:EndCall', tonumber(otherplayer.source))
            end
        else
            TriggerClientEvent('tqrp_phone:client:EndCall', src)
        end
    end
end)

RegisterServerEvent('tqrp_phone:server:EndCall')
AddEventHandler('tqrp_phone:server:EndCall', function()
local src = source
local player = ESX.GetPlayerFromId(source)
local myData = getIdentity(src)
myData['phone_number'] = tonumber(myData.phone_number)

    if Calls[myData.phone_number] ~= nil then
        local tPlayer = (Calls[myData.phone_number].number)
        local numbersid = getIdentifierByPhoneNumber(tPlayer)
        local otherplayer = ESX.GetPlayerFromIdentifier(numbersid) -- erro
        if tPlayer ~= nil then
            Calls[Calls[myData.phone_number].number] = nil
            Calls[myData.phone_number] = nil

            TriggerClientEvent('tqrp_phone:client:EndCall', src)
            if otherplayer ~= nil then
                TriggerClientEvent('tqrp_phone:client:EndCall', tonumber(otherplayer.source))
            end
        end
    end
end)