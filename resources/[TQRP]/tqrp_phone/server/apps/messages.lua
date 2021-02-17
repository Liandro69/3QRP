ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tqrp_phone:server:GetTexts')
AddEventHandler('tqrp_phone:server:GetTexts', function()
local src = source
local player = ESX.GetPlayerFromId(source)
local thingy = getNumberPhone(player.identifier)
    Citizen.CreateThread(function()
        MySQL.Async.fetchAll("SELECT * FROM phone_texts WHERE (sender = @number AND sender_deleted = 0) OR (receiver = @number AND receiver_deleted = 0)", { ['@number'] = thingy }
         , function(result)
            TriggerClientEvent('tqrp_phone:client:SetupData', src, {{ name = 'messages', data = result }})
         end)
    end)
end)

function getMessages(identifier)
    MySQL.Async.fetchAll("SELECT * FROM phone_texts INNER JOIN users ON users.identifier = @identifier WHERE phone_texts.receiver = users.phone_number OR phone_texts.sender = users.phone_number", {
         ['@identifier'] = identifier
    }, function(result)
        return result
    end)
end

ESX.RegisterServerCallback('tqrp_phone:server:SendText', function(source, cb, data)
    local src = source
    local thingy = getIdentity(src)
        
    Citizen.CreateThread(function()
        MySQL.Async.execute('INSERT INTO phone_texts (`sender`, `receiver`, `message`) VALUES(@sender, @receiver, @message)', { ['sender'] = thingy.phone_number, ['receiver'] = data.receiver, ['message'] = data.message }, function(status)
            if status > 0 then
                local hi = getIdentifierByPhoneNumber(data.receiver)
                local xTarget =  ESX.GetPlayerFromIdentifier(hi)
                local otherplayer
                if xTarget ~= nil then
                    otherplayer = xTarget.source
                else
                    otherplayer = nil
                end 
                if otherplayer ~= nil then
                    MySQL.Async.fetchAll('SELECT * FROM phone_contacts WHERE number = @number AND identifier = @identifier', { ['number'] = thingy.phone_number, ['identifier'] = hi }, 
                    function(contact)
                        if contact[1] ~= nil then
                            TriggerClientEvent('tqrp_phone:client:ReceiveText', tonumber(otherplayer), contact[1].name, data.message, thingy.phone_number)
                        else
                            TriggerClientEvent('tqrp_phone:client:ReceiveText', tonumber(otherplayer), thingy.phone_number, data.message, thingy.phone_number)
                        end
                    end)
                end
                cb(data)
            else
                cb(false)
            end
        end)
    end)
end)

RegisterServerEvent('tqrp_phone:server:SendTextbot')
AddEventHandler('tqrp_phone:server:SendTextbot', function(textmsg)
local src = source
local thingy = getIdentity(src)
    
    Citizen.CreateThread(function()
        MySQL.Async.execute('INSERT INTO phone_texts (`sender`, `receiver`, `message`) VALUES(@sender, @receiver, @message)', { ['sender'] = "000000000", ['receiver'] = thingy.phone_number, ['message'] = textmsg }, function(status)
            if status > 0 then
                if textmsg ~= nil then
                    stat = (textmsg)

                    TriggerClientEvent('tqrp_phone:client:ReceiveText', src, "000000000", textmsg)
                else
                    stat = (false)
                end
            else
                stat = (false)
            end
        end)
    end)
end)

ESX.RegisterServerCallback('tqrp_phone:server:DeleteConversation', function(source, cb, data)
    local src = source
    local thingy = getIdentity(src)
    MySQL.Async.execute('UPDATE phone_texts SET sender_deleted = 1 WHERE sender = @me AND receiver = @other', { ['@me'] = thingy.phone_number, ['@other'] = data.number }, function(status1)
        MySQL.Async.execute('UPDATE phone_texts SET receiver_deleted = 1 WHERE receiver = @me AND sender = @other', { ['@me'] = thingy.phone_number, ['@other'] = data.number }, function(status2)
            cb(status1 ~= 0 or status2 ~= 0)
        end)
    end)
end)