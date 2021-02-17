ESX                           = nil
local ESXLoaded = false
local robbing = false

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    ESXLoaded = true
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local peds = {}
local objects = {}

RegisterNetEvent('loffe_robbery:onPedDeath')
AddEventHandler('loffe_robbery:onPedDeath', function(store)
    SetEntityHealth(peds[store], 0)
end)

RegisterNetEvent('loffe_robbery:msgPolice')
AddEventHandler('loffe_robbery:msgPolice', function(store, robber)
    local playerCoords = Config.Shops[store].coords
    DecorSetInt(PlayerPedId(), "IsOutlaw", 2)
    local streethash, crossinghash = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    TriggerServerEvent('tqrp_base:roblog','Assalto a uma Loja','Localização: '.. GetStreetNameFromHashKey(streethash) .. ' | ' .. GetStreetNameFromHashKey(crossinghash) .. '\nCoords: '.. playerCoords, 36124)
    TriggerServerEvent("tqrp_outlawalert:shoprobberyInProgress",
        Config.Shops[store].copjob, "Alarme Loja", "Desconhecido", "shopping_basket", "gps_fixed", 1,
        playerCoords.x, playerCoords.y, playerCoords.z, 119, 75, "10-90"
    )
end)

RegisterNetEvent('loffe_robbery:removePickup')
AddEventHandler('loffe_robbery:removePickup', function(bank)
    for i = 1, #objects do
        if objects[i].bank == bank and DoesEntityExist(objects[i].object) then
            DeleteObject(objects[i].object)
        end
    end
end)

RegisterNetEvent('loffe_robbery:robberyOver')
AddEventHandler('loffe_robbery:robberyOver', function()
    robbing = false
end)

RegisterNetEvent('loffe_robbery:talk')
AddEventHandler('loffe_robbery:talk', function(store, text, time)
    robbing = false
    local endTime = GetGameTimer() + 1000 * time
    while endTime >= GetGameTimer() do
        local x = GetEntityCoords(peds[store])
        DrawText3D(vector3(x.x, x.y, x.z + 1.0), text)
        Wait(0)
    end
end)

RegisterNetEvent('loffe_robbery:rob')
AddEventHandler('loffe_robbery:rob', function(i, ped)
    if not IsPedDeadOrDying(peds[i]) then
        SetEntityCoords(peds[i], Config.Shops[i].coords)
        loadDict('mp_am_hold_up')
        TaskPlayAnim(peds[i], "mp_am_hold_up", "holdup_victim_20s", 8.0, -8.0, -1, 2, 0, false, false, false)
        while not IsEntityPlayingAnim(peds[i], "mp_am_hold_up", "holdup_victim_20s", 3) do Wait(0) end
        local timer = GetGameTimer() + 10800
        while timer >= GetGameTimer() do
            if IsPedDeadOrDying(peds[i]) then
                break
            end
            Wait(0)
        end

        if not IsPedDeadOrDying(peds[i]) then
            local cashRegister = GetClosestObjectOfType(GetEntityCoords(peds[i]), 5.0, GetHashKey('prop_till_01'))
            if DoesEntityExist(cashRegister) then
                CreateModelSwap(GetEntityCoords(cashRegister), 0.5, GetHashKey('prop_till_01'), GetHashKey('prop_till_01_dam'), false)
            end

            timer = GetGameTimer() + 200
            while timer >= GetGameTimer() do
                if IsPedDeadOrDying(peds[i]) then
                    break
                end
                Wait(0)
            end

            local model = GetHashKey('prop_poly_bag_01')
            RequestModel(model)
            while not HasModelLoaded(model) do Wait(0) end
            local bag = CreateObject(model, GetEntityCoords(peds[i]), false, false)

            AttachEntityToEntity(bag, peds[i], GetPedBoneIndex(peds[i], 60309), 0.1, -0.11, 0.08, 0.0, -75.0, -75.0, 1, 1, 0, 0, 2, 1)
            timer = GetGameTimer() + 10000
            while timer >= GetGameTimer() do
                if IsPedDeadOrDying(peds[i]) then
                    break
                end
                Wait(0)
            end
            if not IsPedDeadOrDying(peds[i]) and PlayerPedId() == ped then
                DetachEntity(bag, true, false)
                timer = GetGameTimer() + 75
                while timer >= GetGameTimer() do
                    if IsPedDeadOrDying(peds[i]) then
                        break
                    end
                    Wait(0)
                end
                SetEntityHeading(bag, Config.Shops[i].heading)
                ApplyForceToEntity(bag, 3, vector3(0.0, 50.0, 0.0), 0.0, 0.0, 0.0, 0, true, true, false, false, true)
                table.insert(objects, {bank = i, object = bag})
                Citizen.CreateThread(function()
                    while true do
                        Wait(10)
                        if DoesEntityExist(bag) then
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(bag), true) <= 1.5 then
                                PlaySoundFrontend(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', true)
                                TriggerServerEvent('loffe_robbery:pickUp', i)
                                DeleteObject(bag)
                                break
                            end
                        else
                            break
                        end
                    end
                end)
            else
                DeleteObject(bag)
            end
        end
        loadDict('mp_am_hold_up')
        TaskPlayAnim(peds[i], "mp_am_hold_up", "cower_intro", 8.0, -8.0, -1, 0, 0, false, false, false)
        timer = GetGameTimer() + 2500
        while timer >= GetGameTimer() do Wait(0) end
        TaskPlayAnim(peds[i], "mp_am_hold_up", "cower_loop", 8.0, -8.0, -1, 1, 0, false, false, false)
        local stop = GetGameTimer() + 120000
        while stop >= GetGameTimer() do
            Wait(50)
        end
        if IsEntityPlayingAnim(peds[i], "mp_am_hold_up", "cower_loop", 3) then
            ClearPedTasks(peds[i])
        end
    end
end)

