local PlayerData                = {}
ESX                             = nil
local notificationTable = {}
local myName = 'Desconhecido'
local waiteee = false
local called = false
local LastEntity
local LastVehicle
local colorNames = {
    ['0'] = "Preto Metálico",
    ['1'] = "Preto Grafite Metálico",
    ['2'] = "Preto Roubo Metálico  ",
    ['3'] = "Preto Escuro Metálico",
    ['4'] = "Prata Metálico",
    ['5'] = "Prata Azul Metálico",
    ['6'] = "Cinzento Aço Metálico",
    ['7'] = "Prata Sombra Metálica",
    ['8'] = "Prata Pedra Metálica",
    ['9'] = "Prata Meia-Noite Metálica",
    ['10'] = "Metal Arma Metálico",
    ['11'] = "Cinza Antracite Metálico",
    ['12'] = "Preto Fosco",
    ['13'] = "Cinza Fosco",
    ['14'] = "Cinza Claro Fosco",
    ['15'] = "Preto Util",
    ['16'] = "Preto Poli Util ",
    ['17'] = "Prata Escuro Util",
    ['18'] = "Prata util",
    ['19'] = "Metal Arma Metálico",
    ['20'] = "Prata Sombra Util",
    ['21'] = "Preto Vestido",
    ['22'] = "Desgastado Grafite",
    ['23'] = "Desgastado Cinza Prateado",
    ['24'] = "Prata Desgastado ",
    ['25'] = "Prata Azul Desgastado",
    ['26'] = "Prata Sombra Desgastado",
    ['27'] = "Vermelho Metálico",
    ['28'] = "Vermelho Torino Metálico",
    ['29'] = "Vermelho Fórmula Metálico",
    ['30'] = "Vermelho Chama Metálico",
    ['31'] = "Vermelho Gracioso Metálico",
    ['32'] = "Vermelho Granada Metálico",
    ['33'] = "Vermelho Deserto Metálico",
    ['34'] = "Vermelho Carbenet Metálico ",
	['35'] = "Vermelho Doce Metálico",
    ['36'] = "Laranja Nascer Do Sol Metálico",
    ['37'] = "Ouro Clássico Metálico",
    ['38'] = "Laranja Metálico",
    ['39'] = "Vermelho Fosco",
    ['40'] = "Vermelho Escuro Fosco",
    ['41'] = "Laranja Fosco",
    ['42'] = "Amarelho Fosco",
    ['43'] = "Vermelho Util",
    ['44'] = "Vermelho Brilhante Util",
    ['45'] = "Vermelho Garnet Util ",
    ['46'] = "Vermelho Desgastado",
    ['47'] = "Vermelho Dourado Desgastado",
    ['48'] = "Vermelho Escuro Desgastado",
    ['49'] = "Verde Eescuro Metálico",
    ['50'] = "Verde De Corrida Metálico",
    ['51'] = "Verde Mar Metálico",
    ['52'] = "Verde Azeitona Metálico",
    ['53'] = "Verde Metálico",
    ['54'] = "Verde Azul Gasolina Metálico",
    ['55'] = "Verde Lima Fosco",
    ['56'] = "Verde Escuro Util",
    ['57'] = "Verde Util",
    ['58'] = "Verde Escuro Desgastado",
    ['59'] = "Verde Desgastado",
    ['60'] = "Lavagem Do Mar Desgastado",
    ['61'] = "Azul Meia-Noite Desgastado",
    ['62'] = "Azul Escuro Metálico",
    ['63'] = "Azul Saxônia Metálico",
    ['64'] = "Azul Metálico",
    ['65'] = "Azul Marinheiro Metálico",
    ['66'] = "Azul Porto Metálico",
    ['67'] = "Azul Diamante Metálico",
    ['68'] = "Azul Surf Metálico",
    ['69'] = "Azul Náutico Metálico",
    ['70'] = "Azul Brilhante Metálico",
    ['71'] = "Azul Roxo Metálico",
    ['72'] = "Azul Spinnaker Metálico",
    ['73'] = "Azul Ultra Metálico",
    ['74'] = "Azul Brilhante Metálico",
    ['75'] = "Azul Escuro Util",
    ['76'] = "Azul Meia-Noite Util",
    ['77'] = "Azul Util",
    ['78'] = "Azul Mar Util",
    ['79'] = "Azul Relâmpago Util",
    ['80'] = "Azul Poli Marinho Util",
    ['81'] = "Azul Brilhante Util",
    ['82'] = "Azul Escuro Fosco",
    ['83'] = "Azul Fosco",
    ['84'] = "Azul Meia-Noite Fosco",
    ['85'] = "Azul Escuro Deesgastado",
    ['86'] = "Azul Desgastado",
    ['87'] = "Azul Claro Desgastado",
    ['88'] = "Amarelo Taxi Metálico",
    ['89'] = "Amarelo Corrida Metálico",
    ['90'] = "Bronze Metálico",
    ['91'] = "Amarelo Passaro Metálico",
	['92'] = "Lima Metálico",
    ['93'] = "Champagne Metálico",
    ['94'] = "Pueblo Bege Metálico",
    ['95'] = "Marfim Escuro Metálico",
    ['96'] = "Castanho Chocolate Metálico",
    ['97'] = "Marrom Dourado Metálico",
    ['98'] = "Castanho Claro Metálico",
    ['99'] = "Bege Palha Metálico",
    ['100'] = "Marrom Musgo Metálico",
    ['101'] = "Marrom Pistão Metálico",
    ['102'] = "Madeira Faia Metálico",
    ['103'] = "Madeira Faia Escura Metálica",
    ['104'] = "Laranja Choco Metálico",
    ['105'] = "Areia Praia Metálico",
    ['106'] = "Areia Sol Metálica",
    ['107'] = "Creme Metálica",
    ['108'] = "Castanho Desgastado",
    ['109'] = "Castanho Médio Desgastado",
    ['110'] = "Castanho Claro Desgastado",
    ['111'] = "Branco Metálico",
    ['112'] = "Branco Geada Metálico",
    ['113'] = "Bege Mel Desgastado",
    ['114'] = "Castanho Desgastado",
    ['115'] = "Castanho Escuro Desgastado",
    ['116'] = "Bege Palha Desgastado",
    ['117'] = "Aço Escovado",
    ['118'] = "Aço Preto Escovado",
    ['119'] = "Alumínio Escovado",
    ['120'] = "Chrome",
    ['121'] = "Branco",
    ['122'] = "Branco Desgastado",
    ['123'] = "Laranja Desgastado",
    ['124'] = "Laranja Claro Desgastado",
    ['125'] = "Verde Securicor Metálico",
    ['126'] = "Amarelo Taxi Desgastado",
    ['127'] = "Azul Carro da Polícia",
    ['128'] = "Verde Fosco",
    ['129'] = "Castanho Fosco",
    ['130'] = "Laranja Desgastado",
    ['131'] = "Branco Fosco",
    ['132'] = "Branco Desgastado",
    ['133'] = "Verde Exército Azeitona Desgastado",
    ['134'] = "Branco Puro",
    ['135'] = "Rosa Quente",
	['136'] = "Rosa Salmão",
    ['137'] = "Vermelho Rosa Metálico",
    ['138'] = "Laranja",
    ['139'] = "Verde",
    ['140'] = "Azul",
    ['141'] = "Preto Azul Metálico",
    ['142'] = "Preto Roxo Metálico",
    ['143'] = "Preto Vermelho Metálico",
    ['144'] = "Verde Caçador",
    ['145'] = "Roxo Metálico",
    ['146'] = "Azul Escuro V Metálico",
    ['147'] = "PRETO1 MODSHOP",
    ['148'] = "Roxo Fosco",
    ['149'] = "Roxo Escuro Fosco",
    ['150'] = "Vermelho Lava Metálico",
    ['151'] = "Verde Floresta Fosco",
    ['152'] = "OLive Fosco",
    ['153'] = "Castanho Deserto Fosco",
    ['154'] = "Bronzeado Deserto Fosco",
    ['155'] = "Verde Folhagem Fosco",
    ['156'] = "COR PADRÃO",
    ['157'] = "Azul Epsilon ",
}

