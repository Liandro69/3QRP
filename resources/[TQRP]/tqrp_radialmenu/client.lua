-- Menu state
local showMenu = false
local dragging = false
ESX = nil

-- Keybind Lookup table
local keybindControls = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('tqrp_radialmenu:open')
AddEventHandler('tqrp_radialmenu:open', function()

    -- Loop through all menus in config
    for _, menuConfig in pairs(menuConfigs) do
        -- Check if menu should be enabled
        if menuConfig:enableMenu() then
            -- When keybind is pressed toggle UI
            local keybindControl = keybindControls[menuConfig.data.keybind]
            -- Init UI
            showMenu = true
            SendNUIMessage({
                type = 'init',
                data = menuConfig.data,
                resourceName = GetCurrentResourceName()
            })

            -- Set cursor position and set focus
            SetCursorLocation(0.5, 0.5)
            SetNuiFocus(true, true)

            -- Play sound
            PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

            -- Prevent menu from showing again until key is released
            while showMenu == true do 
                Citizen.Wait(100) 
            end
            Citizen.Wait(100)
            while IsControlPressed(0, keybindControl) do 
                Citizen.Wait(100) 
            end
        end
    end

end)

RegisterCommand("fecharmenu", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(10)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu1"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("submenu1", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(10)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu1"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("submenu2", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(10)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu2"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("submenu3", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(10)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu3"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("submenu4", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(10)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu4"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("submenu5", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(10)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu5"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("submenu6", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(10)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu6"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("minimenu1", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(10)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = miniMenuConfigs["minimenu1"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("minimenu2", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(10)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = miniMenuConfigs["minimenu2"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("minimenu3", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(10)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = miniMenuConfigs["minimenu3"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("minimenu4", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(10)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = miniMenuConfigs["minimenu4"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

-- Callback function for closing menu
RegisterNUICallback('closemenu', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    -- Send ACK to callback function
    cb('ok')
end)

-- Callback function for when a slice is clicked, execute command
RegisterNUICallback('sliceclicked', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    -- Run command
    ExecuteCommand(data.command)

    -- Send ACK to callback function
    cb('ok')
end)

RegisterCommand('showidcard', function(source, args, rawCommand)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestDistance ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('tqrp_idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
	else
		ESX.ShowNotification('Ninguém por perto', 1)
	end
end)

RegisterCommand('seeidcard', function(source, args, rawCommand)
	--ESX.PlayerData = ESX.GetPlayerData()
	TriggerServerEvent('tqrp_idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
end)

RegisterCommand('showdriver', function(source, args, rawCommand)
	--ESX.PlayerData = ESX.GetPlayerData()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
											
	if closestDistance ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('tqrp_idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'driver')
	else
		ESX.ShowNotification('Ninguém por perto', 1)
	end
end)

RegisterCommand('seedriver', function(source, args, rawCommand)
	ESX.PlayerData = ESX.GetPlayerData()
	TriggerServerEvent('tqrp_idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
end)

RegisterCommand('showgun', function(source, args, rawCommand)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	--ESX.PlayerData = ESX.GetPlayerData()
											
	if closestDistance ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('tqrp_idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'weapon')
	else
		ESX.ShowNotification('Ninguém por perto', 1)
	end
end)

RegisterCommand('seegun', function(source, args, rawCommand)
	--ESX.PlayerData = ESX.GetPlayerData()
	TriggerServerEvent('tqrp_idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
end)

RegisterCommand('showjob', function(source, args, rawCommand)
	ESX.PlayerData = ESX.GetPlayerData()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
											
	if closestDistance ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('radialmenu:showJob', GetPlayerServerId(closestPlayer), ESX.PlayerData.job.label , ESX.PlayerData.job.grade_label)
	else
		ESX.ShowNotification('Ninguém por perto', 1)
	end
end)

RegisterNetEvent('ILRP_radialmenu:societyMoney')
AddEventHandler('ILRP_radialmenu:societyMoney', function(money)
	ESX.PlayerData = ESX.GetPlayerData()
	local limit = 0
	while limit < 100 do
		local coords = GetEntityCoords(PlayerPedId(-1))
		if ESX.PlayerData.job.grade_name == 'boss' then
			DrawText3Ds(coords.x,coords.y,(coords.z + 1),ESX.PlayerData.job.label .. ' - ' .. ESX.PlayerData.job.grade_label .. ' - Empresa: ' .. money .. '$')
		else
			DrawText3Ds(coords.x,coords.y,(coords.z + 1),ESX.PlayerData.job.label .. ' - ' .. ESX.PlayerData.job.grade_label)
		end
		Citizen.Wait(1)
		limit = limit + 1
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

RegisterCommand('seejob', function(source, args, rawCommand)
	ESX.PlayerData = ESX.GetPlayerData()
	TriggerServerEvent('radialmenu:seesociety', GetPlayerServerId(PlayerId()), ESX.PlayerData.job.name)
end)

RegisterCommand('seemoney', function(source, args, rawCommand)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
											
	if closestDistance ~= -1 and closestDistance <= 3.0 then
		GetMoney()
		Citizen.Wait(100)
		TriggerServerEvent('radialmenu:showMoney', GetPlayerServerId(closestPlayer), money, black)
	else
		ESX.ShowNotification('Ninguém por perto', 1)
	end
end)

RegisterCommand('arrastar', function(source, args, rawCommand)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()								
    local npc = GetClosestNPC()
    if not dragging then 
        if closestDistance ~= -1 and closestDistance <= 3.0 then
            if IsEntityPlayingAnim(closestPlayer, "mp_arresting", "idle", 3) or IsEntityPlayingAnim(closestPlayer, "mp_arrest_paired", "crook_p2_back_right", 3) then
                AttachEntityToEntity(closestPlayer, GetPlayerPed(-1), 11816, -0.06, 0.65, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                LoadAnimDict('switch@trevor@escorted_out')
                TaskPlayAnim(GetPlayerPed(-1), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                dragging = true
                isped = true
            end
        else
            if npc ~= nil then
                Citizen.Wait(800)
                if IsEntityPlayingAnim(npc, "mp_arresting", "idle", 3) or IsEntityPlayingAnim(npc, "mp_arrest_paired", "crook_p2_back_right", 3) then
                    AttachEntityToEntity(npc, GetPlayerPed(-1), 11816, -0.06, 0.65, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                    LoadAnimDict('switch@trevor@escorted_out')
                    TaskPlayAnim(GetPlayerPed(-1), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                    dragging = true
                    isped = false
                end
            end
        end
    elseif dragging == true then
        if isped == false then 
            DetachEntity(npc, true, false)
        else
            TriggerServerEvent('tqrp_policejob:drag', GetPlayerServerId(closestPlayer), false)
        end
        
        StopAnimTask(GetPlayerPed(-1), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 1.0)
        dragging = false
    else
        ESX.ShowNotification('Ninguém por perto', 1)
    end
end)

function pedDrag(entity)
    while not NetworkHasControlOfEntity(entity) do
        NetworkRequestControlOfEntity(entity)
        Citizen.Wait(100)
    end
    AttachEntityToEntity(GetPlayerPed(-1), entity, 11816, -0.06, 0.65, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

function GetClosestNPC()

    local playerped = GetPlayerPed(-1)

    local playerCoords = GetEntityCoords(playerped)

    local handle, ped = FindFirstPed()

    local success

    local rped = nil

    local distanceFrom

    repeat

        local pos = GetEntityCoords(ped)

        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)

        if canPedBeUsed(ped, true) and distance < 2.0 and (distanceFrom == nil or distance < distanceFrom) then

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



    if ped == GetPlayerPed(-1) then

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

RegisterCommand('inveh', function(source, args, rawCommand)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
											
	if closestDistance ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('tqrp_policejob:notDrag', GetPlayerServerId(closestPlayer))
        TriggerServerEvent('tqrp_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
	else
		ESX.ShowNotification('Ninguém por perto', 1)
	end
end)

RegisterCommand('outveh', function(source, args, rawCommand)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
											
	if closestDistance ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('tqrp_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
	else
		ESX.ShowNotification('Ninguém por perto', 1)
	end
end)

function GetMoney()
	ESX.PlayerData = ESX.GetPlayerData()
	for i = 1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == 'black_money' then
			if ESX.PlayerData.accounts[i].money > 0 then
				black = ESX.PlayerData.accounts[i].money
			else
				black = 0
			end
		end
	end
	if ESX.PlayerData.money > 0 then
		money = ESX.PlayerData.money
	else
		money = 0
	end
end
