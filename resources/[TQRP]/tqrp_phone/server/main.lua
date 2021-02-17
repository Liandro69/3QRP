ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AppData = {}
Callbacks = nil
Cache = nil

function RegisterData(source, key, data)
    if AppData[source] ~= nil then
        AppData[source].key = data
    else
        AppData[source] = {}
        AppData[source].key = data
    end
end

ESX.RegisterServerCallback('tqrp_phone:getItemAmount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getInventoryItem(item).count)
end)

ESX.RegisterServerCallback('tqrp_phone:server:GetPhoneNumber', function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[1]
    cb(getNumberPhone(identifier))
end)

ESX.RegisterServerCallback('tqrp_phone:getOtherPlayerData', function(source, cb)
        local player = ESX.GetPlayerFromId(source)
        local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height, phone_number FROM users WHERE identifier = @identifier', {
            ['@identifier'] = player.identifier
        })

        local firstname = result[1].firstname
        local lastname  = result[1].lastname
        local height    = result[1].height
        local sex       = result[1].sex
        local dob       = result[1].dateofbirth
        local height    = result[1].height
        local phone_number    = result[1].phone_number

        local data = {
            name      = GetPlayerName(player),
            job       = player.job,
            inventory = player.inventory,
            accounts  = player.accounts,
            weapons   = player.loadout,
            firstname = firstname,
            lastname  = lastname,
            sex       = sex,
            dob       = dob,
            height    = height,
            phone_number = phone_number
        }

            cb(data)

end)

function getIdentity(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        local job =  xPlayer.getJob()
        local identifier = GetPlayerIdentifiers(source)[1]
        local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
        if result[1] ~= nil then
            local identity = result[1]
            return {
                identifier = identity['identifier'],
                firstname = identity['firstname'],
                lastname = identity['lastname'],
                dateofbirth = identity['dateofbirth'],
                sex = identity['sex'],
                height = identity['height'],
                phone_number = identity['phone_number'],
                money =  identity['money'],
                bank = identity['bank'],
                job = job.label .. " - " .. job.grade_label
                
            }
        else
            return nil
        end
    else 
        return nil
    end
end

RegisterServerEvent('tqrp_phone:server:SetupApps')
AddEventHandler('tqrp_phone:server:SetupApps', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local cData = getIdentity(src)
    TriggerClientEvent('tqrp_phone:client:SetupData', src, {
        { name = 'myData', data = {
            id = xPlayer.identifier,
            name = cData.firstname .. ' ' .. cData.lastname,
            phone = cData.phone_number
        }},
        { name = 'apps', data = Config.Apps }
    })
end)

RegisterServerEvent('tqrp_phone:server:giveNumber')
AddEventHandler('tqrp_phone:server:giveNumber', function(num, target)
    TriggerClientEvent('tqrp_phone:client:showNumToMe', tonumber(target), num)
end)



RegisterServerEvent('tqrp_phone:server:SetupInfo')
AddEventHandler('tqrp_phone:server:SetupInfo', function()
    local src = source
    local cData = getIdentity(src)

    TriggerClientEvent('tqrp_phone:client:SetupData', src, { { name = 'firstname', data = cData.firstname } })
    TriggerClientEvent('tqrp_phone:client:SetupData', src, { { name = 'lastname', data = cData.lastname } })
    TriggerClientEvent('tqrp_phone:client:SetupData', src, { { name = 'myNumber', data = cData.phone_number } })
    TriggerClientEvent('tqrp_phone:client:SetupData', src, { { name = 'money', data = cData.money} })
    TriggerClientEvent('tqrp_phone:client:SetupData', src, { { name = 'bank', data = cData.bank} })
    TriggerClientEvent('tqrp_phone:client:SetupData', src, { { name = 'job', data = cData.job} })
end)



ESX.RegisterServerCallback('tqrp_phone:server:RegisterData', function(source, cb, data)
    RegisterData(source, data.key, data.data)
    cb(true)
end)

ESX.RegisterServerCallback('tqrp_phone:server:GetData', function(source, cb, data)
    cb(AppData[source][data.key])
end)

--====================================================================================
--  Utils
--====================================================================================
function getNumberPhone(identifier)
    local result = MySQL.Sync.fetchScalar("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result ~= nil then
        return result
    end
    return nil
end
function getIdentifierByPhoneNumber(phonenumber) 
    local result = MySQL.Sync.fetchScalar("SELECT users.identifier FROM users WHERE users.phone_number = @phone_number", {
        ['@phone_number'] = phonenumber
    })
    if result ~= nil then
        return result
    end
    return nil
end


function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

math.randomseed(os.time())

--- Pour les numero du style XXX-XXXX
function getPhoneRandomNumber()
    local numBase0 = math.random(91,98)
    local numBase1 = math.random(0,9999999)
    local num = string.format("%d%07d", numBase0, numBase1)
    return num
end


function getOrGeneratePhoneNumber(sourcePlayer, identifier, cb)
    local sourcePlayer = sourcePlayer
    local identifier = identifier
    local myPhoneNumber = getNumberPhone(identifier)
    if myPhoneNumber == '0' or myPhoneNumber == nil then
        repeat
            myPhoneNumber = getPhoneRandomNumber()
            local id = getIdentifierByPhoneNumber(myPhoneNumber)
        until id == nil
        MySQL.Async.insert("UPDATE users SET phone_number = @myPhoneNumber WHERE identifier = @identifier", { 
            ['@myPhoneNumber'] = myPhoneNumber,
            ['@identifier'] = identifier
        }, function ()
            cb(myPhoneNumber)
        end)
    else
        cb(myPhoneNumber)
    end
end

AddEventHandler('es:playerLoaded',function(source)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    getOrGeneratePhoneNumber(sourcePlayer, identifier, function (myPhoneNumber)
    end)
end)