local recoils = {}

local effects = {}

Citizen.CreateThread(function()

    while ESX == nil do

        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

        Citizen.Wait(0)

	end
	
    PlayerData = ESX.GetPlayerData()
    
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    TriggerServerEvent("tqrp_outlawalert:GetMyName")

end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local ped = PlayerPedId()
        if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) then
            if CheckWeapon(ped) then
                local playerCoords  = GetEntityCoords(ped, true)
                local RandomNPC     = GetClosestNPC()
                if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'sheriff' then
					if RandomNPC ~= nil then
                        local RandomNPcoords = GetEntityCoords(RandomNPC, true)
                        if GetDistanceBetweenCoords(playerCoords, RandomNPcoords, true) < 15.0 then
                            if canPedBeUsed(RandomNPC, false) then
                                if GetWeapontypeGroup(GetSelectedPedWeapon(ped)) == -728555052 then
                                    TriggerServerEvent("tqrp_outlawalert:server:NewAlert", 
                                        'police', 'sheriff', "Suspeito Armado", GetLabelFromWeapon(GetSelectedPedWeapon(ped)), "remove_red_eye", "gps_fixed", 1, 
                                        playerCoords.x, playerCoords.y, playerCoords.z, 313, 75, "10-61"
                                    )
                                else
                                    TriggerServerEvent("tqrp_outlawalert:server:NewAlert", 
                                    'police', 'sheriff', "Suspeito Armado", GetLabelFromWeapon(GetSelectedPedWeapon(ped)), "remove_red_eye", "gps_fixed", 1, 
                                    playerCoords.x, playerCoords.y, playerCoords.z, 313, 75, "10-60"
                                    )
                                end
                                Wait(10000)
                            end
                        end
                    end
                end
            end
        end
    end
