ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local isPlayerLoaded        = true
local waitDrawShopsP = 5
local shopsP = {
    { ['x'] = 412.08427734375, ['y'] = 315.0219238281, ['z'] = 103.1362744903564},
}
local onSelling = false
local sellNPCpos = {
 [1] = { ['x'] = -1797.53, ['y'] = -497.27, ['z'] = 38.76, ['h'] = 314.29, ['modelHash'] = 'g_m_y_lost_02'},
 [2] = { ['x'] = -1647.03, ['y'] = -1078.97, ['z'] = 13.16, ['h'] = 217.62, ['modelHash'] = 'cs_taocheng'},
 [3] = { ['x'] = -1079.33, ['y'] = -1678.82, ['z'] = 4.58, ['h'] = 307.95, ['modelHash'] = 'a_m_m_soucent_01'},
 [4] = { ['x'] = -764.58, ['y'] = -1316.67, ['z'] = 5.15, ['h'] = 231.68, ['modelHash'] = 'a_m_m_mexlabor_01'},
 [5] = { ['x'] = -551.03, ['y'] = -1791.35, ['z'] = 22.29, ['h'] = 61.31, ['modelHash'] = 'u_m_y_tattoo_01'},
 [6] = { ['x'] = -277.59, ['y'] = -1679.7, ['z'] = 31.85, ['h'] = 332.89, ['modelHash'] = 'u_m_y_party_01'},
 [7] = { ['x'] = 96.06, ['y'] = -1809.21, ['z'] = 27.08, ['h'] = 224.72, ['modelHash'] = 's_m_y_robber_01'},
 [8] = { ['x'] = 86.82, ['y'] = -1671.48, ['z'] = 29.15, ['h'] = 78.37, ['modelHash'] = 's_m_m_autoshop_01'},
 [9] = { ['x'] = 369.52, ['y'] = -1854.54, ['z'] = 27.66, ['h'] = 49.11, ['modelHash'] = 'ig_ortega'},
 [10] = { ['x'] = 477.84, ['y'] = -1397.67, ['z'] = 31.04, ['h'] = 177.06, ['modelHash'] = 's_m_y_robber_01'},
 [11] = { ['x'] = 21.38, ['y'] = -1102.95, ['z'] = 38.15, ['h'] = 351.22, ['modelHash'] = 'g_m_y_lost_02'},
 [12] = { ['x'] = -54.94, ['y'] = -1226.44, ['z'] = 28.74, ['h'] = 44.86, ['modelHash'] = 'u_m_y_party_01'},
 [13] = { ['x'] = 156.93, ['y'] = -1190.24, ['z'] = 29.51, ['h'] = 179.39, ['modelHash'] = 'csb_ballasog'},
 [14] = { ['x'] = 214.21, ['y'] = -922.43, ['z'] = 30.69, ['h'] = 52.27, ['modelHash'] = 'g_m_y_ballaeast_01'},
 [15] = { ['x'] = 508.07, ['y'] = -553.48, ['z'] = 24.75, ['h'] = 176.13, ['modelHash'] = 'g_m_y_mexgang_01'},
 [16] = { ['x'] = 21.6, ['y'] = -390.05, ['z'] = 39.57, ['h'] = 64.43, ['modelHash'] = 'ig_ramp_gang'},
 [17] = { ['x'] = 322.05, ['y'] = -146.99, ['z'] = 64.56, ['h'] = 159.96, ['modelHash'] = 'g_m_y_korean_01'},
 [18] = { ['x'] = -120.73, ['y'] = -20.46, ['z'] = 58.32, ['h'] = 160.36, ['modelHash'] = 'g_m_y_ballasout_01'},
 [19] = { ['x'] = 135.28, ['y'] = 323.13, ['z'] = 116.63, ['h'] = 119.94, ['modelHash'] = 'g_m_y_azteca_01'},
 [20] = { ['x'] = -29.72, ['y'] = 325.56, ['z'] = 113.16, ['h'] = 339.13, ['modelHash'] = 'g_m_y_famca_01'},
 [21] = { ['x'] = -676.18, ['y'] = 401.13, ['z'] = 101.26, ['h'] = 290.01, ['modelHash'] = 'g_m_y_lost_02'},
 [22] = { ['x'] = -777.1, ['y'] = 892.6, ['z'] = 203.4, ['h'] = 138.21, ['modelHash'] = 'cs_taocheng'},
 [23] = { ['x'] = -1366.77, ['y'] = 58.91, ['z'] = 54.1, ['h'] = 105.32, ['modelHash'] = 'a_m_m_soucent_01'},
 [24] = { ['x'] = -1194.33, ['y'] = -250.52, ['z'] = 37.95, ['h'] = 337.42, ['modelHash'] = 'a_m_m_mexlabor_01'},
 [25] = { ['x'] = -1336.73, ['y'] = -627.77, ['z'] = 28.62, ['h'] = 212.43, ['modelHash'] = 'u_m_y_tattoo_01'},
 [26] = { ['x'] = -1000.77, ['y'] = -1064.61, ['z'] = 2.17, ['h'] = 213.4, ['modelHash'] = 'u_m_y_party_01'},
 [27] = { ['x'] = -710.76, ['y'] = -1030.12, ['z'] = 16.11, ['h'] = 301.73, ['modelHash'] = 's_m_y_robber_01'},
 [28] = { ['x'] = -590.61, ['y'] = -280.0, ['z'] = 35.45, ['h'] = 210.78, ['modelHash'] = 's_m_m_autoshop_01'},
 [29] = { ['x'] = 1070.99, ['y'] = -711.44, ['z'] = 58.47, ['h'] = 224.2, ['modelHash'] = 'ig_ortega'},
 [30] = { ['x'] = 1330.64, ['y'] = -1658.99, ['z'] = 51.24, ['h'] = 130.8, ['modelHash'] = 's_m_y_robber_01'},
 [31] = { ['x'] = 1260.16, ['y'] = -2571.65, ['z'] = 42.82, ['h'] = 10.07, ['modelHash'] = 'g_m_y_lost_02'},
 [32] = { ['x'] = 975.48, ['y'] = -2558.83, ['z'] = 31.82, ['h'] = 176.38, ['modelHash'] = 'u_m_y_party_01'},
 [33] = { ['x'] = 765.76, ['y'] = -3191.42, ['z'] = 6.04, ['h'] = 268.76, ['modelHash'] = 'csb_ballasog'},
 [34] = { ['x'] = -63.0, ['y'] = -2443.55, ['z'] = 6.0, ['h'] = 325.23, ['modelHash'] = 'g_m_y_ballaeast_01'},
 [35] = { ['x'] = -421.57, ['y'] = -2170.93, ['z'] = 11.34, ['h'] = 357.84, ['modelHash'] = 'g_m_y_mexgang_01'},
 [36] = { ['x'] = 103.88, ['y'] = -1713.87, ['z'] = 30.11, ['h'] = 320.12, ['modelHash'] = 'ig_ramp_gang'},
 [37] = { ['x'] = -56.8, ['y'] = -1494.66, ['z'] = 31.72, ['h'] = 142.15, ['modelHash'] = 'g_m_y_korean_01'},
 [38] = { ['x'] = -38.33, ['y'] = -1752.86, ['z'] = 29.49, ['h'] = 234.64, ['modelHash'] = 'g_m_y_ballasout_01'},
 [39] = { ['x'] = 236.55, ['y'] = -1947.22, ['z'] = 23.01, ['h'] = 318.87, ['modelHash'] = 'g_m_y_azteca_01'},
 [40] = { ['x'] = 1166.46, ['y'] = -1377.72, ['z'] = 34.92, ['h'] = 323.32, ['modelHash'] = 'g_m_y_famca_01'},
}

