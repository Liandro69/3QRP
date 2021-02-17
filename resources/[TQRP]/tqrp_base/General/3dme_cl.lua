
local color = { r = 255, g = 255, b = 255, alpha = 255 }
local displayingDo = false
local time = 7000
local chatMessage = false
local nbrDisplaying = 1

RegisterCommand('me', function(source, args)
    local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ''
    TriggerServerEvent('3dme:shareDisplay', text, "me")
end)

RegisterCommand('do', function(source, args)
    displayingDo = false
    local text = '~r~AÇÃO | ~w~'
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ''
    TriggerServerEvent('3dme:shareDisplay', text, "do")
end)

RegisterCommand('undo', function(source, args)
    TriggerServerEvent('3dme:shareDisplay', 'null', "clear")
end)

RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source, type)
    local offset = -0.2 + (nbrDisplaying*0.08)
    if type == 'me' then
        DisplayMe(GetPlayerFromServerId(source), text, offset)
    elseif type == 'do' then
        DisplayDo(GetPlayerFromServerId(source), text, offset)
    elseif type == 'tentar' then
        DisplayMe(GetPlayerFromServerId(source), text, offset)
    elseif type == 'clear' then
        displayingDo = false
    end
end)

function DisplayMe(mePlayer, text, offset)
    local displayingMe = true

    if chatMessage then
        local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
        local coords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist2(coordsMe, coords)
        if dist < 2500 then
            TriggerEvent('chat:addMessage', {
                color = { color.r, color.g, color.b },
                multiline = true,
                args = { text}
            })
        end
    end

    Citizen.CreateThread(function()
        Wait(time)
        displayingMe = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displayingMe do
            Wait(7)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 2500 then
                DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DisplayDo(mePlayer, text, offset)
    displayingDo = true

    if chatMessage then
        local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
        local coords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist2(coordsMe, coords)
        if dist < 2500 then
            TriggerEvent('chat:addMessage', {
                color = { color.r, color.g, color.b },
                multiline = true,
                args = { text}
            })
        end
    end

    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displayingDo do
            Wait(7)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 2500 then
                DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)

end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    local scale = 0.30

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
--end

RegisterCommand('tentar', function(source, args)
    local ptr = math.random(1,2)
    if ptr == 1 then
        msg = ' ~g~Conseguiu~s~'
    else
        msg = ' ~r~Não conseguiu~s~'
    end
    local text = ' ' .. msg
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. '  '
    TriggerServerEvent('3dme:shareDisplay', text, "tentar")
end)