end)

function loop()
    Citizen.CreateThread(function ()
        Citizen.Wait(7000)
        waiteee = false
    end)
end

function callCops()
    Citizen.CreateThread(function ()
        local ped = PlayerPedId()
        Citizen.Wait(2000)
        local rand = math.random(1, 100)
        if rand <= 100 then
            local vehicle = GetVehiclePedIsIn(ped, true)
            if vehicle then
                local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
                while plate == nil do
                    Citizen.Wait(100)
                end
               -- ESX.TriggerServerCallback('tqrp_outlawalert:isVehicleOwner', function(owner)
              --  	if owner == false then
                        local primary = GetVehicleColours(vehicle)
                        primary = colorNames[tostring(primary)]
                        local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                        vehicleLabel = GetLabelText(vehicleLabel)
                        local playerCoords = GetEntityCoords(ped)
                        TriggerServerEvent("tqrp_outlawalert:carJackInProgress", 
                            'police', "sheriff","Viatura Roubada", vehicleLabel .. " - " .. primary, "palette", "gps_fixed", 1, 
                            playerCoords.x, playerCoords.y, playerCoords.z, 225, 74, "10-17"
                        )
                        called = false
               -- 	end
              -- end, plate)
            end
        end
    end)
end


local weapons = {

    { name = 'WEAPON_MICROSMG', label = "Micro SMG"},
    { name = 'WEAPON_SMG', label = "SMG"},
    { name = 'WEAPON_PISTOL', label = "Taurus PT92AF"},
    { name = 'WEAPON_SNSPISTOL', label = "Heckler&Koch P7M10"},
    { name = 'WEAPON_ASSAULTSMG', label = "Assault SMG"},
    { name = 'WEAPON_ASSAULTRIFLE', label = "Rifle AK-47"},
    { name = 'WEAPON_CARBINERIFLE', label = "Rifle M4"},
    { name = 'WEAPON_ADVANCEDRIFLE', label = "Rifle avançada"},
    { name = 'WEAPON_MG', label = "Metralhadora"},
    { name = 'WEAPON_COMBATMG', label = "Metralhadora de combate"},
    { name = 'WEAPON_PUMPSHOTGUN', label = "Caçadeira"},
    { name = 'WEAPON_SAWNOFFSHOTGUN', label = "Caçadeira de Canos Serrados"},
    { name = 'WEAPON_ASSAULTSHOTGUN', label = "Caçadeira automática"},
    { name = 'WEAPON_BULLPUPSHOTGUN', label = "Caçadeira automática"},
    { name = 'WEAPON_SNIPERRIFLE', label = "Sniper"},
    { name = 'WEAPON_HEAVYSNIPER', label = "Sniper pesada"},
    { name = 'WEAPON_GRENADELAUNCHER', label = "Lançador de granada"},
    { name = 'WEAPON_RPG', label = "RPG"},
    { name = 'WEAPON_STINGER', label = "RPG"},
    { name = 'WEAPON_MINIGUN', label = "Minigun"},
    { name = 'WEAPON_SPECIALCARBINE', label = "Carabina especial"},
    { name = 'WEAPON_BULLPUPRIFLE', label = "Fuzil bullpup"},
    { name = 'WEAPON_MUSKET', label = "Musket"},
    { name = 'WEAPON_HEAVYSHOTGUN', label = "Caçadeira pesada"},
    { name = 'WEAPON_HEAVYPISTOL', label = "W.B 1911"},
    { name = 'WEAPON_MARKSMANRIFLE', label = "Rifle de elite"},
    { name = 'WEAPON_HOMINGLAUNCHER', label = "Lança-mísseis teleguiados"},
    { name = 'WEAPON_MARKSMANPISTOL', label = "Trabuco"},
    { name = 'WEAPON_MACHINEPISTOL', label = "Pistola metralhadora"},
    { name = 'WEAPON_REVOLVER', label = "Revolver"},
    { name = 'WEAPON_DBSHOTGUN', label = "Caçadeira DBS"},

}


