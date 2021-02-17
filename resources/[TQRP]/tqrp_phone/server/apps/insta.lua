RegisterServerEvent('tqrp_phone:server:UpdateIsta')
AddEventHandler('tqrp_phone:server:UpdateIsta', function()
    local src = source
    Citizen.CreateThread(function()
        MySQL.Async.fetchAll('SELECT * FROM phone_instas ORDER BY time DESC LIMIT 31', {}, function(instas) 
            TriggerClientEvent('tqrp_phone:client:SetupData', src, { { name = 'instas', data = instas } })
        end)
    end)
end)

ESX.RegisterServerCallback('tqrp_phone:server:getLink', function(source, cb)
    cb("http://54.36.165.186/threequeens/upload.php")
end)

ESX.RegisterServerCallback('tqrp_phone:server:DeleteInsta', function(source, cb, link)
    local photo = link
    MySQL.Async.execute('DELETE FROM `phone_instas` WHERE `photo` = @photo', {
        ['@photo'] = photo
      }, function(status)
          if status > 0 then
            TriggerClientEvent('tqrp_phone:client:RemoveInsta', -1, photo)
            cb(true)
          else
            cb(false)
          end
      end)
end)

ESX.RegisterServerCallback('tqrp_phone:server:SumbitNewInsta', function(source, cb, data)
    local cData = getIdentity(source)
    local insta = {
        identifier = cData.identifier,
        author =  cData.firstname .. ' ' .. cData.lastname,
        descricao = data.desc,
        likes = 0,
        photo = data.img,
    }

    MySQL.Async.execute('INSERT INTO phone_instas (`identifier`, `author`, `descricao`, `photo`) VALUES (@identifier, @author, @descricao, @photo)', { 
        ['@identifier'] = insta.identifier, ['@author'] = insta.author, ['@descricao'] = insta.descricao, ['@photo'] = insta.photo}
      , function(status)
          if status > 0 then
              cb(true)
          else
              cb(false)
          end
        end)

    TriggerClientEvent('tqrp_phone:client:RecieveNewInsta', -1, insta)
end)

