ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Freeze = {F1 = 0, F2 = 0, F3 = 0, F4 = 0, F5 = 0, F6 = 0}
PlayerData = nil
Check = {F1 = false, F2 = false, F3 = false, F4 = false, F5 = false, F6 = false}
SearchChecks = {F1 = false, F2 = false, F3 = false, F4 = false, F5 = false, F6 = false}
LootCheck = {
    F1 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false, Loot4 = false, Loot5 = false, Loot6 = false, Loot7 = false},
    F2 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false, Loot4 = false, Loot5 = false, Loot6 = false, Loot7 = false},
    F3 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false, Loot4 = false, Loot5 = false, Loot6 = false, Loot7 = false},
    F4 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false, Loot4 = false, Loot5 = false, Loot6 = false, Loot7 = false},
    F5 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false, Loot4 = false, Loot5 = false, Loot6 = false, Loot7 = false},
    F6 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false, Loot4 = false, Loot5 = false, Loot6 = false, Loot7 = false}
}
Doors = {}
local BankData
local disableinput = false
local initiator = false
local startdstcheck = false
local currentname = nil
local currentcoords = nil
local done = true
local dooruse = false
local RouletteWords = {
    "C0ND3BUR",
    "S3KUND3N",
    "3SC4D0T3",
    "F4IRPL4Y",
    "TRYYH4RD",
    "1RP4BNTY"
}

function ScaleformLabel(label)
    BeginTextCommandScaleformString(label)
    EndTextCommandScaleformString()
end

local scaleform = nil
local lives = 5
local ClickReturn
local SorF = false
local Hacking = false
local UsingComputer = false
local hackingBank = nil

local soundid
local state = 0
local inMission = false
local ped = {}
local currentDrillAnim = 'drill_straight_idle'
local drilling = false
local finishedDrilling = false
local speed = 0.0
local temperature = 0.0
local depth = 0.1
local position = 0.0
local drillEntity = {}
local playSound = true


Citizen.CreateThread(function() while true do local enabled = false Citizen.Wait(10) if disableinput then enabled = true DisableControl() end if not enabled then Citizen.Wait(3000) end end end)
--[[function DrawText3D(x, y, z, text, scale) local onScreen, _x, _y = World3dToScreen2d(x, y, z) local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) SetTextScale(scale, scale) SetTextFont(4) SetTextProportional(1) SetTextEntry("STRING") SetTextCentre(true) SetTextColour(255, 255, 255, 215) AddTextComponentString(text) DrawText(_x, _y) local factor = (string.len(text)) / 700 DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 41, 11, 41, 100) end ]]
function DisableControl() DisableControlAction(0, 73, false) DisableControlAction(0, 24, true) DisableControlAction(0, 257, true) DisableControlAction(0, 25, true) DisableControlAction(0, 263, true) DisableControlAction(0, 32, true) DisableControlAction(0, 34, true) DisableControlAction(0, 31, true) DisableControlAction(0, 30, true) DisableControlAction(0, 45, true) DisableControlAction(0, 22, true) DisableControlAction(0, 44, true) DisableControlAction(0, 37, true) DisableControlAction(0, 23, true) DisableControlAction(0, 288, true) DisableControlAction(0, 289, true) DisableControlAction(0, 170, true) DisableControlAction(0, 167, true) DisableControlAction(0, 73, true) DisableControlAction(2, 199, true) DisableControlAction(0, 47, true) DisableControlAction(0, 264, true) DisableControlAction(0, 257, true) DisableControlAction(0, 140, true) DisableControlAction(0, 141, true) DisableControlAction(0, 142, true) DisableControlAction(0, 143, true) end

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    PlayerData.job = job
end)

RegisterNetEvent("tqrp_fleeca:resetDoorState")
AddEventHandler("tqrp_fleeca:resetDoorState", function(name)
    Freeze[name] = 0
end)

RegisterNetEvent("tqrp_fleeca:lootup_c")
AddEventHandler("tqrp_fleeca:lootup_c", function(var, var2, var3)
    LootCheck[var][var2] = var3
end)

RegisterNetEvent("tqrp_fleeca:outcome")
AddEventHandler("tqrp_fleeca:outcome", function(oc, arg)
    for i = 1, #Check, 1 do
        Check[i] = false
    end
    for i = 1, #LootCheck, 1 do
        for j = 1, #LootCheck[i] do
            LootCheck[i][j] = false
        end
    end
    if oc then
        TriggerServerEvent("tqrp_outlawalert:server:NewAlert",
        'police', 'sheriff',"Assalto ao banco Fleeca", "Desconhecido", "person", "gps_fixed", 1, 
        UTK.Banks[arg].doors.startloc.x, UTK.Banks[arg].doors.startloc.y, UTK.Banks[arg].doors.startloc.z, 108, 69, "10-90")

        TriggerServerEvent('tqrp_base:roblog','Assalto ao banco Fleeca','Começou um assalto ao banco Fleeca ID: '..arg, 12613380)
        
        local ped = GetPlayerPed(-1)
        SetEntityCoords(ped, UTK.Banks[arg].doors.startloc.animcoords.x, UTK.Banks[arg].doors.startloc.animcoords.y, UTK.Banks[arg].doors.startloc.animcoords.z)
        SetEntityHeading(ped, UTK.Banks[arg].doors.startloc.animcoords.h)
        TriggerEvent('tqrp_fleeca:hackinganim', arg)
        exports['mythic_progbar']:Progress({
            name = "virus",
            duration = 5000,
            label = "A inserir virus no sistema... ",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {},
          }, function(status)
            if not status then
                BankData = arg
                Check[arg] = true
                scaleform = Initialize("HACKING_PC")
                UsingComputer = true
            end
        end)

        TriggerServerEvent("big_skills:addStress", 45000)
    elseif not oc then
        exports["mythic_notify"]:SendAlert("error", arg)
    end
end)