function OpenNotifications()

    SetNuiFocus(true, true)
    SendNUIMessage({

        type = "openNotifications",

        notifications = notificationTable

    })

end

--RegisterCommand('limparAlertas', function()
--    DeleteNotifications()
--end)

function DeleteNotifications()
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "deleteNotifications",
        notifications = notificationTable
    })
end


function HideNotifications()

    SetNuiFocus(false, false)

    SendNUIMessage({

        type = "hideNotifications"

    })

end



function CheckWeapon(ped)

    for i = 1, #weapons do

        if GetHashKey(weapons[i].name) == GetSelectedPedWeapon(ped) then

            return true

        end

    end

    return false

end



function GetLabelFromWeapon(weapon)

    for i = 1, #weapons do

        if GetHashKey(weapons[i].name) == weapon then

            return weapons[i].label

        end

    end

    return false

end



function loadAnimDict( dict )

    while ( not HasAnimDictLoaded( dict ) ) do

        RequestAnimDict( dict )

        Citizen.Wait( 5 )

    end

end



function EnumeratePeds()

    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)

end



function EnumerateEntities(initFunc, moveFunc, disposeFunc)

    return coroutine.wrap(function()

        local iter, id = initFunc()

        if not id or id == 0 then

            disposeFunc(iter)

            return

        end

        

        local enum = {handle = iter, destructor = disposeFunc}

        setmetatable(enum, entityEnumerator)

        

        local next = true

        repeat

            coroutine.yield(id)

            next, id = moveFunc(iter)

        until not next

        

        enum.destructor, enum.handle = nil, nil

        disposeFunc(iter)

    end)

