Whitelist = {}

-- Check if player is whitelisted
AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
    deferrals.defer()

    local source = source

    deferrals.update(_U('whitelist_check'))

    Citizen.Wait(300)

    local Identifiers = GetPlayerIdentifiers(source)
    
    if not has_value(Whitelist, Identifiers[1]) and not has_value(Whitelist, Identifiers[2]) then
        deferrals.done(_U('not_whitelisted'))
        CancelEvent()
        return
    else
        deferrals.done()
    end
end)

-- Load Whitelist
function initWhitelist()
    MySQL.Async.fetchAll('SELECT identifier FROM whitelist', {}, function(result)
        for i = 1, #result, 1 do
            table.insert(Whitelist, tostring(result[i].identifier):lower())
        end
    end)
end

-- Validate if table got identifier
function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    
    return false
end

-- Loads Whitelist when MySQL is ready
MySQL.ready(function()
    initWhitelist()
end)