RegisterNetEvent("tqrp_fleeca:startLoot_c")
AddEventHandler("tqrp_fleeca:startLoot_c", function(data, name)
    --local check = true
    --[[while check do
        local pedcoords = GetEntityCoords(PlayerPedId())
        local dst = GetDistanceBetweenCoords(pedcoords, data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z, true)

        if dst < 50 or LootCheck[name].Stop then
            check = false
        end
        Citizen.Wait(1000)
    end]]
    currentname = name
    currentcoords = vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z)
    if not LootCheck[name].Stop then
        Citizen.CreateThread(function()
            while true do
                local pedcoords = GetEntityCoords(PlayerPedId())
                local dst = GetDistanceBetweenCoords(pedcoords, data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z, true)

                if dst < 40 then
--[[                     if not LootCheck[name].Loot1 then
                        local dst1 = GetDistanceBetweenCoords(pedcoords, data.trolley1.x, data.trolley1.y, data.trolley1.z + 1, true)

                        if dst1 < 5 then
                            DrawText3D(data.trolley1.x, data.trolley1.y, data.trolley1.z+1, "[~r~E~w~] Pegar o dinheiro", 0.40)
                            if dst1 < 0.75 and IsControlJustReleased(0, 38) then
                                TriggerServerEvent("tqrp_fleeca:lootup", name, "Loot1")
                                StartGrab(name)
                            end
                        end
                    end

                    if not LootCheck[name].Loot2 then
                        local dst1 = GetDistanceBetweenCoords(pedcoords, data.trolley2.x, data.trolley2.y, data.trolley2.z+1, true)

                        if dst1 < 5 then
                            DrawText3D(data.trolley2.x, data.trolley2.y, data.trolley2.z+1, "[~r~E~w~] Pegar o dinheiro", 0.40)
                            if dst1 < 1 and IsControlJustReleased(0, 38) then
                                TriggerServerEvent("tqrp_fleeca:lootup", name, "Loot2")
                                StartGrab(name)
                            end
                        end
                    end ]]

                    if not LootCheck[name].Loot5 then
                        local dst1 = GetDistanceBetweenCoords(pedcoords, data.trolley3.x, data.trolley3.y, data.trolley3.z+1, true)

                        if dst1 < 2 then
                            DrawText3D(data.trolley3.x, data.trolley3.y, data.trolley3.z+1, "[~r~E~w~] Pegar o dinheiro", 0.35)
                            if dst1 < 1 and IsControlJustReleased(0, 38) then
                                TriggerServerEvent("tqrp_fleeca:lootup", name, "Loot5", true)
                                StartGrab(name)
                                TriggerServerEvent('tqrp_base:roblog','Assalto ao banco Fleeca','Banco Fleeca ID: '.. name ..'\nPegou o carrinho de dinheiro.', 12613380)
                                TriggerServerEvent("big_skills:addStress", 45000)
                            end
                        end
                    end

                    if not LootCheck[name].Loot1 then
                        local dst1 = GetDistanceBetweenCoords(pedcoords, data.drill1.x, data.drill1.y, data.drill1.z+1, true)

                        if dst1 < 2 then
                            DrawText3D(data.drill1.x, data.drill1.y, data.drill1.z+1, "[~r~E~w~] Furar mini cofre", 0.35)
                            if dst1 < 1 and IsControlJustReleased(0, 38) then
                                TriggerServerEvent("tqrp_fleeca:lootup", name, "Loot1", true)
                                StartDrilling(name, "Loot1")
                                TriggerServerEvent('tqrp_base:roblog','Assalto ao banco Fleeca','Banco Fleeca ID: '.. name ..'\nFurou o mini cofre ID: Loot 1', 12613380)
                                TriggerServerEvent("big_skills:addStress", 45000)
                            end
                        end
                    end

                    if not LootCheck[name].Loot2 then
                        local dst1 = GetDistanceBetweenCoords(pedcoords, data.drill2.x, data.drill2.y, data.drill2.z+1, true)

                        if dst1 < 2 then
                            DrawText3D(data.drill2.x, data.drill2.y, data.drill2.z+1, "[~r~E~w~] Furar mini cofre", 0.35)
                            if dst1 < 1 and IsControlJustReleased(0, 38) then
                                TriggerServerEvent("tqrp_fleeca:lootup", name, "Loot2", true)
                                StartDrilling(name, "Loot2")
                                TriggerServerEvent('tqrp_base:roblog','Assalto ao banco Fleeca','Banco Fleeca ID: '.. name ..'\nFurou o mini cofre ID: Loot 2', 12613380)
                                TriggerServerEvent("big_skills:addStress", 45000)
                            end
                        end
                    end

                    if not LootCheck[name].Loot3 then
                        local dst1 = GetDistanceBetweenCoords(pedcoords, data.drill3.x, data.drill3.y, data.drill3.z+1, true)

                        if dst1 < 2 then
                            DrawText3D(data.drill3.x, data.drill3.y, data.drill3.z+1, "[~r~E~w~] Furar mini cofre", 0.35)
                            if dst1 < 1 and IsControlJustReleased(0, 38) then
                                TriggerServerEvent("tqrp_fleeca:lootup", name, "Loot3", true)
                                StartDrilling(name, "Loot3")
                                TriggerServerEvent('tqrp_base:roblog','Assalto ao banco Fleeca','Banco Fleeca ID: '.. name ..'\nFurou o mini cofre ID: Loot 3', 12613380)
                                TriggerServerEvent("big_skills:addStress", 45000)
                            end
                        end
                    end

                    if not LootCheck[name].Loot4 then
                        local dst1 = GetDistanceBetweenCoords(pedcoords, data.drill4.x, data.drill4.y, data.drill4.z+1, true)

                        if dst1 < 2 then
                            DrawText3D(data.drill4.x, data.drill4.y, data.drill4.z+1, "[~r~E~w~] Furar mini cofre", 0.35)
                            if dst1 < 1 and IsControlJustReleased(0, 38) then
                                TriggerServerEvent("tqrp_fleeca:lootup", name, "Loot4", true)
                                StartDrilling(name, "Loot4")
                                TriggerServerEvent('tqrp_base:roblog','Assalto ao banco Fleeca','Banco Fleeca ID: '.. name ..'\nFurou o mini cofre ID: Loot 4', 12613380)
                                TriggerServerEvent("big_skills:addStress", 45000)
                            end
                        end
                    end

                    if LootCheck[name].Stop or (LootCheck[name].Loot1 and LootCheck[name].Loot2 and LootCheck[name].Loot3 and LootCheck[name].Loot4 and LootCheck[name].Loot5 --[[ and LootCheck[name].Loot6and and LootCheck[name].Loot7 ]]) then
                        LootCheck[name].Stop = false
                        if initiator then
                            TriggerEvent("tqrp_fleeca:reset", name, data)
                            return
                        end
                        return
                    end
                    Citizen.Wait(7)
                else
                    Citizen.Wait(3000)
                end
            end
        end)
    end