end



function GetNearbyPeds(X, Y, Z, Radius)

    local NearbyPeds = {}

    if tonumber(X) and tonumber(Y) and tonumber(Z) then

        if tonumber(Radius) then

            for Ped in EnumeratePeds() do

                if DoesEntityExist(Ped) then

                    local PedPosition = GetEntityCoords(Ped, false)

                    if Vdist(X, Y, Z, PedPosition.x, PedPosition.y, PedPosition.z) <= Radius then

                        table.insert(NearbyPeds, Ped)

                    end

                end

            end

        else

            Log.Warn("GetNearbyPeds was given an invalid radius!")

        end

    else

        Log.Warn("GetNearbyPeds was given invalid coordinates!")

    end

    return NearbyPeds

end



function GetOtherNPC(targetPed)

    local playerped = PlayerPedId()

    local playerCoords = GetEntityCoords(playerped)

    local handle, ped = FindFirstPed()

    local success

    local rped = nil

    local distanceFrom

    repeat

        local pos = GetEntityCoords(ped)

        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)

        if ped == targetPed and distance > 100.0 then

            distanceFrom = distance

            rped = ped

            success = false

        end

        success, ped = FindNextPed(handle)

    until not success

        EndFindPed(handle)

    return rped

end



function GetClosestNPC()

    local playerped = PlayerPedId()

    local playerCoords = GetEntityCoords(playerped)

    local handle, ped = FindFirstPed()

    local success

    local rped = nil

    local distanceFrom

    repeat

        local pos = GetEntityCoords(ped)

        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)

        if canPedBeUsed(ped, true) and distance < 100.0 and (distanceFrom == nil or distance < distanceFrom) then

            distanceFrom = distance

            rped = ped

            success = false

        end

        success, ped = FindNextPed(handle)

    until not success

        EndFindPed(handle)

    return rped

end



function canPedBeUsed(ped, fresh)

    if ped == nil then

        return false

    end



    if ped == PlayerPedId() then

        return false

    end



    if not DoesEntityExist(ped) then

        return false

    end



    if IsPedAPlayer(ped) then

        return false

    end



    if IsPedFatallyInjured(ped) then

        return false

    end



    if IsPedFleeing(ped) then

        return false

    end



    if IsPedInCover(ped) or IsPedGoingIntoCover(ped) or IsPedGettingUp(ped) then

        return false

    end



    if IsPedInMeleeCombat(ped) then

        return false

    end



    if IsPedShooting(ped) then

        return false

    end



    if IsPedDucking(ped) then

        return false

    end



    if IsPedBeingJacked(ped) then

        return false

    end



    if IsPedSwimming(ped) then

        return false

    end



    local pedType = GetPedType(ped)

    if pedType == 6 or pedType == 27 or pedType == 29 or pedType == 28 then

        return false

    end



    return true

end



RegisterNUICallback('close', function(data, cb)

    HideNotifications()

end)



RegisterNUICallback('createBlip', function(data, cb)

    local id = data.id

    local info = notificationTable[tonumber(id)]

    HideNotifications()

    

    if info.MapBlip ~= nil then

    	RemoveBlip(info.MapBlip)

    end

    local alpha = 255

    local blip = AddBlipForCoord(info.x, info.y, info.z)

    SetBlipRoute(blip, true)

    SetBlipSprite(blip,  info.blipID)

    SetBlipAlpha(blip,  alpha)

    SetBlipAsShortRange(blip, 0)

    SetBlipScale(blip, 2.0)

    SetBlipColour(blip, info.color)

    BeginTextCommandSetBlipName("STRING")

    AddTextComponentString("["..info.number.."] "..info.title)

    EndTextCommandSetBlipName(blip)


    notificationTable[tonumber(id)].MapBlip = blip



    while alpha ~= 0 do

        Wait(500)

        alpha = alpha - 1

        SetBlipAlpha(blip,  alpha)

        if alpha == 0 then

            SetBlipSprite(blip, 2)

            RemoveBlip(blip)

            return

        end

    end

end)