function loadAnimDict( dict )
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function DrawText3DWeed(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local scale = 0.30
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function givePackageAnim(item, count)
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    local bone = GetPedBoneIndex(ped, 28422)
    loadAnimDict("mp_safehouselost@")
    if IsEntityPlayingAnim(ped, "mp_safehouselost@", "package_dropoff", 3) then
        TaskPlayAnim(ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
    else
        TaskPlayAnim(ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
    end
    Wait(500)
    local packageProp = CreateObject(GetHashKey('prop_drug_package_02'), coords.x, coords.y, coords.z, 1, 1, 1)
    AttachEntityToEntity(packageProp, ped, bone, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
    print(item)
    TriggerServerEvent('tqrp_runs:removeitem', item, count)
    DeleteObject(packageProp)
end

function giveMoneyAnimPed(ped, price)
    ClearPedTasksImmediately(ped)
    local coords = GetEntityCoords(ped)
    local bone = GetPedBoneIndex(ped, 28422)
    loadAnimDict("mp_safehouselost@")
    TaskPlayAnim(ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
    SetEntityAsMissionEntity(ped, 1, 1)
    Wait(500)
    local moneyObject = CreateObject(GetHashKey('p_banknote_onedollar_s'), coords.x, coords.y, coords.z, 1, 1, 1)
    AttachEntityToEntity(moneyObject, ped, bone, 0.0, 0.0, 0.0, 80.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
    Wait(4000)
    TriggerServerEvent("tqrp_runs:addmoney", price)
    DeleteObject(moneyObject)
    SetEntityAsMissionEntity(ped, 0, 0)
end


CreateThread(function()
    while true do
        if isPlayerLoaded then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            for k,v in pairs(shopsP) do
                if GetDistanceBetweenCoords(coords, shopsP[k].x, shopsP[k].y, shopsP[k].z, false) < 35.0 then
                    if GetDistanceBetweenCoords(coords, shopsP[k].x, shopsP[k].y, shopsP[k].z, false) < 4.0 then
                        DrawText3DWeed(shopsP[k].x, shopsP[k].y, shopsP[k].z, "~g~[E]~w~ vender")
                        if GetDistanceBetweenCoords(coords, shopsP[k].x, shopsP[k].y, shopsP[k].z, false) < 2.0 then
                            if (IsControlPressed(1, 38)) then
                                local hour = GetClockHours()
                                 --entre as 22h e 7h da manhã
                                if hour > 6 and hour < 22 then
                                    ESX.TriggerServerCallback('tqrp_runs:getItemsToSell', function (cb)
                                        if cb ~= false then
                                            print(cb.name)
                                            print(cb.price)
                                            print(cb.count)
                                            exports['mythic_notify']:SendAlert('inform', "Não posso comprar esses produtos. Vou ver se consigo alguém para te comprar isso, fica atento e boa sorte!")
                                            TriggerEvent("tqrp_runs:startSellingItems")
                                        else
                                            exports['mythic_notify']:SendAlert('error', "Não tens nenhum produto para vender")
                                        end
                                    end)
                                    Wait(2500)
                                else
                                    exports['mythic_notify']:SendAlert('error', "Loja fechada")
                                    Wait(2500)
                               end
                            end
                        end
                    end
                    waitDrawShopsP = 5
                    break
                else
                    waitDrawShopsP = 10000
                end
            end
        end
        Wait(waitDrawShopsP)
    end
end)

RegisterNetEvent('tqrp_runs:startSellingItems')
AddEventHandler('tqrp_runs:startSellingItems', function()
    local wait = math.random(100000,200000)
    Wait(wait)
    if not onSelling then
        ESX.TriggerServerCallback('tqrp_runs:getItemsToSell', function (cb)
            if cb ~= false then
                TriggerEvent("tqrp_runs:sellToRandomNPC")
            end
        end)
    end
end)

RegisterNetEvent('tqrp_runs:sellToRandomNPC')
AddEventHandler('tqrp_runs:sellToRandomNPC', function()
    onSelling = true
    local num = math.random(1, #sellNPCpos)
    local blip = AddBlipForCoord(sellNPCpos[num].x, sellNPCpos[num].y, sellNPCpos[num].z)
    SetBlipSprite(blip,  364)
    SetBlipAsShortRange(blip,  0)
    SetBlipScale(blip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Comprador")
    EndTextCommandSetBlipName(blip)
    CreateThread(function()
        while true do
            Wait(5)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if GetDistanceBetweenCoords(coords, sellNPCpos[num].x, sellNPCpos[num].y, sellNPCpos[num].z, false) < 50.0 then
                if not DoesEntityExist(sellNPC) then
                    RequestModel(sellNPCpos[num].modelHash)
                    while not HasModelLoaded(sellNPCpos[num].modelHash) do
                        Citizen.Wait(1)
                    end
                    sellNPC = CreatePed(2, sellNPCpos[num].modelHash, sellNPCpos[num].x, sellNPCpos[num].y, sellNPCpos[num].z, sellNPCpos[num].h, true, true)
                    SetPedFleeAttributes(sellNPC, 0, 0)
                    SetPedDropsWeaponsWhenDead(sellNPC, false)
                    SetPedDiesWhenInjured(sellNPC, false)
                    SetRelationshipBetweenGroups(0, GetPedRelationshipGroupHash(sellNPC), GetPedRelationshipGroupHash(GetPlayerPed(-1)))
                end
            end
            if GetDistanceBetweenCoords(coords, sellNPCpos[num].x, sellNPCpos[num].y, sellNPCpos[num].z, false) < 2.0 then
                local npcCoords = GetEntityCoords(sellNPC)
                local ammount = math.random(1,3)
                DrawText3DWeed(npcCoords.x, npcCoords.y, npcCoords.z, "~g~[E]~w~ vender")
                if (IsControlPressed(1, 38)) then
                    ESX.TriggerServerCallback('tqrp_runs:getItemsToSell', function (cb)
                        if cb ~= false then
                            TaskLookAtEntity(sellNPC,GetPlayerPed(-1), 5500.0, 2048, 3)
                            TaskTurnPedToFaceEntity(sellNPC, GetPlayerPed(-1), 5500)
                            PlayAmbientSpeech1(sellNPC, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
                            if cb.count > 2 then
                                givePackageAnim(cb.name, ammount)
                            else
                                givePackageAnim(cb.name,1)
                            end
                            PlayAmbientSpeech1(sellNPC, "GENERIC_THANKS", "SPEECH_PARAMS_FORCE_SHOUTED_CRITICAL")
                            if cb.count > 2 then
                                giveMoneyAnimPed(sellNPC, cb.price * ammount)
                            else
                                giveMoneyAnimPed(sellNPC, cb.price)
                            end 
                         PlayAmbientSpeech1(sellNPC, "GENERIC_BYE", "SPEECH_PARAMS_FORCE_SHOUTED_CRITICAL")
                            TriggerEvent("tqrp_runs:startSellingItems")
                            TriggerEvent("tqrp_runs:deleteNPCafterSell", sellNPCpos[num].x, sellNPCpos[num].y, sellNPCpos[num].z, sellNPC)
                            onSelling = false
                            RemoveBlip(blip)
                        else
                            exports['mythic_notify']:SendAlert('error', "Não tinhas o produto certo para vender!")
                            TriggerEvent("tqrp_runs:deleteNPCafterSell", sellNPCpos[num].x, sellNPCpos[num].y, sellNPCpos[num].z, sellNPC)
                            onSelling = false
                            RemoveBlip(blip)
                        end
                    end)
                  break
                end
            end
        end
    end)
end)

RegisterNetEvent('tqrp_runs:deleteNPCafterSell')
AddEventHandler('tqrp_runs:deleteNPCafterSell', function(x,y,z,npc)
    CreateThread(function()
        while true do
            Wait(50)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if GetDistanceBetweenCoords(coords, x,y,z, false) > 50.0 then
                if DoesEntityExist(npc) then
                    DeleteEntity(npc)
                    break
                end
            end
        end
    end)
end)