end)

RegisterNetEvent("tqrp_fleeca:stopHeist_c")
AddEventHandler("tqrp_fleeca:stopHeist_c", function(name)
    LootCheck[name].Stop = true
end)

-- MAIN DOOR UPDATE --

RegisterCommand("cofre", function(source, args)
    if PlayerData.job.name == "police" and not dooruse then
        local pcoords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Doors) do
            local dst = GetDistanceBetweenCoords(pcoords, v.loc, true)
            if dst <= 1.5 then
                dooruse = true
                TriggerServerEvent("tqrp_fleeca:toggleVault", k, not v.locked)
                LootCheck[k].Stop = true
            end
        end
    end
end)

-----------------------------------------------------------------------------------

AddEventHandler("tqrp_fleeca:freezeDoors", function()
    Citizen.CreateThread(function()
        doVaultStuff = function()
            while true do
                local pcoords = GetEntityCoords(PlayerPedId())
                for k, v in pairs(Doors) do
                    if GetDistanceBetweenCoords(v.loc, pcoords, true) <= 20.0 then
                        if v.state ~= nil then
                            local obj
                            if k ~= "F1" then
                                obj = GetClosestObjectOfType(v.loc, 1.5, GetHashKey("v_ilev_gb_vauldr"), false, false, false)
                            else
                                obj = GetClosestObjectOfType(v.loc, 1.5, 4231427725, false, false, false)
                            end
                            SetEntityHeading(obj, v.state)
                            Citizen.Wait(1000)
                            return doVaultStuff()
                        end
                    else
                        Citizen.Wait(1000)
                    end
                end
                Citizen.Wait(1)
            end
        end
        doVaultStuff()
    end)
end)


------------------------------------------------------------------------------------------------------------------------------------------------------

--[[ RegisterNetEvent("tqrp_fleeca:toggleDoor")
AddEventHandler("tqrp_fleeca:toggleDoor", function(key, state)
    Doors[key][1].locked = state
    dooruse = false
end) ]]

RegisterNetEvent("tqrp_fleeca:toggleVault")
AddEventHandler("tqrp_fleeca:toggleVault", function(key, state)
    dooruse = true
    Doors[key].state = nil
    if UTK.Banks[key].hash == nil then
        if not state then
            local obj = GetClosestObjectOfType(UTK.Banks[key].doors.startloc.x, UTK.Banks[key].doors.startloc.y, UTK.Banks[key].doors.startloc.z, 2.0, GetHashKey(UTK.vaultdoor), false, false, false)
            local count = 0

            repeat
                local heading = GetEntityHeading(obj) - 0.10

                SetEntityHeading(obj, heading)
                count = count + 1
                Citizen.Wait(10)
            until count == 900
            Doors[key].locked = state
            Doors[key].state = GetEntityHeading(obj)
            TriggerServerEvent("tqrp_fleeca:updateVaultState", key, Doors[key].state)
        elseif state then
            local obj = GetClosestObjectOfType(UTK.Banks[key].doors.startloc.x, UTK.Banks[key].doors.startloc.y, UTK.Banks[key].doors.startloc.z, 2.0, GetHashKey(UTK.vaultdoor), false, false, false)
            local count = 0

            repeat
                local heading = GetEntityHeading(obj) + 0.10

                SetEntityHeading(obj, heading)
                count = count + 1
                Citizen.Wait(10)
            until count == 900
            Doors[key].locked = state
            Doors[key].state = GetEntityHeading(obj)
            TriggerServerEvent("tqrp_fleeca:updateVaultState", key, Doors[key].state)
        end
    else
        if not state then
            local obj = GetClosestObjectOfType(UTK.Banks.F1.doors.startloc.x, UTK.Banks.F1.doors.startloc.y, UTK.Banks.F1.doors.startloc.z, 2.0, UTK.Banks.F1.hash, false, false, false)
            local count = 0
            repeat
                local heading = GetEntityHeading(obj) - 0.10

                SetEntityHeading(obj, heading)
                count = count + 1
                Citizen.Wait(10)
            until count == 900
            Doors[key].locked = state
            Doors[key].state = GetEntityHeading(obj)
            TriggerServerEvent("tqrp_fleeca:updateVaultState", key, Doors[key].state)
        elseif state then
            local obj = GetClosestObjectOfType(UTK.Banks.F1.doors.startloc.x, UTK.Banks.F1.doors.startloc.y, UTK.Banks.F1.doors.startloc.z, 2.0, UTK.Banks.F1.hash, false, false, false)
            local count = 0

            repeat
                local heading = GetEntityHeading(obj) + 0.10

                SetEntityHeading(obj, heading)
                count = count + 1
                Citizen.Wait(10)
            until count == 900
            Doors[key].locked = state
            Doors[key].state = GetEntityHeading(obj)
            TriggerServerEvent("tqrp_fleeca:updateVaultState", key, Doors[key].state)
        end
    end
    dooruse = false
end)