RegisterNUICallback('deleteAlert', function(data, cb)

	if DoesBlipExist(notificationTable[tonumber(data.id)].MapBlip) then

		RemoveBlip(notificationTable[tonumber(data.id)].MapBlip)

		SetBlipRoute(notificationTable[tonumber(data.id)].MapBlip, false)

	end



    table.remove(notificationTable, tonumber(data.id))

end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

    PlayerData.job = job

end)

RegisterCommand('panic', function(src, args, raw)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'sheriff' then
        local coord  = GetEntityCoords(PlayerPedId(), true)
        TriggerServerEvent("tqrp_outlawalert:sendPanic", 'police', 'ambulance', 'sheriff',"Botão Pânico", myName, "person", "gps_fixed", 1, coord.x, coord.y, coord.z, 480, 75, "10-99")
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'Panic', 1.0)
        --RequestAnimDict("mini@safe_cracking")
    end
end)

RegisterCommand('911', function(src, args, raw)
    if args[1] ~= nil then
        local coord  = GetEntityCoords(PlayerPedId(), true)
        if #(myName .. " - " .. raw:sub(4)) <= 50 then
            message = myName .. " - " .. raw:sub(4)
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1.0, '911', 0.4)
            exports['mythic_progbar']:Progress({
                name = "chamada_911",
                duration = 10000,
                label = "A fazer queixinhas a DPLS",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "cellphone@",
                    anim = "cellphone_call_listen_base",
                    flags = 49,
                },
                prop = {
                    model = "prop_npc_phone_02",
                    bone = 58866,
                    coords = { x = 0.075, y = -0.045, z = -0.020 },
                    rotation = { x = 100.0, y = 0.0, z = 50.0 },
                },
            }, function(status)
                if not status then
                    TriggerServerEvent("tqrp_outlawalert:send911", 'police', 'ambulance', 'sheriff', "Central 911", message, "person", "gps_fixed", 1, coord.x, coord.y, coord.z, 480, 75, "911")
                    exports["mythic_notify"]:SendAlert("success", "Pedido de ajuda enviado com sucesso")        
                end
            end)
        else
            exports["mythic_notify"]:SendAlert("error", "Insere um motivo mais curto")
        end
    else
        exports["mythic_notify"]:SendAlert("error", "Insere um motivo")
    end
end)

RegisterCommand('mec', function(src, args, raw)
    if args[1] ~= nil then
        local coord  = GetEntityCoords(PlayerPedId(), true)
        if #(myName .. " - " .. raw:sub(4)) <= 60 then
            message = myName .. " - " .. raw:sub(4)
            TriggerServerEvent("tqrp_outlawalert:sendmecanicos", 'mechanic', 'mechanic2', "Central Seguros", message, "person", "gps_fixed", 1, coord.x, coord.y, coord.z, 106, 75, "Benny´s")
            exports["mythic_notify"]:SendAlert("success", "Pedido de ajuda enviado com sucesso")
        else
            exports["mythic_notify"]:SendAlert("error", "Insere um motivo mais curto")
        end
    else
        exports["mythic_notify"]:SendAlert("error", "Insere um motivo")
    end
end)
--[[
RegisterCommand('sem', function(src, args, raw)
    if args[1] ~= nil then
        local coord  = GetEntityCoords(PlayerPedId(), true)
        if #(myName .. " - " .. raw:sub(4)) <= 50 then
            message = myName .. " - " .. raw:sub(4)
            TriggerServerEvent("tqrp_outlawalert:send911", nil, 'ambulance', "Central 911", message, "person", "gps_fixed", 1, coord.x, coord.y, coord.z, 480, 75, "911")
            exports["mythic_notify"]:SendAlert("success", "Pedido de ajuda enviado com sucesso")
        else
            exports["mythic_notify"]:SendAlert("error", "Insere um motivo mais curto")
        end
    else
        exports["mythic_notify"]:SendAlert("error", "Insere um motivo")
    end
end)]]