RegisterNetEvent('loffe_robbery:resetStore')
AddEventHandler('loffe_robbery:resetStore', function(i)
    while not ESXLoaded do Wait(0) end
    if DoesEntityExist(peds[i]) then
        DeleteEntity(peds[i])
    end
    Wait(250)
    --peds[i] = _CreatePed(Config.Shopkeeper, Config.Shops[i].coords, Config.Shops[i].heading)
    local brokenCashRegister = GetClosestObjectOfType(GetEntityCoords(peds[i]), 5.0, GetHashKey('prop_till_01_dam'))
    if DoesEntityExist(brokenCashRegister) then
        CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, GetHashKey('prop_till_01_dam'), GetHashKey('prop_till_01'), false)
    end
end)

function _CreatePed(hash, coords, heading)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(5)
    end

    local ped = CreatePed(4, hash, coords, false, false)
    SetEntityHeading(ped, heading)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetPedFleeAttributes(ped, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    return ped
end

local near = false
Citizen.CreateThread(function()
    while not ESXLoaded do Wait(0) end
    for i = 1, #Config.Shops do
        if Config.Shops[i].blip then
            local blip = AddBlipForCoord(Config.Shops[i].coords)
            SetBlipSprite(blip, 156)
            SetBlipColour(blip, 40)
            SetBlipScale(blip,0.6)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Shops[i].name)
            EndTextCommandSetBlipName(blip)
        end

        local brokenCashRegister = GetClosestObjectOfType(Config.Shops[i].coords, 5.0, GetHashKey('prop_till_01_dam'))
        if DoesEntityExist(brokenCashRegister) then
            CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, GetHashKey('prop_till_01_dam'), GetHashKey('prop_till_01'), false)
        end
    end

    while true do
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for i = 1, #Config.Shops, 1 do
            if #(coords - Config.Shops[i].coords) < 15 then
                if not DoesEntityExist(peds[i]) then
                    peds[i] = _CreatePed(Config.Shopkeeper, Config.Shops[i].coords, Config.Shops[i].heading)
                end
            else
                if DoesEntityExist(peds[i]) then
                    DeleteEntity(peds[i])
                end
            end
        end
        Citizen.Wait(2000)
    end
    --[[local model = GetHashKey('prop_poly_bag_01')
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    local object = CreateObject(model, GetEntityCoords(PlayerPedId()), false, false)
    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, -15.0, -62.0, 10.0, 1, 1, 0, 0, 2, 1)
    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, -15.0, -62.0, 10.0, 1, 1, 0, 0, 2, 1)
    Wait(2000)
    DeleteObject(object)
    Citizen.CreateThread(function()
        while true do
            for i = 1, #peds do
                if IsPedDeadOrDying(peds[i]) then
                    TriggerServerEvent('loffe_robbery:pedDead', i)
                    break
                end
            end
            Wait(5000)
        end
    end)]]
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local me = PlayerPedId()
        if IsPedArmed(me, 7) and IsPedOnFoot(me) then
            if IsPlayerFreeAiming(PlayerId()) and GetSelectedPedWeapon(me) ~= 0x3656C8C1 then
                for k, v in pairs(peds) do
                    local i = tonumber(k)
                    if HasEntityClearLosToEntityInFront(me, v, 19) and not IsPedDeadOrDying(v) and GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(v), true) <= 5.0 then
                        if not robbing then
                            local canRob = nil
                            local cops = nil
                            ESX.TriggerServerCallback('tqrp_base:getJobsOnline', function(ems, police, sheriff)
                                if Config.Shops[i].copJob == 'police' then
                                    cops = police
                                    print(cops)
                                else
                                    cops = sheriff
                                    print(cops)
                                end
                            end)
                            while cops == nil do
                                Citizen.Wait(100)
                            end
                            ESX.TriggerServerCallback('loffe_robbery:canRob', function(cb)
                                canRob = cb
                            end, i, cops)
                            while canRob == nil do
                                Wait(0)
                            end
                            if canRob == true then
                                TriggerServerEvent('loffe_robbery:alarm', i)
                                robbing = true
                                Citizen.CreateThread(function()
                                    while robbing do
                                        Wait(10)
                                        if IsPedDeadOrDying(v) then
                                            robbing = false
                                        end
                                    end
                                end)
                                loadDict('missheist_agency2ahands_up')
                                TaskPlayAnim(v, "missheist_agency2ahands_up", "handsup_anxious", 8.0, -8.0, -1, 1, 0, false, false, false)

                                local scared = 0
                                while scared < 100 and not IsPedDeadOrDying(v) and GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(v), true) <= 7.5 do
                                    local sleep = 8000
                                    SetEntityAnimSpeed(v, "missheist_agency2ahands_up", "handsup_anxious", 1.0)
                                    if IsPlayerFreeAiming(PlayerId()) then
                                        sleep = 1350
                                        SetEntityAnimSpeed(v, "missheist_agency2ahands_up", "handsup_anxious", 1.3)
                                    end
                                    if IsPedArmed(me, 4) and GetAmmoInClip(me, GetSelectedPedWeapon(me)) > 0 and IsControlPressed(0, 24) then
                                        sleep = 1000
                                        SetEntityAnimSpeed(v, "missheist_agency2ahands_up", "handsup_anxious", 1.7)
                                    end
                                    if IsPedShooting(me) then
                                        scared = 10.00
                                    end
                                    sleep = GetGameTimer() + sleep
                                    while sleep >= GetGameTimer() and not IsPedDeadOrDying(v) do
                                        Wait(7)
                                        DrawRect(0.5, 0.98, 0.2, 0.03, 75, 75, 75, 125)
                                        local draw = scared/500
                                        DrawRect(0.5, 0.98, draw, 0.03, 255, 0, 0, 250)
                                    end
                                    scared = scared + 0.75
                                end
                                if GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(v), true) <= 7.5 then
                                    if not IsPedDeadOrDying(v) then
                                        TriggerServerEvent('loffe_robbery:rob', i, me)
                                        while robbing do
                                            Wait(0)
                                            if IsPedDeadOrDying(v) then
                                                robbing = false
                                            end
                                        end
                                    end
                                else
                                    ClearPedTasks(v)
                                    local wait = GetGameTimer()+5000
                                    while wait >= GetGameTimer() do
                                        Wait(0)
                                        DrawText3D(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.4), Translation[Config.Locale]['walked_too_far'])
                                    end
                                    robbing = false
                                end
                            elseif canRob == 'no_cops' then
                                local wait = GetGameTimer()+5000
                                while wait >= GetGameTimer() do
                                    Wait(0)
                                    DrawText3D(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.4), Translation[Config.Locale]['no_cops'])
                                end
                            else
                                TriggerEvent('loffe_robbery:talk', i, '~g~*' .. Translation[Config.Locale]['shopkeeper'] .. '* ~w~' .. Translation[Config.Locale]['robbed'], 5)
                                Wait(2500)
                            end
                        end
                        near = true
                        break
                    else
                        near = false
                    end
                end
                if not near then
                    Citizen.Wait(1500)
                end
            else
                Citizen.Wait(1500)
            end
        else
            Citizen.Wait(1500)
        end
    end
end)

loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function DrawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.4, 0.4)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()

    AddTextComponentString(text)
    DrawText(_x, _y)
end