AddEventHandler("tqrp_fleeca:reset", function(name, data)
    for i = 1, #LootCheck[name], 1 do
        LootCheck[name][i] = false
    end
    Check[name] = false
    Citizen.Wait(30000)
    TriggerServerEvent("tqrp_fleeca:toggleVault", name, true)
    TriggerEvent("tqrp_fleeca:cleanUp", data, name)
end)

AddEventHandler("tqrp_fleeca:startheist", function(data, name)
    disableinput = false
    currentname = name
    currentcoords = vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z)
    local ped = PlayerPedId()

--[[     SetEntityCoords(ped, data.doors.startloc.animcoords.x, data.doors.startloc.animcoords.y, data.doors.startloc.animcoords.z)
    SetEntityHeading(ped, data.doors.startloc.animcoords.h) ]]
    local pedco = GetEntityCoords(PlayerPedId())
    local boneIndex = GetPedBoneIndex(PlayerPedId(), 28422)
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    TriggerServerEvent("tqrp_fleeca:toggleVault", name, false)
    startdstcheck = true
    currentname = name
    SpawnTrolleys(data, name)
end)


AddEventHandler("tqrp_fleeca:cleanUp", function(data, name)
    Citizen.Wait(10000)
        local obj = GetClosestObjectOfType(data.object.x, data.object.y, data.object.z, 0.75, GetHashKey("hei_prop_hei_cash_trolly_01"), false, false, false)

        if DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
        local obj = GetClosestObjectOfType(data.object.x, data.object.y, data.object.z, 0.75, GetHashKey("hei_prop_hei_cash_trolly_03"), false, false, false)

        if DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
    if DoesEntityExist(IdProp) then
        DeleteEntity(IdProp)
    end
    if DoesEntityExist(IdProp2) then
        DeleteEntity(IdProp2)
    end
    TriggerServerEvent("tqrp_fleeca:setCooldown", name)
    initiator = false
end)

function SpawnTrolleys(data, name)
    RequestModel("hei_prop_hei_cash_trolly_01")
    while not HasModelLoaded("hei_prop_hei_cash_trolly_01") do
        Citizen.Wait(1)
    end
--[[     Trolley1 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), data.trolley1.x, data.trolley1.y, data.trolley1.z, 1, 1, 0)
    Trolley2 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), data.trolley2.x, data.trolley2.y, data.trolley2.z, 1, 1, 0) ]]
    Trolley3 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), data.trolley3.x, data.trolley3.y, data.trolley3.z, 1, 1, 0)
--[[     local h1 = GetEntityHeading(Trolley1)
    local h2 = GetEntityHeading(Trolley2) ]]
    local h3 = GetEntityHeading(Trolley3)
--[[ 
    SetEntityHeading(Trolley1, h1 + UTK.Banks[name].trolley1.h)
    SetEntityHeading(Trolley2, h2 + UTK.Banks[name].trolley2.h) ]]
    SetEntityHeading(Trolley3, h3 + UTK.Banks[name].trolley3.h)
    local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}

    for i = 1, #players, 1 do
        if players[i] ~= PlayerId() then
            table.insert(missionplayers, GetPlayerServerId(players[i]))
        end
    end
    TriggerServerEvent("tqrp_fleeca:startLoot", data, name, missionplayers)
    done = false
end