function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()

	if useMilitaryTime == false then
		if hour == 0 or hour == 24 then
			hour = 12
		elseif hour >= 13 then
			hour = hour - 12
		end
	end

	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end

RegisterNetEvent('tqrp_outlawalert:setMyName')
AddEventHandler('tqrp_outlawalert:setMyName', function(name)

    if name ~= nil then

        myName = name

    end

end)

RegisterNetEvent('tqrp_outlawalert:exportName')
AddEventHandler('tqrp_outlawalert:exportName', function(cb)
    cb(myName)
end)

local codes = {
    [1] = {code = "10-99", level = 1},
    [2] = {code = "10-90", level = 1},
    [3] = {code = "10-13", level = 1},
    [4] = {code = "10-10", level = 2},
    [5] = {code = "10-17", level = 2},
    [6] = {code = "10-60", level = 2},
    [6] = {code = "10-61", level = 2},
    [7] = {code = "911", level = 3},
    [8] = {code = "10-17A", level = 2},
    [9] = {code = "Benny´s", level = 3},
}

function getLevel(code)
    for k,v in pairs(codes) do
        if v.code == code then
            return v.level
        end
    end
    return 3
end

RegisterNetEvent('tqrp_outlawalert:NewAlert')
AddEventHandler('tqrp_outlawalert:NewAlert', function(job, title, desc, emote, emote2, number, x, y, z, blipID, color, code)

    if PlayerData.job ~= nil and PlayerData.job.name == job then

        local Level = getLevel(code)
        if Level == 1 then
            PlaySoundFrontend(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 1)
        elseif Level == 2 then
            PlaySoundFrontend( -1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
        elseif Level == 3 then
            --PlaySoundFrontend(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", 1)
            TriggerEvent('InteractSound_CL:PlayOnOne',"pop", 0.2)
        end

        local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(x, y, z))
        CalculateTimeToDisplay()
        table.insert(notificationTable, {

            title = title,

            desc = desc,

            time = hour .. ":" .. minute,

            emote = emote,

            emote2 = emote2,

            street = streetName,

            number = number,

            x = x,

            y = y,

            z = z,

            blipID = blipID,

            color = color,

            code = code,

            level = Level

        })


	    local alpha = 255

	    local blip = AddBlipForCoord(x, y, z)

	    SetBlipSprite(blip,  blipID)

	    SetBlipAlpha(blip,  alpha)

	    SetBlipAsShortRange(blip, 0)

	    SetBlipScale(blip, 2.0)

	    SetBlipColour(blip, color)

	    BeginTextCommandSetBlipName("STRING")

	    AddTextComponentString("["..number.."] "..title)

	    EndTextCommandSetBlipName(blip)


	    notificationTable[#notificationTable].MapBlip = blip

        SendNUIMessage({

            type = "newNotifications",

            notifications = notificationTable[#notificationTable]

        })

	    while alpha ~= 0 do

	        Wait(500)

	        alpha = alpha - 1

	        SetBlipAlpha(blip,  alpha)

	        if alpha == 0 then

	            SetBlipSprite(blip, 2)

	            RemoveBlip(blip)

	            return

	        end

	    end


    end

end)

RegisterCommand('notimenu', function(source)
    TriggerEvent('tqrp_outlaw:openMenu')
end)

RegisterNetEvent('tqrp_outlaw:openMenu')
AddEventHandler('tqrp_outlaw:openMenu', function()

    if #notificationTable > 0 then

		OpenNotifications()

	end

end)

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end) -- Fix RAM leaks by collecting garbage