function StartGrab(name)
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"

    Trolley = GetClosestObjectOfType(GetEntityCoords(ped), 1.0, GetHashKey("hei_prop_hei_cash_trolly_01"), false, false, false)
    local CashAppear = function()
	    local pedCoords = GetEntityCoords(ped)
        local grabmodel = GetHashKey(model)

        RequestModel(grabmodel)
        while not HasModelLoaded(grabmodel) do
            Citizen.Wait(100)
        end
	    local grabobj = CreateObject(grabmodel, pedCoords, true)

	    FreezeEntityPosition(grabobj, true)
	    SetEntityInvincible(grabobj, true)
	    SetEntityNoCollisionEntity(grabobj, ped)
	    SetEntityVisible(grabobj, false, false)
	    AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	    local startedGrabbing = GetGameTimer()

	    Citizen.CreateThread(function()
		    while GetGameTimer() - startedGrabbing < 37000 do
			    Citizen.Wait(7)
			    DisableControlAction(0, 73, true)
			    if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
				    if not IsEntityVisible(grabobj) then
					    SetEntityVisible(grabobj, true, false)
				    end
			    end
			    if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
				    if IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, false, false)
                        TriggerServerEvent("tqrp_fleeca:rewardCash")
				    end
			    end
		    end
		    DeleteObject(grabobj)
	    end)
    end
	local trollyobj = Trolley
    local emptyobj = GetHashKey("hei_prop_hei_cash_trolly_03")

	if IsEntityPlayingAnim(trollyobj, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
		return
    end
    local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")

    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
        Citizen.Wait(100)
    end
	while not NetworkHasControlOfEntity(trollyobj) do
		Citizen.Wait(1)
		NetworkRequestControlOfEntity(trollyobj)
	end
	local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    local scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(ped, scene1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
	NetworkStartSynchronisedScene(scene1)
	Citizen.Wait(1500)
	CashAppear()
	local scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(ped, scene2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bag, scene2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(trollyobj, scene2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene2)
	Citizen.Wait(37000)
	local scene3 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(ped, scene3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bag, scene3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene3)
    NewTrolley = CreateObject(emptyobj, GetEntityCoords(trollyobj) + vector3(0.0, 0.0, - 0.985), true)
    --TriggerServerEvent("tqrp_fleeca:updateObj", name, NewTrolley, 2)
    SetEntityRotation(NewTrolley, GetEntityRotation(trollyobj))
	while not NetworkHasControlOfEntity(trollyobj) do
		Citizen.Wait(1)
		NetworkRequestControlOfEntity(trollyobj)
	end
	DeleteObject(trollyobj)
    PlaceObjectOnGroundProperly(NewTrolley)
	Citizen.Wait(1800)
	DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
	RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
	SetModelAsNoLongerNeeded(emptyobj)
    SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
    disableinput = false
end

Citizen.CreateThread(function()
    while true do
        if initiator then
            local playercoord = GetEntityCoords(PlayerPedId())

            if (GetDistanceBetweenCoords(playercoord, currentcoords, true)) > 20 then
                LootCheck[currentname].Stop = true
                TriggerServerEvent("tqrp_fleeca:stopHeist", currentname)
            end
        end
        Citizen.Wait(3000)
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(100)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
    PlayerData = ESX.GetPlayerData()
    while PlayerData == nil do
        Citizen.Wait(100)
    end
    ESX.TriggerServerCallback("tqrp_fleeca:getBanks", function(bank, door)
        UTK.Banks = bank
        Doors = door
    end)
    TriggerEvent("tqrp_fleeca:freezeDoors")
end)

RegisterNetEvent("tqrp_fleeca:usePen")
AddEventHandler("tqrp_fleeca:usePen", function()
    local coords = GetEntityCoords(PlayerPedId())
    for k, v in pairs(UTK.Banks) do
        if not v.onaction then
            local dst = GetDistanceBetweenCoords(coords, v.doors.startloc.x, v.doors.startloc.y, v.doors.startloc.z, true)
            if dst <= 1 then
                ESX.TriggerServerCallback('tqrp_base:getJobsOnline', function(ems, police)
                    if police >= 6 then -- URGENTE
                    TriggerServerEvent("tqrp_fleeca:startcheck", k)
                    else
                        exports["mythic_notify"]:SendAlert("error", "Foi instalada uma nova Firewall no banco.")
                    end
                end)
            end
        end
    end
end)

----- HACKING START ------

Citizen.CreateThread(function()
    function Initialize(scaleform)
        local scaleform = RequestScaleformMovieInteractive(scaleform)
        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end
        
        local CAT = 'hack'
        local CurrentSlot = 0
        while HasAdditionalTextLoaded(CurrentSlot) and not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
            Citizen.Wait(0)
            CurrentSlot = CurrentSlot + 1
        end
        
        if not HasThisAdditionalTextLoaded(CAT, CurrentSlot) then
            ClearAdditionalText(CurrentSlot, true)
            RequestAdditionalText(CAT, CurrentSlot)
            while not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
                Citizen.Wait(0)
            end
        end

        PushScaleformMovieFunction(scaleform, "SET_LABELS")
        ScaleformLabel("H_ICON_1")
        ScaleformLabel("H_ICON_2")
        ScaleformLabel("H_ICON_3")
        ScaleformLabel("H_ICON_4")
        ScaleformLabel("H_ICON_5")
        ScaleformLabel("H_ICON_6")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_BACKGROUND")
        PushScaleformMovieFunctionParameterInt(4)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(1.0)
        PushScaleformMovieFunctionParameterFloat(4.0)
        PushScaleformMovieFunctionParameterString("My Computer")
        PopScaleformMovieFunctionVoid()
        
        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(1.0)
        PushScaleformMovieFunctionParameterFloat(4.0)
        PushScaleformMovieFunctionParameterString("My Computer")
        PopScaleformMovieFunctionVoid()
        
        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterString("Power Off")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_LIVES")
        PushScaleformMovieFunctionParameterInt(lives)
        PushScaleformMovieFunctionParameterInt(5)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_LIVES")
        PushScaleformMovieFunctionParameterInt(lives)
        PushScaleformMovieFunctionParameterInt(5)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(1)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(2)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(4)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(5)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(6)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(7)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()
        

        return scaleform
    end
    scaleform = Initialize("HACKING_PC")
    --UsingComputer = true
    while true do
        Citizen.Wait(3)
        if UsingComputer then
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            PushScaleformMovieFunction(scaleform, "SET_CURSOR")
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 239))
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 240))
            PopScaleformMovieFunctionVoid()
            if IsDisabledControlJustPressed(0,24) and not SorF then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_SELECT")
                ClickReturn = PopScaleformMovieFunction()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 25) and not Hacking and not SorF then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_BACK")
                PopScaleformMovieFunctionVoid()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            end
        end
    end
end)

Citizen.CreateThread(function()
    local Hacked = false
    while true do
        Citizen.Wait(3)
        if HasScaleformMovieLoaded(scaleform) and UsingComputer then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            if GetScaleformMovieFunctionReturnBool(ClickReturn) then
                ProgramID = GetScaleformMovieFunctionReturnInt(ClickReturn)
                if ProgramID == 83 and not Hacking and not Hacked then
                    lives = 5
                    
                    PushScaleformMovieFunction(scaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(lives)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()

                    PushScaleformMovieFunction(scaleform, "OPEN_APP")
                    PushScaleformMovieFunctionParameterFloat(1.0)
                    PopScaleformMovieFunctionVoid()
                    
                    PushScaleformMovieFunction(scaleform, "SET_ROULETTE_WORD")
                    PushScaleformMovieFunctionParameterString(RouletteWords[math.random(#RouletteWords)])
                    PopScaleformMovieFunctionVoid()

                    Hacking = true
                elseif ProgramID == 82 and not Hacking then
                    PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                elseif Hacking and ProgramID == 87 then
                    lives = lives - 1
                    PushScaleformMovieFunction(scaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(lives)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()
                    PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                elseif Hacking and ProgramID == 92 then
                    PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
                elseif Hacking and ProgramID == 86 then
                    SorF = true
                    PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                    PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                    PushScaleformMovieFunctionParameterBool(true)
                    ScaleformLabel("WINBRUTE")
                    PopScaleformMovieFunctionVoid()
                    Wait(0)
                    PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                    PopScaleformMovieFunctionVoid()
                    TriggerEvent("tqrp_fleeca:startheist", UTK.Banks[BankData], BankData)
                    Hacking = true
                    SorF = false
                    Hacked = true
                elseif ProgramID == 6 then
                    Hacking = false
                    UsingComputer = false
                    SetScaleformMovieAsNoLongerNeeded(scaleform)
                    DisableControlAction(0, 24, false)
                    DisableControlAction(0, 25, false)
                    FreezeEntityPosition(PlayerPedId(), false)
                end
                
                if Hacking then
                    PushScaleformMovieFunction(scaleform, "SHOW_LIVES")
                    PushScaleformMovieFunctionParameterBool(true)
                    PopScaleformMovieFunctionVoid()
                    if lives <= 0 then
                        SorF = true
                        PlaySoundFrontend(-1, "HACKING_FAILURE", "", true)
                        PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(false)
                        ScaleformLabel("LOSEBRUTE")
                        PopScaleformMovieFunctionVoid()
                        Wait(5000)
                        PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        Hacking = false
                        SorF = false
                    end
                end
            end
        else
            Wait(3000)
        end
    end
end)

----- HACKING END ---------

----- DRILLING START ------

RegisterNetEvent('tqrp_fleeca:deleteDrillCl')
AddEventHandler('tqrp_fleeca:deleteDrillCl', function(coords)
    local jackham = GetClosestObjectOfType(coords, 10.0, GetHashKey("prop_tool_jackham"), false, false, false)
    SetEntityAsMissionEntity(jackham, true, true)
    DeleteEntity(jackham)
end)

local scaleform = {}

function drillScaleform()
    scaleform = RequestScaleformMovie("DRILLING")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
end

Citizen.CreateThread(function()
    while true do
        while drilling do
            local text = '~INPUT_CELLPHONE_UP~ Furar \n~INPUT_CELLPHONE_DOWN~ Aliviar a broca\n~INPUT_JUMP~ Largar broca'
			AddTextEntry("tqrp_fleeca_drill_info_text", text)
			DisplayHelpTextThisFrame("tqrp_fleeca_drill_info_text", false)

            drillScaleform()
            Wait(0)
            BeginScaleformMovieMethod(scaleform, "SET_SPEED")
            PushScaleformMovieMethodParameterFloat(speed)
            EndScaleformMovieMethod()

            BeginScaleformMovieMethod(scaleform, "SET_HOLE_DEPTH")
            PushScaleformMovieMethodParameterFloat(depth)
            EndScaleformMovieMethod()

            BeginScaleformMovieMethod(scaleform, "SET_DRILL_POSITION")
            PushScaleformMovieMethodParameterFloat(position)
            EndScaleformMovieMethod()

            BeginScaleformMovieMethod(scaleform, "SET_TEMPERATURE")
            PushScaleformMovieMethodParameterFloat(temperature)
            EndScaleformMovieMethod()
        end
        Wait(5000)
    end
end)

local particleLooped = nil

Citizen.CreateThread(function()
    while true do
        if drilling then
            if depth-position >= 0 then
                currentDrillAnim = 'drill_straight_idle'
            end
            RequestAnimDict('anim@heists@fleeca_bank@drilling')
            while not HasAnimDictLoaded('anim@heists@fleeca_bank@drilling') do
                Wait(10)
            end
            if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', currentDrillAnim, 3) then
                TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', currentDrillAnim, 8.0, 8.0, -1, 17, 1, false, false, false)
            end
        end
        Wait(5000)
    end
end)

RegisterNetEvent('tqrp_fleeca:particleTimer')
AddEventHandler('tqrp_fleeca:particleTimer', function(time)
    Wait(time)
    StopParticleFxLooped(particleLooped)
    particleLooped = nil
end)

Citizen.CreateThread(function()
    while true do -- hei_prop_heist_drill anim@heists@fleeca_bank@drilling
        Wait(5000)
        if drilling then
            while drilling do
                Wait(1)
                if IsDisabledControlPressed(0, 172) and not finishedDrilling then
                    if temperature < 1.0 then
                        RequestAnimDict('anim@heists@fleeca_bank@drilling')
                        while not HasAnimDictLoaded('anim@heists@fleeca_bank@drilling') do
                            Wait(10)
                        end
                        TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', 'drill_straight_start', 8.0, 8.0, -1, 17, 1, false, false, false)
                      --  TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10.0, 'broca2', 1.0)
                        --PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1)
                        while IsDisabledControlPressed(0, 172) and temperature < 1.0 do
                            drilling = true
                            if speed < 0.7 then
                                speed = speed + (math.random(1, 5)/100)
                            end
                            if depth-position >= 0 then
                                position = position + ((math.random(1, 5)/1000)+(speed/10))
                                currentDrillAnim = 'drill_straight_idle'
                                playSound = false
                            else
                                local randomDepth = math.random(1, 5)/1000
                                depth = depth + randomDepth
                                position = position + randomDepth
                                temperature = temperature + 0.02
                                playSound = true

                                currentDrillAnim = 'drill_straight_start'

                                local c = GetEntityCoords(drillEntity)
                            end
                            if depth >= 0.9 then
                                drilling = false
                                finishedDrilling = true
                                break
                            end
                            Wait(100)
                        end
                        if temperature >= 1.0 then
                            playSound = false
                            local c = GetEntityCoords(drillEntity)
                            RequestNamedPtfxAsset("core")
                            while not HasNamedPtfxAssetLoaded("core") do
                                Wait(0)
                            end
                            UseParticleFxAssetNextCall("core")
                            particleLooped = StartParticleFxLoopedAtCoord("ent_amb_exhaust_thick", c, 0.0, 0.0, 0.0, 0.5, false, false, false, 0)
                            SetParticleFxLoopedEvolution(particleLooped, "ent_amb_exhaust_thick", 0.5, 0)

                            for i = 1, 100 do
                                if speed > 0 then
                                    speed = speed - 0.01
                                end
                                if temperature > 0 then
                                    temperature = temperature - 0.01
                                end
                                if position > 0 then
                                    position = position - 0.01
                                end
                                if temperature <= 0.2 then
                                    break   
                                end
                                Wait(250)
                            end
                            playSound = true
                            TriggerEvent('tqrp_fleeca:particleTimer', 750)
                        end
                    else
                        playSound = false
                        local c = GetEntityCoords(drillEntity)
                        RequestNamedPtfxAsset("core")
                        while not HasNamedPtfxAssetLoaded("core") do
                            Wait(0)
                        end
                        UseParticleFxAssetNextCall("core")
                        particleLooped = StartParticleFxLoopedAtCoord("ent_amb_exhaust_thick", c, 0.0, 0.0, 0.0, 0.5, false, false, false, 0)
                        SetParticleFxLoopedEvolution(particleLooped, "ent_amb_exhaust_thick", 0.5, 0)
                        for i = 1, 100 do
                            if speed > 0 then
                                speed = speed - 0.01
                            end
                            if temperature > 0 then
                                temperature = temperature - 0.01
                            end
                            if position > 0 then
                                position = position - 0.005
                            end
                            if temperature <= 0.2 then
                                break   
                            end
                            Wait(250)
                        end
                        playSound = true
                        TriggerEvent('tqrp_fleeca:particleTimer', 750)
                    end
                elseif IsDisabledControlPressed(0, 173) then
                    playSound = false
                    position = position - 0.015
                    temperature = temperature - 0.015
                    speed = speed - 0.015
                    Wait(50)
                else
                    if speed > 0.0 then
                        speed = speed - 0.01
                        Wait(50)
                    end
                    if temperature > 0.0 then
                        temperature = temperature - 0.01
                        Wait(50)
                    end
                end
            end
        end
    end
end)


----- DRILLING END -------
function StartDrilling(name, loot)
    exports['mythic_progbar']:Progress({
        name = "housrob",
        duration = 2000,
        label = "A pegar na broca... ",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {},
      })
        local coords = NetworkGetPlayerCoords(player)
        local playerPed = GetPlayerPed(-1)
        
        FreezeEntityPosition(player, true)
        SetPedCurrentWeaponVisible(player, false, true, 0, 0)
        drilling = true
        speed = 0.0
        temperature = 0.0
        depth = 0.1
        position = 0.0

        local drill_hash = GetHashKey("hei_prop_heist_drill")
        RequestModel(drill_hash)
        while not HasModelLoaded(drill_hash) do
            Wait(0)
        end
        
        drillEntity = CreateObject(drill_hash, NetworkGetPlayerCoords(player), true, false)
        SetEntityAsMissionEntity(drill, true, true)
        local boneIndex = GetPedBoneIndex(PlayerPedId(), 57005)
        Wait(500)
        AttachEntityToEntity(drillEntity, PlayerPedId(), boneIndex, 0.125, 0.0, -0.05, 100.0, 300.0, 135.0, true, true, false, true, 1, true)

        if soundid ~= nil then
            StopSound(soundid)
            ReleaseSoundId(soundid)
        end
                    
        soundid = GetSoundId()
        LoadStream("HEIST_FLEECA_DRILL", "DRILL")
        RequestScriptAudioBank("HEIST_FLEECA_DRILL_2", 1)
        PlaySoundFromEntity(soundid, "Drill", drillEntity, "DLC_HEIST_FLEECA_SOUNDSET", 0, 0)

        local ped_hash = -39239064
        RequestModel(ped_hash)
        while not HasModelLoaded(ped_hash) do
            Wait(5)
        end

        local soundPed = CreatePed(4, ped_hash, coords.x, coords.y, coords.z - 1.5, 0.0, true, false)
        FreezeEntityPosition(soundPed, true)
        SetEntityVisible(soundPed, false)
        TaskStartScenarioInPlace(soundPed, "WORLD_HUMAN_CONST_DRILL", 0, true)   
        SetEntityInvincible(soundPed, true)
        SetEntityAsMissionEntity(soundPed, true, true)
        SetPedHearingRange(soundPed, 0.0)
        SetPedSeeingRange(soundPed, 0.0)
        SetPedAlertness(soundPed, 0.0)
        SetPedFleeAttributes(soundPed, 0, 0)
        SetBlockingOfNonTemporaryEvents(soundPed, true)
        SetPedCombatAttributes(soundPed, 46, true)
        SetPedFleeAttributes(soundPed, 0, 0)

        while drilling do
            Wait(100)
            if not playSound or speed <= 0.1 then
                DeleteEntity(soundPed)
                TriggerServerEvent('tqrp_fleeca:deleteDrill', coords)
            else
                if not DoesEntityExist(soundPed) then
                    RequestModel(ped_hash)
                    while not HasModelLoaded(ped_hash) do
                        Wait(5)
                    end
                    soundPed = CreatePed(4, ped_hash, coords.x, coords.y, coords.z - 1.5, 0.0, true, false)
                    FreezeEntityPosition(soundPed, true)
                    SetEntityVisible(soundPed, false)
                    TaskStartScenarioInPlace(soundPed, "WORLD_HUMAN_CONST_DRILL", 0, true)  
                    SetEntityInvincible(soundPed, true)
                    SetEntityAsMissionEntity(soundPed, true, true)
                    SetPedHearingRange(soundPed, 0.0)
                    SetPedSeeingRange(soundPed, 0.0)
                    SetPedAlertness(soundPed, 0.0)
                    SetPedFleeAttributes(soundPed, 0, 0)
                    SetBlockingOfNonTemporaryEvents(soundPed, true)
                    SetPedCombatAttributes(soundPed, 46, true)
                    SetPedFleeAttributes(soundPed, 0, 0)

                end
            end
            if IsDisabledControlPressed(0, 22) then
                drilling = false
                Wait(250)
                ClearPedTasks(playerPed)
                break
            end
        end
        if finishedDrilling then
            TriggerServerEvent("tqrp_fleeca:rewardDrill")
        else
            TriggerServerEvent("tqrp_fleeca:lootup", name, loot, false)
        end
        
        ClearPedTasks(playerPed)
        RenderScriptCams(false, false, 0, true, false)
        DestroyCam(active, false)

        Wait(100)

        drilling = false
        finishedDrilling = false
        speed = 0.0
        temperature = 0.0
        depth = 0.1
        position = 0.0

        Wait(100)

        DeleteEntity(drillEntity)
        TriggerServerEvent('tqrp_fleeca:deleteDrill', coords)
        FreezeEntityPosition(playerPed, false)

        Wait(100)

        DeleteEntity(soundPed)
        local jackham = GetClosestObjectOfType(coords, 10.0, GetHashKey("prop_tool_jackham"), false, false, false)
        SetEntityAsMissionEntity(jackham, true, true)
        DeleteEntity(jackham)
        drillEntity = {}
end


---- HACKING ANIM -------

AddEventHandler("tqrp_fleeca:hackinganim", function(arg)
    local animDict = "anim@heists@ornate_bank@hack"

    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_heist_card_hack_02")

    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
        Citizen.Wait(100)
    end
    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", UTK.Banks[arg].doors.startloc.animcoords.x, UTK.Banks[arg].doors.startloc.animcoords.y, UTK.Banks[arg].doors.startloc.animcoords.z, UTK.Banks[arg].doors.startloc.animcoords.x, UTK.Banks[arg].doors.startloc.animcoords.y, UTK.Banks[arg].doors.startloc.animcoords.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", UTK.Banks[arg].doors.startloc.animcoords.x, UTK.Banks[arg].doors.startloc.animcoords.y, UTK.Banks[arg].doors.startloc.animcoords.z, UTK.Banks[arg].doors.startloc.animcoords.x, UTK.Banks[arg].doors.startloc.animcoords.y, UTK.Banks[arg].doors.startloc.animcoords.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", UTK.Banks[arg].doors.startloc.animcoords.x, UTK.Banks[arg].doors.startloc.animcoords.y, UTK.Banks[arg].doors.startloc.animcoords.z, UTK.Banks[arg].doors.startloc.animcoords.x, UTK.Banks[arg].doors.startloc.animcoords.y, UTK.Banks[arg].doors.startloc.animcoords.z, 0, 2)

    -- part1
    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    local laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    --local card = CreateObject(GetHashKey("hei_prop_heist_card_hack_02"), targetPosition, 1, 1, 0)
    --NetworkAddEntityToSynchronisedScene(card, netScene, animDict, "hack_enter_card", 4.0, -8.0, 1)
    -- part2
    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
    --NetworkAddEntityToSynchronisedScene(card, netScene2, animDict, "hack_loop_card", 4.0, -8.0, -1)
    -- part3
    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
   -- NetworkAddEntityToSynchronisedScene(card, netScene3, animDict, "hack_exit_card", 4.0, -8.0, 1)

    SetPedComponentVariation(ped, 5, 0, 0, 0) 
    SetEntityHeading(ped, UTK.Banks[arg].doors.startloc.animcoords.h) 

    NetworkStartSynchronisedScene(netScene)
    Citizen.Wait(4500)
    NetworkStopSynchronisedScene(netScene)

    NetworkStartSynchronisedScene(netScene2)
    Citizen.Wait(4500) 
    NetworkStopSynchronisedScene(netScene2)

    NetworkStartSynchronisedScene(netScene3)
    Citizen.Wait(4500)
    NetworkStopSynchronisedScene(netScene3)
    
    
    DeleteObject(bag)
    DeleteObject(laptop)
  --  DeleteObject(card)
    FreezeEntityPosition(ped, false)
    SetPedComponentVariation(ped, 5, 45, 0, 0) 
end)

function DrawText3D(x, y, z, text, scale)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
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