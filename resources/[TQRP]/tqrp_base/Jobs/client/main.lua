ESX                           = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local PlayerData              = {}
local Vehicles                = {}
local FirstSpawn              = true
local is_dead                 = false
PlayerPed            = PlayerPedId()
coords               = GetEntityCoords(PlayerPed)
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local isDead                  = false
local CurrentTask             = {}
local temChapeu               = false
local temColete               = false
local SpawnedSpikes = {}
local spikemodel = "P_ld_stinger_s"
local nearSpikes = false
local prevMaleVariation = 0
local prevFemaleVariation = 0
local femaleHash = GetHashKey("mp_f_freemode_01")
local maleHash = GetHashKey("mp_m_freemode_01")
local shieldActive = false
local shieldEntity = nil
local hadPistol = false
local animDict = "combat@gestures@gang@pistol_1h@beckon"
local animName = "0"
local prop = "prop_ballistic_shield"
local pistol = GetHashKey("WEAPON_COMBATPISTOL")
local SpeedLimit = 80.0
local dragStatus = {}
dragStatus.isDragged = false
ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	PlayerData = ESX.GetPlayerData()

	while PlayerData.job == nil do
		Citizen.Wait(100)
	end

	bleedoutTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)
	------------------------------------------------------------
	------------------------------------------------------------
	local blip = AddBlipForCoord(Config.Jobs["mechanic"].Blip.Pos.x, Config.Jobs["mechanic"].Blip.Pos.y, Config.Jobs["mechanic"].Blip.Pos.z)
	SetBlipSprite (blip, Config.Jobs["mechanic"].Blip.Sprite)
	SetBlipDisplay(blip, Config.Jobs["mechanic"].Blip.Display)
	SetBlipScale  (blip, Config.Jobs["mechanic"].Blip.Scale)
	SetBlipColour (blip, Config.Jobs["mechanic"].Blip.Colour)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Jobs["mechanic"].Label)
	EndTextCommandSetBlipName(blip)
	------------------------------------------------------------
	------------------------------------------------------------
	local blip = AddBlipForCoord(Config.Jobs["mechanic2"].Blip.Pos.x, Config.Jobs["mechanic2"].Blip.Pos.y, Config.Jobs["mechanic2"].Blip.Pos.z)
	SetBlipSprite (blip, Config.Jobs["mechanic2"].Blip.Sprite)
	SetBlipDisplay(blip, Config.Jobs["mechanic2"].Blip.Display)
	SetBlipScale  (blip, Config.Jobs["mechanic2"].Blip.Scale)
	SetBlipColour (blip, Config.Jobs["mechanic2"].Blip.Colour)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Jobs["mechanic2"].Label)
	EndTextCommandSetBlipName(blip)
	------------------------------------------------------------
	------------------------------------------------------------
	local blip = AddBlipForCoord(Config.Jobs["ambulance"].Blip.Pos.x, Config.Jobs["ambulance"].Blip.Pos.y, Config.Jobs["ambulance"].Blip.Pos.z)
	SetBlipSprite (blip, Config.Jobs["ambulance"].Blip.Sprite)
	SetBlipDisplay(blip, Config.Jobs["ambulance"].Blip.Display)
	SetBlipScale  (blip, Config.Jobs["ambulance"].Blip.Scale)
	SetBlipColour (blip, Config.Jobs["ambulance"].Blip.Colour)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Jobs["ambulance"].Label)
	EndTextCommandSetBlipName(blip)
	------------------------------------------------------------
	------------------------------------------------------------
	local blip = AddBlipForCoord(Config.Jobs["unicorn"].Blip.Pos.x, Config.Jobs["unicorn"].Blip.Pos.y, Config.Jobs["unicorn"].Blip.Pos.z)
	SetBlipSprite (blip, Config.Jobs["unicorn"].Blip.Sprite)
	SetBlipDisplay(blip, Config.Jobs["unicorn"].Blip.Display)
	SetBlipScale  (blip, Config.Jobs["unicorn"].Blip.Scale)
	SetBlipColour (blip, Config.Jobs["unicorn"].Blip.Colour)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Jobs["unicorn"].Label)
	EndTextCommandSetBlipName(blip)
	------------------------------------------------------------
	------------------------------------------------------------
	local blip = AddBlipForCoord(Config.Jobs["police"].Blip.Pos.x, Config.Jobs["police"].Blip.Pos.y, Config.Jobs["police"].Blip.Pos.z)
	SetBlipSprite (blip, Config.Jobs["police"].Blip.Sprite)
	SetBlipDisplay(blip, Config.Jobs["police"].Blip.Display)
	SetBlipScale  (blip, Config.Jobs["police"].Blip.Scale)
	SetBlipColour (blip, Config.Jobs["police"].Blip.Colour)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Jobs["police"].Label)
	EndTextCommandSetBlipName(blip)
	------------------------------------------------------------
	------------------------------------------------------------
	local blip = AddBlipForCoord(Config.Jobs["sheriff"].Blip.Pos.x, Config.Jobs["sheriff"].Blip.Pos.y, Config.Jobs["sheriff"].Blip.Pos.z)
	SetBlipSprite (blip, Config.Jobs["sheriff"].Blip.Sprite)
	SetBlipDisplay(blip, Config.Jobs["sheriff"].Blip.Display)
	SetBlipScale  (blip, Config.Jobs["sheriff"].Blip.Scale)
	SetBlipColour (blip, Config.Jobs["sheriff"].Blip.Colour)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Jobs["sheriff"].Label)
	EndTextCommandSetBlipName(blip)
	------------------------------------------------------------
	------------------------------------------------------------
	RegisterEvents()

end)

Citizen.CreateThread(function()
	while true do
		local sleep = 3000
		local closestObject = GetClosestObjectOfType(coords.x, coords.y, coords.z, 3.0, GetHashKey("prop_wheelchair_01"), false)

		if DoesEntityExist(closestObject) then
			sleep = 7

			local wheelChairCoords = GetEntityCoords(closestObject)
			local wheelChairForward = GetEntityForwardVector(closestObject)

			local sitCoords = (wheelChairCoords + wheelChairForward * - 0.5)

			if GetDistanceBetweenCoords(coords, sitCoords, true) <= 1.0 then
				DrawText3Ds(sitCoords.x, sitCoords.y, sitCoords.z, "[~g~E~w~] Sentar", 0.4)

				if IsControlJustPressed(0, 38) then
					Sit(closestObject)
				end
			end
		end

		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if inVeh then
			local vehicle = GetVehiclePedIsIn(PlayerPed, false)
			if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
				local vehiclePos = GetEntityCoords(vehicle, false)
				local spikes = GetClosestObjectOfType(vehiclePos.x, vehiclePos.y, vehiclePos.z, 40.0, GetHashKey(spikemodel), 1, 1, 1)
				if spikes ~= 0 then
					nearSpikes = true
				else
					nearSpikes = false
				end
			else
				nearSpikes = false
			end
		else
			nearSpikes = false
		end

		if not nearSpikes then
			Citizen.Wait(1500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		if nearSpikes and inVeh then
			local tires = {
				{bone = "wheel_lf", index = 0},
				{bone = "wheel_rf", index = 1},
				{bone = "wheel_lm", index = 2},
				{bone = "wheel_rm", index = 3},
				{bone = "wheel_lr", index = 4},
				{bone = "wheel_rr", index = 5}
			}

			for a = 1, #tires do
				local vehicle = GetVehiclePedIsIn(LocalPed(), false)
				local tirePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tires[a].bone))
				local spike = GetClosestObjectOfType(tirePos.x, tirePos.y, tirePos.z, 15.0, GetHashKey(spikemodel), 1, 1, 1)
				local spikePos = GetEntityCoords(spike, false)
				local distance = Vdist(tirePos.x, tirePos.y, tirePos.z, spikePos.x, spikePos.y, spikePos.z)

				if distance < 3.0 then
					if not IsVehicleTyreBurst(vehicle, tires[a].index, true) or IsVehicleTyreBurst(vehicle, tires[a].index, false) then
						SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
					end
				end
			end
		--else
		--	Citizen.Wait(1500) -- BUGOU ESTA MERDA TODA
		end
	end
end)

local IsHandcuffed = false

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

local Skillbar

RegisterNetEvent("tqrp_algemas:TryCuff")
AddEventHandler("tqrp_algemas:TryCuff", function()
	FreezeEntityPosition(PlayerPedId(), true)
	Skillbar = exports['tqrp_skillbar']:GetSkillbarObject()
	Skillbar.Start({
		duration = math.random(400, 500),
		pos = math.random(10, 80),
		width = math.random(4, 6),
	}, function()
		FreezeEntityPosition(PlayerPedId(), false)
		TriggerEvent("tqrp_algemas:forceUncuff")
	end, function()
		FreezeEntityPosition(PlayerPedId(), false)
		TriggerServerEvent("tqrp_algemas:handcuff")
	end)
end)

RegisterNetEvent("tqrp_algemas:checkCuff")
AddEventHandler("tqrp_algemas:checkCuff", function()
    local player, distance = ESX.Game.GetClosestPlayer()
	if distance~=-1 and distance<=3.0 then
		local targetPed = GetPlayerPed(player)
		local coords = GetEntityCoords(PlayerPedId())
		local coords2 = (GetEntityCoords(targetPed) + GetEntityForwardVector(targetPed)*  -0.45)
		if #(coords - coords2) < 0.5 then
			ESX.TriggerServerCallback("tqrp_algemas:isCuffed",function(cuffed)
				if not cuffed then
					LoadAnimDict('mp_arrest_paired')
					TaskPlayAnim(PlayerPed, "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, 4000, 48, 0, 0, 0, 0) 
					TriggerServerEvent("tqrp_algemas:TryCuff", GetPlayerServerId(player))
					TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'busted', 1.0)
				end
			end, GetPlayerServerId(player))
		else
            exports['mythic_notify']:SendAlert('error', 'Sem ninguém por perto')
        end
    else
        local npc = GetClosestNPC()
		if npc ~= nil then
			if not IsEntityPlayingAnim(npc, "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(npc, "mp_arrest_paired", "crook_p2_back_right", 3) then
				NetworkRegisterEntityAsNetworked(npc)
				Citizen.Wait(100)           
												
				NetworkRequestControlOfEntity(npc)            

				if not IsEntityAMissionEntity(npc) then
					SetEntityAsMissionEntity(npc)        
				end

				while not NetworkHasControlOfEntity(npc) do
					NetworkRequestControlOfEntity(npc)
					Citizen.Wait(100)
				end
            
                LoadAnimDict('mp_arrest_paired')
                local x, y, z   = table.unpack(GetEntityCoords(npc) - GetEntityForwardVector(npc) * 1.0)
                SetEntityCoords(PlayerPed, x, y, z)
                SetEntityHeading(PlayerPed, GetEntityHeading(GetPlayerPed(npc)))
                TaskPlayAnim(PlayerPed, 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8, 3750, 2, 0, 0, 0, 0)
                TaskPlayAnim(npc, 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
                Citizen.Wait(3760)
                SetPedConfigFlag(npc, 292, true)
                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'busted', 1.0)
                LoadAnimDict('mp_arresting')
                while not IsEntityPlayingAnim(npc, "mp_arresting", "idle", 3) do
                    TaskPlayAnim(npc, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                    Citizen.Wait(1000)
                end
            end
        else
            exports['mythic_notify']:SendAlert('error', 'Sem ninguém por perto')
        end
    end
end)

RegisterNetEvent("tqrp_algemas:uncuff")
AddEventHandler("tqrp_algemas:uncuff",function()
    local player, distance = ESX.Game.GetClosestPlayer()
	if distance~=-1 and distance<=3.0 then
		TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
		Citizen.Wait(5000)
		StopAnimTask(PlayerPedId(), "mp_arresting", "a_uncuff", 1.0)
        TriggerServerEvent("tqrp_algemas:uncuff", GetPlayerServerId(player))
    else
        local npc = GetClosestNPC()
		if npc ~= nil then
			if IsEntityPlayingAnim(npc, "mp_arresting", "idle", 3) or IsEntityPlayingAnim(npc, "mp_arrest_paired", "crook_p2_back_right", 3) then
				NetworkRegisterEntityAsNetworked(npc)
				Citizen.Wait(100)           
												
				NetworkRequestControlOfEntity(npc)            

				if not IsEntityAMissionEntity(npc) then
					SetEntityAsMissionEntity(npc)        
				end

				while not NetworkHasControlOfEntity(npc) do
					NetworkRequestControlOfEntity(npc)
					Citizen.Wait(100)
				end
				LoadAnimDict('mp_arresting')
				TaskPlayAnim(PlayerPed, 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
				Citizen.Wait(5500)
				ClearPedTasks(PlayerPed)
				ClearPedTasks(npc)
				StopAnimTask(npc, "mp_arresting","a_uncuff", 1.0)
				SetPedConfigFlag(npc, 292, false)
            end
        else
            exports['mythic_notify']:SendAlert('error', 'Sem ninguém por perto')
        end
    end
end)

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

RegisterNetEvent('tqrp_algemas:forceUncuff')
AddEventHandler('tqrp_algemas:forceUncuff',function()
	IsHandcuffed = false
    local playerPed = PlayerPedId()
	ClearPedSecondaryTask(playerPed)
	SetEnableHandcuffs(playerPed, false)
	ClearPedTasks(playerPed)
	ClearPedTasksImmediately(PlayerPed)
	StopAnimTask(playerPed, "mp_arrest_paired", "cop_p2_back_right", 1.0)
	if GetEntityModel(playerPed) == femaleHash then
		SetPedComponentVariation(playerPed, 7, prevFemaleVariation, 0, 0)
	elseif GetEntityModel(playerPed) == maleHash then
		SetPedComponentVariation(playerPed, 7, prevMaleVariation, 0, 0)
	end
    DisablePlayerFiring(playerPed, false)
	SetPedCanPlayGestureAnims(playerPed, true)
	while IsHandcuffed do
		IsHandcuffed = false
		Citizen.Wait(10)
	end
end)

RegisterNetEvent("tqrp_algemas:handcuff")
AddEventHandler("tqrp_algemas:handcuff",function()
    local playerPed = PlayerPedId()
    IsHandcuffed = not IsHandcuffed
    if IsHandcuffed then
        disableControls()
        anim()
    end
    Citizen.CreateThread(function()
        if IsHandcuffed then
            ClearPedTasks(playerPed)
            SetPedCanPlayAmbientBaseAnims(playerPed, true)

            Citizen.Wait(10)
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(100)
            end
            RequestAnimDict('mp_arrest_paired')
            while not HasAnimDictLoaded('mp_arrest_paired') do
                Citizen.Wait(100)
            end
			TaskPlayAnim(playerPed, "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 32, 0, 0, 0, 0)
			Citizen.Wait(5000)
            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

            SetEnableHandcuffs(playerPed, true)
            DisablePlayerFiring(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
			SetPedCanPlayGestureAnims(playerPed, false)
			if GetEntityModel(playerPed) == femaleHash then 
				prevFemaleVariation = GetPedDrawableVariation(ped, 7)
				SetPedComponentVariation(playerPed, 7, 25, 0, 0)
			elseif GetEntityModel(playerPed) == maleHash then 
				prevMaleVariation = GetPedDrawableVariation(ped, 7)
				SetPedComponentVariation(playerPed, 7, 41, 0, 0)
			end
        else
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            DisablePlayerFiring(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
			if GetEntityModel(playerPed) == femaleHash then
				SetPedComponentVariation(playerPed, 7, prevFemaleVariation, 0, 0)
			elseif GetEntityModel(playerPed) == maleHash then
				SetPedComponentVariation(playerPed, 7, prevMaleVariation, 0, 0)
			end
        end
    end)
end)

function disableControls()
    Citizen.CreateThread(function()
        while IsHandcuffed do
            Citizen.Wait(10)
            local playerPed = PlayerPedId()
            DisablePlayerFiring(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
            SetPedCanPlayGestureAnims(playerPed, false)
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 45, true) -- Reload
            --DisableControlAction(0, 22, true) -- Jump
            --DisableControlAction(0, 44, true) -- Cover
            DisableControlAction(0, 37, true) -- Select Weapon
            --DisableControlAction(0, 23, true) -- Also 'enter'?
            DisableControlAction(0, 288,  true) -- Disable phone
            DisableControlAction(0, 289, true) -- Inventory
            DisableControlAction(0, 170, true) -- Animations
            DisableControlAction(0, 167, true) -- Job
            DisableControlAction(0, 0, true) -- Disable changing view
            --DisableControlAction(0, 26, true) -- Disable looking behind
            DisableControlAction(0, 73, true) -- Disable clearing animation
            DisableControlAction(2, 199, true) -- Disable pause screen
            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle
            DisableControlAction(2, 36, true) -- Disable going stealth
            DisableControlAction(0, 47, true)  -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
        end
        if not IsHandcuffed and not IsControlEnabled(0, 140) then 
            EnableControlAction(0, 140, true) 
        end
    end)
end

function anim()
    Citizen.CreateThread(function()
        local wasgettingup = false
        while IsHandcuffed do
            Citizen.Wait(1500)
			local ped = PlayerPedId()
			if IsHandcuffed then
				if not IsEntityPlayingAnim(ped, "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(ped, "mp_arrest_paired", "crook_p2_back_right", 3) or (wasgettingup and not IsPedGettingUp(ped)) then 
					ESX.Streaming.RequestAnimDict("mp_arresting", function() TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0) end) 
				end
				wasgettingup = IsPedGettingUp(ped)
			else
				break
			end
        end
    end)
end

RegisterCommand("minar", function(source,args,rawCommand)
	exports['mythic_progbar']:Progress({
	  name = "vestir_farda",
	  duration = 5000,
	  label = "A vestir a farda",
	  useWhileDead = false,
	  canCancel = true,
	  controlDisables = {
		  disableMovement = false,
		  disableCarMovement = false,
		  disableMouse = false,
		  disableCombat = true,
	  },
	  animation = {
		  animDict = "missmic4",
		  anim = "michael_tux_fidget",
		  flags = 49,
	  }
	}, function(status) 
		if not status then
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
				  local clothesSkin = {
					  ['tshirt_1'] = 59,  ['tshirt_2'] = 0,
					  ['torso_1'] = 56,   ['torso_2'] = 0,
					  ['decals_1'] = 0,   ['decals_2'] = 0,
					  ['arms'] = 63,
					  ['pants_1'] = 98,   ['pants_2'] = 2,
					  ['shoes_1'] = 63,   ['shoes_2'] = 4,
					  ['helmet_1'] = 0,  ['helmet_2'] = 0,
					  ['mask_1'] = 0,     ['mask_2'] = 0,
					  ['chain_1'] = 0,    ['chain_2'] = 0,
					  ['ears_1'] = 0,     ['ears_2'] = 0,
					  ['glasses_1'] = 25,  ['glasses_2'] = 0,
					  ['bproof_1'] = 0,  ['bproof_2'] = 0
				  }
				  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				  ESX.UI.Menu.CloseAll()
				  --TriggerEvent("clothes:openmenucop")
				else
				  local clothesSkin = {
						  ['tshirt_1'] = 36,      ['tshirt_2'] = 0,
						  ['ears_1'] = -1,        ['ears_2'] = 0,
						  ['torso_1'] = 0,       ['torso_2'] = 0,
						  ['decals_1'] = 0,      ['decals_2']= 0,
						  ['mask_1'] = 0,         ['mask_2'] = 0,
						  ['arms'] = 76,
						  ['pants_1'] = 100,       ['pants_2'] = 2,
						  ['shoes_1'] = 36,        ['shoes_2'] = 0,
						  ['helmet_1']  = 60,     ['helmet_2'] = 1,
						  ['bags_1'] = 0,         ['bags_2'] = 0,
						  ['glasses_1'] = 27,      ['glasses_2'] = 0,
						  ['chain_1'] = 0,        ['chain_2'] = 0,
						  ['bproof_1'] = 0,       ['bproof_2'] = 0
				  }
				  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
			end)
		end
	end)

end, false)

RegisterCommand("zeto", function(source,args,rawCommand)
	exports['mythic_progbar']:Progress({
	  name = "vestir_farda",
	  duration = 5000,
	  label = "A vestir a farda",
	  useWhileDead = false,
	  canCancel = true,
	  controlDisables = {
		  disableMovement = false,
		  disableCarMovement = false,
		  disableMouse = false,
		  disableCombat = true,
	  },
	  animation = {
		  animDict = "missmic4",
		  anim = "michael_tux_fidget",
		  flags = 49,
	  }
	}, function(status) 
		if not status then
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 15,  ['tshirt_2'] = 0,
						['torso_1'] = 136,   ['torso_2'] = 2,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 30,
						['pants_1'] = 59,   ['pants_2'] = 0,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 0,  ['bproof_2'] = 0
					}
				  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				  ESX.UI.Menu.CloseAll()
				  --TriggerEvent("clothes:openmenucop")
				else
				  local clothesSkin = {
						  ['tshirt_1'] = 36,      ['tshirt_2'] = 0,
						  ['ears_1'] = -1,        ['ears_2'] = 0,
						  ['torso_1'] = 0,       ['torso_2'] = 0,
						  ['decals_1'] = 0,      ['decals_2']= 0,
						  ['mask_1'] = 0,         ['mask_2'] = 0,
						  ['arms'] = 76,
						  ['pants_1'] = 100,       ['pants_2'] = 2,
						  ['shoes_1'] = 36,        ['shoes_2'] = 0,
						  ['helmet_1']  = 60,     ['helmet_2'] = 1,
						  ['bags_1'] = 0,         ['bags_2'] = 0,
						  ['glasses_1'] = 27,      ['glasses_2'] = 0,
						  ['chain_1'] = 0,        ['chain_2'] = 0,
						  ['bproof_1'] = 0,       ['bproof_2'] = 0
				  }
				  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
			end)
		end
	end)

end, false)

RegisterCommand('cadeirarodas', function()
	LoadModel('prop_wheelchair_01')
	local wheelchair = CreateObject(GetHashKey('prop_wheelchair_01'), GetEntityCoords(PlayerPed), true)
end, false)

RegisterCommand('arrumarcadeirarodas', function()
	local wheelchair = GetClosestObjectOfType(GetEntityCoords(PlayerPed), 10.0, GetHashKey('prop_wheelchair_01'))

	if DoesEntityExist(wheelchair) then
		DeleteEntity(wheelchair)
	end
end, false)

AddEventHandler('esx:onPlayerDeath', function(reason)
	is_dead = true
	OnPlayerDeath()
end)

AddEventHandler('playerSpawned', function(spawn)
	is_dead = false
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	if FirstSpawn then
		Citizen.Wait(2000)
		TriggerServerEvent('tqrp_ambulancejob:firstSpawn')
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		FirstSpawn = false
	end
end)

AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

	PlayerData.job = job
	while PlayerData.job == nil do
		Citizen.Wait(100)
	end
	RegisterEvents()

end)

RegisterNetEvent('tqrp_ambulancejob:heal')
AddEventHandler('tqrp_ambulancejob:heal', function(healType, quiet)
	local maxHealth = GetEntityMaxHealth(PlayerPed)

	if healType == 'small' then
		local health = GetEntityHealth(PlayerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(PlayerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(PlayerPed, maxHealth)
	end
end)

RegisterNetEvent('tqrp_ambulancejob:revive')
AddEventHandler('tqrp_ambulancejob:revive', function()
	TriggerServerEvent('tqrp_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(100)
		end

		ESX.SetPlayerData('lastPosition', {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		TriggerServerEvent('esx:updateLastPosition', {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		RespawnPed(PlayerPed, {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
	end)
end)

RegisterNetEvent('tqrp_ambulancejob:requestDeath')
AddEventHandler('tqrp_ambulancejob:requestDeath', function()
	Citizen.Wait(2000)
	SetEntityHealth(PlayerPed, 0)
end)

RegisterNetEvent('tqrp_ambulancejob:useItem')
AddEventHandler('tqrp_ambulancejob:useItem', function(itemName)
	ESX.UI.Menu.CloseAll()

	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(PlayerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(1500)
			while IsEntityPlayingAnim(PlayerPed, lib, anim, 3) do
				Citizen.Wait(10)
				DisableAllControlActions(0)
			end
			SetEntityHealth(PlayerPed, GetEntityMaxHealth(PlayerPed))
            TriggerEvent('mythic_hospital:client:FieldTreatLimbs')
			TriggerEvent('tqrp_ambulancejob:heal', 'big', true)
		end)
		TriggerEvent('mythic_hospital:client:UsePainKiller', 1)
		StopScreenEffect('Rampage')
		SetPedMoveRateOverride(ped, 1.0)
		ResetPedMovementClipset(ped, 1.0)

	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(PlayerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(1500)
			while IsEntityPlayingAnim(PlayerPed, lib, anim, 3) do
				Citizen.Wait(10)
				DisableAllControlActions(0)
			end

			TriggerEvent('tqrp_ambulancejob:heal', 'small', true)
		end)
	end
end)

RegisterNetEvent('tqrp_phone:loaded')
AddEventHandler('tqrp_phone:loaded', function(phoneNumber, contacts)
	--TriggerEvent('tqrp_phone:addSpecialContact', 'Ambulance', 'ambulance', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAABp5JREFUWIW1l21sFNcVhp/58npn195de23Ha4Mh2EASSvk0CPVHmmCEI0RCTQMBKVVooxYoalBVCVokICWFVFVEFeKoUdNECkZQIlAoFGMhIkrBQGxHwhAcChjbeLcsYHvNfsx+zNz+MBDWNrYhzSvdP+e+c973XM2cc0dihFi9Yo6vSzN/63dqcwPZcnEwS9PDmYoE4IxZIj+ciBb2mteLwlZdfji+dXtNU2AkeaXhCGteLZ/X/IS64/RoR5mh9tFVAaMiAldKQUGiRzFp1wXJPj/YkxblbfFLT/tjq9/f1XD0sQyse2li7pdP5tYeLXXMMGUojAiWKeOodE1gqpmNfN2PFeoF00T2uLGKfZzTwhzqbaEmeYWAQ0K1oKIlfPb7t+7M37aruXvEBlYvnV7xz2ec/2jNs9kKooKNjlksiXhJfLqf1PXOIU9M8fmw/XgRu523eTNyhhu6xLjbSeOFC6EX3t3V9PmwBla9Vv7K7u85d3bpqlwVcvHn7B8iVX+IFQoNKdwfstuFtWoFvwp9zj5XL7nRlPXyudjS9z+u35tmuH/lu6dl7+vSVXmDUcpbX+skP65BxOOPJA4gjDicOM2PciejeTwcsYek1hyl6me5nhNnmwPXBhjYuGC699OpzoaAO0PbYJSy5vgt4idOPrJwf6QuX2FO0oOtqIgj9pDU5dCWrMlyvXf86xsGgHyPeLos83Brns1WFXLxxgVBorHpW4vfQ6KhkbUtCot6srns1TLPjNVr7+1J0PepVc92H/Eagkb7IsTWd4ZMaN+yCXv5zLRY9GQ9xuYtQz4nfreWGdH9dNlkfnGq5/kdO88ekwGan1B3mDJsdMxCqv5w2Iq0khLs48vSllrsG/Y5pfojNugzScnQXKBVA8hrX51ddHq0o6wwIlgS8Y7obZdUZVjOYLC6e3glWkBBVHC2RJ+w/qezCuT/2sV6Q5VYpowjvnf/iBJJqvpYBgBS+w6wVB5DLEOiTZHWy36nNheg0jUBs3PoJnMfyuOdAECqrZ3K7KcACGQp89RAtlysCphqZhPtRzYlcPx+ExklJUiq0le5omCfOGFAYn3qFKS/fZAWS7a3Y2wa+GJOEy4US+B3aaPUYJamj4oI5LA/jWQBt5HIK5+JfXzZsJVpXi/ac8+mxWIXWzAG4Wb4g/jscNMp63I4U5FcKaVvsNyFALokSA47Kx8PVk83OabCHZsiqwAKEpjmfUJIkoh/R+L9oTpjluhRkGSPG4A7EkS+Y3HZk0OXYpIVNy01P5yItnptDsvtIwr0SunqoVP1GG1taTHn1CloXm9aLBEIEDl/IS2W6rg+qIFEYR7+OJTesqJqYa95/VKBNOHLjDBZ8sDS2998a0Bs/F//gvu5Z9NivadOc/U3676pEsizBIN1jCYlhClL+ELJDrkobNUBfBZqQfMN305HAgnIeYi4OnYMh7q/AsAXSdXK+eH41sykxd+TV/AsXvR/MeARAttD9pSqF9nDNfSEoDQsb5O31zQFprcaV244JPY7bqG6Xd9K3C3ALgbfk3NzqNE6CdplZrVFL27eWR+UASb6479ULfhD5AzOlSuGFTE6OohebElbcb8fhxA4xEPUgdTK19hiNKCZgknB+Ep44E44d82cxqPPOKctCGXzTmsBXbV1j1S5XQhyHq6NvnABPylu46A7QmVLpP7w9pNz4IEb0YyOrnmjb8bjB129fDBRkDVj2ojFbYBnCHHb7HL+OC7KQXeEsmAiNrnTqLy3d3+s/bvlVmxpgffM1fyM5cfsPZLuK+YHnvHELl8eUlwV4BXim0r6QV+4gD9Nlnjbfg1vJGktbI5UbN/TcGmAAYDG84Gry/MLLl/zKouO2Xukq/YkCyuWYV5owTIGjhVFCPL6J7kLOTcH89ereF1r4qOsm3gjSevl85El1Z98cfhB3qBN9+dLp1fUTco+0OrVMnNjFuv0chYbBYT2HcBoa+8TALyWQOt/ImPHoFS9SI3WyRajgdt2mbJgIlbREplfveuLf/XXemjXX7v46ZxzPlfd8YlZ01My5MUEVdIY5rueYopw4fQHkbv7/rZkTw6JwjyalBCHur9iD9cI2mU0UzD3P9H6yZ1G5dt7Gwe96w07dl5fXj7vYqH2XsNovdTI6KMrlsAXhRyz7/C7FBO/DubdVq4nBLPaohcnBeMr3/2k4fhQ+Uc8995YPq2wMzNjww2X+vwNt1p00ynrd2yKDJAVN628sBX1hZIdxXdStU9G5W2bd9YHR5L3f/CNmJeY9G8WAAAAAElFTkSuQmCC')
	--TriggerEvent('tqrp_phone:addSpecialContact', "Benny'S", 'mechanic', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAABp5JREFUWIW1l21sFNcVhp/58npn195de23Ha4Mh2EASSvk0CPVHmmCEI0RCTQMBKVVooxYoalBVCVokICWFVFVEFeKoUdNECkZQIlAoFGMhIkrBQGxHwhAcChjbeLcsYHvNfsx+zNz+MBDWNrYhzSvdP+e+c973XM2cc0dihFi9Yo6vSzN/63dqcwPZcnEwS9PDmYoE4IxZIj+ciBb2mteLwlZdfji+dXtNU2AkeaXhCGteLZ/X/IS64/RoR5mh9tFVAaMiAldKQUGiRzFp1wXJPj/YkxblbfFLT/tjq9/f1XD0sQyse2li7pdP5tYeLXXMMGUojAiWKeOodE1gqpmNfN2PFeoF00T2uLGKfZzTwhzqbaEmeYWAQ0K1oKIlfPb7t+7M37aruXvEBlYvnV7xz2ec/2jNs9kKooKNjlksiXhJfLqf1PXOIU9M8fmw/XgRu523eTNyhhu6xLjbSeOFC6EX3t3V9PmwBla9Vv7K7u85d3bpqlwVcvHn7B8iVX+IFQoNKdwfstuFtWoFvwp9zj5XL7nRlPXyudjS9z+u35tmuH/lu6dl7+vSVXmDUcpbX+skP65BxOOPJA4gjDicOM2PciejeTwcsYek1hyl6me5nhNnmwPXBhjYuGC699OpzoaAO0PbYJSy5vgt4idOPrJwf6QuX2FO0oOtqIgj9pDU5dCWrMlyvXf86xsGgHyPeLos83Brns1WFXLxxgVBorHpW4vfQ6KhkbUtCot6srns1TLPjNVr7+1J0PepVc92H/Eagkb7IsTWd4ZMaN+yCXv5zLRY9GQ9xuYtQz4nfreWGdH9dNlkfnGq5/kdO88ekwGan1B3mDJsdMxCqv5w2Iq0khLs48vSllrsG/Y5pfojNugzScnQXKBVA8hrX51ddHq0o6wwIlgS8Y7obZdUZVjOYLC6e3glWkBBVHC2RJ+w/qezCuT/2sV6Q5VYpowjvnf/iBJJqvpYBgBS+w6wVB5DLEOiTZHWy36nNheg0jUBs3PoJnMfyuOdAECqrZ3K7KcACGQp89RAtlysCphqZhPtRzYlcPx+ExklJUiq0le5omCfOGFAYn3qFKS/fZAWS7a3Y2wa+GJOEy4US+B3aaPUYJamj4oI5LA/jWQBt5HIK5+JfXzZsJVpXi/ac8+mxWIXWzAG4Wb4g/jscNMp63I4U5FcKaVvsNyFALokSA47Kx8PVk83OabCHZsiqwAKEpjmfUJIkoh/R+L9oTpjluhRkGSPG4A7EkS+Y3HZk0OXYpIVNy01P5yItnptDsvtIwr0SunqoVP1GG1taTHn1CloXm9aLBEIEDl/IS2W6rg+qIFEYR7+OJTesqJqYa95/VKBNOHLjDBZ8sDS2998a0Bs/F//gvu5Z9NivadOc/U3676pEsizBIN1jCYlhClL+ELJDrkobNUBfBZqQfMN305HAgnIeYi4OnYMh7q/AsAXSdXK+eH41sykxd+TV/AsXvR/MeARAttD9pSqF9nDNfSEoDQsb5O31zQFprcaV244JPY7bqG6Xd9K3C3ALgbfk3NzqNE6CdplZrVFL27eWR+UASb6479ULfhD5AzOlSuGFTE6OohebElbcb8fhxA4xEPUgdTK19hiNKCZgknB+Ep44E44d82cxqPPOKctCGXzTmsBXbV1j1S5XQhyHq6NvnABPylu46A7QmVLpP7w9pNz4IEb0YyOrnmjb8bjB129fDBRkDVj2ojFbYBnCHHb7HL+OC7KQXeEsmAiNrnTqLy3d3+s/bvlVmxpgffM1fyM5cfsPZLuK+YHnvHELl8eUlwV4BXim0r6QV+4gD9Nlnjbfg1vJGktbI5UbN/TcGmAAYDG84Gry/MLLl/zKouO2Xukq/YkCyuWYV5owTIGjhVFCPL6J7kLOTcH89ereF1r4qOsm3gjSevl85El1Z98cfhB3qBN9+dLp1fUTco+0OrVMnNjFuv0chYbBYT2HcBoa+8TALyWQOt/ImPHoFS9SI3WyRajgdt2mbJgIlbREplfveuLf/XXemjXX7v46ZxzPlfd8YlZ01My5MUEVdIY5rueYopw4fQHkbv7/rZkTw6JwjyalBCHur9iD9cI2mU0UzD3P9H6yZ1G5dt7Gwe96w07dl5fXj7vYqH2XsNovdTI6KMrlsAXhRyz7/C7FBO/DubdVq4nBLPaohcnBeMr3/2k4fhQ+Uc8995YPq2wMzNjww2X+vwNt1p00ynrd2yKDJAVN628sBX1hZIdxXdStU9G5W2bd9YHR5L3f/CNmJeY9G8WAAAAAElFTkSuQmCC')
	--TriggerEvent('tqrp_phone:addSpecialContact', "LS Custom'S", 'mechanic2', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAABp5JREFUWIW1l21sFNcVhp/58npn195de23Ha4Mh2EASSvk0CPVHmmCEI0RCTQMBKVVooxYoalBVCVokICWFVFVEFeKoUdNECkZQIlAoFGMhIkrBQGxHwhAcChjbeLcsYHvNfsx+zNz+MBDWNrYhzSvdP+e+c973XM2cc0dihFi9Yo6vSzN/63dqcwPZcnEwS9PDmYoE4IxZIj+ciBb2mteLwlZdfji+dXtNU2AkeaXhCGteLZ/X/IS64/RoR5mh9tFVAaMiAldKQUGiRzFp1wXJPj/YkxblbfFLT/tjq9/f1XD0sQyse2li7pdP5tYeLXXMMGUojAiWKeOodE1gqpmNfN2PFeoF00T2uLGKfZzTwhzqbaEmeYWAQ0K1oKIlfPb7t+7M37aruXvEBlYvnV7xz2ec/2jNs9kKooKNjlksiXhJfLqf1PXOIU9M8fmw/XgRu523eTNyhhu6xLjbSeOFC6EX3t3V9PmwBla9Vv7K7u85d3bpqlwVcvHn7B8iVX+IFQoNKdwfstuFtWoFvwp9zj5XL7nRlPXyudjS9z+u35tmuH/lu6dl7+vSVXmDUcpbX+skP65BxOOPJA4gjDicOM2PciejeTwcsYek1hyl6me5nhNnmwPXBhjYuGC699OpzoaAO0PbYJSy5vgt4idOPrJwf6QuX2FO0oOtqIgj9pDU5dCWrMlyvXf86xsGgHyPeLos83Brns1WFXLxxgVBorHpW4vfQ6KhkbUtCot6srns1TLPjNVr7+1J0PepVc92H/Eagkb7IsTWd4ZMaN+yCXv5zLRY9GQ9xuYtQz4nfreWGdH9dNlkfnGq5/kdO88ekwGan1B3mDJsdMxCqv5w2Iq0khLs48vSllrsG/Y5pfojNugzScnQXKBVA8hrX51ddHq0o6wwIlgS8Y7obZdUZVjOYLC6e3glWkBBVHC2RJ+w/qezCuT/2sV6Q5VYpowjvnf/iBJJqvpYBgBS+w6wVB5DLEOiTZHWy36nNheg0jUBs3PoJnMfyuOdAECqrZ3K7KcACGQp89RAtlysCphqZhPtRzYlcPx+ExklJUiq0le5omCfOGFAYn3qFKS/fZAWS7a3Y2wa+GJOEy4US+B3aaPUYJamj4oI5LA/jWQBt5HIK5+JfXzZsJVpXi/ac8+mxWIXWzAG4Wb4g/jscNMp63I4U5FcKaVvsNyFALokSA47Kx8PVk83OabCHZsiqwAKEpjmfUJIkoh/R+L9oTpjluhRkGSPG4A7EkS+Y3HZk0OXYpIVNy01P5yItnptDsvtIwr0SunqoVP1GG1taTHn1CloXm9aLBEIEDl/IS2W6rg+qIFEYR7+OJTesqJqYa95/VKBNOHLjDBZ8sDS2998a0Bs/F//gvu5Z9NivadOc/U3676pEsizBIN1jCYlhClL+ELJDrkobNUBfBZqQfMN305HAgnIeYi4OnYMh7q/AsAXSdXK+eH41sykxd+TV/AsXvR/MeARAttD9pSqF9nDNfSEoDQsb5O31zQFprcaV244JPY7bqG6Xd9K3C3ALgbfk3NzqNE6CdplZrVFL27eWR+UASb6479ULfhD5AzOlSuGFTE6OohebElbcb8fhxA4xEPUgdTK19hiNKCZgknB+Ep44E44d82cxqPPOKctCGXzTmsBXbV1j1S5XQhyHq6NvnABPylu46A7QmVLpP7w9pNz4IEb0YyOrnmjb8bjB129fDBRkDVj2ojFbYBnCHHb7HL+OC7KQXeEsmAiNrnTqLy3d3+s/bvlVmxpgffM1fyM5cfsPZLuK+YHnvHELl8eUlwV4BXim0r6QV+4gD9Nlnjbfg1vJGktbI5UbN/TcGmAAYDG84Gry/MLLl/zKouO2Xukq/YkCyuWYV5owTIGjhVFCPL6J7kLOTcH89ereF1r4qOsm3gjSevl85El1Z98cfhB3qBN9+dLp1fUTco+0OrVMnNjFuv0chYbBYT2HcBoa+8TALyWQOt/ImPHoFS9SI3WyRajgdt2mbJgIlbREplfveuLf/XXemjXX7v46ZxzPlfd8YlZ01My5MUEVdIY5rueYopw4fQHkbv7/rZkTw6JwjyalBCHur9iD9cI2mU0UzD3P9H6yZ1G5dt7Gwe96w07dl5fXj7vYqH2XsNovdTI6KMrlsAXhRyz7/C7FBO/DubdVq4nBLPaohcnBeMr3/2k4fhQ+Uc8995YPq2wMzNjww2X+vwNt1p00ynrd2yKDJAVN628sBX1hZIdxXdStU9G5W2bd9YHR5L3f/CNmJeY9G8WAAAAAElFTkSuQmCC')
	--TriggerEvent('tqrp_phone:addSpecialContact', "D.P.L.S", 'police', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg==')
end)

RegisterNetEvent('tqrp_mechanicjob:onHijack')
AddEventHandler('tqrp_mechanicjob:onHijack', function()
	local coords    = GetEntityCoords(PlayerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if inVeh then
			vehicle = GetVehiclePedIsIn(PlayerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end
			TaskStartScenarioInPlace(PlayerPed, 'WORLD_HUMAN_WELDING', 0, true)
			TriggerEvent("mythic_progbar:client:progress", {
				name = "unique_action_name",
				duration = 10000,
				label = "A arranjar uns tubos...",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}
				}, function(status)
				if not status then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(PlayerPed)
				end
			end)
			TriggerServerEvent('tqrp_mechanicjob:remove', 'blowtorch')
		end
	end
end)

RegisterNetEvent('tqrp_mechanicjob:onCarokit')
AddEventHandler('tqrp_mechanicjob:onCarokit', function()
	local coords    = GetEntityCoords(PlayerPed)
	local engineRepairValue = 999.0

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if inVeh then
			vehicle = GetVehiclePedIsIn(PlayerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(PlayerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			TriggerEvent("mythic_progbar:client:progress", {
				name = "unique_action_name",
				duration = 13000,
				label = "A arranjar tudo...",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}
			    }, function(status)
				if not status then
					SetVehicleDeformationFixed(vehicle)
					SetVehicleEngineHealth(vehicle, engineRepairValue)
					SetVehicleUndriveable(vehicle, false)
					SetVehicleTyreFixed (vehicle,0,1,2,3,4)
					ClearPedTasksImmediately(PlayerPed)
					while  GetVehicleEngineHealth(vehicle) < engineRepairValue do
						SetVehicleEngineHealth(vehicle, engineRepairValue)
						Citizen.Wait(10)
					end
				end
			end)
			TriggerServerEvent('tqrp_mechanicjob:remove', 'carokit')
		end
	end
end)

RegisterNetEvent('tqrp_mechanicjob:onFixkit')
AddEventHandler('tqrp_mechanicjob:onFixkit', function()
	local coords    = GetEntityCoords(PlayerPed)
	local engineRepairValue = 999.0
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		local dimension = GetModelDimensions(GetEntityModel(vehicle), First, Second)
		local coords2
		if dimension.y > -2 then
			coords2 = (GetEntityCoords(vehicle) + GetEntityForwardVector(vehicle)*  2.0)
		elseif dimension.y > -3 then
			coords2 = (GetEntityCoords(vehicle) + GetEntityForwardVector(vehicle)*  3.0)
		elseif dimension.y < -4 then
			coords2 = (GetEntityCoords(vehicle) + GetEntityForwardVector(vehicle)*  4.5)
		else
			coords2 = (GetEntityCoords(vehicle) + GetEntityForwardVector(vehicle)*  3.5)
		end
	
		local heding = GetEntityHeading(vehicle)
		if #(coords - coords2) < 1.0 then
			SetEntityHeading(PlayerPed, heding-180)

			if DoesEntityExist(vehicle) then
				TaskStartScenarioInPlace(PlayerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
				
				Skillbar = exports['tqrp_skillbar']:GetSkillbarObject()
				Skillbar.Start({
					duration = math.random(5500, 7000),
					pos = math.random(10, 80),
					width = math.random(10, 20),
				}, function()  -- SUCESS
					Skillbar.Start({
						duration = math.random(3000, 5000),
						pos = math.random(10, 80),
						width = math.random(8, 15),
					}, function()  -- SUCESS
						Skillbar.Start({
							duration = math.random(1500, 3000),
							pos = math.random(10, 80),
							width = math.random(6, 10),
						}, function()  -- SUCESS
							SetVehicleEngineHealth(vehicle, engineRepairValue)
							SetVehicleUndriveable(vehicle, false)
							SetVehicleTyreFixed (vehicle,0,1,2,3,4)
							ClearPedTasksImmediately(PlayerPed)
							while  GetVehicleEngineHealth(vehicle) < engineRepairValue do
								SetVehicleEngineHealth(vehicle, engineRepairValue)
								Citizen.Wait(10)
							end	
						end, function()	-- ERROR
							ClearPedTasksImmediately(PlayerPed)
						end)
					end, function()	-- ERROR
						ClearPedTasksImmediately(PlayerPed)
					end)
				end, function()	-- ERROR
					ClearPedTasksImmediately(PlayerPed)
				end)

				TriggerServerEvent('tqrp_mechanicjob:remove', 'fixkit')
			end
		end
	end
end)



function SetVehicleMaxMods(vehicle)
	local props = {
	  modEngine       = Config.Jobs[PlayerData.job.name].modEngine,
	  modBrakes       = Config.Jobs[PlayerData.job.name].modBrakes,
	  modTransmission = Config.Jobs[PlayerData.job.name].modTransmission,
	  modSuspension   = Config.Jobs[PlayerData.job.name].modSuspension,
	  modTurbo        = Config.Jobs[PlayerData.job.name].modTurbo,
	}
	ESX.Game.SetVehicleProperties(vehicle, props)
	if Config.Jobs[PlayerData.job.name].PrimaryColour then
		SetVehicleCustomPrimaryColour(vehicle, Config.Jobs[PlayerData.job.name].PrimaryColour.r, Config.Jobs[PlayerData.job.name].PrimaryColour.g, Config.Jobs[PlayerData.job.name].PrimaryColour.b)
	end
	if Config.Jobs[PlayerData.job.name].SecondaryColour then
		SetVehicleCustomSecondaryColour(vehicle, Config.Jobs[PlayerData.job.name].SecondaryColour.r, Config.Jobs[PlayerData.job.name].SecondaryColour.g, Config.Jobs[PlayerData.job.name].SecondaryColour.b)
	end
end

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)

    local scale = 0.3

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

function OnPlayerDeath()
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent('tqrp_ambulancejob:setDeathStatus', true)
	exports["mythic_hospital"]:ResetAll()
	StartDeathTimer()
	--StartDistressSignal()
	--StartScreenEffect('DeathFailOut', 0, false)
	Citizen.Wait(3000)
	SetEntityHealth(PlayerPed, 100)
	SetEntityCoordsNoOffset(PlayerPed,GetEntityCoords(PlayerPed).x,GetEntityCoords(PlayerPed).y,(GetEntityCoords(PlayerPed).z + 1.5), false, false, false, true)
	SetEntityHealth(PlayerPed, 0)
end



--[[RegisterCommand("updateall", function(source,args,rawCommand)
	TriggerServerEvent("tqrp_mechanicjob:update")
end, false)]]

RegisterCommand("bennys", function(source,args,rawCommand)
	exports['mythic_progbar']:Progress({
	  name = "vestir_farda",
	  duration = 5000,
	  label = "A vestir a farda",
	  useWhileDead = false,
	  canCancel = true,
	  controlDisables = {
		  disableMovement = false,
		  disableCarMovement = false,
		  disableMouse = false,
		  disableCombat = true,
	  },
	  animation = {
		  animDict = "missmic4",
		  anim = "michael_tux_fidget",
		  flags = 49,
	  }
	})
	Citizen.Wait(5000)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
		  local clothesSkin = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 65,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 38,   ['pants_2'] = 1,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 0,     ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['glasses_1'] = 0,  ['glasses_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		  }
		  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		  ESX.UI.Menu.CloseAll()
		  --TriggerEvent("clothes:openmenucop")
		else
		  local clothesSkin = {
			['tshirt_1'] = 14,      ['tshirt_2'] = 0,
			['ears_1'] = -1,        ['ears_2'] = 0,
			['torso_1'] = 60,       ['torso_2'] = 0,
			['decals_1'] = 0,      ['decals_2']= 0,
			['mask_1'] = 0,         ['mask_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 39,       ['pants_2'] = 0,
			['shoes_1'] = 24,        ['shoes_2'] = 0,
			['helmet_1']  = -1,     ['helmet_2'] = 1,
			['bags_1'] = 0,         ['bags_2'] = 0,
			['glasses_1'] = -1,      ['glasses_2'] = 0,
			['chain_1'] = 0,        ['chain_2'] = 0,
			['bproof_1'] = 0,       ['bproof_2'] = 0
		  }
		  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)
end, false)


function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
	local canPayFine = false
	if Config.Jobs["ambulance"].EarlyRespawnFine then
		ESX.TriggerServerCallback('tqrp_ambulancejob:checkBalance', function(canPay)
			canPayFine = canPay
		end)
	end

	Citizen.CreateThread(function()
		bleedoutTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)
		while bleedoutTimer > 0 and is_dead do
			Citizen.Wait(5000)
			ClearPedTasksImmediately(PlayerPed)
			bleedoutTimer = bleedoutTimer - 5
		end
	end)

	Citizen.CreateThread(function()
		local text
		local timeHeld = 0
		local MaxtimeHeld = 60
		bleedoutTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)
		-- bleedout timer [G]
		while bleedoutTimer > 0 and is_dead do
			Citizen.Wait(7)
			text = _U('respawn_bleedout_in', secondsToClock(bleedoutTimer))
			DrawText3Ds(GetEntityCoords(PlayerPed).x,GetEntityCoords(PlayerPed).y,(GetEntityCoords(PlayerPed).z + 0.38), text)
		end
		-- bleedout timer [E]
		while ((bleedoutTimer < 1) and (is_dead) and (timeHeld <= 60)) do
			Citizen.Wait(7)
			text = _U('respawn_bleedout_prompt')
			DrawText3Ds(GetEntityCoords(PlayerPed).x,GetEntityCoords(PlayerPed).y,(GetEntityCoords(PlayerPed).z + 0.38), text .. '[~b~'.. timeHeld .. '~w~ / ~r~' .. MaxtimeHeld .. '~w~]')
			if IsControlPressed(0, 38) and timeHeld <= MaxtimeHeld then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end
			if timeHeld >= MaxtimeHeld then
				RemoveItemsAfterRPDeath()
			end
		end
	end)
end

function RemoveItemsAfterRPDeath()
	TriggerServerEvent('tqrp_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		ESX.TriggerServerCallback('tqrp_ambulancejob:removeItemsAfterRPDeath', function()
			local playerpos = GetEntityCoords(PlayerPedId())
			local playerHeading = GetEntityHeading(PlayerPedId())
				
			ESX.SetPlayerData('lastPosition', playerpos)
			ESX.SetPlayerData('loadout', {})
			RespawnPed(PlayerPedId(), playerpos, playerHeading)

			TriggerServerEvent('esx:updateLastPosition', playerpos)
			TriggerServerEvent('mythic_hospital:server:RequestBed', true)
			Citizen.Wait(10)
			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end)
end

function RespawnPed(PlayerPed, coords, heading)
	SetEntityCoordsNoOffset(PlayerPed, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(PlayerPed, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(PlayerPed)

	ESX.UI.Menu.CloseAll()
end

function OpenActionsMenu()
	local temp = Config.Jobs[PlayerData.job.name].ActionsMenu.elements.normal
	if PlayerData.job.grade_name == 'boss' then
		temp = Config.Jobs[PlayerData.job.name].ActionsMenu.elements.boss
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MENU', {
		title    = "MENU",
		align    = 'top-left',
		elements = temp
	}, function(data, menu)
		for i=1, #temp do
			if data.current.value == temp[i].value then
				if PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'mechanic2' then
					MechanicMenu(data.current.value)
					menu.close()
				end
			end
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionData = {}
	end)
end

function RegisterEvents()
	if Config.Jobs[PlayerData.job.name] ~= nil then
		if PlayerData.job.name == 'mechanic' then
			local lsMenuIsShowed	= false
			local isInLSMarker		= false
			local myCar				= {}
			local elevatorProp = nil
			local elevatorUp = false
			local elevatorDown = false
			local elevatorBaseX = -223.5853
			local elevatorBaseY = -1327.158
			local elevatorBaseZ = 29.8

			RegisterCommand("faturas", function(source, args, raw) --change command here
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
					title = _U('invoice_amount')
					}, function(data, menu)
					local amount = tonumber(data.value)

					if amount == nil or amount < 0 then
						exports['mythic_notify']:SendAlert('error', 'Valor Inválido!')
					else
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > Config.DrawDistance then
							exports['mythic_notify']:SendAlert('error', 'Nenhum jogador por perto!')
						else
							menu.close()
							TriggerServerEvent('tqrp_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanic', _U('mechanic'), amount)
							exports['mythic_notify']:SendAlert('true', 'Fatura enviada')
						end
					end
				end, function(data, menu)
					menu.close()
				end)
			end, false)

			RegisterCommand("limparveiculo", function(source, args, raw) --change command here
				local vehicle   = ESX.Game.GetVehicleInDirection()
				if IsPedSittingInAnyVehicle(PlayerPed) then
					exports['mythic_notify']:SendAlert('error', 'Tens de estar fora do veículo!')
					return
				end

				if DoesEntityExist(vehicle) then
					isBusy = true
					TaskStartScenarioInPlace(PlayerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
					Citizen.CreateThread(function()
						Citizen.Wait(10000)

						SetVehicleDirtLevel(vehicle, 0)
						ClearPedTasksImmediately(PlayerPed)

						exports['mythic_notify']:SendAlert('true', 'Veículo Limpo')
						isBusy = false
					end)
				else
					exports['mythic_notify']:SendAlert('error', 'Nenhum veículo por perto!')
				end
			end, false)

			RegisterCommand("delveiculo", function(source, args, raw) --change command here

				if IsPedSittingInAnyVehicle(PlayerPed) then
					local vehicle = GetVehiclePedIsIn(PlayerPed, false)

					if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
						exports['mythic_notify']:SendAlert('true', 'Veículo Apreedido')
						ESX.Game.DeleteVehicle(vehicle)
					else
						exports['mythic_notify']:SendAlert('error', 'Senta-te no banco principal')
					end
				else
					local vehicle = ESX.Game.GetVehicleInDirection()

					if DoesEntityExist(vehicle) then
						exports['mythic_notify']:SendAlert('true', 'Veículo Apreedido')
						ESX.Game.DeleteVehicle(vehicle)
					else
						exports['mythic_notify']:SendAlert('error', 'Aproxima-te do veículo!')
					end
				end
			end, false)

			RegisterCommand("MECsubmenu1", function(source, args, rawCommand)
				-- Wait for next frame just to be safe
				Citizen.Wait(10)
				-- Init UI and set focus
				showMenu = true
				SendNUIMessage({
					type = 'init',
					data = SubMenu["MECsubmenu1"].data,
					resourceName = GetCurrentResourceName()
				})
				SetNuiFocus(true, true)
			end, false)

			RegisterCommand("MECsubmenu2", function(source, args, rawCommand)
				-- Wait for next frame just to be safe
				Citizen.Wait(10)
				-- Init UI and set focus
				showMenu = true
				SendNUIMessage({
					type = 'init',
					data = SubMenu["MECsubmenu2"].data,
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

			RegisterNetEvent('tqrp_mechanicjob:installMod')
			AddEventHandler('tqrp_mechanicjob:installMod', function()
				local coords 		= GetEntityCoords(PlayerPed)
				local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
				myCar = ESX.Game.GetVehicleProperties(vehicle)
				TriggerServerEvent('tqrp_mechanicjob:refreshOwnedVehicle', myCar)
			end)

			RegisterNetEvent('tqrp_mechanicjob:cancelInstallMod')
			AddEventHandler('tqrp_mechanicjob:cancelInstallMod', function()
				local coords 		= GetEntityCoords(PlayerPed)
				local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
				ESX.Game.SetVehicleProperties(vehicle, myCar)
			end)

			AddEventHandler('tqrp_whitejobs:hasEnteredMarker', function(zone)

				if zone == 'MechanicActions' then
					CurrentAction     = 'mechanic_actions_menu'
					CurrentActionData = {}
				elseif zone == 'Garage' then
					CurrentAction     = 'mechanic_harvest_menu'
					CurrentActionData = {}
				elseif zone == 'Craft' then
					CurrentAction     = 'mechanic_craft_menu'
					CurrentActionData = {}
				elseif zone == 'ls1' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls2' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls3' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls4' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls5' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls6' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls7' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls8' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'VehicleDeleter' then
					if IsPedInAnyVehicle(PlayerPed, true) then
						local vehicle = GetVehiclePedIsIn(PlayerPed, false)
						CurrentAction     = 'delete_vehicle'
						CurrentActionData = {vehicle = vehicle}
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == 'mechanic' do
					Citizen.Wait(100)
					if lsMenuIsShowed then
						DisableControlAction(2, 288, true)
						DisableControlAction(2, 289, true)
						DisableControlAction(2, 170, true)
						DisableControlAction(2, 289, true)
						DisableControlAction(2, 166, true)
						DisableControlAction(2, 23, true)
						DisableControlAction(0, 75, true)  -- Disable exit vehicle
						DisableControlAction(27, 75, true) -- Disable exit vehicle
					else
						Citizen.Wait(1500)
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job == nil do
					Citizen.Wait(100)
				end
				while PlayerData.job.name == "mechanic" do
					Citizen.Wait(10)
					local coords      = GetEntityCoords(PlayerPed)
					local isInMarker  = false
					local currentZone = nil

					for k,v in pairs(Config.Jobs[PlayerData.job.name].Zones) do
						if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
							isInMarker  = true
							currentZone = k
						end
					end

					if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
						HasAlreadyEnteredMarker = true
						LastZone                = currentZone
						TriggerEvent('tqrp_whitejobs:hasEnteredMarker', currentZone)
					end

					if not isInMarker and HasAlreadyEnteredMarker then
						HasAlreadyEnteredMarker = false
						TriggerEvent('tqrp_whitejobs:hasExitedMarker', LastZone)
					end

					if not isInMarker then
						Citizen.Wait(1500)
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == 'mechanic' do
					Citizen.Wait(10)
					if HasAlreadyEnteredMarker then
						if IsControlJustReleased(0, 74) then
							if CurrentAction == 'mechanic_actions_menu' then
								OpenActionsMenu()
							elseif CurrentAction == 'ls_custom' then
								OpenLSAction()
							elseif CurrentAction == 'delete_vehicle' then
								if Config.Jobs[PlayerData.job.name].EnableSocietyOwnedVehicles then
									local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
									TriggerServerEvent('tqrp_society:putVehicleInGarage', 'mechanic', vehicleProps)
								end
								ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
							end
						end
					else
						Citizen.Wait(1500)
					end
				end
			end)

			Citizen.CreateThread(function()
				-- Update every frame
				while PlayerData.job.name == 'mechanic' do
					Citizen.Wait(10)
					-- Loop through all menus in config
					for _, menuConfig in pairs(Config.Jobs[PlayerData.job.name].Menu) do
						-- Check if menu should be enabled
						if menuConfig:enableMenu() then
							-- When keybind is pressed toggle UI
							local keybindControl = menuConfig.data.keybind
							if ((IsControlJustReleased(0, keybindControl)) and (PlayerData.job.name == 'mechanic')) then
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
							end
						end
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == 'mechanic' do
					Citizen.Wait(10)
					local elevatorCoords = GetEntityCoords(elevatorProp, false)
					if DoesEntityExist(elevatorProp) then
						SetEntityAsMissionEntity(elevatorProp ,true, true)
						while not NetworkHasControlOfEntity(elevatorProp) do
							NetworkRequestControlOfEntity(elevatorProp);
							Wait(100);
						end
						if NetworkHasControlOfEntity(elevatorProp) then
							local elevatorCoords = GetEntityCoords(elevatorProp, false)
							if elevatorUp then
								if elevatorCoords.z < 31.8 then
									elevatorBaseZ = elevatorBaseZ + 0.001
									SetEntityCoords(elevatorProp, elevatorBaseX, elevatorBaseY, elevatorBaseZ, false, false, false, false)
								end
							elseif elevatorDown then
								if elevatorCoords.z > 29.8 then
									elevatorBaseZ = elevatorBaseZ - 0.001
									SetEntityCoords(elevatorProp, elevatorBaseX, elevatorBaseY, elevatorBaseZ, false, false, false, false)
								end
							end
						end
					end

					if ((GetDistanceBetweenCoords(Config.Jobs[PlayerData.job.name].Zones.CarLift.Pos.x, Config.Jobs[PlayerData.job.name].Zones.CarLift.Pos.y, Config.Jobs[PlayerData.job.name].Zones.CarLift.Pos.z, GetEntityCoords(PlayerPed, false).x, GetEntityCoords(PlayerPed, false).y, GetEntityCoords(PlayerPed, false).z - 1) < Config.DrawDistance)) then
						if IsControlJustReleased(1, 38) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
							garage_menu = not garage_menu
							Main()
						end
					else
						if (prevMenu == nil) then
							menuOpen = false
							if garage_menu then
								garage_menu = false
							end
							currentOption = 1
						elseif not (prevMenu == nil) then
							if not Menus[prevMenu].previous == nil then
								currentOption = 1
								Menu.Switch(nil, prevMenu)
							else
								if Menus[prevMenu].optionCount < currentOption then
									currentOption = Menus[prevMenu].optionCount
								end
								Menu.Switch(Menus[prevMenu].previous, prevMenu)
							end
						end
					end

					if garage_menu then
						DisableControlAction(1, 22, true)
						DisableControlAction(1, 0, true)
						DisableControlAction(1, 27, true)
						DisableControlAction(1, 140, true)
						DisableControlAction(1, 141, true)
						DisableControlAction(1, 142, true)
						DisableControlAction(1, 20, true)

						DisableControlAction(1, 187, true)

						DisableControlAction(1, 80, true)
						DisableControlAction(1, 95, true)
						DisableControlAction(1, 96, true)
						DisableControlAction(1, 97, true)
						DisableControlAction(1, 98, true)

						DisableControlAction(1, 81, true)
						DisableControlAction(1, 82, true)
						DisableControlAction(1, 83, true)
						DisableControlAction(1, 84, true)
						DisableControlAction(1, 85, true)

						--DisableControlAction(1, 74, true)

						HideHelpTextThisFrame()
						SetCinematicButtonActive(false)
						Menu.DisplayCurMenu()
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == 'mechanic' do
					Citizen.Wait(7)
					local coords, letSleep = GetEntityCoords(PlayerPed), true
					for k,v in pairs(Config.Jobs[PlayerData.job.name].Zones) do
						if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 15) then
							DrawMarker(27, v.Pos.x, v.Pos.y, v.Pos.z - 1, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
							if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
								DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z, v.Text)
							end
							letSleep = false
						end
					end

					if letSleep then
						Citizen.Wait(1500)
					end
				end
			end)

			function isTargetVehicleATrailer(modelHash)
				if GetVehicleClassFromName(modelHash) == 11 then
					return true
				else
					return false
				end
			end

			function isVehicleATowTruck(vehicle)
				local isValid = false
				for model,posOffset in pairs(allowedTowModels) do
					if IsVehicleModel(vehicle, model) then
						xoff = posOffset.x
						yoff = posOffset.y
						zoff = posOffset.z
						isValid = true
						break
					end
				end
				return isValid
			end

			function getVehicleInDirection(coordFrom, coordTo)
				local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPed, 0)
				local vehicle = GetRaycastResult(rayHandle)
				return vehicle
			end

			function OpenLSAction()
				if IsControlJustReleased(0, 74) and not lsMenuIsShowed then
					local coords 		= GetEntityCoords(PlayerPed)
					local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
					if (vehicle ~= 0 or vehicle ~= -1) then
						SetVehicleFixed(vehicle)
						WashDecalsFromVehicle(vehicle, 1.0)
						SetVehicleDirtLevel(vehicle)
						lsMenuIsShowed = true
						FreezeEntityPosition(vehicle, true)
						SetVehicleFixed(vehicle)
						myCar = ESX.Game.GetVehicleProperties(vehicle)
						ESX.UI.Menu.CloseAll()
						GetAction({value = 'main'})
					end
				end
				if isInLSMarker and not hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = true
				end
				if not isInLSMarker and hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = false
				end
			end

			function OpenLSMenu(elems, menuName, menuTitle, parent)
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), menuName,
				{
					title    = menuTitle,
					align    = 'top-left',
					elements = elems
				}, function(data, menu)
					local isRimMod, found = false, false
					local coords 		= GetEntityCoords(PlayerPed)
					local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
					if data.current.modType == "modFrontWheels" or data.current.modType == "wheels" or data.current.modType == "modBackWheels" then
						isRimMod = true
					end
					RegisterLS()
					for k,v in pairs(Config.Jobs[PlayerData.job.name].Menus) do
						if k == data.current.modType or isRimMod then
							if string.match(data.current.label, _U('by_default')) or string.match(data.current.label, _U('installed')) then
								TriggerEvent('tqrp_mechanicjob:installMod')
							else
								local vehiclePrice = 10000
								for i=1, #Vehicles, 1 do
									if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
										vehiclePrice = Vehicles[i].price
										break
									end
								end

								if isRimMod then
									price = math.floor(vehiclePrice * data.current.price / 100)
									TriggerServerEvent("tqrp_mechanicjob:buyMod", price)

								elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
									price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 100)
									TriggerServerEvent("tqrp_mechanicjob:buyMod", price)

								elseif v.modType == 17 then
									price = math.floor(vehiclePrice * v.price[1] / 100)
									TriggerServerEvent("tqrp_mechanicjob:buyMod", price)

								else
									price = math.floor(vehiclePrice * v.price / 100)
									TriggerServerEvent("tqrp_mechanicjob:buyMod", price)

								end
							end
							menu.close()
							found = true
							break
						end
					end
					if not found then
						GetAction(data.current)
					end
				end, function(data, menu) -- on cancel
					menu.close()
					TriggerEvent('tqrp_mechanicjob:cancelInstallMod')
					local coords 		= GetEntityCoords(PlayerPed)
					local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
					SetVehicleDoorsShut(vehicle, false)
					if parent == nil then
						lsMenuIsShowed = false
						local coords 		= GetEntityCoords(PlayerPed)
						local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
						FreezeEntityPosition(vehicle, false)
						myCar = {}
					end
				end, function(data, menu) -- on change
					UpdateMods(data.current)
				end)
			end

			function UpdateMods(data)
				local coords 		= GetEntityCoords(PlayerPed)
				local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
				if data.modType ~= nil then
					local props = {}

					if data.wheelType ~= nil then
						props['wheels'] = data.wheelType
						ESX.Game.SetVehicleProperties(vehicle, props)
						props = {}
					elseif data.modType == 'neonColor' then
						if data.modNum[1] == 0 and data.modNum[2] == 0 and data.modNum[3] == 0 then
							props['neonEnabled'] = {false, false, false, false}
						else
							props['neonEnabled'] = {true, true, true, true}
						end
						ESX.Game.SetVehicleProperties(vehicle, props)
						props = {}
					elseif data.modType == 'tyreSmokeColor' then
						props['modSmokeEnabled'] = true
						ESX.Game.SetVehicleProperties(vehicle, props)
						props = {}
					end
					props[data.modType] = data.modNum
					if data.modType == 'modFrontWheels' then
						props['modBackWheels'] = data.modNum
					end
					ESX.Game.SetVehicleProperties(vehicle, props)
				end
			end

			function GetAction(data)
				if data ~= nil then
					local elements  = {}
					local menuName  = ''
					local menuTitle = ''
					local parent    = nil
					local coords 		= GetEntityCoords(PlayerPed)
					local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
					local currentMods = ESX.Game.GetVehicleProperties(vehicle)
					FreezeEntityPosition(vehicle, true)
					myCar = currentMods
					if data.value == 'modSpeakers' or
						data.value == 'modTrunk' or
						data.value == 'modHydrolic' or
						data.value == 'modEngineBlock' or
						data.value == 'modAirFilter' or
						data.value == 'modStruts' or
						data.value == 'modTank' then
						SetVehicleDoorOpen(vehicle, 4, false)
						SetVehicleDoorOpen(vehicle, 5, false)
					elseif data.value == 'modDoorSpeaker' then
						SetVehicleDoorOpen(vehicle, 0, false)
						SetVehicleDoorOpen(vehicle, 1, false)
						SetVehicleDoorOpen(vehicle, 2, false)
						SetVehicleDoorOpen(vehicle, 3, false)
					else
						SetVehicleDoorsShut(vehicle, false)
					end
					local vehiclePrice = 10000
					for i=1, #Vehicles, 1 do
						if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
							vehiclePrice = Vehicles[i].price
							break
						end
					end
					RegisterLS()
					for k,v in pairs(Config.Jobs[PlayerData.job.name].Menus) do
						if data.value == k then
							menuName  = k
							menuTitle = v.label
							parent    = v.parent
							if v.modType ~= nil then

								if v.modType == 22 then
									table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = false})
								elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- disable neon
									table.insert(elements, {label = " " ..  _U('by_default'), modType = k, modNum = {0, 0, 0}})
								elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then
									local num = myCar[v.modType]
									table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = num})
								elseif v.modType == 17 then
									table.insert(elements, {label = " " .. _U('no_turbo'), modType = k, modNum = false})
								 else
									table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = -1})
								end
								if v.modType == 14 then -- HORNS
									for j = 0, 51, 1 do
										local _label = ''
										if j == currentMods.modHorns then
											_label = GetHornName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
										else
											price = math.floor(vehiclePrice * v.price / 100)
											_label = GetHornName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
										end
										table.insert(elements, {label = _label, modType = k, modNum = j})
									end
								elseif v.modType == 'plateIndex' then -- PLATES
									for j = 0, 4, 1 do
										local _label = ''
										if j == currentMods.plateIndex then
											_label = GetPlatesName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
										else
											price = math.floor(vehiclePrice * v.price / 100)
											_label = GetPlatesName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
										end
										table.insert(elements, {label = _label, modType = k, modNum = j})
									end
								elseif v.modType == 22 then -- NEON
									local _label = ''
									if currentMods.modXenon then
										_label = _U('neon') .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
									else
										price = math.floor(vehiclePrice * v.price / 100)
										_label = _U('neon') .. ' - <span style="color:green;">$' .. price .. ' </span>'
									end
									table.insert(elements, {label = _label, modType = k, modNum = true})
								elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- NEON & SMOKE COLOR
									local neons = GetNeons()
									price = math.floor(vehiclePrice * v.price / 100)
									for i=1, #neons, 1 do
										table.insert(elements, {
											label = '<span style="color:rgb(' .. neons[i].r .. ',' .. neons[i].g .. ',' .. neons[i].b .. ');">' .. neons[i].label .. ' - <span style="color:green;">$' .. price .. '</span>',
											modType = k,
											modNum = { neons[i].r, neons[i].g, neons[i].b }
										})
									end
								elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then -- RESPRAYS
									local colors = GetColors(data.color)
									for j = 1, #colors, 1 do
										local _label = ''
										price = math.floor(vehiclePrice * v.price / 100)
										_label = colors[j].label .. ' - <span style="color:green;">$' .. price .. ' </span>'
										table.insert(elements, {label = _label, modType = k, modNum = colors[j].index})
									end
								elseif v.modType == 'windowTint' then -- WINDOWS TINT
									for j = 1, 5, 1 do
										local _label = ''
										if j == currentMods.modHorns then
											_label = GetWindowName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
										else
											price = math.floor(vehiclePrice * v.price / 100)
											_label = GetWindowName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
										end
										table.insert(elements, {label = _label, modType = k, modNum = j})
									end
								elseif v.modType == 23 then -- WHEELS RIM & TYPE
									local props = {}
									props['wheels'] = v.wheelType
									ESX.Game.SetVehicleProperties(vehicle, props)

									local modCount = GetNumVehicleMods(vehicle, v.modType)
									for j = 0, modCount, 1 do
										local modName = GetModTextLabel(vehicle, v.modType, j)
										if modName then
											local _label = ''
											if j == currentMods.modFrontWheels then
												_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
											else
												price = math.floor(vehiclePrice * v.price / 100)
												_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
											end
											table.insert(elements, {label = _label, modType = 'modFrontWheels', modNum = j, wheelType = v.wheelType, price = v.price})
										end
									end
								elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
									local modCount = GetNumVehicleMods(vehicle, v.modType) -- UPGRADES
									for j = 0, modCount, 1 do
										local _label = ''
										if j == currentMods[k] then
											_label = _U('level', j+1) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
										else
											price = math.floor(vehiclePrice * v.price[j+1] / 100)
											_label = _U('level', j+1) .. ' - <span style="color:green;">$' .. price .. ' </span>'
										end
										table.insert(elements, {label = _label, modType = k, modNum = j})
										if j == modCount-1 then
											break
										end
									end
								elseif v.modType == 17 then -- TURBO
									local _label = ''
									if currentMods[k] then
										_label = 'Turbo - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
									else
										_label = 'Turbo - <span style="color:green;">$' .. math.floor(vehiclePrice * v.price[1] / 100) .. ' </span>'
									end
									table.insert(elements, {label = _label, modType = k, modNum = true})
								elseif v.modType == 48 then -- Livery
									local _label = ''
									local modCount = tonumber(GetNumVehicleMods(vehicle, 48) or 0) + tonumber(GetVehicleLiveryCount(vehicle) or 0)
									for j = 1, modCount, 1 do
										if j == currentMods[k] then
											_label = _U('stickers') .. ' ' .. j .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
										else
											price = math.floor(vehiclePrice * v.price / 100)
											_label = _U('stickers') .. ' ' .. j .. ' - <span style="color:green;">$' .. price .. ' </span>'
										end
										table.insert(elements, {label = _label, modType = k, modNum = j})
									end
								else
									local modCount = GetNumVehicleMods(vehicle, v.modType) -- BODYPARTS
									for j = 0, modCount, 1 do
										local modName = GetModTextLabel(vehicle, v.modType, j)
										if modName then
											local _label = ''
											if j == currentMods[k] then
												_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
											else
												price = math.floor(vehiclePrice * v.price / 100)
												_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
											end
											table.insert(elements, {label = _label, modType = k, modNum = j})
										end
									end
								end
							else
								if data.value == 'primaryRespray' or data.value == 'secondaryRespray' or data.value == 'pearlescentRespray' or data.value == 'modFrontWheelsColor' then
									for i=1, #Config.Jobs[PlayerData.job.name].Colors, 1 do
										if data.value == 'primaryRespray' then
											table.insert(elements, {label = Config.Jobs[PlayerData.job.name].Colors[i].label, value = 'color1', color = Config.Jobs[PlayerData.job.name].Colors[i].value})
										elseif data.value == 'secondaryRespray' then
											table.insert(elements, {label = Config.Jobs[PlayerData.job.name].Colors[i].label, value = 'color2', color = Config.Jobs[PlayerData.job.name].Colors[i].value})
										elseif data.value == 'pearlescentRespray' then
											table.insert(elements, {label = Config.Jobs[PlayerData.job.name].Colors[i].label, value = 'pearlescentColor', color = Config.Jobs[PlayerData.job.name].Colors[i].value})
										elseif data.value == 'modFrontWheelsColor' then
											table.insert(elements, {label = Config.Jobs[PlayerData.job.name].Colors[i].label, value = 'wheelColor', color = Config.Jobs[PlayerData.job.name].Colors[i].value})
										end
									end
								else
									for l,w in pairs(v) do
										if l ~= 'label' and l ~= 'parent' then
											table.insert(elements, {label = w, value = l})
										end
									end
								end
							end
							break
						end
					end
					table.sort(elements, function(a, b)
						return a.label < b.label
					end)
					OpenLSMenu(elements, menuName, menuTitle, parent)
				end
			end

			function deleteObject(object)
				return Citizen.InvokeNative(0x539E0AE3E6634B9F, Citizen.PointerValueIntInitialized(object))
			end

			function createObject(model, x, y, z)
				RequestModel(model)
				while (not HasModelLoaded(model)) do
					Citizen.Wait(10)
				end
				return CreateObject(model, x, y, z, true, true, false)
			end

			function spawnProp(propName, x, y, z)
				local model = GetHashKey(propName)

				if IsModelValid(model) then
					elevatorProp = createObject(model, x, y, z)
					local propNetId = ObjToNet(elevatorProp)
					SetNetworkIdExistsOnAllMachines(propNetId, true)
					NetworkSetNetworkIdDynamic(propNetId, true)
					SetNetworkIdCanMigrate(propNetId, false)

					SetEntityLodDist(elevatorProp, 0xFFFF)
					SetEntityCollision(elevatorProp, true, true)
					NetworkRequestControlOfEntity(elevatorProp)
					while not IsEntityAMissionEntity(elevatorProp) do
						Wait(100)
					end
					FreezeEntityPosition(elevatorProp, true)
					SetEntityCoords(elevatorProp, x, y, z, false, false, false, false) -- Patch un bug pour certains props.
				end
			end

			function Main()
				Menu.SetupMenu("mainmenu", "BENNY'S")
				Menu.Switch(nil, "mainmenu")

				Menu.addOption("mainmenu", function() if (Menu.Option("Ligar máquina")) then
					spawnProp("nacelle", elevatorBaseX, elevatorBaseY, elevatorBaseZ)
				end end)

				Menu.addOption("mainmenu", function()
					if (Menu.Option("Desligar máquina")) then
						if DoesEntityExist(elevatorProp) then
							SetEntityAsMissionEntity(elevatorProp ,true, true)
							while not NetworkHasControlOfEntity(elevatorProp) do
								NetworkRequestControlOfEntity(elevatorProp);
								Wait(100);
							end
							deleteObject(elevatorProp)
						else
							local object = GetClosestObjectOfType(coords, 5.5, GetHashKey("nacelle"), false, false, false)
							SetEntityAsMissionEntity(object ,true, true)
							while not NetworkHasControlOfEntity(object) do
								NetworkRequestControlOfEntity(object);
								Wait(100);
							end
							ESX.Game.DeleteObject(object)
						end
					end
				end)

				Menu.addOption("mainmenu", function() if (Menu.Option("Subir")) then
					if elevatorProp ~= nil then
						elevatorDown = false
						elevatorUp = true
					end
				end end)

				Menu.addOption("mainmenu", function() if (Menu.Option("Descer")) then
					if elevatorProp ~= nil then
						elevatorUp = false
						elevatorDown = true
					end
				end end)
			end

			function GetColors(color)
				local colors = {}
				if color == 'black' then
					colors = {
						{ index = 0, label = _U('black')},
						{ index = 1, label = _U('graphite')},
						{ index = 2, label = _U('black_metallic')},
						{ index = 3, label = _U('caststeel')},
						{ index = 11, label = _U('black_anth')},
						{ index = 12, label = _U('matteblack')},
						{ index = 15, label = _U('darknight')},
						{ index = 16, label = _U('deepblack')},
						{ index = 21, label = _U('oil')},
						{ index = 147, label = _U('carbon')}
					}
				elseif color == 'white' then
					colors = {
						{ index = 106, label = _U('vanilla')},
						{ index = 107, label = _U('creme')},
						{ index = 111, label = _U('white')},
						{ index = 112, label = _U('polarwhite')},
						{ index = 113, label = _U('beige')},
						{ index = 121, label = _U('mattewhite')},
						{ index = 122, label = _U('snow')},
						{ index = 131, label = _U('cotton')},
						{ index = 132, label = _U('alabaster')},
						{ index = 134, label = _U('purewhite')}
					}
				elseif color == 'grey' then
					colors = {
						{ index = 4, label = _U('silver')},
						{ index = 5, label = _U('metallicgrey')},
						{ index = 6, label = _U('laminatedsteel')},
						{ index = 7, label = _U('darkgray')},
						{ index = 8, label = _U('rockygray')},
						{ index = 9, label = _U('graynight')},
						{ index = 10, label = _U('aluminum')},
						{ index = 13, label = _U('graymat')},
						{ index = 14, label = _U('lightgrey')},
						{ index = 17, label = _U('asphaltgray')},
						{ index = 18, label = _U('grayconcrete')},
						{ index = 19, label = _U('darksilver')},
						{ index = 20, label = _U('magnesite')},
						{ index = 22, label = _U('nickel')},
						{ index = 23, label = _U('zinc')},
						{ index = 24, label = _U('dolomite')},
						{ index = 25, label = _U('bluesilver')},
						{ index = 26, label = _U('titanium')},
						{ index = 66, label = _U('steelblue')},
						{ index = 93, label = _U('champagne')},
						{ index = 144, label = _U('grayhunter')},
						{ index = 156, label = _U('grey')}
					}
				elseif color == 'red' then
					colors = {
						{ index = 27, label = _U('red')},
						{ index = 28, label = _U('torino_red')},
						{ index = 29, label = _U('poppy')},
						{ index = 30, label = _U('copper_red')},
						{ index = 31, label = _U('cardinal')},
						{ index = 32, label = _U('brick')},
						{ index = 33, label = _U('garnet')},
						{ index = 34, label = _U('cabernet')},
						{ index = 35, label = _U('candy')},
						{ index = 39, label = _U('matte_red')},
						{ index = 40, label = _U('dark_red')},
						{ index = 43, label = _U('red_pulp')},
						{ index = 44, label = _U('bril_red')},
						{ index = 46, label = _U('pale_red')},
						{ index = 143, label = _U('wine_red')},
						{ index = 150, label = _U('volcano')}
					}
				elseif color == 'pink' then
					colors = {
						{ index = 135, label = _U('electricpink')},
						{ index = 136, label = _U('salmon')},
						{ index = 137, label = _U('sugarplum')}
					}
				elseif color == 'blue' then
					colors = {
						{ index = 54, label = _U('topaz')},
						{ index = 60, label = _U('light_blue')},
						{ index = 61, label = _U('galaxy_blue')},
						{ index = 62, label = _U('dark_blue')},
						{ index = 63, label = _U('azure')},
						{ index = 64, label = _U('navy_blue')},
						{ index = 65, label = _U('lapis')},
						{ index = 67, label = _U('blue_diamond')},
						{ index = 68, label = _U('surfer')},
						{ index = 69, label = _U('pastel_blue')},
						{ index = 70, label = _U('celeste_blue')},
						{ index = 73, label = _U('rally_blue')},
						{ index = 74, label = _U('blue_todise')},
						{ index = 75, label = _U('blue_night')},
						{ index = 77, label = _U('cyan_blue')},
						{ index = 78, label = _U('cobalt')},
						{ index = 79, label = _U('electric_blue')},
						{ index = 80, label = _U('horizon_blue')},
						{ index = 82, label = _U('metallic_blue')},
						{ index = 83, label = _U('aquamarine')},
						{ index = 84, label = _U('blue_agathe')},
						{ index = 85, label = _U('zirconium')},
						{ index = 86, label = _U('spinel')},
						{ index = 87, label = _U('tourmaline')},
						{ index = 127, label = _U('todise')},
						{ index = 140, label = _U('bubble_gum')},
						{ index = 141, label = _U('midnight_blue')},
						{ index = 146, label = _U('forbidden_blue')},
						{ index = 157, label = _U('glacier_blue')}
					}
				elseif color == 'yellow' then
					colors = {
						{ index = 42, label = _U('yellow')},
						{ index = 88, label = _U('wheat')},
						{ index = 89, label = _U('raceyellow')},
						{ index = 91, label = _U('paleyellow')},
						{ index = 126, label = _U('lightyellow')}
					}
				elseif color == 'green' then
					colors = {
						{ index = 49, label = _U('met_dark_green')},
						{ index = 50, label = _U('rally_green')},
						{ index = 51, label = _U('pine_green')},
						{ index = 52, label = _U('olive_green')},
						{ index = 53, label = _U('light_green')},
						{ index = 55, label = _U('lime_green')},
						{ index = 56, label = _U('forest_green')},
						{ index = 57, label = _U('lawn_green')},
						{ index = 58, label = _U('imperial_green')},
						{ index = 59, label = _U('green_bottle')},
						{ index = 92, label = _U('citrus_green')},
						{ index = 125, label = _U('green_anis')},
						{ index = 128, label = _U('khaki')},
						{ index = 133, label = _U('army_green')},
						{ index = 151, label = _U('dark_green')},
						{ index = 152, label = _U('hunter_green')},
						{ index = 155, label = _U('matte_foilage_green')}
					}
				elseif color == 'orange' then
					colors = {
						{ index = 36, label = _U('tangerine')},
						{ index = 38, label = _U('orange')},
						{ index = 41, label = _U('matteorange')},
						{ index = 123, label = _U('lightorange')},
						{ index = 124, label = _U('peach')},
						{ index = 130, label = _U('pumpkin')},
						{ index = 138, label = _U('orangelambo')}
					}
				elseif color == 'brown' then
					colors = {
						{ index = 45, label = _U('copper')},
						{ index = 47, label = _U('lightbrown')},
						{ index = 48, label = _U('darkbrown')},
						{ index = 90, label = _U('bronze')},
						{ index = 94, label = _U('brownmetallic')},
						{ index = 95, label = _U('Expresso')},
						{ index = 96, label = _U('chocolate')},
						{ index = 97, label = _U('terracotta')},
						{ index = 98, label = _U('marble')},
						{ index = 99, label = _U('sand')},
						{ index = 100, label = _U('sepia')},
						{ index = 101, label = _U('bison')},
						{ index = 102, label = _U('palm')},
						{ index = 103, label = _U('caramel')},
						{ index = 104, label = _U('rust')},
						{ index = 105, label = _U('chestnut')},
						{ index = 108, label = _U('brown')},
						{ index = 109, label = _U('hazelnut')},
						{ index = 110, label = _U('shell')},
						{ index = 114, label = _U('mahogany')},
						{ index = 115, label = _U('cauldron')},
						{ index = 116, label = _U('blond')},
						{ index = 129, label = _U('gravel')},
						{ index = 153, label = _U('darkearth')},
						{ index = 154, label = _U('desert')}
					}
				elseif color == 'purple' then
					colors = {
						{ index = 71, label = _U('indigo')},
						{ index = 72, label = _U('deeppurple')},
						{ index = 76, label = _U('darkviolet')},
						{ index = 81, label = _U('amethyst')},
						{ index = 142, label = _U('mysticalviolet')},
						{ index = 145, label = _U('purplemetallic')},
						{ index = 148, label = _U('matteviolet')},
						{ index = 149, label = _U('mattedeeppurple')}
					}
				elseif color == 'chrome' then
					colors = {
						{ index = 117, label = _U('brushechrome')},
						{ index = 118, label = _U('blackchrome')},
						{ index = 119, label = _U('brushedaluminum')},
						{ index = 120, label = _U('chrome')}
					}
				elseif color == 'gold' then
					colors = {
						{ index = 37, label = _U('gold')},
						{ index = 158, label = _U('puregold')},
						{ index = 159, label = _U('brushedgold')},
						{ index = 160, label = _U('lightgold')}
					}
				end
				return colors
			end

			function GetWindowName(index)
				if (index == 1) then
					return "Pure Black"
				elseif (index == 2) then
					return "Darksmoke"
				elseif (index == 3) then
					return "Lightsmoke"
				elseif (index == 4) then
					return "Limo"
				elseif (index == 5) then
					return "Green"
				else
					return "Unknown"
				end
			end

			function GetHornName(index)
				if (index == 0) then
					return "Truck Horn"
				elseif (index == 1) then
					return "Cop Horn"
				elseif (index == 2) then
					return "Clown Horn"
				elseif (index == 3) then
					return "Musical Horn 1"
				elseif (index == 4) then
					return "Musical Horn 2"
				elseif (index == 5) then
					return "Musical Horn 3"
				elseif (index == 6) then
					return "Musical Horn 4"
				elseif (index == 7) then
					return "Musical Horn 5"
				elseif (index == 8) then
					return "Sad Trombone"
				elseif (index == 9) then
					return "Classical Horn 1"
				elseif (index == 10) then
					return "Classical Horn 2"
				elseif (index == 11) then
					return "Classical Horn 3"
				elseif (index == 12) then
					return "Classical Horn 4"
				elseif (index == 13) then
					return "Classical Horn 5"
				elseif (index == 14) then
					return "Classical Horn 6"
				elseif (index == 15) then
					return "Classical Horn 7"
				elseif (index == 16) then
					return "Scale - Do"
				elseif (index == 17) then
					return "Scale - Re"
				elseif (index == 18) then
					return "Scale - Mi"
				elseif (index == 19) then
					return "Scale - Fa"
				elseif (index == 20) then
					return "Scale - Sol"
				elseif (index == 21) then
					return "Scale - La"
				elseif (index == 22) then
					return "Scale - Ti"
				elseif (index == 23) then
					return "Scale - Do"
				elseif (index == 24) then
					return "Jazz Horn 1"
				elseif (index == 25) then
					return "Jazz Horn 2"
				elseif (index == 26) then
					return "Jazz Horn 3"
				elseif (index == 27) then
					return "Jazz Horn Loop"
				elseif (index == 28) then
					return "Star Spangled Banner 1"
				elseif (index == 29) then
					return "Star Spangled Banner 2"
				elseif (index == 30) then
					return "Star Spangled Banner 3"
				elseif (index == 31) then
					return "Star Spangled Banner 4"
				elseif (index == 32) then
					return "Classical Horn 8 Loop"
				elseif (index == 33) then
					return "Classical Horn 9 Loop"
				elseif (index == 34) then
					return "Classical Horn 10 Loop"
				elseif (index == 35) then
					return "Classical Horn 8"
				elseif (index == 36) then
					return "Classical Horn 9"
				elseif (index == 37) then
					return "Classical Horn 10"
				elseif (index == 38) then
					return "Funeral Loop"
				elseif (index == 39) then
					return "Funeral"
				elseif (index == 40) then
					return "Spooky Loop"
				elseif (index == 41) then
					return "Spooky"
				elseif (index == 42) then
					return "San Andreas Loop"
				elseif (index == 43) then
					return "San Andreas"
				elseif (index == 44) then
					return "Liberty City Loop"
				elseif (index == 45) then
					return "Liberty City"
				elseif (index == 46) then
					return "Festive 1 Loop"
				elseif (index == 47) then
					return "Festive 1"
				elseif (index == 48) then
					return "Festive 2 Loop"
				elseif (index == 49) then
					return "Festive 2"
				elseif (index == 50) then
					return "Festive 3 Loop"
				elseif (index == 51) then
					return "Festive 3"
				else
					return "Unknown Horn"
				end
			end

			function GetNeons()
				local neons = {
					{label = _U('white'),		r = 255, 	g = 255, 	b = 255},
					{label = "Slate Gray",		r = 112, 	g = 128, 	b = 144},
					{label = "Blue",			r = 0, 		g = 0, 		b = 255},
					{label = "Light Blue",		r = 0, 		g = 150, 	b = 255},
					{label = "Navy Blue", 		r = 0, 		g = 0, 		b = 128},
					{label = "Sky Blue", 		r = 135, 	g = 206, 	b = 235},
					{label = "Turquoise", 		r = 0, 		g = 245, 	b = 255},
					{label = "Mint Green", 	r = 50, 	g = 255, 	b = 155},
					{label = "Lime Green", 	r = 0, 		g = 255, 	b = 0},
					{label = "Olive", 			r = 128, 	g = 128, 	b = 0},
					{label = _U('yellow'), 	r = 255, 	g = 255, 	b = 0},
					{label = _U('gold'), 		r = 255, 	g = 215, 	b = 0},
					{label = _U('orange'), 	r = 255, 	g = 165, 	b = 0},
					{label = _U('wheat'), 		r = 245, 	g = 222, 	b = 179},
					{label = _U('red'), 		r = 255, 	g = 0, 		b = 0},
					{label = _U('pink'), 		r = 255, 	g = 161, 	b = 211},
					{label = _U('brightpink'),	r = 255, 	g = 0, 		b = 255},
					{label = _U('purple'), 	r = 153, 	g = 0, 		b = 153},
					{label = "Ivory", 			r = 41, 	g = 36, 	b = 33}
				}

				return neons
			end

			function OpenVehicleExtrasMenu()
				local vehicle = GetVehiclePedIsIn(PlayerPed, false)
				local availableExtras = {}
			
				if not DoesEntityExist(vehicle) then
					return
				end
			
				for i=0, 12 do
					if DoesExtraExist(vehicle, i) then
						local state = IsVehicleExtraTurnedOn(vehicle, i) == 1
			
						table.insert(availableExtras, {
							label = ('Extra <span style="color:darkgoldenrod;">%s</span>: %s'):format(i, GetExtraLabel(state)),
							state = state,
							extraId = i
						})
					end
				end
			
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_extras', {
					title    = 'Vehicle Extras',
					align    = 'top-left',
					elements = availableExtras
				}, function(data, menu)
					ToggleVehicleExtra(vehicle, data.current.extraId, data.current.state)
			
					menu.close()
					OpenVehicleExtrasMenu()
				end, function(data, menu)
					menu.close()
				end)
			end
			
			function ToggleVehicleExtra(vehicle, extraId, extraState)
				SetVehicleExtra(vehicle, extraId, extraState)
			end
			
			function GetExtraLabel(state)
				if state then
					return '<span style="color:green;">Enabled</span>'
				elseif not state then
					return '<span style="color:darkred;">Disabled</span>'
				end
			end

			function GetPlatesName(index)
				if (index == 0) then
					return _U('blue_on_white_1')
				elseif (index == 1) then
					return _U('yellow_on_black')
				elseif (index == 2) then
					return _U('yellow_blue')
				elseif (index == 3) then
					return _U('blue_on_white_2')
				elseif (index == 4) then
					return _U('blue_on_white_3')
				end
			end

			function RegisterLS()
				if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), Config.Jobs[PlayerData.job.name].Zones.ls1.Pos.x, Config.Jobs[PlayerData.job.name].Zones.ls1.Pos.y, Config.Jobs[PlayerData.job.name].Zones.ls1.Pos.z, true) < Config.DrawDistance) or (GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), Config.Jobs[PlayerData.job.name].Zones.ls7.Pos.x, Config.Jobs[PlayerData.job.name].Zones.ls7.Pos.y, Config.Jobs[PlayerData.job.name].Zones.ls7.Pos.z, true) < Config.DrawDistance) then
				Config.Jobs[PlayerData.job.name].Menus = {
					main = {
						label = 'LS CUSTOMS',
						parent = nil,
						cosmetics = _U('cosmetics')
					},
						cosmetics = {
						label				= _U('cosmetics'),
						parent				= 'main',
						bodyparts			= _U('bodyparts'),
						windowTint			= _U('windowtint'),
						modHorns			= _U('horns'),
						neonColor			= _U('neons'),
						modXenon			= _U('headlights'),
						plateIndex			= _U('licenseplates'),
						wheels				= _U('wheels'),
						modPlateHolder		= _U('modplateholder'),
						modVanityPlate		= _U('modvanityplate'),
						modTrimA			= _U('interior'),
						modOrnaments		= _U('trim'),
						modDashboard		= _U('dashboard'),
						modDial				= _U('speedometer'),
						modDoorSpeaker		= _U('door_speakers'),
						modSeats			= _U('seats'),
						modSteeringWheel	= _U('steering_wheel'),
						modShifterLeavers	= _U('gear_lever'),
						modAPlate			= _U('quarter_deck'),
						modSpeakers			= _U('speakers'),
						modTrunk			= _U('trunk'),
						modHydrolic			= _U('hydraulic'),
						modEngineBlock		= _U('engine_block'),
						modAirFilter		= _U('air_filter'),
						modStruts			= _U('struts'),
						modArchCover		= _U('arch_cover'),
						modAerials			= _U('aerials'),
						modTrimB			= _U('wings'),
						modTank				= _U('fuel_tank'),
						modWindows			= _U('windows')
					},

					modPlateHolder = {
						label = 'Plaque - Contour',
						parent = 'cosmetics',
						modType = 25,
						price = 0.8
					},
					modVanityPlate = {
						label = 'Plaque - Avant',
						parent = 'cosmetics',
						modType = 26,
						price = 0.8
					},
					modTrimA = {
						label = 'Intérieur',
						parent = 'cosmetics',
						modType = 27,
						price = 1.2
					},
					modOrnaments = {
						label = 'Ornements',
						parent = 'cosmetics',
						modType = 28,
						price = 1.2
					},
					modDashboard = {
						label = 'Tableau de bord',
						parent = 'cosmetics',
						modType = 29,
						price = 0.9
					},
					modDial = {
						label = 'Compteur de vitesse',
						parent = 'cosmetics',
						modType = 30,
						price = 0.9
					},
					modDoorSpeaker = {
						label = 'Sono portière',
						parent = 'cosmetics',
						modType = 31,
						price = 0.9
					},
					modSeats = {
						label = 'Siège',
						parent = 'cosmetics',
						modType = 32,
						price = 0.9
					},
					modSteeringWheel = {
						label = 'Volant',
						parent = 'cosmetics',
						modType = 33,
						price = 0.9
					},
					modShifterLeavers = {
						label = 'Levier de vitesse',
						parent = 'cosmetics',
						modType = 34,
						price = 0.4
					},
					modAPlate = {
						label = 'Plage arrière',
						parent = 'cosmetics',
						modType = 35,
						price = 0.9
					},
					modSpeakers = {
						label = 'Sono',
						parent = 'cosmetics',
						modType = 36,
						price = 0.9
					},
					modTrunk = {
						label = 'Coffre',
						parent = 'cosmetics',
						modType = 37,
						price = 0.9
					},
					modHydrolic = {
						label = 'Hydrolique',
						parent = 'cosmetics',
						modType = 38,
						price = 0.9
					},
					modEngineBlock = {
						label = 'Bloc moteur',
						parent = 'cosmetics',
						modType = 39,
						price = 0.9
					},
					modAirFilter = {
						label = 'Filtre a air',
						parent = 'cosmetics',
						modType = 40,
						price = 1.9
					},
					modStruts = {
						label = 'Struts',
						parent = 'cosmetics',
						modType = 41,
						price = 1.9
					},
					modArchCover = {
						label = 'Cache-roues',
						parent = 'cosmetics',
						modType = 42,
						price = 0.9
					},
					modAerials = {
						label = 'Antennes',
						parent = 'cosmetics',
						modType = 43,
						price = 0.9
					},
					modTrimB = {
						label = 'Ailes',
						parent = 'cosmetics',
						modType = 44,
						price = 1.9
					},
					modTank = {
						label = 'Réservoir',
						parent = 'cosmetics',
						modType = 45,
						price = 0.9
					},
					modWindows = {
						label = 'Fenêtres',
						parent = 'cosmetics',
						modType = 46,
						price = 0.9
					},

					wheels = {
						label = _U('wheels'),
						parent = 'cosmetics',
						modFrontWheelsTypes = _U('wheel_type'),
						tyreSmokeColor = _U('tiresmoke')
					},
					modFrontWheelsTypes = {
						label               = _U('wheel_type'),
						parent              = 'wheels',
						modFrontWheelsType0 = _U('sport'),
						modFrontWheelsType1 = _U('muscle'),
						modFrontWheelsType2 = _U('lowrider'),
						modFrontWheelsType3 = _U('suv'),
						modFrontWheelsType4 = _U('allterrain'),
						modFrontWheelsType5 = _U('tuning'),
						modFrontWheelsType6 = _U('motorcycle'),
						modFrontWheelsType7 = _U('highend')
					},
					modFrontWheelsType0 = {
						label = _U('sport'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 0,
						price = 0.9
					},
					modFrontWheelsType1 = {
						label = _U('muscle'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 1,
						price = 0.9
					},
					modFrontWheelsType2 = {
						label = _U('lowrider'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 2,
						price = 0.9
					},
					modFrontWheelsType3 = {
						label = _U('suv'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 3,
						price = 0.9
					},
					modFrontWheelsType4 = {
						label = _U('allterrain'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 4,
						price = 0.9
					},
					modFrontWheelsType5 = {
						label = _U('tuning'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 5,
						price = 0.9
					},
					modFrontWheelsType6 = {
						label = _U('motorcycle'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 6,
						price = 0.9
					},
					modFrontWheelsType7 = {
						label = _U('highend'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 7,
						price = 0.9
					},
					modFrontWheelsColor = {
						label = 'Peinture Jantes',
						parent = 'wheels'
					},
					wheelColor = {
						label = 'Peinture Jantes',
						parent = 'modFrontWheelsColor',
						modType = 'wheelColor',
						price = 0.9
					},
					plateIndex = {
						label = _U('licenseplates'),
						parent = 'cosmetics',
						modType = 'plateIndex',
						price = 0.9
					},
					modXenon = {
						label = _U('headlights'),
						parent = 'cosmetics',
						modType = 22,
						price = 5.9
					},
					bodyparts = {
						label = _U('bodyparts'),
						parent = 'cosmetics',
						modFender = _U('leftfender'),
						modRightFender = _U('rightfender'),
						modSpoilers = _U('spoilers'),
						modSideSkirt = _U('sideskirt'),
						modFrame = _U('cage'),
						modHood = _U('hood'),
						modGrille = _U('grille'),
						modRearBumper = _U('rearbumper'),
						modFrontBumper = _U('frontbumper'),
						modExhaust = _U('exhaust'),
						modRoof = _U('roof')
					},
					modSpoilers = {
						label = _U('spoilers'),
						parent = 'bodyparts',
						modType = 0,
						price = 0.9
					},
					modFrontBumper = {
						label = _U('frontbumper'),
						parent = 'bodyparts',
						modType = 1,
						price = 0.9
					},
					modRearBumper = {
						label = _U('rearbumper'),
						parent = 'bodyparts',
						modType = 2,
						price = 0.9
					},
					modSideSkirt = {
						label = _U('sideskirt'),
						parent = 'bodyparts',
						modType = 3,
						price = 0.9
					},
					modExhaust = {
						label = _U('exhaust'),
						parent = 'bodyparts',
						modType = 4,
						price = 0.9
					},
					modFrame = {
						label = _U('cage'),
						parent = 'bodyparts',
						modType = 5,
						price = 0.9
					},
					modGrille = {
						label = _U('grille'),
						parent = 'bodyparts',
						modType = 6,
						price = 1.9
					},
					modHood = {
						label = _U('hood'),
						parent = 'bodyparts',
						modType = 7,
						price = 1.9
					},
					modFender = {
						label = _U('leftfender'),
						parent = 'bodyparts',
						modType = 8,
						price = 0.9
					},
					modRightFender = {
						label = _U('rightfender'),
						parent = 'bodyparts',
						modType = 9,
						price = 0.9
					},
					modRoof = {
						label = _U('roof'),
						parent = 'bodyparts',
						modType = 10,
						price = 0.9
					},
					windowTint = {
						label = _U('windowtint'),
						parent = 'cosmetics',
						modType = 'windowTint',
						price = 0.9
					},
					modHorns = {
						label = _U('horns'),
						parent = 'cosmetics',
						modType = 14,
						price = 0.9
					},
					neonColor = {
						label = _U('neons'),
						parent = 'cosmetics',
						modType = 'neonColor',
						price = 3.9
					},
					tyreSmokeColor = {
						label = _U('tiresmoke'),
						parent = 'wheels',
						modType = 'tyreSmokeColor',
						price = 0.9
					}

				}
				elseif (GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), Config.Jobs[PlayerData.job.name].Zones.ls2.Pos.x, Config.Jobs[PlayerData.job.name].Zones.ls2.Pos.y, Config.Jobs[PlayerData.job.name].Zones.ls2.Pos.z, true) < Config.DrawDistance) or (GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), Config.Jobs[PlayerData.job.name].Zones.ls4.Pos.x, Config.Jobs[PlayerData.job.name].Zones.ls4.Pos.y, Config.Jobs[PlayerData.job.name].Zones.ls4.Pos.z, true) < Config.DrawDistance) or (GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), Config.Jobs[PlayerData.job.name].Zones.ls8.Pos.x, Config.Jobs[PlayerData.job.name].Zones.ls8.Pos.y, Config.Jobs[PlayerData.job.name].Zones.ls8.Pos.z, true) < Config.DrawDistance) then
					Config.Jobs[PlayerData.job.name].Menus = {
						main = {
							label = 'LS CUSTOMS',
							parent = nil,
							cosmetics = _U('cosmetics')
						},
							cosmetics = {
							label				= _U('cosmetics'),
							parent				= 'main',
							resprays			= _U('respray'),
							wheels				= _U('wheels'),
							modLivery			= _U('stickers')
						},
						modLivery = {
							label = 'Stickers',
							parent = 'cosmetics',
							modType = 48,
							price = 1.9
						},

						wheels = {
							label = _U('wheels'),
							parent = 'cosmetics',
							modFrontWheelsColor = _U('wheel_color')
						},
						modFrontWheelsColor = {
							label = 'Peinture Jantes',
							parent = 'wheels'
						},
						wheelColor = {
							label = 'Peinture Jantes',
							parent = 'modFrontWheelsColor',
							modType = 'wheelColor',
							price = 0.99
						},
						resprays = {
							label = _U('respray'),
							parent = 'cosmetics',
							primaryRespray = _U('primary'),
							secondaryRespray = _U('secondary'),
							pearlescentRespray = _U('pearlescent'),
						},
						primaryRespray = {
							label = _U('primary'),
							parent = 'resprays',
						},
						secondaryRespray = {
							label = _U('secondary'),
							parent = 'resprays',
						},
						pearlescentRespray = {
							label = _U('pearlescent'),
							parent = 'resprays',
						},
						color1 = {
							label = _U('primary'),
							parent = 'primaryRespray',
							modType = 'color1',
							price = 0.9
						},
						color2 = {
							label = _U('secondary'),
							parent = 'secondaryRespray',
							modType = 'color2',
							price = 0.5
						},
						pearlescentColor = {
							label = _U('pearlescent'),
							parent = 'pearlescentRespray',
							modType = 'pearlescentColor',
							price = 1.10
						}

					}
				elseif (GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), Config.Jobs[PlayerData.job.name].Zones.ls3.Pos.x, Config.Jobs[PlayerData.job.name].Zones.ls3.Pos.y, Config.Jobs[PlayerData.job.name].Zones.ls3.Pos.z, true) < Config.DrawDistance) or (GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), Config.Jobs[PlayerData.job.name].Zones.ls5.Pos.x, Config.Jobs[PlayerData.job.name].Zones.ls5.Pos.y, Config.Jobs[PlayerData.job.name].Zones.ls5.Pos.z, true) < Config.DrawDistance) or (GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), Config.Jobs[PlayerData.job.name].Zones.ls6.Pos.x, Config.Jobs[PlayerData.job.name].Zones.ls6.Pos.y, Config.Jobs[PlayerData.job.name].Zones.ls6.Pos.z, true) < Config.DrawDistance) then
					Config.Jobs[PlayerData.job.name].Menus = {
						main = {
							label = 'LS CUSTOMS',
							parent = nil,
							upgrades = _U('upgrades')
						},
						upgrades = {
							label = _U('upgrades'),
							parent = 'main',
							modEngine = _U('engine'),
							modBrakes = _U('brakes'),
							modTransmission = _U('transmission'),
							modSuspension = _U('suspension'),
							modArmor = _U('armor'),
							modTurbo = _U('turbo')
						},
						modEngine = {
							label = _U('engine'),
							parent = 'upgrades',
							modType = 11,
							price = {0.5, 0.9, 1.5, 2.8}
						},
						modBrakes = {
							label = _U('brakes'),
							parent = 'upgrades',
							modType = 12,
							price = {1.10, 2.0, 2.2, 2.6}
						},
						modTransmission = {
							label = _U('transmission'),
							parent = 'upgrades',
							modType = 13,
							price = {1.5, 2.0, 2.4}
						},
						modSuspension = {
							label = _U('suspension'),
							parent = 'upgrades',
							modType = 15,
							price = {1.2, 1.4, 1.5, 1.9, 2.0}
						},
						modArmor = {
							label = _U('armor'),
							parent = 'upgrades',
							modType = 16,
							price = {2.0, 3.0, 3.2, 4.0, 4.4, 4.8}
						},
						modTurbo = {
							label = _U('turbo'),
							parent = 'upgrades',
							modType = 17,
							price = {1.00}
						}
					}
				end
			end

			function MechanicMenu(data)
				if data == 'vehicle_list' then
					if Config.Jobs[PlayerData.job.name].EnableSocietyOwnedVehicles then
						local elements = {}
						ESX.TriggerServerCallback('tqrp_society:getVehiclesInGarage', function(vehicles)
							for i=1, #vehicles, 1 do
								table.insert(elements, {
									label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
									value = vehicles[i]
								})
							end

							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
								title    = _U('service_vehicle'),
								align    = 'top-left',
								elements = elements
							}, function(data, menu)
								menu.close()
								local vehicleProps = data.current.value

								ESX.Game.SpawnVehicle(vehicleProps.model, Config.Jobs[PlayerData.job.name].Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
									TriggerEvent("onyx:updatePlates", ESX.Game.GetVehicleProperties(vehicle).plate)
									SetVehicleMaxMods(vehicle)
								end)
								TriggerEvent("onyx:updatePlates", GetVehicleProperties(vehicle).plate)
								TriggerServerEvent('tqrp_society:removeVehicleFromGarage', PlayerData.job.name, vehicleProps)
							end, function(data, menu)
								menu.close()
							end)
						end, PlayerData.job.name)
					else
						local elements = {
							{label = "Reboque Prancha",  value = 'flatbed3'},
							{label = "Reboque Guincho 2",  value = 'towtruck'},
							{label = "Reboque Guincho", value = 'towtruck2'}

						}
						ESX.UI.Menu.CloseAll()
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
							title    = _U('service_vehicle'),
							align    = 'top-left',
							elements = elements
						}, function(data, menu)
							ESX.Game.SpawnVehicle(data.current.value, Config.Jobs[PlayerData.job.name].Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
								ESX.Game.SetVehicleProperties(vehicle, {
									modLivery = 0
								})
								--TaskWarpPedIntoVehicle(PlayerPed, vehicle, -1)
								SetVehicleMaxMods(vehicle)
								Citizen.Wait(100)
								TriggerEvent("onyx:updatePlates", ESX.Game.GetVehicleProperties(vehicle).plate)
							end)
							menu.close()
						end, function(data, menu)
							menu.close()
							MechanicMenu()
						end)
					end
				elseif data == 'cloakroom' then
					ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin, jobSkin)
						if skin.sex == 0 then
							TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
						else
							TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
						end
					end)
				elseif data == 'cloakroom2' then
					ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin, jobSkin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)
				elseif data == 'buy' then
					OpenBuyMenu()
				elseif data == 'boss_actions' then
					TriggerEvent('tqrp_society:openBossMenu', 'mechanic', function(data, menu)
						menu.close()
					end)
				end
			end

			function OpenBuyMenu()
				local elements = {
					--{label = _U('blowtorch'),  value = 'blowtorch'},
					{label = _U('repair_kit'), value = 'fixkit'},
					{label = _U('body_kit'),   value = 'carokit'}
				}
				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic', {
					title    = 'Menu de compra',
					align    = 'top-left',
					elements = elements
				}, function(data, menu)
					menu.close()
					--if data.current.value == 'blowtorch' then
					--	TriggerServerEvent('tqrp_mechanicjob:buy', 'blowtorch', 35)
					--else
					if data.current.value == 'fixkit' then
						TriggerServerEvent('tqrp_mechanicjob:buy', 'fixkit', 20)
					elseif data.current.value == 'carokit' then
						TriggerServerEvent('tqrp_mechanicjob:buy', 'carokit', 25)
					end
				end, function(data, menu)
					menu.close()
				end)
			end

			ESX.TriggerServerCallback('tqrp_mechanicjob:getVehiclesPrices', function(vehicles)
				Vehicles = vehicles
			end)

		elseif PlayerData.job.name == 'mechanic2' then

			local lsMenuIsShowed	= false
			local isInLSMarker		= false
			local myCar				= {}
			--[[local elevatorProp = nil
			local elevatorUp = false
			local elevatorDown = false
			local elevatorBaseX = -223.5853
			local elevatorBaseY = -1327.158
			local elevatorBaseZ = 29.8]]

			ESX.TriggerServerCallback('tqrp_mechanicjob:getVehiclesPrices', function(vehicles)
				Vehicles = vehicles
			end)

			RegisterCommand("faturas", function(source, args, raw) --change command here
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
					title = _U('invoice_amount')
					}, function(data, menu)
					local amount = tonumber(data.value)

					if amount == nil or amount < 0 then
						exports['mythic_notify']:SendAlert('error', 'Valor Inválido!')
					else
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > Config.DrawDistance then
							exports['mythic_notify']:SendAlert('error', 'Nenhum jogador por perto!')
						else
							menu.close()
							TriggerServerEvent('tqrp_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanic2', _U('mechanic'), amount)
							exports['mythic_notify']:SendAlert('true', 'Fatura enviada')
						end
					end
				end, function(data, menu)
					menu.close()
				end)
			end, false)

			RegisterCommand("limparveiculo", function(source, args, raw) --change command here
				local vehicle   = ESX.Game.GetVehicleInDirection()

				if IsPedSittingInAnyVehicle(PlayerPed) then
					exports['mythic_notify']:SendAlert('error', 'Tens de estar fora do veículo!')
					return
				end

				if DoesEntityExist(vehicle) then
					isBusy = true
					TaskStartScenarioInPlace(PlayerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
					Citizen.CreateThread(function()
						Citizen.Wait(10000)

						SetVehicleDirtLevel(vehicle, 0)
						ClearPedTasksImmediately(PlayerPed)

						exports['mythic_notify']:SendAlert('true', 'Veículo Limpo')
						isBusy = false
					end)
				else
					exports['mythic_notify']:SendAlert('error', 'Nenhum veículo por perto!')
				end
			end, false)

			RegisterCommand("delveiculo", function(source, args, raw) --change command here

				if IsPedSittingInAnyVehicle(PlayerPed) then
					local vehicle = GetVehiclePedIsIn(PlayerPed, false)

					if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
						exports['mythic_notify']:SendAlert('true', 'Veículo Apreedido')
						ESX.Game.DeleteVehicle(vehicle)
					else
						exports['mythic_notify']:SendAlert('error', 'Senta-te no banco principal')
					end
				else
					local vehicle = ESX.Game.GetVehicleInDirection()

					if DoesEntityExist(vehicle) then
						exports['mythic_notify']:SendAlert('true', 'Veículo Apreedido')
						ESX.Game.DeleteVehicle(vehicle)
					else
						exports['mythic_notify']:SendAlert('error', 'Aproxima-te do veículo!')
					end
				end
			end, false)

			RegisterCommand("MECsubmenu1", function(source, args, rawCommand)
				-- Wait for next frame just to be safe
				Citizen.Wait(10)
				-- Init UI and set focus
				showMenu = true
				SendNUIMessage({
					type = 'init',
					data = SubMenu["MECsubmenu1"].data,
					resourceName = GetCurrentResourceName()
				})
				SetNuiFocus(true, true)
			end, false)

			RegisterCommand("MECsubmenu2", function(source, args, rawCommand)
				-- Wait for next frame just to be safe
				Citizen.Wait(10)
				-- Init UI and set focus
				showMenu = true
				SendNUIMessage({
					type = 'init',
					data = SubMenu["MECsubmenu2"].data,
					resourceName = GetCurrentResourceName()
				})
				SetNuiFocus(true, true)
			end, false)

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

			RegisterNetEvent('tqrp_mechanicjob:installMod')
			AddEventHandler('tqrp_mechanicjob:installMod', function()
				local coords 		= GetEntityCoords(PlayerPed)
				local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
				myCar = ESX.Game.GetVehicleProperties(vehicle)
				TriggerServerEvent('tqrp_mechanicjob:refreshOwnedVehicle', myCar)
			end)

			RegisterNetEvent('tqrp_mechanicjob:cancelInstallMod')
			AddEventHandler('tqrp_mechanicjob:cancelInstallMod', function()
				local coords 		= GetEntityCoords(PlayerPed)
				local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
				ESX.Game.SetVehicleProperties(vehicle, myCar)
			end)

			AddEventHandler('tqrp_whitejobs:hasEnteredMarker', function(zone)

				if zone == 'MechanicActions' then
					CurrentAction     = 'mechanic_actions_menu'
					CurrentActionData = {}
				elseif zone == 'Garage' then
					CurrentAction     = 'mechanic_harvest_menu'
					CurrentActionData = {}
				elseif zone == 'Craft' then
					CurrentAction     = 'mechanic_craft_menu'
					CurrentActionData = {}
				elseif zone == 'ls1' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls2' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls3' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls4' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls5' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls6' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls7' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls8' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'ls9' then
					CurrentAction     = 'ls_custom'
					CurrentActionData = {}
				elseif zone == 'VehicleDeleter' then
					if IsPedInAnyVehicle(PlayerPed) then
						local vehicle = GetVehiclePedIsIn(PlayerPed)
						CurrentAction     = 'delete_vehicle'
						CurrentActionData = {vehicle = vehicle}
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == 'mechanic2' do
					Citizen.Wait(100)
					if lsMenuIsShowed then
						DisableControlAction(2, 288, true)
						DisableControlAction(2, 289, true)
						DisableControlAction(2, 170, true)
						DisableControlAction(2, 289, true)
						DisableControlAction(2, 166, true)
						DisableControlAction(2, 23, true)
						DisableControlAction(0, 75, true)  -- Disable exit vehicle
						DisableControlAction(27, 75, true) -- Disable exit vehicle
					else
						Citizen.Wait(1500)
					end
				end
			end)

			Citizen.CreateThread(function()
				-- Update every frame
				while PlayerData.job.name == 'mechanic2' do
					Citizen.Wait(10)
					-- Loop through all menus in config
					for _, menuConfig in pairs(Config.Jobs[PlayerData.job.name].Menu) do
						-- Check if menu should be enabled
						if menuConfig:enableMenu() then
							-- When keybind is pressed toggle UI
							local keybindControl = menuConfig.data.keybind
							if ((IsControlJustReleased(0, keybindControl)) and (PlayerData.job.name == 'mechanic2')) then
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
							end
						end
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == 'mechanic2' do
					Citizen.Wait(7)
					local coords, letSleep = GetEntityCoords(PlayerPed), true
					for k,v in pairs(Config.Jobs[PlayerData.job.name].Zones) do
						if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 15) then
							DrawMarker(27, v.Pos.x, v.Pos.y, v.Pos.z - 1, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
							isInLSMarker = false
							if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
								DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z, v.Text)
							end
							letSleep = false
						end
					end

					if letSleep then
						Citizen.Wait(1500)
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job == nil do
					Citizen.Wait(100)
				end
				while PlayerData.job.name == "mechanic2" do
					Citizen.Wait(10)
					local coords      = GetEntityCoords(PlayerPed)
					local isInMarker  = false
					local currentZone = nil

					for k,v in pairs(Config.Jobs[PlayerData.job.name].Zones) do
						if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
							isInMarker  = true
							currentZone = k
						end
					end

					if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
						HasAlreadyEnteredMarker = true
						LastZone                = currentZone
						TriggerEvent('tqrp_whitejobs:hasEnteredMarker', currentZone)
					end

					if not isInMarker and HasAlreadyEnteredMarker then
						HasAlreadyEnteredMarker = false
						TriggerEvent('tqrp_whitejobs:hasExitedMarker', LastZone)
					end

					if not isInMarker then
						Citizen.Wait(1500)
					end
				end
			end)


			Citizen.CreateThread(function()
				while PlayerData.job.name == 'mechanic2' do
					Citizen.Wait(10)
					if IsControlJustReleased(0, 74) and HasAlreadyEnteredMarker then
						if CurrentAction == 'mechanic_actions_menu' then
							OpenActionsMenu()
						elseif CurrentAction == 'ls_custom' then
							OpenLSAction()
						elseif CurrentAction == 'delete_vehicle' then
							if Config.Jobs[PlayerData.job.name].EnableSocietyOwnedVehicles then
								local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
								TriggerServerEvent('tqrp_society:putVehicleInGarage', 'mechanic2', vehicleProps)
							end
							ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
						end
					end
				end
			end)

			function isTargetVehicleATrailer(modelHash)
				if GetVehicleClassFromName(modelHash) == 11 then
					return true
				else
					return false
				end
			end

			function isVehicleATowTruck(vehicle)
				local isValid = false
				for model,posOffset in pairs(allowedTowModels) do
					if IsVehicleModel(vehicle, model) then
						xoff = posOffset.x
						yoff = posOffset.y
						zoff = posOffset.z
						isValid = true
						break
					end
				end
				return isValid
			end

			function getVehicleInDirection(coordFrom, coordTo)
				local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPed, 0)
				local vehicle = GetRaycastResult(rayHandle)
				return vehicle
			end

			function OpenLSAction()
				if IsControlJustReleased(0, 74) and not lsMenuIsShowed then
					local coords 		= GetEntityCoords(PlayerPed)
					local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
					if (vehicle ~= 0 or vehicle ~= -1) then
						SetVehicleFixed(vehicle)
						lsMenuIsShowed = true
						FreezeEntityPosition(vehicle, true)
						myCar = ESX.Game.GetVehicleProperties(vehicle)
						ESX.UI.Menu.CloseAll()
						GetAction({value = 'main'})
					end
				end
				if isInLSMarker and not hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = true
				end
				if not isInLSMarker and hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = false
				end
			end

			function OpenLSMenu(elems, menuName, menuTitle, parent)
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), menuName,
				{
					title    = menuTitle,
					align    = 'top-left',
					elements = elems
				}, function(data, menu)
					local isRimMod, found = false, false
					local coords 		= GetEntityCoords(PlayerPed)
					local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
					if data.current.modType == "modFrontWheels" or data.current.modType == "wheels" or data.current.modType == "modBackWheels" then
						isRimMod = true
					end
					RegisterLS()
					for k,v in pairs(Config.Jobs[PlayerData.job.name].Menus) do
						if k == data.current.modType or isRimMod then
							if string.match(data.current.label, _U('by_default')) or string.match(data.current.label, _U('installed')) then
								TriggerEvent('tqrp_mechanicjob:installMod')
							else
								local vehiclePrice = 10000
								for i=1, #Vehicles, 1 do
									if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
										vehiclePrice = Vehicles[i].price
										break
									end
								end

								if isRimMod then
									price = math.floor(vehiclePrice * data.current.price / 100)
									TriggerServerEvent("tqrp_mechanicjob:buyMod", price)

								elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
									price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 100)
									TriggerServerEvent("tqrp_mechanicjob:buyMod", price)

								elseif v.modType == 17 then
									price = math.floor(vehiclePrice * v.price[1] / 100)
									TriggerServerEvent("tqrp_mechanicjob:buyMod", price)

								else
									price = math.floor(vehiclePrice * v.price / 100)
									TriggerServerEvent("tqrp_mechanicjob:buyMod", price)

								end
							end
							menu.close()
							found = true
							break
						end
					end
					if not found then
						GetAction(data.current)
					end
				end, function(data, menu) -- on cancel
					menu.close()
					TriggerEvent('tqrp_mechanicjob:cancelInstallMod')
					local coords 		= GetEntityCoords(PlayerPed)
					local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
					SetVehicleDoorsShut(vehicle, false)
					if parent == nil then
						lsMenuIsShowed = false
						local coords 		= GetEntityCoords(PlayerPed)
						local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
						FreezeEntityPosition(vehicle, false)
						myCar = {}
					end
				end, function(data, menu) -- on change
					UpdateMods(data.current)
				end)
			end

			function UpdateMods(data)
				local coords 		= GetEntityCoords(PlayerPed)
				local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
				if data.modType ~= nil then
					local props = {}

					if data.wheelType ~= nil then
						props['wheels'] = data.wheelType
						ESX.Game.SetVehicleProperties(vehicle, props)
						props = {}
					elseif data.modType == 'neonColor' then
						if data.modNum[1] == 0 and data.modNum[2] == 0 and data.modNum[3] == 0 then
							props['neonEnabled'] = {false, false, false, false}
						else
							props['neonEnabled'] = {true, true, true, true}
						end
						ESX.Game.SetVehicleProperties(vehicle, props)
						props = {}
					elseif data.modType == 'tyreSmokeColor' then
						props['modSmokeEnabled'] = true
						ESX.Game.SetVehicleProperties(vehicle, props)
						props = {}
					end
					props[data.modType] = data.modNum
					if data.modType == 'modFrontWheels' then
						props['modBackWheels'] = data.modNum
					end
					ESX.Game.SetVehicleProperties(vehicle, props)
				end
			end

			function GetAction(data)
				if data ~= nil then
					local elements  = {}
					local menuName  = ''
					local menuTitle = ''
					local parent    = nil
					local coords 		= GetEntityCoords(PlayerPed)
					local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
					local currentMods = ESX.Game.GetVehicleProperties(vehicle)
					FreezeEntityPosition(vehicle, true)
					myCar = currentMods
					if data.value == 'modSpeakers' or
						data.value == 'modTrunk' or
						data.value == 'modHydrolic' or
						data.value == 'modEngineBlock' or
						data.value == 'modAirFilter' or
						data.value == 'modStruts' or
						data.value == 'modTank' then
						SetVehicleDoorOpen(vehicle, 4, false)
						SetVehicleDoorOpen(vehicle, 5, false)
					elseif data.value == 'modDoorSpeaker' then
						SetVehicleDoorOpen(vehicle, 0, false)
						SetVehicleDoorOpen(vehicle, 1, false)
						SetVehicleDoorOpen(vehicle, 2, false)
						SetVehicleDoorOpen(vehicle, 3, false)
					else
						SetVehicleDoorsShut(vehicle, false)
					end
					local vehiclePrice = 10000
					for i=1, #Vehicles, 1 do
						if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
							vehiclePrice = Vehicles[i].price
							break
						end
					end
					RegisterLS()
					for k,v in pairs(Config.Jobs[PlayerData.job.name].Menus) do
						if data.value == k then
							menuName  = k
							menuTitle = v.label
							parent    = v.parent
							if v.modType ~= nil then

								if v.modType == 22 then
									table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = false})
								elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- disable neon
									table.insert(elements, {label = " " ..  _U('by_default'), modType = k, modNum = {0, 0, 0}})
								elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then
									local num = myCar[v.modType]
									table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = num})
								elseif v.modType == 17 then
									table.insert(elements, {label = " " .. _U('no_turbo'), modType = k, modNum = false})
								 else
									table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = -1})
								end
								if v.modType == 14 then -- HORNS
									for j = 0, 51, 1 do
										local _label = ''
										if j == currentMods.modHorns then
											_label = GetHornName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
										else
											price = math.floor(vehiclePrice * v.price / 100)
											_label = GetHornName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
										end
										table.insert(elements, {label = _label, modType = k, modNum = j})
									end
								elseif v.modType == 'plateIndex' then -- PLATES
									for j = 0, 4, 1 do
										local _label = ''
										if j == currentMods.plateIndex then
											_label = GetPlatesName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
										else
											price = math.floor(vehiclePrice * v.price / 100)
											_label = GetPlatesName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
										end
										table.insert(elements, {label = _label, modType = k, modNum = j})
									end
								elseif v.modType == 22 then -- NEON
									local _label = ''
									if currentMods.modXenon then
										_label = _U('neon') .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
									else
										price = math.floor(vehiclePrice * v.price / 100)
										_label = _U('neon') .. ' - <span style="color:green;">$' .. price .. ' </span>'
									end
									table.insert(elements, {label = _label, modType = k, modNum = true})
								elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- NEON & SMOKE COLOR
									local neons = GetNeons()
									price = math.floor(vehiclePrice * v.price / 100)
									for i=1, #neons, 1 do
										table.insert(elements, {
											label = '<span style="color:rgb(' .. neons[i].r .. ',' .. neons[i].g .. ',' .. neons[i].b .. ');">' .. neons[i].label .. ' - <span style="color:green;">$' .. price .. '</span>',
											modType = k,
											modNum = { neons[i].r, neons[i].g, neons[i].b }
										})
									end
								elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then -- RESPRAYS
									local colors = GetColors(data.color)
									for j = 1, #colors, 1 do
										local _label = ''
										price = math.floor(vehiclePrice * v.price / 100)
										_label = colors[j].label .. ' - <span style="color:green;">$' .. price .. ' </span>'
										table.insert(elements, {label = _label, modType = k, modNum = colors[j].index})
									end
								elseif v.modType == 'windowTint' then -- WINDOWS TINT
									for j = 1, 5, 1 do
										local _label = ''
										if j == currentMods.modHorns then
											_label = GetWindowName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
										else
											price = math.floor(vehiclePrice * v.price / 100)
											_label = GetWindowName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
										end
										table.insert(elements, {label = _label, modType = k, modNum = j})
									end
								elseif v.modType == 23 then -- WHEELS RIM & TYPE
									local props = {}
									props['wheels'] = v.wheelType
									ESX.Game.SetVehicleProperties(vehicle, props)

									local modCount = GetNumVehicleMods(vehicle, v.modType)
									for j = 0, modCount, 1 do
										local modName = GetModTextLabel(vehicle, v.modType, j)
										if modName then
											local _label = ''
											if j == currentMods.modFrontWheels then
												_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
											else
												price = math.floor(vehiclePrice * v.price / 100)
												_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
											end
											table.insert(elements, {label = _label, modType = 'modFrontWheels', modNum = j, wheelType = v.wheelType, price = v.price})
										end
									end
								elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
									local modCount = GetNumVehicleMods(vehicle, v.modType) -- UPGRADES
									for j = 0, modCount, 1 do
										local _label = ''
										if j == currentMods[k] then
											_label = _U('level', j+1) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
										else
											price = math.floor(vehiclePrice * v.price[j+1] / 100)
											_label = _U('level', j+1) .. ' - <span style="color:green;">$' .. price .. ' </span>'
										end
										table.insert(elements, {label = _label, modType = k, modNum = j})
										if j == modCount-1 then
											break
										end
									end
								elseif v.modType == 17 then -- TURBO
									local _label = ''
									if currentMods[k] then
										_label = 'Turbo - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
									else
										_label = 'Turbo - <span style="color:green;">$' .. math.floor(vehiclePrice * v.price[1] / 100) .. ' </span>'
									end
									table.insert(elements, {label = _label, modType = k, modNum = true})
								elseif v.modType == 48 then -- Livery
									local _label = ''
									local modCount = tonumber(GetNumVehicleMods(vehicle, 48) or 0) + tonumber(GetVehicleLiveryCount(vehicle) or 0)
									for j = 1, modCount, 1 do
										if j == currentMods[k] then
											_label = _U('stickers') .. ' ' .. j .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
										else
											price = math.floor(vehiclePrice * v.price / 100)
											_label = _U('stickers') .. ' ' .. j .. ' - <span style="color:green;">$' .. price .. ' </span>'
										end
										table.insert(elements, {label = _label, modType = k, modNum = j})
									end
								else
									local modCount = GetNumVehicleMods(vehicle, v.modType) -- BODYPARTS
									for j = 0, modCount, 1 do
										local modName = GetModTextLabel(vehicle, v.modType, j)
										if modName then
											local _label = ''
											if j == currentMods[k] then
												_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
											else
												price = math.floor(vehiclePrice * v.price / 100)
												_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
											end
											table.insert(elements, {label = _label, modType = k, modNum = j})
										end
									end
								end
							else
								if data.value == 'primaryRespray' or data.value == 'secondaryRespray' or data.value == 'pearlescentRespray' or data.value == 'modFrontWheelsColor' then
									for i=1, #Config.Jobs[PlayerData.job.name].Colors, 1 do
										if data.value == 'primaryRespray' then
											table.insert(elements, {label = Config.Jobs[PlayerData.job.name].Colors[i].label, value = 'color1', color = Config.Jobs[PlayerData.job.name].Colors[i].value})
										elseif data.value == 'secondaryRespray' then
											table.insert(elements, {label = Config.Jobs[PlayerData.job.name].Colors[i].label, value = 'color2', color = Config.Jobs[PlayerData.job.name].Colors[i].value})
										elseif data.value == 'pearlescentRespray' then
											table.insert(elements, {label = Config.Jobs[PlayerData.job.name].Colors[i].label, value = 'pearlescentColor', color = Config.Jobs[PlayerData.job.name].Colors[i].value})
										elseif data.value == 'modFrontWheelsColor' then
											table.insert(elements, {label = Config.Jobs[PlayerData.job.name].Colors[i].label, value = 'wheelColor', color = Config.Jobs[PlayerData.job.name].Colors[i].value})
										end
									end
								else
									for l,w in pairs(v) do
										if l ~= 'label' and l ~= 'parent' then
											table.insert(elements, {label = w, value = l})
										end
									end
								end
							end
							break
						end
					end
					table.sort(elements, function(a, b)
						return a.label < b.label
					end)
					OpenLSMenu(elements, menuName, menuTitle, parent)
				end
			end

			function GetColors(color)
				local colors = {}
				if color == 'black' then
					colors = {
						{ index = 0, label = _U('black')},
						{ index = 1, label = _U('graphite')},
						{ index = 2, label = _U('black_metallic')},
						{ index = 3, label = _U('caststeel')},
						{ index = 11, label = _U('black_anth')},
						{ index = 12, label = _U('matteblack')},
						{ index = 15, label = _U('darknight')},
						{ index = 16, label = _U('deepblack')},
						{ index = 21, label = _U('oil')},
						{ index = 147, label = _U('carbon')}
					}
				elseif color == 'white' then
					colors = {
						{ index = 106, label = _U('vanilla')},
						{ index = 107, label = _U('creme')},
						{ index = 111, label = _U('white')},
						{ index = 112, label = _U('polarwhite')},
						{ index = 113, label = _U('beige')},
						{ index = 121, label = _U('mattewhite')},
						{ index = 122, label = _U('snow')},
						{ index = 131, label = _U('cotton')},
						{ index = 132, label = _U('alabaster')},
						{ index = 134, label = _U('purewhite')}
					}
				elseif color == 'grey' then
					colors = {
						{ index = 4, label = _U('silver')},
						{ index = 5, label = _U('metallicgrey')},
						{ index = 6, label = _U('laminatedsteel')},
						{ index = 7, label = _U('darkgray')},
						{ index = 8, label = _U('rockygray')},
						{ index = 9, label = _U('graynight')},
						{ index = 10, label = _U('aluminum')},
						{ index = 13, label = _U('graymat')},
						{ index = 14, label = _U('lightgrey')},
						{ index = 17, label = _U('asphaltgray')},
						{ index = 18, label = _U('grayconcrete')},
						{ index = 19, label = _U('darksilver')},
						{ index = 20, label = _U('magnesite')},
						{ index = 22, label = _U('nickel')},
						{ index = 23, label = _U('zinc')},
						{ index = 24, label = _U('dolomite')},
						{ index = 25, label = _U('bluesilver')},
						{ index = 26, label = _U('titanium')},
						{ index = 66, label = _U('steelblue')},
						{ index = 93, label = _U('champagne')},
						{ index = 144, label = _U('grayhunter')},
						{ index = 156, label = _U('grey')}
					}
				elseif color == 'red' then
					colors = {
						{ index = 27, label = _U('red')},
						{ index = 28, label = _U('torino_red')},
						{ index = 29, label = _U('poppy')},
						{ index = 30, label = _U('copper_red')},
						{ index = 31, label = _U('cardinal')},
						{ index = 32, label = _U('brick')},
						{ index = 33, label = _U('garnet')},
						{ index = 34, label = _U('cabernet')},
						{ index = 35, label = _U('candy')},
						{ index = 39, label = _U('matte_red')},
						{ index = 40, label = _U('dark_red')},
						{ index = 43, label = _U('red_pulp')},
						{ index = 44, label = _U('bril_red')},
						{ index = 46, label = _U('pale_red')},
						{ index = 143, label = _U('wine_red')},
						{ index = 150, label = _U('volcano')}
					}
				elseif color == 'pink' then
					colors = {
						{ index = 135, label = _U('electricpink')},
						{ index = 136, label = _U('salmon')},
						{ index = 137, label = _U('sugarplum')}
					}
				elseif color == 'blue' then
					colors = {
						{ index = 54, label = _U('topaz')},
						{ index = 60, label = _U('light_blue')},
						{ index = 61, label = _U('galaxy_blue')},
						{ index = 62, label = _U('dark_blue')},
						{ index = 63, label = _U('azure')},
						{ index = 64, label = _U('navy_blue')},
						{ index = 65, label = _U('lapis')},
						{ index = 67, label = _U('blue_diamond')},
						{ index = 68, label = _U('surfer')},
						{ index = 69, label = _U('pastel_blue')},
						{ index = 70, label = _U('celeste_blue')},
						{ index = 73, label = _U('rally_blue')},
						{ index = 74, label = _U('blue_todise')},
						{ index = 75, label = _U('blue_night')},
						{ index = 77, label = _U('cyan_blue')},
						{ index = 78, label = _U('cobalt')},
						{ index = 79, label = _U('electric_blue')},
						{ index = 80, label = _U('horizon_blue')},
						{ index = 82, label = _U('metallic_blue')},
						{ index = 83, label = _U('aquamarine')},
						{ index = 84, label = _U('blue_agathe')},
						{ index = 85, label = _U('zirconium')},
						{ index = 86, label = _U('spinel')},
						{ index = 87, label = _U('tourmaline')},
						{ index = 127, label = _U('todise')},
						{ index = 140, label = _U('bubble_gum')},
						{ index = 141, label = _U('midnight_blue')},
						{ index = 146, label = _U('forbidden_blue')},
						{ index = 157, label = _U('glacier_blue')}
					}
				elseif color == 'yellow' then
					colors = {
						{ index = 42, label = _U('yellow')},
						{ index = 88, label = _U('wheat')},
						{ index = 89, label = _U('raceyellow')},
						{ index = 91, label = _U('paleyellow')},
						{ index = 126, label = _U('lightyellow')}
					}
				elseif color == 'green' then
					colors = {
						{ index = 49, label = _U('met_dark_green')},
						{ index = 50, label = _U('rally_green')},
						{ index = 51, label = _U('pine_green')},
						{ index = 52, label = _U('olive_green')},
						{ index = 53, label = _U('light_green')},
						{ index = 55, label = _U('lime_green')},
						{ index = 56, label = _U('forest_green')},
						{ index = 57, label = _U('lawn_green')},
						{ index = 58, label = _U('imperial_green')},
						{ index = 59, label = _U('green_bottle')},
						{ index = 92, label = _U('citrus_green')},
						{ index = 125, label = _U('green_anis')},
						{ index = 128, label = _U('khaki')},
						{ index = 133, label = _U('army_green')},
						{ index = 151, label = _U('dark_green')},
						{ index = 152, label = _U('hunter_green')},
						{ index = 155, label = _U('matte_foilage_green')}
					}
				elseif color == 'orange' then
					colors = {
						{ index = 36, label = _U('tangerine')},
						{ index = 38, label = _U('orange')},
						{ index = 41, label = _U('matteorange')},
						{ index = 123, label = _U('lightorange')},
						{ index = 124, label = _U('peach')},
						{ index = 130, label = _U('pumpkin')},
						{ index = 138, label = _U('orangelambo')}
					}
				elseif color == 'brown' then
					colors = {
						{ index = 45, label = _U('copper')},
						{ index = 47, label = _U('lightbrown')},
						{ index = 48, label = _U('darkbrown')},
						{ index = 90, label = _U('bronze')},
						{ index = 94, label = _U('brownmetallic')},
						{ index = 95, label = _U('Expresso')},
						{ index = 96, label = _U('chocolate')},
						{ index = 97, label = _U('terracotta')},
						{ index = 98, label = _U('marble')},
						{ index = 99, label = _U('sand')},
						{ index = 100, label = _U('sepia')},
						{ index = 101, label = _U('bison')},
						{ index = 102, label = _U('palm')},
						{ index = 103, label = _U('caramel')},
						{ index = 104, label = _U('rust')},
						{ index = 105, label = _U('chestnut')},
						{ index = 108, label = _U('brown')},
						{ index = 109, label = _U('hazelnut')},
						{ index = 110, label = _U('shell')},
						{ index = 114, label = _U('mahogany')},
						{ index = 115, label = _U('cauldron')},
						{ index = 116, label = _U('blond')},
						{ index = 129, label = _U('gravel')},
						{ index = 153, label = _U('darkearth')},
						{ index = 154, label = _U('desert')}
					}
				elseif color == 'purple' then
					colors = {
						{ index = 71, label = _U('indigo')},
						{ index = 72, label = _U('deeppurple')},
						{ index = 76, label = _U('darkviolet')},
						{ index = 81, label = _U('amethyst')},
						{ index = 142, label = _U('mysticalviolet')},
						{ index = 145, label = _U('purplemetallic')},
						{ index = 148, label = _U('matteviolet')},
						{ index = 149, label = _U('mattedeeppurple')}
					}
				elseif color == 'chrome' then
					colors = {
						{ index = 117, label = _U('brushechrome')},
						{ index = 118, label = _U('blackchrome')},
						{ index = 119, label = _U('brushedaluminum')},
						{ index = 120, label = _U('chrome')}
					}
				elseif color == 'gold' then
					colors = {
						{ index = 37, label = _U('gold')},
						{ index = 158, label = _U('puregold')},
						{ index = 159, label = _U('brushedgold')},
						{ index = 160, label = _U('lightgold')}
					}
				end
				return colors
			end

			function GetWindowName(index)
				if (index == 1) then
					return "Pure Black"
				elseif (index == 2) then
					return "Darksmoke"
				elseif (index == 3) then
					return "Lightsmoke"
				elseif (index == 4) then
					return "Limo"
				elseif (index == 5) then
					return "Green"
				else
					return "Unknown"
				end
			end

			function GetHornName(index)
				if (index == 0) then
					return "Truck Horn"
				elseif (index == 1) then
					return "Cop Horn"
				elseif (index == 2) then
					return "Clown Horn"
				elseif (index == 3) then
					return "Musical Horn 1"
				elseif (index == 4) then
					return "Musical Horn 2"
				elseif (index == 5) then
					return "Musical Horn 3"
				elseif (index == 6) then
					return "Musical Horn 4"
				elseif (index == 7) then
					return "Musical Horn 5"
				elseif (index == 8) then
					return "Sad Trombone"
				elseif (index == 9) then
					return "Classical Horn 1"
				elseif (index == 10) then
					return "Classical Horn 2"
				elseif (index == 11) then
					return "Classical Horn 3"
				elseif (index == 12) then
					return "Classical Horn 4"
				elseif (index == 13) then
					return "Classical Horn 5"
				elseif (index == 14) then
					return "Classical Horn 6"
				elseif (index == 15) then
					return "Classical Horn 7"
				elseif (index == 16) then
					return "Scale - Do"
				elseif (index == 17) then
					return "Scale - Re"
				elseif (index == 18) then
					return "Scale - Mi"
				elseif (index == 19) then
					return "Scale - Fa"
				elseif (index == 20) then
					return "Scale - Sol"
				elseif (index == 21) then
					return "Scale - La"
				elseif (index == 22) then
					return "Scale - Ti"
				elseif (index == 23) then
					return "Scale - Do"
				elseif (index == 24) then
					return "Jazz Horn 1"
				elseif (index == 25) then
					return "Jazz Horn 2"
				elseif (index == 26) then
					return "Jazz Horn 3"
				elseif (index == 27) then
					return "Jazz Horn Loop"
				elseif (index == 28) then
					return "Star Spangled Banner 1"
				elseif (index == 29) then
					return "Star Spangled Banner 2"
				elseif (index == 30) then
					return "Star Spangled Banner 3"
				elseif (index == 31) then
					return "Star Spangled Banner 4"
				elseif (index == 32) then
					return "Classical Horn 8 Loop"
				elseif (index == 33) then
					return "Classical Horn 9 Loop"
				elseif (index == 34) then
					return "Classical Horn 10 Loop"
				elseif (index == 35) then
					return "Classical Horn 8"
				elseif (index == 36) then
					return "Classical Horn 9"
				elseif (index == 37) then
					return "Classical Horn 10"
				elseif (index == 38) then
					return "Funeral Loop"
				elseif (index == 39) then
					return "Funeral"
				elseif (index == 40) then
					return "Spooky Loop"
				elseif (index == 41) then
					return "Spooky"
				elseif (index == 42) then
					return "San Andreas Loop"
				elseif (index == 43) then
					return "San Andreas"
				elseif (index == 44) then
					return "Liberty City Loop"
				elseif (index == 45) then
					return "Liberty City"
				elseif (index == 46) then
					return "Festive 1 Loop"
				elseif (index == 47) then
					return "Festive 1"
				elseif (index == 48) then
					return "Festive 2 Loop"
				elseif (index == 49) then
					return "Festive 2"
				elseif (index == 50) then
					return "Festive 3 Loop"
				elseif (index == 51) then
					return "Festive 3"
				else
					return "Unknown Horn"
				end
			end

			function GetNeons()
				local neons = {
					{ label = _U('white'), 			r = 255, 	g = 255, 	b = 255},
					{ label = "Slate Gray", 	r = 112, 	g = 128, 	b = 144},
					{ label = "Blue", 			r = 0, 		g = 0, 		b = 255},
					{ label = "Light Blue", 	r = 0, 		g = 150, 	b = 255},
					{ label = "Navy Blue", 		r = 0, 		g = 0, 		b = 128},
					{ label = "Sky Blue", 		r = 135, 	g = 206, 	b = 235},
					{ label = "Turquoise", 		r = 0, 		g = 245, 	b = 255},
					{ label = "Mint Green", 	r = 50, 	g = 255, 	b = 155},
					{ label = "Lime Green", 	r = 0, 		g = 255, 	b = 0},
					{ label = "Olive", 			r = 128, 	g = 128, 	b = 0},
					{ label = _U('yellow'), 		r = 255, 	g = 255, 	b = 0},
					{ label = _U('gold'), 			r = 255, 	g = 215, 	b = 0},
					{ label = _U('orange'), 		r = 255, 	g = 165, 	b = 0},
					{ label = _U('wheat'), 			r = 245, 	g = 222, 	b = 179},
					{ label = _U('red'), 			r = 255, 	g = 0, 		b = 0},
					{ label = _U('pink'), 			r = 255, 	g = 161, 	b = 211},
					{ label = _U('brightpink'), 	r = 255, 	g = 0, 		b = 255},
					{ label = _U('purple'), 		r = 153, 	g = 0, 		b = 153},
					{ label = "Ivory", 			r = 41, 	g = 36, 	b = 33}
					}
					return neons
			end

			function GetPlatesName(index)
				if (index == 0) then
					return _U('blue_on_white_1')
				elseif (index == 1) then
					return _U('yellow_on_black')
				elseif (index == 2) then
					return _U('yellow_blue')
				elseif (index == 3) then
					return _U('blue_on_white_2')
				elseif (index == 4) then
					return _U('blue_on_white_3')
				end
			end

			function RegisterLS()
				if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), Config.Jobs[PlayerData.job.name].Zones.ls1.Pos.x, Config.Jobs[PlayerData.job.name].Zones.ls1.Pos.y, Config.Jobs[PlayerData.job.name].Zones.ls1.Pos.z, true) < Config.DrawDistance) then
				Config.Jobs[PlayerData.job.name].Menus = {
					main = {
						label = 'LS CUSTOMS',
						parent = nil,
						cosmetics = _U('cosmetics')
					},
						cosmetics = {
						label				= _U('cosmetics'),
						parent				= 'main',
						bodyparts			= _U('bodyparts'),
						windowTint			= _U('windowtint'),
						modHorns			= _U('horns'),
						neonColor			= _U('neons'),
						modXenon			= _U('headlights'),
						plateIndex			= _U('licenseplates'),
						wheels				= _U('wheels'),
						modPlateHolder		= _U('modplateholder'),
						modVanityPlate		= _U('modvanityplate'),
						modTrimA			= _U('interior'),
						modOrnaments		= _U('trim'),
						modDashboard		= _U('dashboard'),
						modDial				= _U('speedometer'),
						modDoorSpeaker		= _U('door_speakers'),
						modSeats			= _U('seats'),
						modSteeringWheel	= _U('steering_wheel'),
						modShifterLeavers	= _U('gear_lever'),
						modAPlate			= _U('quarter_deck'),
						modSpeakers			= _U('speakers'),
						modTrunk			= _U('trunk'),
						modHydrolic			= _U('hydraulic'),
						modEngineBlock		= _U('engine_block'),
						modAirFilter		= _U('air_filter'),
						modStruts			= _U('struts'),
						modArchCover		= _U('arch_cover'),
						modAerials			= _U('aerials'),
						modTrimB			= _U('wings'),
						modTank				= _U('fuel_tank'),
						modWindows			= _U('windows')
					},

					modPlateHolder = {
						label = 'Plaque - Contour',
						parent = 'cosmetics',
						modType = 25,
						price = 0.5
					},
					modVanityPlate = {
						label = 'Plaque - Avant',
						parent = 'cosmetics',
						modType = 26,
						price = 0.5
					},
					modTrimA = {
						label = 'Intérieur',
						parent = 'cosmetics',
						modType = 27,
						price = 0.8
					},
					modOrnaments = {
						label = 'Ornements',
						parent = 'cosmetics',
						modType = 28,
						price = 0.9
					},
					modDashboard = {
						label = 'Tableau de bord',
						parent = 'cosmetics',
						modType = 29,
						price = 0.65
					},
					modDial = {
						label = 'Compteur de vitesse',
						parent = 'cosmetics',
						modType = 30,
						price = 0.59
					},
					modDoorSpeaker = {
						label = 'Sono portière',
						parent = 'cosmetics',
						modType = 31,
						price = 0.58
					},
					modSeats = {
						label = 'Siège',
						parent = 'cosmetics',
						modType = 32,
						price = 0.65
					},
					modSteeringWheel = {
						label = 'Volant',
						parent = 'cosmetics',
						modType = 33,
						price = 0.59
					},
					modShifterLeavers = {
						label = 'Levier de vitesse',
						parent = 'cosmetics',
						modType = 34,
						price = 0.26
					},
					modAPlate = {
						label = 'Plage arrière',
						parent = 'cosmetics',
						modType = 35,
						price = 0.59
					},
					modSpeakers = {
						label = 'Sono',
						parent = 'cosmetics',
						modType = 36,
						price = 0.8
					},
					modTrunk = {
						label = 'Coffre',
						parent = 'cosmetics',
						modType = 37,
						price = 0.58
					},
					modHydrolic = {
						label = 'Hydrolique',
						parent = 'cosmetics',
						modType = 38,
						price = 0.6
					},
					modEngineBlock = {
						label = 'Bloc moteur',
						parent = 'cosmetics',
						modType = 39,
						price = 0.6
					},
					modAirFilter = {
						label = 'Filtre a air',
						parent = 'cosmetics',
						modType = 40,
						price = 1.72
					},
					modStruts = {
						label = 'Struts',
						parent = 'cosmetics',
						modType = 41,
						price = 1.51
					},
					modArchCover = {
						label = 'Cache-roues',
						parent = 'cosmetics',
						modType = 42,
						price = 0.59
					},
					modAerials = {
						label = 'Antennes',
						parent = 'cosmetics',
						modType = 43,
						price = 0.6
					},
					modTrimB = {
						label = 'Ailes',
						parent = 'cosmetics',
						modType = 44,
						price = 1.05
					},
					modTank = {
						label = 'Réservoir',
						parent = 'cosmetics',
						modType = 45,
						price = 0.59
					},
					modWindows = {
						label = 'Fenêtres',
						parent = 'cosmetics',
						modType = 46,
						price = 0.59
					},

					wheels = {
						label = _U('wheels'),
						parent = 'cosmetics',
						modFrontWheelsTypes = _U('wheel_type'),
						tyreSmokeColor = _U('tiresmoke')
					},
					modFrontWheelsTypes = {
						label               = _U('wheel_type'),
						parent              = 'wheels',
						modFrontWheelsType0 = _U('sport'),
						modFrontWheelsType1 = _U('muscle'),
						modFrontWheelsType2 = _U('lowrider'),
						modFrontWheelsType3 = _U('suv'),
						modFrontWheelsType4 = _U('allterrain'),
						modFrontWheelsType5 = _U('tuning'),
						modFrontWheelsType6 = _U('motorcycle'),
						modFrontWheelsType7 = _U('highend')
					},
					modFrontWheelsType0 = {
						label = _U('sport'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 0,
						price = 0.65
					},
					modFrontWheelsType1 = {
						label = _U('muscle'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 1,
						price = 0.59
					},
					modFrontWheelsType2 = {
						label = _U('lowrider'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 2,
						price = 0.65
					},
					modFrontWheelsType3 = {
						label = _U('suv'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 3,
						price = 0.59
					},
					modFrontWheelsType4 = {
						label = _U('allterrain'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 4,
						price = 0.59
					},
					modFrontWheelsType5 = {
						label = _U('tuning'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 5,
						price = 0.6
					},
					modFrontWheelsType6 = {
						label = _U('motorcycle'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 6,
						price = 0.26
					},
					modFrontWheelsType7 = {
						label = _U('highend'),
						parent = 'modFrontWheelsTypes',
						modType = 23,
						wheelType = 7,
						price = 0.6
					},
					modFrontWheelsColor = {
						label = 'Peinture Jantes',
						parent = 'wheels'
					},
					wheelColor = {
						label = 'Peinture Jantes',
						parent = 'modFrontWheelsColor',
						modType = 'wheelColor',
						price = 0.33
					},
					plateIndex = {
						label = _U('licenseplates'),
						parent = 'cosmetics',
						modType = 'plateIndex',
						price = 0.5
					},
					modXenon = {
						label = _U('headlights'),
						parent = 'cosmetics',
						modType = 22,
						price = 4.2
					},
					bodyparts = {
						label = _U('bodyparts'),
						parent = 'cosmetics',
						modFender = _U('leftfender'),
						modRightFender = _U('rightfender'),
						modSpoilers = _U('spoilers'),
						modSideSkirt = _U('sideskirt'),
						modFrame = _U('cage'),
						modHood = _U('hood'),
						modGrille = _U('grille'),
						modRearBumper = _U('rearbumper'),
						modFrontBumper = _U('frontbumper'),
						modExhaust = _U('exhaust'),
						modRoof = _U('roof')
					},
					modSpoilers = {
						label = _U('spoilers'),
						parent = 'bodyparts',
						modType = 0,
						price = 0.65
					},
					modFrontBumper = {
						label = _U('frontbumper'),
						parent = 'bodyparts',
						modType = 1,
						price = 0.6
					},
					modRearBumper = {
						label = _U('rearbumper'),
						parent = 'bodyparts',
						modType = 2,
						price = 0.6
					},
					modSideSkirt = {
						label = _U('sideskirt'),
						parent = 'bodyparts',
						modType = 3,
						price = 0.65
					},
					modExhaust = {
						label = _U('exhaust'),
						parent = 'bodyparts',
						modType = 4,
						price = 0.6
					},
					modFrame = {
						label = _U('cage'),
						parent = 'bodyparts',
						modType = 5,
						price = 0.6
					},
					modGrille = {
						label = _U('grille'),
						parent = 'bodyparts',
						modType = 6,
						price = 1.72
					},
					modHood = {
						label = _U('hood'),
						parent = 'bodyparts',
						modType = 7,
						price = 1.88
					},
					modFender = {
						label = _U('leftfender'),
						parent = 'bodyparts',
						modType = 8,
						price = 0.6
					},
					modRightFender = {
						label = _U('rightfender'),
						parent = 'bodyparts',
						modType = 9,
						price = 0.6
					},
					modRoof = {
						label = _U('roof'),
						parent = 'bodyparts',
						modType = 10,
						price = 0.58
					},
					windowTint = {
						label = _U('windowtint'),
						parent = 'cosmetics',
						modType = 'windowTint',
						price = 0.6
					},
					modHorns = {
						label = _U('horns'),
						parent = 'cosmetics',
						modType = 14,
						price = 0.6
					},
					neonColor = {
						label = _U('neons'),
						parent = 'cosmetics',
						modType = 'neonColor',
						price = 0.6
					},
					tyreSmokeColor = {
						label = _U('tiresmoke'),
						parent = 'wheels',
						modType = 'tyreSmokeColor',
						price = 0.6
					}

				}
				elseif (GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), Config.Jobs[PlayerData.job.name].Zones.ls2.Pos.x, Config.Jobs[PlayerData.job.name].Zones.ls2.Pos.y, Config.Jobs[PlayerData.job.name].Zones.ls2.Pos.z, true) < Config.DrawDistance) then
					Config.Jobs[PlayerData.job.name].Menus = {
						main = {
							label = 'LS CUSTOMS',
							parent = nil,
							cosmetics = _U('cosmetics')
						},
							cosmetics = {
							label				= _U('cosmetics'),
							parent				= 'main',
							resprays			= _U('respray'),
							wheels				= _U('wheels'),
							modLivery			= _U('stickers')
						},
						modLivery = {
							label = 'Stickers',
							parent = 'cosmetics',
							modType = 48,
							price = 1.3
						},

						wheels = {
							label = _U('wheels'),
							parent = 'cosmetics',
							modFrontWheelsColor = _U('wheel_color')
						},
						modFrontWheelsColor = {
							label = 'Peinture Jantes',
							parent = 'wheels'
						},
						wheelColor = {
							label = 'Peinture Jantes',
							parent = 'modFrontWheelsColor',
							modType = 'wheelColor',
							price = 0.33
						},
						resprays = {
							label = _U('respray'),
							parent = 'cosmetics',
							primaryRespray = _U('primary'),
							secondaryRespray = _U('secondary'),
							pearlescentRespray = _U('pearlescent'),
						},
						primaryRespray = {
							label = _U('primary'),
							parent = 'resprays',
						},
						secondaryRespray = {
							label = _U('secondary'),
							parent = 'resprays',
						},
						pearlescentRespray = {
							label = _U('pearlescent'),
							parent = 'resprays',
						},
						color1 = {
							label = _U('primary'),
							parent = 'primaryRespray',
							modType = 'color1',
							price = 0.3
						},
						color2 = {
							label = _U('secondary'),
							parent = 'secondaryRespray',
							modType = 'color2',
							price = 0.1
						},
						pearlescentColor = {
							label = _U('pearlescent'),
							parent = 'pearlescentRespray',
							modType = 'pearlescentColor',
							price = 0.4
						}

					}
				elseif (GetDistanceBetweenCoords(GetEntityCoords(PlayerPed), Config.Jobs[PlayerData.job.name].Zones.ls3.Pos.x, Config.Jobs[PlayerData.job.name].Zones.ls3.Pos.y, Config.Jobs[PlayerData.job.name].Zones.ls3.Pos.z, true) < Config.DrawDistance) then
					Config.Jobs[PlayerData.job.name].Menus = {
						main = {
							label = 'LS CUSTOMS',
							parent = nil,
							upgrades = _U('upgrades')
						},
						upgrades = {
							label = _U('upgrades'),
							parent = 'main',
							modEngine = _U('engine'),
							modBrakes = _U('brakes'),
							modTransmission = _U('transmission'),
							modSuspension = _U('suspension'),
							modArmor = _U('armor'),
							modTurbo = _U('turbo')
						},
						modEngine = {
							label = _U('engine'),
							parent = 'upgrades',
							modType = 11,
							price = {2, 4, 5, 8}
						},
						modBrakes = {
							label = _U('brakes'),
							parent = 'upgrades',
							modType = 12,
							price = {2.65, 3.3, 4.6, 5.95}
						},
						modTransmission = {
							label = _U('transmission'),
							parent = 'upgrades',
							modType = 13,
							price = {2.95, 3.5, 4.2}
						},
						modSuspension = {
							label = _U('suspension'),
							parent = 'upgrades',
							modType = 15,
							price = {3.72, 4.44, 5.88, 6.20, 7.4}
						},
						modArmor = {
							label = _U('armor'),
							parent = 'upgrades',
							modType = 16,
							price = {3.77, 4.2, 5.1, 6.7, 7.2, 8.8}
						},
						modTurbo = {
							label = _U('turbo'),
							parent = 'upgrades',
							modType = 17,
							price = {9.81}
						}
					}
				end
			end

			function MechanicMenu(data)
				if data == 'vehicle_list' then
					if Config.Jobs[PlayerData.job.name].EnableSocietyOwnedVehicles then
						local elements = {}
						ESX.TriggerServerCallback('tqrp_society:getVehiclesInGarage', function(vehicles)
							for i=1, #vehicles, 1 do
								table.insert(elements, {
									label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
									value = vehicles[i]
								})
							end

							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
								title    = _U('service_vehicle'),
								align    = 'top-left',
								elements = elements
							}, function(data, menu)
								menu.close()
								local vehicleProps = data.current.value

								ESX.Game.SpawnVehicle(vehicleProps.model, Config.Jobs[PlayerData.job.name].Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
									TriggerEvent("onyx:updatePlates", ESX.Game.GetVehicleProperties(vehicle).plate)
									--TaskWarpPedIntoVehicle(PlayerPed,  vehicle,  -1)
									SetVehicleMaxMods(vehicle)
								end)

								TriggerServerEvent('tqrp_society:removeVehicleFromGarage', PlayerData.job.name, vehicleProps)
							end, function(data, menu)
								menu.close()
							end)
						end, PlayerData.job.name)
					else
						local elements = {
							{label = "Reboque Prancha",  value = 'flatbed3'},
							{label = "Reboque Guincho 2",  value = 'towtruck'},
							{label = "Reboque Guincho", value = 'towtruck2'}

						}
						ESX.UI.Menu.CloseAll()
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
							title    = _U('service_vehicle'),
							align    = 'top-left',
							elements = elements
						}, function(data, menu)
							ESX.Game.SpawnVehicle(data.current.value, Config.Jobs[PlayerData.job.name].Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
								--TaskWarpPedIntoVehicle(PlayerPed, vehicle, -1)
								TriggerEvent("onyx:updatePlates", ESX.Game.GetVehicleProperties(vehicle).plate)
								SetVehicleMaxMods(vehicle)
								ESX.Game.SetVehicleProperties(vehicle, {
									modLivery = 3
								})
							end)
							menu.close()
						end, function(data, menu)
							menu.close()
							MechanicMenu()
						end)
					end
				elseif data == 'cloakroom' then
					ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin, jobSkin)
						if skin.sex == 0 then
							TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
						else
							TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
						end
					end)
				elseif data == 'cloakroom2' then
					ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin, jobSkin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)
				elseif data == 'buy' then
					OpenBuyMenu()
				elseif data == 'boss_actions' then
					TriggerEvent('tqrp_society:openBossMenu', 'mechanic2', function(data, menu)
						menu.close()
					end)
				end
			end

			function OpenBuyMenu()
				local elements = {
					--{label = _U('blowtorch'),  value = 'blowtorch'},
					{label = _U('repair_kit'), value = 'fixkit'},
					{label = _U('body_kit'),   value = 'carokit'}
				}
				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic2', {
					title    = 'Menu de compra',
					align    = 'top-left',
					elements = elements
				}, function(data, menu)
					menu.close()
					if data.current.value == 'blowtorch' then
						TriggerServerEvent('tqrp_mechanicjob:buy', 'blowtorch', 35)
					elseif data.current.value == 'fixkit' then
						TriggerServerEvent('tqrp_mechanicjob:buy', 'fixkit', 20)
					elseif data.current.value == 'carokit' then
						TriggerServerEvent('tqrp_mechanicjob:buy', 'carokit', 25)
					end
				end, function(data, menu)
					menu.close()
				end)
			end
		elseif PlayerData.job.name == 'unicorn' then

			function setClipset(PlayerPed, clip)
				RequestAnimSet(clip)
				while not HasAnimSetLoaded(clip) do
				  Citizen.Wait(10)
				end
				SetPedMovementClipset(PlayerPed, clip, true)
			end

			function setUniform(job, PlayerPed)
				TriggerEvent('skinchanger:getSkin', function(skin)

					if skin.sex == 0 then
					if Config.Jobs[PlayerData.job.name].Uniforms[job].male ~= nil then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs[PlayerData.job.name].Uniforms[job].male)
					else
						ESX.ShowNotification(_U('no_outfit'))
					end
					if job ~= 'citizen_wear' and job ~= 'barman_outfit' then
						setClipset(PlayerPed, "MOVE_M@POSH@")
					end
					else
					if Config.Jobs[PlayerData.job.name].Uniforms[job].female ~= nil then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs[PlayerData.job.name].Uniforms[job].female)
					else
						ESX.ShowNotification(_U('no_outfit'))
					end
					if job ~= 'citizen_wear' and job ~= 'barman_outfit' then
						setClipset(PlayerPed, "MOVE_F@POSH@")
					end
					end

				end)
			end

			function OpenCloakroomMenu()

				local elements = {
					{ label = _U('citizen_wear'),     value = 'citizen_wear'},
					{ label = _U('barman_outfit'),    value = 'barman_outfit'},
					{ label = _U('dancer_outfit_1'),  value = 'dancer_outfit_1'},
					{ label = _U('dancer_outfit_2'),  value = 'dancer_outfit_2'},
					{ label = _U('dancer_outfit_3'),  value = 'dancer_outfit_3'},
					{ label = _U('dancer_outfit_4'),  value = 'dancer_outfit_4'},
					{ label = _U('dancer_outfit_5'),  value = 'dancer_outfit_5'},
					{ label = _U('dancer_outfit_6'),  value = 'dancer_outfit_6'},
					{ label = _U('dancer_outfit_7'),  value = 'dancer_outfit_7'},
				}

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'cloakroom',
					{
					title    = "Cabides",
					align    = 'top-left',
					elements = elements,
					},
					function(data, menu)

					isBarman = false
					cleanPlayer(PlayerPed)

					if data.current.value == 'citizen_wear' then
						ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
						end)
					end

					if data.current.value == 'barman_outfit' then
						setUniform(data.current.value, PlayerPed)
						isBarman = true
					end

					if
						data.current.value == 'dancer_outfit_1' or
						data.current.value == 'dancer_outfit_2' or
						data.current.value == 'dancer_outfit_3' or
						data.current.value == 'dancer_outfit_4' or
						data.current.value == 'dancer_outfit_5' or
						data.current.value == 'dancer_outfit_6' or
						data.current.value == 'dancer_outfit_7'
					then
						setUniform(data.current.value, PlayerPed)
					end

					CurrentAction     = 'menu_cloakroom'
					CurrentActionData = {}

					end,
					function(data, menu)
					menu.close()
					CurrentAction     = 'menu_cloakroom'
					CurrentActionData = {}
					end
				)
			end

			function OpenVehicleSpawnerMenu()

				local vehicles = Config.Jobs[PlayerData.job.name].Zones.Vehicles

				ESX.UI.Menu.CloseAll()

				if Config.EnableSocietyOwnedVehicles then

					local elements = {}

					ESX.TriggerServerCallback('tqrp_society:getVehiclesInGarage', function(garageVehicles)

					for i=1, #garageVehicles, 1 do
						table.insert(elements, {label = GetDisplayNameFromVehicleModel(garageVehicles[i].model) .. ' [' .. garageVehicles[i].plate .. ']', value = garageVehicles[i]})
					end

					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'vehicle_spawner',
						{
						title    = _U('vehicle_menu'),
						align    = 'top-left',
						elements = elements,
						},
						function(data, menu)

						menu.close()

						local vehicleProps = data.current.value
						ESX.Game.SpawnVehicle(vehicleProps.model, vehicles.SpawnPoint, vehicles.Heading, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
							TriggerEvent("onyx:updatePlates", ESX.Game.GetVehicleProperties(vehicle).plate)
							----TaskWarpPedIntoVehicle(PlayerPed,  vehicle,  -1)  -- teleport into vehicle
						end)

						TriggerServerEvent('tqrp_society:removeVehicleFromGarage', 'unicorn', vehicleProps)

						end,
						function(data, menu)

						menu.close()

						CurrentAction     = 'menu_vehicle_spawner'
						CurrentActionData = {}

						end
					)

					end, 'unicorn')

				else

					local elements = {}

					for i=1, #Config.Jobs[PlayerData.job.name].AuthorizedVehicles, 1 do
						local vehicle = Config.Jobs[PlayerData.job.name].AuthorizedVehicles[i]
						table.insert(elements, {label = vehicle.label, value = vehicle.name})
					end

					ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'vehicle_spawner',
					{
						title    = _U('vehicle_menu'),
						align    = 'top-left',
						elements = elements,
					},
					function(data, menu)
							menu.close()
							local model = data.current.value

							local vehicle = GetClosestVehicle(vehicles.SpawnPoint.x,  vehicles.SpawnPoint.y,  vehicles.SpawnPoint.z,  3.0,  0,  71)

							if not DoesEntityExist(vehicle) then

							ESX.Game.SpawnVehicle(model, {
								x = vehicles.SpawnPoint.x,
								y = vehicles.SpawnPoint.y,
								z = vehicles.SpawnPoint.z
								}, vehicles.Heading, function(vehicle)
								----TaskWarpPedIntoVehicle(PlayerPed,  vehicle,  -1) -- teleport into vehicle
								SetVehicleMaxMods(vehicle)
								SetVehicleDirtLevel(vehicle, 0)
							end)
						end
					end,
					function(data, menu)

						menu.close()

						CurrentAction     = 'menu_vehicle_spawner'
						CurrentActionData = {}

					end
					)

				end

			end

			function OpenSocietyActionsMenu()

				local elements = {}

				table.insert(elements, {label = _U('billing'),    value = 'billing'})
				if (isBarman or IsGradeBoss()) then
					table.insert(elements, {label = _U('crafting'),    value = 'menu_crafting'})
				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'unicorn_actions',
					{
					title    = _U('unicorn'),
					align    = 'top-left',
					elements = elements
					},
					function(data, menu)

					if data.current.value == 'billing' then
						OpenBillingMenu()
					end

					if data.current.value == 'menu_crafting' then

						ESX.UI.Menu.Open(
							'default', GetCurrentResourceName(), 'menu_crafting',
							{
								title = _U('crafting'),
								align = 'bottom-right',
								elements = {
									{label = _U('watch_frame'),     value = 'watch_frame'},
									{label = _U('golem'),         value = 'golem'},
									{label = _U('whiskycoca'),    value = 'whiskycoca'},
									{label = _U('vodkaenergy'),   value = 'vodkaenergy'},
									{label = _U('vodkafruit'),    value = 'vodkafruit'},
									{label = _U('rhumfruit'),     value = 'rhumfruit'},
									{label = _U('teqpaf'),        value = 'teqpaf'},
									{label = _U('rhumcoca'),      value = 'rhumcoca'},
									{label = _U('mojito'),        value = 'mojito'},
									{label = _U('mixapero'),      value = 'mixapero'},
									{label = _U('metreshooter'),  value = 'metreshooter'},
									{label = _U('jagercerbere'),  value = 'jagercerbere'},
								}
							},
							function(data2, menu2)

								TriggerServerEvent('tqrp_unicornjob:craftingCoktails', data2.current.value)
								animsAction({ lib = "mini@drinking", anim = "shots_barman_b" })

							end,
							function(data2, menu2)
								menu2.close()
							end
						)
					end

					end,
					function(data, menu)

					menu.close()

					end
				)

			end

			function OpenBillingMenu()

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'billing',
					{
					title = _U('billing_amount')
					},
					function(data, menu)

					local amount = tonumber(data.value)
					local player, distance = ESX.Game.GetClosestPlayer()

					if player ~= -1 and distance <= 3.0 then

						menu.close()
						if amount == nil then
							ESX.ShowNotification(_U('amount_invalid'))
						else
							TriggerServerEvent('tqrp_billing:sendBill', GetPlayerServerId(player), 'society_unicorn', _U('billing'), amount)
						end

					else
						ESX.ShowNotification(_U('no_players_nearby'))
					end

					end,
					function(data, menu)
						menu.close()
					end
				)
			end

			AddEventHandler('tqrp_unicornjob:hasEnteredMarker', function(zone)

				if zone == 'BossActions' and PlayerData.job.grade_name == "boss" then
					CurrentAction     = 'menu_boss_actions'
					CurrentActionData = {}
				end

				if zone == 'Cloakrooms' then
					CurrentAction     = 'menu_cloakroom'
					CurrentActionData = {}
				end

				--[[if zone == 'Vehicles' then
					CurrentAction     = 'menu_vehicle_spawner'
					CurrentActionData = {}
				end]]

				if zone == 'VehicleDeleters' then

				if IsPedInAnyVehicle(PlayerPed,  false) then

					local vehicle = GetVehiclePedIsIn(PlayerPed,  false)

					CurrentAction     = 'delete_vehicle'
					CurrentActionData = {vehicle = vehicle}
				end

				end

			end)

			AddEventHandler('tqrp_unicornjob:hasExitedMarker', function(zone)

				CurrentAction = nil
				ESX.UI.Menu.CloseAll()

			end)

			-- Display markers
			Citizen.CreateThread(function()
				while PlayerData.job.name == "unicorn" do
					Citizen.Wait(7)
					local coords, letSleep = GetEntityCoords(PlayerPed), true

					for k,v in pairs(Config.Jobs[PlayerData.job.name].Zones) do
						if (v.Type ~= -1) and (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 10) then
							DrawMarker(27, v.Pos.x, v.Pos.y, v.Pos.z - 1, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
							if (v.Type ~= -1) and (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
								DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z, v.Text)
							end
							letSleep = false
						end
					end

					if letSleep then
						Citizen.Wait(1500)
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == "unicorn" do
					Wait(500)
					local coords      = GetEntityCoords(PlayerPed)
					local isInMarker  = false
					local currentZone = nil

					for k,v in pairs(Config.Jobs[PlayerData.job.name].Zones) do
						if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
							isInMarker  = true
							currentZone = k
						end
					end

					if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
						HasAlreadyEnteredMarker = true
						LastZone                = currentZone
						TriggerEvent('tqrp_unicornjob:hasEnteredMarker', currentZone)
					end

					if not isInMarker and HasAlreadyEnteredMarker then
						HasAlreadyEnteredMarker = false
						TriggerEvent('tqrp_unicornjob:hasExitedMarker', LastZone)
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == "unicorn" do

					Citizen.Wait(10)
					if CurrentAction ~= nil then

						if IsControlJustReleased(0,  74) then
							print(CurrentAction)
							if CurrentAction == 'menu_cloakroom' then
								OpenCloakroomMenu()
							end

							--[[if CurrentAction == 'menu_vault' then
								OpenVaultMenu()
							end

							if CurrentAction == 'menu_fridge' then
								OpenFridgeMenu()
							end]]

							if CurrentAction == 'menu_shop' then
								OpenShopMenu(CurrentActionData.zone)
							end

							--[[if CurrentAction == 'menu_vehicle_spawner' then
								OpenVehicleSpawnerMenu()
							end]]

							if CurrentAction == 'delete_vehicle' then

								if Config.EnableSocietyOwnedVehicles then

									local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
									TriggerServerEvent('tqrp_society:putVehicleInGarage', 'unicorn', vehicleProps)

								else

									if
										GetEntityModel(vehicle) == GetHashKey('rentalbus')
									then
										TriggerServerEvent('tqrp_service:disableService', 'unicorn')
									end

								end

								ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
							end


							if CurrentAction == 'menu_boss_actions' then
								local options = {
								wash      = false,
								}

								ESX.UI.Menu.CloseAll()

								TriggerEvent('tqrp_society:openBossMenu', 'unicorn', function(data, menu)

								menu.close()
								CurrentAction     = 'menu_boss_actions'
								CurrentActionData = {}

								end,options)

							end


							CurrentAction = nil
						end

					end

					if IsControlJustReleased(0,  289) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'unicorn_actions') then
						OpenSocietyActionsMenu()
					end

				end
			end)
		elseif PlayerData.job.name == 'ambulance' then
			local inVeh = false
			local CurrentAction, CurrentActionMsg = nil, ''
			local HasAlreadyEnteredMarker, LastPart, LastPartNum
			local isBusy = false

			RegisterCommand("despir", function()
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 2.5 then
					TriggerServerEvent('smerfikubrania:despir', GetPlayerServerId(closestPlayer))
				end
			end, false)

			RegisterCommand("bandage", function()
				isBusy = true
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 1.0 then
					TriggerEvent("pNotify:SendNotification", {text = "<span style='font-weight: 300'>" .. _U('no_players') .. "</span>",
						layout = "topRight",
						timeout = 2000,
						progressBar = false,
						type = "error",
						animation = {
							open = "gta_effects_fade_in",
							close = "gta_effects_fade_out"
					}})
				else
					ESX.TriggerServerCallback('tqrp_ambulancejob:getItemAmount', function(quantity)
						if quantity > 0 then
							local closestPlayerPed = GetPlayerPed(closestPlayer)
							local health = GetEntityHealth(closestPlayerPed)

							if health > 0 then
								isBusy = true
								TriggerServerEvent('tqrp_ambulancejob:removeItem', 'bandage')
								TriggerEvent("mythic_progbar:client:progress", {
									name = "unique_action_name",
									duration = 1000,
									label = _U('heal_inprogress'),
									useWhileDead = false,
									canCancel = true,
									controlDisables = {
										disableMovement = true,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									}
									}, function(status)
									if not status then
										TaskStartScenarioInPlace(PlayerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
										Citizen.Wait(10000)
										ClearPedTasks(PlayerPed)
									end
								end)
								TriggerServerEvent('tqrp_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
								isBusy = false
							else
								TriggerEvent("pNotify:SendNotification", {text = "<span style='font-weight: 300'>" .. _U('player_not_conscious') .. "</span>",
									layout = "topRight",
									timeout = 2000,
									progressBar = false,
									type = "info",
									animation = {
										open = "gta_effects_fade_in",
										close = "gta_effects_fade_out"
								}})
							end
						else
							TriggerEvent("pNotify:SendNotification", {text = "<span style='font-weight: 300'>" .. _U('not_enough_bandage') .. "</span>",
								layout = "topRight",
								timeout = 2000,
								progressBar = false,
								type = "error",
								animation = {
									open = "gta_effects_fade_in",
									close = "gta_effects_fade_out"
							}})
						end
					end, 'bandage')
				end
				isBusy = true
			end, false)

			RegisterCommand("medicKit", function()
				isBusy = true
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 1.0 then
					TriggerEvent("pNotify:SendNotification", {text = "<span style='font-weight: 300'>" .. _U('no_players') .. "</span>",
								layout = "topRight",
								timeout = 2000,
								progressBar = false,
								type = "error",
								animation = {
									open = "gta_effects_fade_in",
									close = "gta_effects_fade_out"
						}})
				else
					ESX.TriggerServerCallback('tqrp_ambulancejob:getItemAmount', function(quantity)
						if quantity > 0 then
							local closestPlayerPed = GetPlayerPed(closestPlayer)
							local health = GetEntityHealth(closestPlayerPed)

							if health > 0 then
								isBusy = true
								TriggerServerEvent('tqrp_ambulancejob:removeItem', 'medickit')
								TriggerEvent("mythic_progbar:client:progress", {
									name = "unique_action_name",
									duration = 1000,
									label = _U('heal_inprogress'),
									useWhileDead = false,
									canCancel = true,
									controlDisables = {
										disableMovement = true,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									}
									}, function(status)
									if not status then
										TaskStartScenarioInPlace(PlayerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
										Citizen.Wait(10000)
										ClearPedTasks(PlayerPed)
									end
								end)
								TriggerServerEvent('tqrp_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
								isBusy = false
							else
								TriggerEvent("pNotify:SendNotification", {text = "<span style='font-weight: 300'>" .. _U('player_not_conscious') .. "</span>",
								layout = "topRight",
								timeout = 2000,
								progressBar = false,
								type = "info",
								animation = {
									open = "gta_effects_fade_in",
									close = "gta_effects_fade_out"
								}})
							end
						else
							TriggerEvent("pNotify:SendNotification", {text = "<span style='font-weight: 300'>" .. _U('not_enough_bandage') .. "</span>",
								layout = "topRight",
								timeout = 2000,
								progressBar = false,
								type = "error",
								animation = {
									open = "gta_effects_fade_in",
									close = "gta_effects_fade_out"
							}})
						end
					end, 'medickit')
				end
				isBusy = false
			end, false)

			RegisterCommand("medic_revive", function()
				isBusy = true
				local closestPlayer = ESX.Game.GetClosestPlayer()
				ESX.TriggerServerCallback('tqrp_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local closestPlayerPed = GetPlayerPed(closestPlayer)

						if IsPedDeadOrDying(closestPlayerPed, 1) then
							local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
							for i=1, 15, 1 do
								Citizen.Wait(900)
								ESX.Streaming.RequestAnimDict(lib, function()
									TaskPlayAnim(PlayerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
								end)
							end
							TriggerServerEvent('tqrp_ambulancejob:removeItem', 'medikit')
							TriggerServerEvent('tqrp_ambulancejob:revive', GetPlayerServerId(closestPlayer))
						else
							TriggerEvent("pNotify:SendNotification", {text = "<span style='font-weight: 300'>" .. _U('player_not_conscious') .. "</span>",
							layout = "topRight",
							timeout = 2000,
							progressBar = false,
							type = "info",
							animation = {
								open = "gta_effects_fade_in",
								close = "gta_effects_fade_out"
							}})
						end
					else
						TriggerEvent("pNotify:SendNotification", {text = "<span style='font-weight: 300'>" .. _U('not_enough_medikit') .. "</span>",
							layout = "topRight",
							timeout = 2000,
							progressBar = false,
							type = "error",
							animation = {
								open = "gta_effects_fade_in",
								close = "gta_effects_fade_out"
						}})
					end

					isBusy = false

				end, 'medikit')
				isBusy = false
			end, false)

			RegisterCommand("fatura", function(source, args, raw) --change command here
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
					title = "Valor da fatura"
					}, function(data, menu)
					local amount = tonumber(data.value)

					if amount == nil or amount < 0 then
						TriggerEvent("pNotify:SendNotification", {text = "<span style='font-weight: 300'> Valor Inválido! </span>",
								layout = "topRight",
								timeout = 2000,
								progressBar = false,
								type = "error",
								animation = {
									open = "gta_effects_fade_in",
									close = "gta_effects_fade_out"
						}})
					else
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > Config.DrawDistance then
							TriggerEvent("pNotify:SendNotification", {text = "<span style='font-weight: 300'> Nenhum jogador por perto! </span>",
								layout = "topRight",
								timeout = 2000,
								progressBar = false,
								type = "error",
								animation = {
									open = "gta_effects_fade_in",
									close = "gta_effects_fade_out"
							}})
						else
							menu.close()
							TriggerServerEvent('tqrp_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ambulance', "Despesas Médicas", amount)
							exports['mythic_notify']:SendAlert('true', 'Fatura enviada')
						end
					end
				end, function(data, menu)
					menu.close()
				end)
			end, false)

			Citizen.CreateThread(function()
				while PlayerData.job.name == 'ambulance' do
					Citizen.Wait(7)
					local letSleep, isInMarker, hasExited = true, false, false
					local currentPart, currentPartNum
					local playerCoords = GetEntityCoords(PlayerPed)
					-- Ambulance Actions
					for k,v in ipairs(Config.Jobs[PlayerData.job.name].Zones.AmbulanceActions) do
						local distance = GetDistanceBetweenCoords(playerCoords, v.Pos, true)
						local x,y,z = table.unpack(v.Pos)
						if distance < 5 then
							DrawMarker(27, x,y,z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
							if distance < Config.DrawDistance then
								DrawText3Ds(x, y ,(z + 1), v.Text)
								isInMarker, currentPart, currentPartNum = true, 'AmbulanceActions', k
							end
							letSleep = false
						end
					end

					-- Pharmacies
					for k,v in ipairs(Config.Jobs[PlayerData.job.name].Zones.Pharmacies) do
						local distance = GetDistanceBetweenCoords(playerCoords, v.Pos, true)
						local x,y,z = table.unpack(v.Pos)
						if distance < 5 then
							DrawMarker(27, x,y,z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
							if (v.Type ~= -1) and (GetDistanceBetweenCoords(playerCoords, x,y,z, true) < Config.DrawDistance) then
								DrawText3Ds(x, y ,(z + 1), v.Text)
								isInMarker, currentPart, currentPartNum = true, 'Pharmacy', k
							end
							letSleep = false
						end
					end

					-- Helicopter Spawners
					for k,v in ipairs(Config.Jobs[PlayerData.job.name].Zones.Helicopters) do
						local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)
						local x,y,z = table.unpack(v.Spawner)
						if distance < 5 then
							DrawMarker(27, x,y,z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
							if (v.Type ~= -1) and (GetDistanceBetweenCoords(playerCoords, x,y,z, true) < Config.DrawDistance) then
								DrawText3Ds(x, y ,(z + 1), v.Text)
								isInMarker, currentPart, currentPartNum = true, 'Helicopters', k
							end
							letSleep = false
						end
					end

					-- Vehicles Spawners
					for k,v in ipairs(Config.Jobs[PlayerData.job.name].Zones.Vehicles) do
						local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)
						local x,y,z = table.unpack(v.Spawner)
						if distance < 15 then
							DrawMarker(27, x,y,z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
							if (v.Type ~= -1) and (GetDistanceBetweenCoords(playerCoords, x,y,z, true) < Config.DrawDistance) then
								DrawText3Ds(x, y ,(z + 1), v.Text)
								isInMarker, currentPart, currentPartNum = true, 'Vehicles', k
							end
							letSleep = false
						end
					end

					-- Logic for exiting & entering markers
					if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
						if
							(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
							(LastPart ~= currentPart or LastPartNum ~= currentPartNum)
						then
							TriggerEvent('tqrp_whitejobs:hasExitedMarker', LastPart, LastPartNum)
							hasExited = true
						end

						HasAlreadyEnteredMarker, LastPart, LastPartNum = true, currentPart, currentPartNum

						TriggerEvent('tqrp_ambulancejob:hasEnteredMarker', currentPart, currentPartNum)

					end

					if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
						HasAlreadyEnteredMarker = false
						TriggerEvent('tqrp_whitejobs:hasExitedMarker', LastPart, LastPartNum)
					end

					if letSleep then
						Citizen.Wait(1500)
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == 'ambulance' do
					Citizen.Wait(10)
					if CurrentAction then
						if IsControlJustReleased(0, 74) then
							if CurrentAction == 'AmbulanceActions' then
								OpenAmbulanceActionsMenu()
							elseif CurrentAction == 'Pharmacy' then
								OpenPharmacyMenu()
							elseif CurrentAction == 'Vehicles' then
								OpenVehicleSpawnerMenu()
							elseif CurrentAction == 'Helicopters' then
								OpenHelicopterSpawnerMenu()
							end

							CurrentAction = nil

						end

					--[[elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' and not is_dead then
						if IsControlJustReleased(0, 289) then
							OpenMobileAmbulanceActionsMenu()
						end]]
					end
					if IsDisabledControlJustPressed(1, 161) and GetLastInputMethod(0) then
						TriggerEvent('tqrp_outlaw:openMenu')
					end
				end
			end)

			Citizen.CreateThread(function()
				-- Update every frame
				while PlayerData.job.name == 'ambulance' do
					Citizen.Wait(10)
					-- Loop through all menus in config
					for _, menuConfig in pairs(Config.Jobs[PlayerData.job.name].Menu) do
						-- Check if menu should be enabled
						if menuConfig:enableMenu() then
							-- When keybind is pressed toggle UI
							local keybindControl = menuConfig.data.keybind
							if IsControlJustReleased(0, keybindControl) then
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
							end
						end
					end
				end
			end)

			RegisterCommand("zeze", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
					name = "vestir_farda",
					duration = 5000,
					label = "A vestir a farda",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "missmic4",
						anim = "michael_tux_fidget",
						flags = 49,
					}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
						local clothesSkin = {
							['tshirt_1'] = 88,  ['tshirt_2'] = 0,
							['torso_1'] = 31,   ['torso_2'] = 0,
							['decals_1'] = 0,   ['decals_2'] = 0,
							['arms'] = 6,
							['pants_1'] = 20,   ['pants_2'] = 0,
							['shoes_1'] = 5,   ['shoes_2'] = 0,
							['helmet_1'] = -1,  ['helmet_2'] = 0,
							['mask_1'] = 0,     ['mask_2'] = 0,
							['chain_1'] = 126,    ['chain_2'] = 0,
							['ears_1'] = -1,     ['ears_2'] = 0,
							['glasses_1'] = 0,  ['glasses_2'] = 0,
							['bproof_1'] = 0,  ['bproof_2'] = 0
						}
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					else
						local clothesSkin = {
								['tshirt_1'] = 31,      ['tshirt_2'] = 0,
								['ears_1'] = -1,        ['ears_2'] = 0,
								['torso_1'] = 85,       ['torso_2'] = 1,
								['decals_1'] = 0,      ['decals_2']= 0,
								['mask_1'] = 0,         ['mask_2'] = 0,
								['arms'] = 31,
								['pants_1'] = 54,       ['pants_2'] = 1,
								['shoes_1'] = 24,        ['shoes_2'] = 0,
								['helmet_1']  = -1,     ['helmet_2'] = 0,
								['bags_1'] = 0,         ['bags_2'] = 0,
								['glasses_1'] = -1,      ['glasses_2'] = 0,
								['chain_1'] = 0,        ['chain_2'] = 0,
								['bproof_1'] = 14,       ['bproof_2'] = 0
						}
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			function OpenCloakroomMenu()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
					title    = "Roupa de Trabalho",
					align    = 'top-left',
					elements = {
						{label = "Civil", value = 'citizen_wear'},
						{label = "Doutor", value = 'ambulance_wear'},
						{label = "Cirurgão", value = 'ambulance_cirurgia'},
						{label = "Paramedico", value = 'ambulance_paramedico'},
					}
				}, function(data, menu)
					if data.current.value == 'citizen_wear' then
						ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin, jobSkin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)
					elseif data.current.value == 'ambulance_wear' then
						if GetEntityModel(PlayerPed) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPed) == GetHashKey("mp_f_freemode_01") then
							TriggerEvent('skinchanger:getSkin', function(skin)
							  if skin.sex == 0 then
								local clothesSkin = {
									['tshirt_1'] = 122,  ['tshirt_2'] = 0,
									['torso_1'] = 32,   ['torso_2'] = 1,
									['decals_1'] = 0,   ['decals_2'] = 0,
									['arms'] = 92,
									['pants_1'] = 20,   ['pants_2'] = 0,
									['shoes_1'] = 8,   ['shoes_2'] = 0,
									['helmet_1'] = -1,  ['helmet_2'] = 0,
									['mask_1'] = 0,     ['mask_2'] = 0,
									['chain_1'] = 126,    ['chain_2'] = 0,
									['ears_1'] = -1,     ['ears_2'] = 0,
									['glasses_1'] = 0,  ['glasses_2'] = 0,
									['bproof_1'] = 0,  ['bproof_2'] = 0
								}
								TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
								ESX.UI.Menu.CloseAll()
								--TriggerEvent("clothes:openmenucop")
							  else
								local clothesSkin = {
										['tshirt_1'] = 14,      ['tshirt_2'] = 0,
										['ears_1'] = -1,        ['ears_2'] = 0,
										['torso_1'] = 26,       ['torso_2'] = 0,
										['decals_1'] = 0,      ['decals_2']= 0,
										['mask_1'] = 0,         ['mask_2'] = 0,
										['arms'] = 101,
										['pants_1'] = 3,       ['pants_2'] = 0,
										['shoes_1'] = 64,        ['shoes_2'] = 0,
										['helmet_1']  = -1,     ['helmet_2'] = 0,
										['bags_1'] = 0,         ['bags_2'] = 0,
										['glasses_1'] = -1,      ['glasses_2'] = 0,
										['chain_1'] = 14,        ['chain_2'] = 0,
										['bproof_1'] = 0,       ['bproof_2'] = 0
								}
								TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
								ESX.UI.Menu.CloseAll()
								--TriggerEvent("clothes:openmenucop")
							  end
							  onDutyPolicia = true
							end)
						  else
							TriggerEvent('esx:notifyPl', "Veste primeiro a roupa de civil normal.")
						  end
						end

						if data.current.value == 'ambulance_cirurgia' then
							if GetEntityModel(PlayerPed) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPed) == GetHashKey("mp_f_freemode_01") then
							  TriggerEvent('skinchanger:getSkin', function(skin)
								if skin.sex == 0 then
								  local clothesSkin = {
									  ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
									  ['torso_1'] = 271,   ['torso_2'] = 0,
									  ['decals_1'] = 0,   ['decals_2'] = 0,
									  ['arms'] = 85,
									  ['pants_1'] = 104,   ['pants_2'] = 0,
									  ['shoes_1'] = 42,   ['shoes_2'] = 2,
									  ['helmet_1'] = 83,  ['helmet_2'] = 2,
									  ['mask_1'] = 101,     ['mask_2'] = 1,
									  ['chain_1'] = 0,    ['chain_2'] = 0,
									  ['ears_1'] = -1,     ['ears_2'] = 0,
									  ['glasses_1'] = 0,  ['glasses_2'] = 0,
									  ['bproof_1'] = 0,  ['bproof_2'] = 0
								  }
								  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
								  ESX.UI.Menu.CloseAll()
								  --TriggerEvent("clothes:openmenucop")
								else
								  local clothesSkin = {
										  ['tshirt_1'] = 14,      ['tshirt_2'] = 0,
										  ['ears_1'] = -1,        ['ears_2'] = 0,
										  ['torso_1'] = 280,       ['torso_2'] = 0,
										  ['decals_1'] = 0,      ['decals_2']= 0,
										  ['mask_1'] = 101,         ['mask_2'] = 1,
										  ['arms'] = 109,
										  ['pants_1'] = 111,       ['pants_2'] = 0,
										  ['shoes_1'] = 1,        ['shoes_2'] = 3,
										  ['helmet_1']  = 82,     ['helmet_2'] = 2,
										  ['bags_1'] = 0,         ['bags_2'] = 0,
										  ['glasses_1'] = -1,      ['glasses_2'] = 0,
										  ['chain_1'] = 0,        ['chain_2'] = 0,
										  ['bproof_1'] = 0,       ['bproof_2'] = 0
								  }
								  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
								  ESX.UI.Menu.CloseAll()
								  --TriggerEvent("clothes:openmenucop")
								end
								onDutyPolicia = true
							  end)
							else
							  TriggerEvent('esx:notifyPl', "Veste primeiro a roupa de civil normal.")
							end
						end

						if data.current.value == 'ambulance_paramedico' then
							if GetEntityModel(PlayerPed) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPed) == GetHashKey("mp_f_freemode_01") then
							  TriggerEvent('skinchanger:getSkin', function(skin)
								if skin.sex == 0 then
								  local clothesSkin = {
									  ['tshirt_1'] = 137,  ['tshirt_2'] = 0,
									  ['torso_1'] = 51,   ['torso_2'] = 1,
									  ['decals_1'] = 0,   ['decals_2'] = 0,
									  ['arms'] = 93	,
									  ['pants_1'] = 46,   ['pants_2'] = 0,
									  ['shoes_1'] = 25,   ['shoes_2'] = 0,
									  ['helmet_1'] = -1,  ['helmet_2'] = 0,
									  ['mask_1'] = -1,     ['mask_2'] = 0,
									  ['chain_1'] = 0,    ['chain_2'] = 0,
									  ['ears_1'] = -1,     ['ears_2'] = 0,
									  ['glasses_1'] = 0,  ['glasses_2'] = 0,
									  ['bproof_1'] = 0,  ['bproof_2'] = 0
								  }
								  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
								  ESX.UI.Menu.CloseAll()
								  --TriggerEvent("clothes:openmenucop")
								else
								  local clothesSkin = {
										  ['tshirt_1'] = 14,      ['tshirt_2'] = 0,
										  ['ears_1'] = -1,        ['ears_2'] = 0,
										  ['torso_1'] = 280,       ['torso_2'] = 0,
										  ['decals_1'] = 0,      ['decals_2']= 0,
										  ['mask_1'] = 101,         ['mask_2'] = 1,
										  ['arms'] = 109,
										  ['pants_1'] = 111,       ['pants_2'] = 0,
										  ['shoes_1'] = 1,        ['shoes_2'] = 3,
										  ['helmet_1']  = 82,     ['helmet_2'] = 2,
										  ['bags_1'] = 0,         ['bags_2'] = 0,
										  ['glasses_1'] = -1,      ['glasses_2'] = 0,
										  ['chain_1'] = 0,        ['chain_2'] = 0,
										  ['bproof_1'] = 0,       ['bproof_2'] = 0
								  }
								  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
								  ESX.UI.Menu.CloseAll()
								  --TriggerEvent("clothes:openmenucop")
								end
								onDutyPolicia = true
							  end)
							else
							  TriggerEvent('esx:notifyPl', "Veste primeiro a roupa de civil normal.")
							end
						end

					menu.close()
				end, function(data, menu)
					menu.close()
				end)
			end

			function OpenVehicleSpawnerMenu()
				local elements = {
					{label = 'Veículos',   value = 'vehicle_list'},
					{label = 'Guardar Veículos',      value = 'save_vehicle'}
				}
				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_actions', {
					title    = _U('mechanic'),
					align    = 'top-left',
					elements = elements
				}, function(data, menu)
					if data.current.value == 'vehicle_list' then
						local elements = {
							{label = 'S.U.V S.E.M',  value = 'qrv'},
							{label = 'Ambulância',  value = 'ambulance'}
						}

						ESX.UI.Menu.CloseAll()
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
							title    = _U('service_vehicle'),
							align    = 'top-left',
							elements = elements
						}, function(data, menu)
							ESX.Game.SpawnVehicle(data.current.value, vector3(338.92, -559.36, 28.74), 90.0, function(vehicle)
								ESX.Game.SetVehicleProperties(vehicle, {
									modLivery = 0
								})
								--TaskWarpPedIntoVehicle(PlayerPed, vehicle, -1)
								SetVehicleMaxMods(vehicle)
								TriggerEvent("onyx:updatePlates", ESX.Game.GetVehicleProperties(vehicle).plate)
							end)
							menu.close()
						end, function(data, menu)
							menu.close()
						end)
					elseif data.current.value == 'save_vehicle' then
						menu.close()
						local veh,dist = ESX.Game.GetClosestVehicle(playerCoords)
						if dist < 3 then
							DeleteEntity(veh)
							exports['mythic_notify']:SendAlert('true', 'Guardado')
						else
							exports['mythic_notify']:SendAlert('false', 'Nenhum vehiculo para guardar!')
						end
					end
				end, function(data, menu)
					menu.close()

					CurrentAction     = 'Vehicles'
					CurrentActionData = {}
				end)
			end

			function OpenHelicopterSpawnerMenu()
				local elements = {
					{label = 'Helicopteros',   value = 'vehicle_list'}--[[,
					{label = 'Guardar Helicopteros',      value = 'save_vehicle'}]]
				}
				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_actions', {
					title    = "Menu",
					align    = 'top-left',
					elements = elements
				}, function(data, menu)
					if data.current.value == 'vehicle_list' then
						local elements = {
							{label = 'Polmav',  value = 'polmav'}
						}

						ESX.UI.Menu.CloseAll()
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
							title    = 'Menu',
							align    = 'top-left',
							elements = elements
						}, function(data, menu)
							ESX.Game.SpawnVehicle(data.current.value, vector3(351.12, -588.21, 74.17), 164.0, function(vehicle)
								ESX.Game.SetVehicleProperties(vehicle, {
									modLivery = 1
								})
								SetVehicleMaxMods(vehicle)
								TriggerEvent("onyx:updatePlates", ESX.Game.GetVehicleProperties(vehicle).plate)
							end)
							menu.close()
						end, function(data, menu)
							menu.close()
						end)
					end
				end, function(data, menu)
					menu.close()
					CurrentAction     = 'Vehicles'
					CurrentActionData = {}
				end)
			end

			function OpenAmbulanceActionsMenu()
				local elements = {
					{label = _U('work_wear'), value = 'cloakroom'}
				}

				if PlayerData.job.grade_name == 'boss' then
					table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
					title    = "MENU",
					align    = 'top-left',
					elements = elements
				}, function(data, menu)
					if data.current.value == 'cloakroom' then
						OpenCloakroomMenu()
					elseif data.current.value == 'boss_actions' then
						TriggerEvent('tqrp_society:openBossMenu', 'ambulance', function(data, menu)
							menu.close()
						end, {wash = false})
					end
					menu.close()
				end)

			end

			function OpenPharmacyMenu()
				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
					title    = _U('pharmacy_menu_title'),
					align    = 'top-left',
					elements = {
						{label = _U('pharmacy_take', _U('medikit')), value = 'medikit'},
						{label = _U('pharmacy_take', "Morfina"), value = 'morphine'},
						{label = _U('pharmacy_take', "Hydrocodona"), value = 'hydrocodone'},
						{label = _U('pharmacy_take', "Bandagem"), value = 'bandage'},
						{label = _U('pharmacy_take', "Vincodina"), value = 'vicodin'}
					}
				}, function(data, menu)
					TriggerServerEvent('tqrp_ambulancejob:giveItem', data.current.value)
				end, function(data, menu)
					menu.close()
				end)
			end

			AddEventHandler('tqrp_ambulancejob:hasEnteredMarker', function(part, partNum)
				if part == 'AmbulanceActions' then
					CurrentAction = part
					CurrentActionData = {}
				elseif part == 'Pharmacy' then
					CurrentAction = part
					CurrentActionData = {}
				elseif part == 'Vehicles' then
					CurrentAction = part
					CurrentActionData = {partNum = partNum}
				elseif part == 'Helicopters' then
					CurrentAction = part
					CurrentActionData = {partNum = partNum}
				end
			end)

			RegisterCommand("MEDsubmenu1", function(source, args, rawCommand)
				-- Wait for next frame just to be safe
				Citizen.Wait(10)

				-- Init UI and set focus
				showMenu = true
				SendNUIMessage({
					type = 'init',
					data = Config.Jobs["ambulance"].SubMenu["ambulance"].data,
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
		elseif PlayerData.job.name == 'police' then

			local radar = {

				shown = false,

				freeze = false,

				info = "00AAA00A    000  KM/H",

				info2 = "00AAA00A    000  KM/H",

				minSpeed = 5.0,

				maxSpeed = 75.0,

			}

			function OpenPoliceActionsMenu()
				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions',
				{
					title    = 'Policia de Los Santos',
					align    = 'bottom-right',
					elements = {
						{label = _U('citizen_interaction'),	value = 'citizen_interaction'},
						{label = _U('vehicle_interaction'),	value = 'vehicle_interaction'},
						{label = "Fita de pregos",      value = 'pregos_script'}
					}
				}, function(data, menu)

					if data.current.value == 'citizen_interaction' then
						local elements = {
							{label = 'Arrastar',			value = 'drag'},
							{label = 'Colocar no Veículo',			value = 'putVeh'},
							{label = 'Tirar do Veículo',			value = 'takeVeh'},
							{label = '-------------------------------------------------------------------------',			value = '7'},
							{label = 'Cartão de Cidadão',			value = 'identity_card'},
							{label = '-------------------------------------------------------------------------',			value = '1'},
							{label = 'MULTAS',			value = '2'},
							{label = '-------------------------------------------------------------------------',			value = '3'},
							{label = _U('fine'),			value = 'fine'},
							{label = 'Multa personalizada',			value = 'fine2'},
							{label = 'Multa não pagas',			value = 'fine3'},
							{label = '-------------------------------------------------------------------------',			value = '4'},
							{label = 'LICENÇAS',			value = 'licences'},
							{label = '-------------------------------------------------------------------------',			value = '6'},
						}

						ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'citizen_interaction',
						{
							title    = _U('citizen_interaction'),
							align    = 'bottom-right',
							elements = elements
						}, function(data2, menu2)
							local player, distance = ESX.Game.GetClosestPlayer()
							if distance ~= -1 and distance <= 3.0 then
								local action = data2.current.value

								if data2.current.value == 'licences' then
									local elements3 = {
										{label = 'Atribuir porte de arma',			value = 'license_weapon_add'},
										{label = 'Atribuir Licença de Caça',			value = 'license_weapon_add_2'},
										{label = 'Atribuir Carta de Motociclos',            value = 'license_moto_add'},
										{label = 'Atribuir Carta de Pesados',            value = 'license_camion_add'},
										{label = 'Atribuir Carta de Ligeiros',            value = 'license_voiture_add'},
										{label = 'Atribuir Código de Condução',            value = 'license_code_add'},
										{label = 'Retirar Porte de Arma',            value = 'license_weapon_remove'},
										{label = 'Retirar Carta de Motociclos',            value = 'license_moto_remove'},
										{label = 'Retirar Carta de Pesados',            value = 'license_camion_remove'},
										{label = 'Retirar Carta de Ligeiros',            value = 'license_voiture_remove'},
										{label = 'Retirar Código de Condução',            value = 'license_code_remove'}
									}
									ESX.UI.Menu.Open(
										'default', GetCurrentResourceName(), 'licences',
										{
											title    = "Licenças",
											align    = 'bottom-right',
											elements = elements3
										}, function(data3, menu3)
											if data3.current.value == 'license_weapon_add' then
												if PlayerData.job.grade > 3 then
													TriggerServerEvent('tqrp_policejob:addLicense', GetPlayerServerId(player), 'weapon')
												else
													exports["mythic_notify"]:SendAlert("error", "Pede a um superior para fazer isso.")
												end
											end
			
											if data3.current.value == 'license_weapon_add_2' then
												if PlayerData.job.grade > 3 then
													TriggerServerEvent('tqrp_policejob:addLicense', GetPlayerServerId(player), 'hunt')
												else
													exports["mythic_notify"]:SendAlert("error", "Pede a um superior para fazer isso.")
												end
											end
			
											if data3.current.value == 'license_moto_add' then
												TriggerServerEvent('tqrp_policejob:addLicense', GetPlayerServerId(player), 'drive_bike')
											end
			
											if data3.current.value == 'license_camion_add' then
												TriggerServerEvent('tqrp_policejob:addLicense', GetPlayerServerId(player), 'drive_truck')
											end
			
											if data3.current.value == 'license_voiture_add' then
												TriggerServerEvent('tqrp_policejob:addLicense', GetPlayerServerId(player), 'drive')
											end
			
											if data3.current.value == 'license_code_add' then
												TriggerServerEvent('tqrp_policejob:addLicense', GetPlayerServerId(player), 'dmv')
											end
			
											if data3.current.value == 'license_weapon_remove' then
												TriggerServerEvent('tqrp_policejob:deletelicense', GetPlayerServerId(player), 'weapon')
											end
			
											if data3.current.value == 'license_moto_remove' then
												TriggerServerEvent('tqrp_policejob:deletelicense', GetPlayerServerId(player), 'drive_bike')
											end
			
											if data3.current.value == 'license_camion_remove' then
												TriggerServerEvent('tqrp_policejob:deletelicense', GetPlayerServerId(player), 'drive_truck')
											end
			
											if data3.current.value == 'license_voiture_remove' then
												TriggerServerEvent('tqrp_policejob:deletelicense', GetPlayerServerId(player), 'drive')
											end
			
											if data3.current.value == 'license_code_remove' then
												TriggerServerEvent('tqrp_policejob:deletelicense', GetPlayerServerId(player), 'dmv')
											end
									end, function(data3, menu3)
										menu3.close()
									end)
								end

								if data2.current.value == 'identity_card' then
									OpenIdentityCardMenu(player)
								end

								if data2.current.value == 'body_search' then
									OpenBodySearchMenu(player)
								end

								if data2.current.value == 'fine' then
									OpenFineMenu(player)
								end

								if data2.current.value == 'fine2' then
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing',
									{
										title = 'Valor fatura'
									},
									function(data, menu)
										local amount = tonumber(data.value)
										if amount == nil then
											TriggerEvent('esx:notifyPl','Valor inválido')
										else
											menu.close()
											local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
											if closestPlayer == -1 or closestDistance > 3.0 then
												TriggerEvent('esx:notifyPl','Não há jogadores próximos')
											else
												TriggerServerEvent('tqrp_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Multa Policia de Los Santos', amount)
											end
										end
									end,
									function(data, menu)
										menu.close()
									end)
								end
								if data2.current.value == 'fine3' then
									OpenUnpaidBillsMenu(player)
								end
								
								if data2.current.value == 'drag' then
									TriggerServerEvent('tqrp_policejob:drag', GetPlayerServerId(player))
								end

								if data2.current.value == 'putVeh' then
									TriggerServerEvent("tqrp_policejob:putInVehicle", GetPlayerServerId(player))
								end

								if data2.current.value == 'takeVeh' then
									TriggerServerEvent("tqrp_policejob:OutVehicle", GetPlayerServerId(player))
								end
								--  GetPlayerServerId(closestPlayer)
							else
								TriggerEvent('esx:notifyPl', "Não há pessoas próximas de ti")
							end
						end, function(data2, menu2)
							menu2.close()
						end)


					elseif data.current.value == 'vehicle_interaction' then
						local elements  = {}
						local vehicle   = ESX.Game.GetVehicleInDirection()

						if DoesEntityExist(vehicle) then
							table.insert(elements, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
							table.insert(elements, {label = _U('impound'),		value = 'impound'})
						end

						ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'vehicle_interaction',
						{
							title    = _U('vehicle_interaction'),
							align    = 'bottom-right',
							elements = elements
						}, function(data2, menu2)
							vehicle = ESX.Game.GetVehicleInDirection()
							action  = data2.current.value
							if DoesEntityExist(vehicle) then
								local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
								if action == 'hijack_vehicle' then
									if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
										--TaskStartScenarioInPlace(PlayerPed, "WORLD_HUMAN_WELDING", 0, true)
										TaskStartScenarioInPlace(PlayerPed, "PROP_HUMAN_BUM_BIN", 0, true)
										Citizen.Wait(20000)
										ClearPedTasksImmediately(PlayerPed)

										SetVehicleDoorsLocked(vehicle, 1)
										SetVehicleDoorsLockedForAllPlayers(vehicle, false)
										ESX.ShowNotification(_U('vehicle_unlocked'))
									end
								elseif action == 'impound' then

									-- is the script busy?
									if CurrentTask.Busy then
										return
									end
									TaskStartScenarioInPlace(PlayerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

									CurrentTask.Busy = true
									CurrentTask.Task = ESX.SetTimeout(10000, function()
										ClearPedTasks(PlayerPed)
										ImpoundVehicle(vehicle)
										Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
									end)

									-- keep track of that vehicle!
									Citizen.CreateThread(function()
										while CurrentTask.Busy do
											Citizen.Wait(1500)

											vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
											if not DoesEntityExist(vehicle) and CurrentTask.Busy then
												ESX.ShowNotification(_U('impound_canceled_moved'))
												ESX.ClearTimeout(CurrentTask.Task)
												ClearPedTasks(PlayerPed)
												CurrentTask.Busy = false
												break
											end
										end
									end)
								end
							else
								ESX.ShowNotification(_U('no_vehicles_nearby'))
							end

						end, function(data2, menu2)
							menu2.close()
						end)

					elseif data.current.value == 'pregos_script' then

						ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'pregos_script',
						{
							title    = "Fita de pregos",
							align    = 'bottom-right',
							elements = {
							{label = "Colocar 1",         value = 'colocar_pregos1'},
							{label = "Colocar 2",         value = 'colocar_pregos2'},
							{label = "Colocar 3",         value = 'colocar_pregos3'},
							{label = "Remover",           value = 'remover_pregos'}

							},
						},
						function(data2, menu2)

						if data2.current.value == 'colocar_pregos1' then
							CreateSpikes(1)
						end

						if data2.current.value == 'colocar_pregos2' then
							CreateSpikes(2)
						end

						if data2.current.value == 'colocar_pregos3' then
							CreateSpikes(3)
						end

						if data2.current.value == 'remover_pregos' then
							RemoveSpikes()
							spikesSpawned = false
						end

						end,
						function(data2, menu2)
							menu2.close()
						end)
					end
				end,
				function(data, menu)
				  menu.close()
				end)
			end

			function OpenIdentityCardMenu(player)

				ESX.TriggerServerCallback('tqrp_policejob:getOtherPlayerData', function(data)

					local elements    = {}
					local nameLabel   = _U('name', data.name)
					local dobLabel    = nil
					local heightLabel = nil
					local idLabel     = nil

					if true then

						nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)

						if data.dob ~= nil then
							dobLabel = _U('dob', data.dob)
						else
							dobLabel = _U('dob', _U('unknown'))
						end

						if data.height ~= nil then
							heightLabel = _U('height', data.height)
						else
							heightLabel = _U('height', _U('unknown'))
						end

						if data.name ~= nil then
							idLabel = _U('id', data.name)
						else
							idLabel = _U('id', _U('unknown'))
						end

					end

					local elements = {
						{label = nameLabel, value = nil},
						{label = jobLabel,  value = nil},
					}

					if true then
						table.insert(elements, {label = dobLabel, value = nil})
						table.insert(elements, {label = heightLabel, value = nil})
						table.insert(elements, {label = idLabel, value = nil})
					end

					if data.drunk ~= nil then
						table.insert(elements, {label = _U('bac', data.drunk), value = nil})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
					{
						title    = _U('citizen_interaction'),
						align    = 'bottom-right',
						elements = elements,
					}, function(data, menu)

					end, function(data, menu)
						menu.close()
					end)

				end, GetPlayerServerId(player))

			end

			function OpenFineMenu(player)

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine',
				{
					title    = _U('fine'),
					align    = 'bottom-right',
					elements = {
						{label = "AUTOS DE TRANSITO", value = 0},
						{label = "CRIMES BÁSICOS",   value = 1},
						{label = "ASSALTOS", value = 2},
						{label = "CRIMES ADICIONAIS",   value = 3},
						{label = "CRIMES LEVES",   value = 4},
						{label = "CRIMES MÉDIOS",   value = 5},
						{label = "CRIMES GRAVES",   value = 6},
						{label = "PORTE ILEGAL DE ARMAS",   value = 7}
					}
				}, function(data, menu)
					OpenFineCategoryMenu(player, data.current.value)
				end, function(data, menu)
					menu.close()
				end)

			end

			function OpenFineCategoryMenu(player, category)

				ESX.TriggerServerCallback('tqrp_policejob:getFineList', function(fines)

					local elements = {}

					for i=1, #fines, 1 do
						table.insert(elements, {
							label     = fines[i].label .. ' <span style="color: green;">€' .. fines[i].amount .. '</span>',
							value     = fines[i].id,
							amount    = fines[i].amount,
							fineLabel = fines[i].label
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category',
					{
						title    = _U('fine'),
						align    = 'bottom-right',
						elements = elements,
					}, function(data, menu)

						local label  = data.current.fineLabel
						local amount = data.current.amount

						menu.close()
						TriggerServerEvent('tqrp_billing:sendBill', GetPlayerServerId(player), 'society_police', _U('fine_total', label), amount)

						ESX.SetTimeout(300, function()
							OpenFineCategoryMenu(player, category)
						end)

					end, function(data, menu)
						menu.close()
					end)

				end, category)

			end

			function OpenUnpaidBillsMenu(player)
				local elements = {}

				ESX.TriggerServerCallback('tqrp_billing:getTargetBills', function(bills)
					for i=1, #bills, 1 do
						table.insert(elements, {
							label = bills[i].label .. " | " .. bills[i].day .. "/" .. bills[i].month ..' - <span style="color: red;">€' .. bills[i].amount .. '</span>',
							value = bills[i].id
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
					{
						title    = 'Divída fiscal',
						align    = 'bottom-right',
						elements = elements
					}, function(data, menu)

					end, function(data, menu)
						menu.close()
					end)
				end, GetPlayerServerId(player))
			end

			function RemoveSpikes()
				for a = 1, #SpawnedSpikes do
					TriggerServerEvent("Spikes:TriggerDeleteSpikes", SpawnedSpikes[a])
				end
				SpawnedSpikes = {}
			end

			RegisterNetEvent("Spikes:DeleteSpikes")
			AddEventHandler("Spikes:DeleteSpikes", function(netid)
				Citizen.CreateThread(function()
					local spike = NetworkGetEntityFromNetworkId(netid)
					DeleteEntity(spike)
				end)
			end)

			RegisterNetEvent("Spikes:SpawnSpikes")
			AddEventHandler("Spikes:SpawnSpikes", function(config)
				CreateSpikes(config.amount)
			end)

			AddEventHandler('tqrp_policejob:hasEnteredMarker', function(part, partNum)

				if part == 'BossActions' then

					CurrentAction     = 'menu_boss_actions'
					CurrentActionData = {}

				end

			end)

			AddEventHandler('tqrp_policejob:hasEnteredEntityZone', function(entity)

				if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

					if IsPedInAnyVehicle(PlayerPed, false) then
						local vehicle = GetVehiclePedIsIn(PlayerPed)

						for i=0, 7, 1 do
							SetVehicleTyreBurst(vehicle, i, true, 1000)
						end
					end
				end
			end)

			AddEventHandler('tqrp_policejob:hasExitedEntityZone', function(entity)

				if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

					if IsPedInAnyVehicle(PlayerPed,  false) then

						local vehicle = GetVehiclePedIsIn(PlayerPed)

						for i=0, 7, 1 do
							SetVehicleTyreBurst(vehicle,  i,  true,  1000)
						end

					end

			  	end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' do
					Citizen.Wait(7)
					letSleep = true
					if GetDistanceBetweenCoords(coords, Config.Jobs[PlayerData.job.name].Zones.BossActions.x, Config.Jobs[PlayerData.job.name].Zones.BossActions.y, Config.Jobs[PlayerData.job.name].Zones.BossActions.z, true) < 15 then
						DrawMarker(27, Config.Jobs[PlayerData.job.name].Zones.BossActions.x, Config.Jobs[PlayerData.job.name].Zones.BossActions.y, Config.Jobs[PlayerData.job.name].Zones.BossActions.z - 1, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
						if GetDistanceBetweenCoords(coords, Config.Jobs[PlayerData.job.name].Zones.BossActions.x, Config.Jobs[PlayerData.job.name].Zones.BossActions.y, Config.Jobs[PlayerData.job.name].Zones.BossActions.z, true) < Config.DrawDistance then
							DrawText3Ds(Config.Jobs[PlayerData.job.name].Zones.BossActions.x, Config.Jobs[PlayerData.job.name].Zones.BossActions.y, Config.Jobs[PlayerData.job.name].Zones.BossActions.z, "[~g~E~w~] Policia de Los Santos")
							CurrentAction = 'menu_boss_actions'
						else
							CurrentAction = nil
						end
					else
						Citizen.Wait(1500)
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == 'police' do
					Citizen.Wait(7)
					if CurrentAction ~= nil then
						if IsControlJustReleased(0, 38) then

							if CurrentAction == 'menu_boss_actions' then
								ESX.UI.Menu.CloseAll()
								TriggerEvent('tqrp_society:openBossMenu', 'police', function(data, menu)
									menu.close()
									CurrentAction     = 'menu_boss_actions'
									CurrentActionMsg  = _U('open_bossmenu')
									CurrentActionData = {}
								end, { wash = false })
							end
							CurrentAction = nil
						end
					end

					if radar.shown and inVeh then
						waitRadar = 7
						if radar.freeze == false then
							local veh = GetVehiclePedIsIn(PlayerPed, false)
							local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
							local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
							local frontcar = StartShapeTestCapsule(coordA, coordB, 6.0, 10, veh, 7)

							local a, b, c, d, e = GetShapeTestResult(frontcar)

							if IsEntityAVehicle(e) then
								local fvspeed = GetEntitySpeed(e)*3.6
								local fplate = GetVehicleNumberPlateText(e)
								radar.info = string.format("%s   %s KM/H", fplate, round(fvspeed, 0))

								if fvspeed > SpeedLimit then
									PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
									radar.freeze = true
								end
							end

							local bcoordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, -105.0, 0.0)
							local rearcar = StartShapeTestCapsule(coordA, bcoordB, 3.0, 10, veh, 7)
							local f, g, h, i, j = GetShapeTestResult(rearcar)


							if IsEntityAVehicle(j) then

								local bvspeed = GetEntitySpeed(j)*3.6
								local bplate = GetVehicleNumberPlateText(j)
								radar.info2 = string.format("%s   %s KM/H", bplate, round(bvspeed, 0))

								if bvspeed > SpeedLimit then
									PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
									radar.freeze = true
								end
							end
						end

						--DrawRect(0.262, 0.86, 0.182, 0.0565, 0, 0, 0, 150)

						if radar.freeze == false then
							DrawAdvancedText(0.140, 0.80, 0.17, 0.05, 0.3, "FRONTAL", 106, 153, 74, 255, 4, 0)
							DrawAdvancedText(0.215, 0.80, 0.19, 0.05, 0.3, "TRASEIRA", 106, 153, 74, 255, 4, 0)
						else
							DrawAdvancedText(0.140, 0.80, 0.17, 0.05, 0.3, "FRONTAL", 245, 66, 66, 255, 4, 0)
							DrawAdvancedText(0.215, 0.80, 0.19, 0.05, 0.3, "TRASEIRA", 245, 66, 66, 255, 4, 0)
						end

						DrawAdvancedText(0.140, 0.776, 0.17, 0.05, 0.45, radar.info, 255, 255, 255, 255, 4, 0)
						DrawAdvancedText(0.215, 0.776, 0.19, 0.05, 0.45, radar.info2, 255, 255, 255, 255, 4, 0)



						if IsControlJustPressed(1, 311) and IsPedInAnyPoliceVehicle(PlayerPed) then

							if radar.freeze then

								radar.freeze = false
								radar.info = string.format("00AAA00A    000  KM/H")
								radar.info2 = string.format("00AAA00A    000  KM/H")
								exports["mythic_notify"]:SendAlert("success", "Radar Debloqueado")

							else

								radar.freeze = true
								exports["mythic_notify"]:SendAlert("error", "Radar Bloqueado")

							end

						end

					end

					if IsControlJustReleased(0, 289) and not isDead and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
						OpenPoliceActionsMenu()
					end

					if IsDisabledControlJustPressed(1, 161) and GetLastInputMethod(0) then
						TriggerEvent('tqrp_outlaw:openMenu')
					end

					if IsControlJustReleased(0, 38) and CurrentTask.Busy then
						ESX.ShowNotification(_U('impound_canceled'))
						ESX.ClearTimeout(CurrentTask.Task)
						ClearPedTasks(PlayerPed)
						CurrentTask.Busy = false
					end
				end
			end)

			function ImpoundVehicle(vehicle)
				--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
				ESX.Game.DeleteVehicle(vehicle)
				ESX.ShowNotification(_U('impound_successful'))
				CurrentTask.Busy = false
			end

			RegisterCommand("chapeu", function()
				if temChapeu then
					temChapeu = false
					LoadAnimDict( "missheist_agency2ahelmet" )
					TaskPlayAnim(PlayerPed, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1500)
					ClearPedTasks(PlayerPed)
					ClearPedProp(PlayerPed, 0)
				else
					temChapeu = true
					LoadAnimDict( "missheistdockssetup1hardhat@" )
					TaskPlayAnim(PlayerPed, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1000)
					SetPedPropIndex(PlayerPed, 0, 13, 2, true)
					Wait(1050)
					ClearPedTasks(PlayerPed)
				end
			end, false)

			RegisterCommand("chapeu2", function()

				if temChapeu then
					temChapeu = false
					LoadAnimDict( "missheist_agency2ahelmet" )
					TaskPlayAnim(PlayerPed, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1500)
					ClearPedTasks(PlayerPed)
					ClearPedProp(PlayerPed, 0)
				else
					temChapeu = true
					LoadAnimDict( "missheistdockssetup1hardhat@" )
					TaskPlayAnim(PlayerPed, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1000)
					SetPedPropIndex(PlayerPed, 0, 14, 1, true)
					Wait(1050)
					ClearPedTasks(PlayerPed)
				end
			end,false)

			RegisterCommand("chapeu3", function()
				if temChapeu then
					temChapeu = false
					LoadAnimDict( "missheist_agency2ahelmet" )
					TaskPlayAnim(PlayerPed, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1500)
					ClearPedTasks(PlayerPed)
					ClearPedProp(PlayerPed, 0)
				else
					temChapeu = true
					LoadAnimDict( "missheistdockssetup1hardhat@" )
					TaskPlayAnim(PlayerPed, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1000)
					SetPedPropIndex(PlayerPed, 0, 9, 0, true)
					Wait(1050)
					ClearPedTasks(PlayerPed)
				end
			end,false)

			RegisterCommand("capacete", function()
				if temChapeu then
					temChapeu = false
					LoadAnimDict( "missheist_agency2ahelmet" )
					TaskPlayAnim(PlayerPed, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1500)
					ClearPedTasks(PlayerPed)
					ClearPedProp(PlayerPed, 0)
				else
					temChapeu = true
					LoadAnimDict( "missheistdockssetup1hardhat@" )
					TaskPlayAnim(PlayerPed, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1000)
					SetPedPropIndex(PlayerPed, 0, 17, 0, true)
					Wait(1050)
					ClearPedTasks(PlayerPed)
				end
			end,false)

			RegisterCommand("capacetebici", function()
				if temChapeu then
					temChapeu = false
					LoadAnimDict( "missheist_agency2ahelmet" )
					TaskPlayAnim(PlayerPed, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1500)
					ClearPedTasks(PlayerPed)
					ClearPedProp(PlayerPed, 0)
				else
					temChapeu = true
					LoadAnimDict( "missheistdockssetup1hardhat@" )
					TaskPlayAnim(PlayerPed, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1000)
					SetPedPropIndex(PlayerPed, 0, 49, 0, true)
					Wait(1050)
					ClearPedTasks(PlayerPed)
				end
			end,false)

			RegisterCommand("capaceteuti", function()
				if temChapeu then
					temChapeu = false
					LoadAnimDict( "missheist_agency2ahelmet" )
					TaskPlayAnim(PlayerPed, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1500)
					ClearPedTasks(PlayerPed)
					ClearPedProp(PlayerPed, 0)
				else
					temChapeu = true
					LoadAnimDict( "missheistdockssetup1hardhat@" )
					TaskPlayAnim(PlayerPed, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1000)
					SetPedPropIndex(PlayerPed, 0, 75, 0, true)
					Wait(1050)
					ClearPedTasks(PlayerPed)
				end
			end,false)

			RegisterCommand("chapeu2", function()
				if temChapeu then
					temChapeu = false
					LoadAnimDict( "missheist_agency2ahelmet" )
					TaskPlayAnim(PlayerPed, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1500)
					ClearPedTasks(PlayerPed)
					ClearPedProp(PlayerPed, 0)
				else
					temChapeu = true
					LoadAnimDict( "missheistdockssetup1hardhat@" )
					TaskPlayAnim(PlayerPed, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1000)
					SetPedPropIndex(PlayerPed, 0, 8, 0, true)
					Wait(1050)
					ClearPedTasks(PlayerPed)
				end
			end,false)

			RegisterCommand("boina", function()
				if temChapeu then
					temChapeu = false
					LoadAnimDict( "missheist_agency2ahelmet" )
					TaskPlayAnim(PlayerPed, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1500)
					ClearPedTasks(PlayerPed)
					ClearPedProp(PlayerPed, 0)
				else
					temChapeu = true
					LoadAnimDict( "missheistdockssetup1hardhat@" )
					TaskPlayAnim(PlayerPed, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1000)
					SetPedPropIndex(PlayerPed, 0, 28, 0, true)
					Wait(1050)
					ClearPedTasks(PlayerPed)
				end
			end,false)

			--[[RegisterCommand("colete", function()
				if temColete then
					temColete = false
					AddArmourToPed(PlayerPed, 0)
					SetPedComponentVariation(PlayerPed, 9, 13, 0, 0)
				else
					temColete = true
					AddArmourToPed(PlayerPed, 100)
					SetPedComponentVariation(PlayerPed, 9, 7, 0, 0)
				end
			end,false)]]

			RegisterCommand("coleterf", function()
				if temColete then
					temColete = false
					AddArmourToPed(PlayerPed, 0)
					SetPedComponentVariation(PlayerPed, 9, 13, 0, 0)
				else
					temColete = true
					SetPedComponentVariation(PlayerPed, 9, 10, 0, 0)
					end
			end,false)

			RegisterCommand("recruta", function(source,args,rawCommand)
			exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
			})
			Citizen.Wait(5000)
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 38,  ['tshirt_2'] = 0,
						['torso_1'] = 38,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 0,
						['pants_1'] = 59,   ['pants_2'] = 0,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 5,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 1,  ['bproof_2'] = 0
								}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				else
					local clothesSkin = {
							['tshirt_1'] = 31,      ['tshirt_2'] = 0,
							['ears_1'] = -1,        ['ears_2'] = 0,
							['torso_1'] = 85,       ['torso_2'] = 1,
							['decals_1'] = 0,      ['decals_2']= 0,
							['mask_1'] = 0,         ['mask_2'] = 0,
							['arms'] = 31,
							['pants_1'] = 61,       ['pants_2'] = 0,
							['shoes_1'] = 24,        ['shoes_2'] = 0,
							['helmet_1']  = -1,     ['helmet_2'] = 0,
							['bags_1'] = 0,         ['bags_2'] = 0,
							['glasses_1'] = -1,      ['glasses_2'] = 0,
							['chain_1'] = 0,        ['chain_2'] = 0,
							['bproof_1'] = 16,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
			end)
			end, false)

			RegisterCommand("recruta2", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
					name = "vestir_farda",
					duration = 5000,
					label = "A vestir a farda",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "missmic4",
						anim = "michael_tux_fidget",
						flags = 49,
					}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
						local clothesSkin = {
							['tshirt_1'] = 38,  ['tshirt_2'] = 0,
							['torso_1'] = 38,   ['torso_2'] = 0,
							['decals_1'] = 0,   ['decals_2'] = 0,
							['arms'] = 0,
							['pants_1'] = 15,   ['pants_2'] = 3,
							['shoes_1'] = 57,   ['shoes_2'] = 4,
							['helmet_1'] = -1,  ['helmet_2'] = 0,
							['mask_1'] = 0,     ['mask_2'] = 0,
							['chain_1'] = 5,    ['chain_2'] = 0,
							['ears_1'] = -1,     ['ears_2'] = 0,
							['glasses_1'] = 0,  ['glasses_2'] = 0,
							['bproof_1'] = 0,  ['bproof_2'] = 0
									}
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					else
						local clothesSkin = {
								['tshirt_1'] = 31,      ['tshirt_2'] = 0,
								['ears_1'] = -1,        ['ears_2'] = 0,
								['torso_1'] = 85,       ['torso_2'] = 1,
								['decals_1'] = 0,      ['decals_2']= 0,
								['mask_1'] = 0,         ['mask_2'] = 0,
								['arms'] = 31,
								['pants_1'] = 61,       ['pants_2'] = 0,
								['shoes_1'] = 24,        ['shoes_2'] = 0,
								['helmet_1']  = -1,     ['helmet_2'] = 0,
								['bags_1'] = 0,         ['bags_2'] = 0,
								['glasses_1'] = -1,      ['glasses_2'] = 0,
								['chain_1'] = 0,        ['chain_2'] = 0,
								['bproof_1'] = 14,       ['bproof_2'] = 0
						}
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("agente", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 37,  ['tshirt_2'] = 0,
						['torso_1'] = 38,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 30,
						['pants_1'] = 59,   ['pants_2'] = 0,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 27,  ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					else
					local clothesSkin = {
							['tshirt_1'] = 31,      ['tshirt_2'] = 0,
							['ears_1'] = -1,        ['ears_2'] = 0,
							['torso_1'] = 85,       ['torso_2'] = 1,
							['decals_1'] = 0,      ['decals_2']= 0,
							['mask_1'] = 0,         ['mask_2'] = 0,
							['arms'] = 31,
							['pants_1'] = 61,       ['pants_2'] = 0,
							['shoes_1'] = 24,        ['shoes_2'] = 0,
							['helmet_1']  = -1,     ['helmet_2'] = 0,
							['bags_1'] = 0,         ['bags_2'] = 0,
							['glasses_1'] = -1,      ['glasses_2'] = 0,
							['chain_1'] = -1,        ['chain_2'] = 0,
							['bproof_1'] = 29,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("central", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
					name = "vestir_farda",
					duration = 5000,
					label = "A vestir a farda",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "missmic4",
						anim = "michael_tux_fidget",
						flags = 49,
					}
					})
					Citizen.Wait(5000)
					TriggerEvent('skinchanger:getSkin', function(skin)
						if skin.sex == 0 then
						local clothesSkin = {
							['tshirt_1'] = 37,  ['tshirt_2'] = 0,
							['torso_1'] = 38,   ['torso_2'] = 0,
							['decals_1'] = 0,   ['decals_2'] = 0,
							['arms'] = 30,
							['pants_1'] = 59,   ['pants_2'] = 0,
							['shoes_1'] = 24,   ['shoes_2'] = 0,
							['helmet_1'] = -1,  ['helmet_2'] = 0,
							['mask_1'] = 0,     ['mask_2'] = 0,
							['chain_1'] = 1,    ['chain_2'] = 0,
							['ears_1'] = -1,     ['ears_2'] = 0,
							['glasses_1'] = 0,  ['glasses_2'] = 0,
							['bproof_1'] = 27,  ['bproof_2'] = 0
						}
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
						else
						local clothesSkin = {
								['tshirt_1'] = 31,      ['tshirt_2'] = 0,
								['ears_1'] = -1,        ['ears_2'] = 0,
								['torso_1'] = 85,       ['torso_2'] = 1,
								['decals_1'] = 0,      ['decals_2']= 0,
								['mask_1'] = 0,         ['mask_2'] = 0,
								['arms'] = 31,
								['pants_1'] = 61,       ['pants_2'] = 0,
								['shoes_1'] = 24,        ['shoes_2'] = 0,
								['helmet_1']  = -1,     ['helmet_2'] = 0,
								['bags_1'] = 0,         ['bags_2'] = 0,
								['glasses_1'] = -1,      ['glasses_2'] = 0,
								['chain_1'] = -1,        ['chain_2'] = 0,
								['bproof_1'] = 29,       ['bproof_2'] = 1
						}
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
						end
					end)
				end, false)
	
			RegisterCommand("salgueiro", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 37,  ['tshirt_2'] = 0,
						['torso_1'] = 38,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 30,
						['pants_1'] = 59,   ['pants_2'] = 0,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 2,  ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					else
					local clothesSkin = {
							['tshirt_1'] = 31,      ['tshirt_2'] = 0,
							['ears_1'] = -1,        ['ears_2'] = 0,
							['torso_1'] = 85,       ['torso_2'] = 1,
							['decals_1'] = 0,      ['decals_2']= 0,
							['mask_1'] = 0,         ['mask_2'] = 0,
							['arms'] = 31,
							['pants_1'] = 61,       ['pants_2'] = 0,
							['shoes_1'] = 24,        ['shoes_2'] = 0,
							['helmet_1']  = -1,     ['helmet_2'] = 0,
							['bags_1'] = 0,         ['bags_2'] = 0,
							['glasses_1'] = -1,      ['glasses_2'] = 0,
							['chain_1'] = -1,        ['chain_2'] = 0,
							['bproof_1'] = 29,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("pereira", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 37,  ['tshirt_2'] = 0,
						['torso_1'] = 38,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 30,
						['pants_1'] = 59,   ['pants_2'] = 0,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 2,  ['bproof_2'] = 1
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					else
					local clothesSkin = {
							['tshirt_1'] = 31,      ['tshirt_2'] = 0,
							['ears_1'] = -1,        ['ears_2'] = 0,
							['torso_1'] = 85,       ['torso_2'] = 1,
							['decals_1'] = 0,      ['decals_2']= 0,
							['mask_1'] = 0,         ['mask_2'] = 0,
							['arms'] = 31,
							['pants_1'] = 61,       ['pants_2'] = 0,
							['shoes_1'] = 24,        ['shoes_2'] = 0,
							['helmet_1']  = -1,     ['helmet_2'] = 0,
							['bags_1'] = 0,         ['bags_2'] = 0,
							['glasses_1'] = -1,      ['glasses_2'] = 0,
							['chain_1'] = -1,        ['chain_2'] = 0,
							['bproof_1'] = 29,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("arthur", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 37,  ['tshirt_2'] = 0,
						['torso_1'] = 38,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 30,
						['pants_1'] = 59,   ['pants_2'] = 0,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 2,  ['bproof_2'] = 2
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					else
					local clothesSkin = {
							['tshirt_1'] = 31,      ['tshirt_2'] = 0,
							['ears_1'] = -1,        ['ears_2'] = 0,
							['torso_1'] = 85,       ['torso_2'] = 1,
							['decals_1'] = 0,      ['decals_2']= 0,
							['mask_1'] = 0,         ['mask_2'] = 0,
							['arms'] = 31,
							['pants_1'] = 61,       ['pants_2'] = 0,
							['shoes_1'] = 24,        ['shoes_2'] = 0,
							['helmet_1']  = -1,     ['helmet_2'] = 0,
							['bags_1'] = 0,         ['bags_2'] = 0,
							['glasses_1'] = -1,      ['glasses_2'] = 0,
							['chain_1'] = -1,        ['chain_2'] = 0,
							['bproof_1'] = 29,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("costa", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 37,  ['tshirt_2'] = 0,
						['torso_1'] = 38,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 30,
						['pants_1'] = 59,   ['pants_2'] = 0,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 2,  ['bproof_2'] = 3
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					else
					local clothesSkin = {
							['tshirt_1'] = 31,      ['tshirt_2'] = 0,
							['ears_1'] = -1,        ['ears_2'] = 0,
							['torso_1'] = 85,       ['torso_2'] = 1,
							['decals_1'] = 0,      ['decals_2']= 0,
							['mask_1'] = 0,         ['mask_2'] = 0,
							['arms'] = 31,
							['pants_1'] = 61,       ['pants_2'] = 0,
							['shoes_1'] = 24,        ['shoes_2'] = 0,
							['helmet_1']  = -1,     ['helmet_2'] = 0,
							['bags_1'] = 0,         ['bags_2'] = 0,
							['glasses_1'] = -1,      ['glasses_2'] = 0,
							['chain_1'] = -1,        ['chain_2'] = 0,
							['bproof_1'] = 29,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("agentemanga", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 37,  ['tshirt_2'] = 0,
						['torso_1'] = 98,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 28,
						['pants_1'] = 59,   ['pants_2'] = 0,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 27,  ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					else
					local clothesSkin = {
							['tshirt_1'] = 130,      ['tshirt_2'] = 0,
							['ears_1'] = -1,        ['ears_2'] = 0,
							['torso_1'] = 44,       ['torso_2'] = 0,
							['decals_1'] = 0,      ['decals_2']= 0,
							['mask_1'] = 0,         ['mask_2'] = 0,
							['arms'] = 31,
							['pants_1'] = 32,       ['pants_2'] = 0,
							['shoes_1'] = 24,        ['shoes_2'] = 0,
							['helmet_1']  = -1,     ['helmet_2'] = 0,
							['bags_1'] = 0,         ['bags_2'] = 0,
							['glasses_1'] = -1,      ['glasses_2'] = 0,
							['chain_1'] = 1,        ['chain_2'] = 0,
							['bproof_1'] = 0,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("agentemanga2", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 37,  ['tshirt_2'] = 0,
						['torso_1'] = 97,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 28,
						['pants_1'] = 59,   ['pants_2'] = 0,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 27,  ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					else
					local clothesSkin = {
							['tshirt_1'] = 130,      ['tshirt_2'] = 0,
							['ears_1'] = -1,        ['ears_2'] = 0,
							['torso_1'] = 44,       ['torso_2'] = 0,
							['decals_1'] = 0,      ['decals_2']= 0,
							['mask_1'] = 0,         ['mask_2'] = 0,
							['arms'] = 31,
							['pants_1'] = 32,       ['pants_2'] = 0,
							['shoes_1'] = 24,        ['shoes_2'] = 0,
							['helmet_1']  = -1,     ['helmet_2'] = 0,
							['bags_1'] = 0,         ['bags_2'] = 0,
							['glasses_1'] = -1,      ['glasses_2'] = 0,
							['chain_1'] = 1,        ['chain_2'] = 0,
							['bproof_1'] = 0,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("dplscasaco", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 71,  ['tshirt_2'] = 3,
						['torso_1'] = 261,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 20,
						['pants_1'] = 52,   ['pants_2'] = 1,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 3,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 0,  ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					else
					local clothesSkin = {
							['tshirt_1'] = 27,      ['tshirt_2'] = 0,
							['ears_1'] = -1,        ['ears_2'] = 0,
							['torso_1'] = 44,       ['torso_2'] = 0,
							['decals_1'] = 0,      ['decals_2']= 0,
							['mask_1'] = 0,         ['mask_2'] = 0,
							['arms'] = 31,
							['pants_1'] = 32,       ['pants_2'] = 0,
							['shoes_1'] = 24,        ['shoes_2'] = 0,
							['helmet_1']  = -1,     ['helmet_2'] = 0,
							['bags_1'] = 0,         ['bags_2'] = 0,
							['glasses_1'] = -1,      ['glasses_2'] = 0,
							['chain_1'] = 6,        ['chain_2'] = 0,
							['bproof_1'] = 0,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("dplsansio", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 13,  ['tshirt_2'] = 0,
						['torso_1'] = 261,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 6,
						['pants_1'] = 48,   ['pants_2'] = 3,
						['shoes_1'] = 63,   ['shoes_2'] = 4,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 10,    ['chain_2'] = 2,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 0,  ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					ESX.UI.Menu.CloseAll()
					--TriggerEvent("clothes:openmenucop")
					else
					local clothesSkin = {
							['tshirt_1'] = 14,      ['tshirt_2'] = 0,
							['ears_1'] = -1,        ['ears_2'] = 0,
							['torso_1'] = 26,       ['torso_2'] = 0,
							['decals_1'] = 0,      ['decals_2']= 0,
							['mask_1'] = 0,         ['mask_2'] = 0,
							['arms'] = 101,
							['pants_1'] = 3,       ['pants_2'] = 0,
							['shoes_1'] = 64,        ['shoes_2'] = 0,
							['helmet_1']  = -1,     ['helmet_2'] = 0,
							['bags_1'] = 0,         ['bags_2'] = 0,
							['glasses_1'] = -1,      ['glasses_2'] = 0,
							['chain_1'] = 14,        ['chain_2'] = 0,
							['bproof_1'] = 0,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("dplsansio", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 13,  ['tshirt_2'] = 0,
						['torso_1'] = 261,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 6,
						['pants_1'] = 48,   ['pants_2'] = 3,
						['shoes_1'] = 63,   ['shoes_2'] = 4,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 10,    ['chain_2'] = 2,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 0,  ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					ESX.UI.Menu.CloseAll()
					--TriggerEvent("clothes:openmenucop")
					else
					local clothesSkin = {
							['tshirt_1'] = 14,      ['tshirt_2'] = 0,
							['ears_1'] = -1,        ['ears_2'] = 0,
							['torso_1'] = 26,       ['torso_2'] = 0,
							['decals_1'] = 0,      ['decals_2']= 0,
							['mask_1'] = 0,         ['mask_2'] = 0,
							['arms'] = 101,
							['pants_1'] = 3,       ['pants_2'] = 0,
							['shoes_1'] = 64,        ['shoes_2'] = 0,
							['helmet_1']  = -1,     ['helmet_2'] = 0,
							['bags_1'] = 0,         ['bags_2'] = 0,
							['glasses_1'] = -1,      ['glasses_2'] = 0,
							['chain_1'] = 14,        ['chain_2'] = 0,
							['bproof_1'] = 0,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("dplschefe", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 37,  ['tshirt_2'] = 0,
						['torso_1'] = 97,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 28,
						['pants_1'] = 59,   ['pants_2'] = 0,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 15,  ['bproof_2'] = 2
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					ESX.UI.Menu.CloseAll()
					--TriggerEvent("clothes:openmenucop")
					else
					local clothesSkin = {
						['tshirt_1'] = 36,      ['tshirt_2'] = 0,
						['ears_1'] = -1,        ['ears_2'] = 0,
						['torso_1'] = 0,       ['torso_2'] = 0,
						['decals_1'] = 0,      ['decals_2']= 0,
						['mask_1'] = 0,         ['mask_2'] = 0,
						['arms'] = 76,
						['pants_1'] = 100,       ['pants_2'] = 2,
						['shoes_1'] = 36,        ['shoes_2'] = 0,
						['helmet_1']  = 60,     ['helmet_2'] = 1,
						['bags_1'] = 0,         ['bags_2'] = 0,
						['glasses_1'] = 27,      ['glasses_2'] = 0,
						['chain_1'] = 0,        ['chain_2'] = 0,
						['bproof_1'] = 0,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("dplschefe2", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 37,  ['tshirt_2'] = 0,
						['torso_1'] = 38,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 30,
						['pants_1'] = 59,   ['pants_2'] = 0,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 15,  ['bproof_2'] = 2
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					ESX.UI.Menu.CloseAll()
					--TriggerEvent("clothes:openmenucop")
					else
					local clothesSkin = {
						['tshirt_1'] = 36,      ['tshirt_2'] = 0,
						['ears_1'] = -1,        ['ears_2'] = 0,
						['torso_1'] = 0,       ['torso_2'] = 0,
						['decals_1'] = 0,      ['decals_2']= 0,
						['mask_1'] = 0,         ['mask_2'] = 0,
						['arms'] = 76,
						['pants_1'] = 100,       ['pants_2'] = 2,
						['shoes_1'] = 36,        ['shoes_2'] = 0,
						['helmet_1']  = 60,     ['helmet_2'] = 1,
						['bags_1'] = 0,         ['bags_2'] = 0,
						['glasses_1'] = 27,      ['glasses_2'] = 0,
						['chain_1'] = 0,        ['chain_2'] = 0,
						['bproof_1'] = 0,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("dplschefe3", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 37,  ['tshirt_2'] = 0,
						['torso_1'] = 38,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 30,
						['pants_1'] = 48,   ['pants_2'] = 0,
						['shoes_1'] = 25,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 15,  ['bproof_2'] = 2
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					ESX.UI.Menu.CloseAll()
					--TriggerEvent("clothes:openmenucop")
					else
					local clothesSkin = {
						['tshirt_1'] = 36,      ['tshirt_2'] = 0,
						['ears_1'] = -1,        ['ears_2'] = 0,
						['torso_1'] = 0,       ['torso_2'] = 0,
						['decals_1'] = 0,      ['decals_2']= 0,
						['mask_1'] = 0,         ['mask_2'] = 0,
						['arms'] = 76,
						['pants_1'] = 100,       ['pants_2'] = 2,
						['shoes_1'] = 36,        ['shoes_2'] = 0,
						['helmet_1']  = 60,     ['helmet_2'] = 1,
						['bags_1'] = 0,         ['bags_2'] = 0,
						['glasses_1'] = 27,      ['glasses_2'] = 0,
						['chain_1'] = 0,        ['chain_2'] = 0,
						['bproof_1'] = 0,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("dplshr", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 37,  ['tshirt_2'] = 0,
						['torso_1'] = 38,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 30,
						['pants_1'] = 52,   ['pants_2'] = 1,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 15,  ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					ESX.UI.Menu.CloseAll()
					--TriggerEvent("clothes:openmenucop")
					else
					local clothesSkin = {
						['tshirt_1'] = 36,      ['tshirt_2'] = 0,
						['ears_1'] = -1,        ['ears_2'] = 0,
						['torso_1'] = 0,       ['torso_2'] = 0,
						['decals_1'] = 0,      ['decals_2']= 0,
						['mask_1'] = 0,         ['mask_2'] = 0,
						['arms'] = 76,
						['pants_1'] = 100,       ['pants_2'] = 2,
						['shoes_1'] = 36,        ['shoes_2'] = 0,
						['helmet_1']  = 60,     ['helmet_2'] = 1,
						['bags_1'] = 0,         ['bags_2'] = 0,
						['glasses_1'] = 27,      ['glasses_2'] = 0,
						['chain_1'] = 0,        ['chain_2'] = 0,
						['bproof_1'] = 0,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("dplstp", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 5000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 137,  ['tshirt_2'] = 0,
						['torso_1'] = 97,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 31,
						['pants_1'] = 52,   ['pants_2'] = 1,
						['shoes_1'] = 24,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 15,  ['bproof_2'] = 1
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					ESX.UI.Menu.CloseAll()
					--TriggerEvent("clothes:openmenucop")
					else
					local clothesSkin = {
						['tshirt_1'] = 36,      ['tshirt_2'] = 0,
						['ears_1'] = -1,        ['ears_2'] = 0,
						['torso_1'] = 0,       ['torso_2'] = 0,
						['decals_1'] = 0,      ['decals_2']= 0,
						['mask_1'] = 0,         ['mask_2'] = 0,
						['arms'] = 76,
						['pants_1'] = 100,       ['pants_2'] = 2,
						['shoes_1'] = 36,        ['shoes_2'] = 0,
						['helmet_1']  = 60,     ['helmet_2'] = 1,
						['bags_1'] = 0,         ['bags_2'] = 0,
						['glasses_1'] = 27,      ['glasses_2'] = 0,
						['chain_1'] = 0,        ['chain_2'] = 0,
						['bproof_1'] = 0,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("dplsmota", function(source,args,rawCommand)
				exports['mythic_progbar']:Progress({
				name = "vestir_farda",
				duration = 4000,
				label = "A vestir a farda",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "missmic4",
					anim = "michael_tux_fidget",
					flags = 49,
				}
				})
				Citizen.Wait(5000)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 137,  ['tshirt_2'] = 0,
						['torso_1'] = 51,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 20,
						['pants_1'] = 32,   ['pants_2'] = 1,
						['shoes_1'] = 13,   ['shoes_2'] = 0,
						['helmet_1'] = -1,  ['helmet_2'] = 0,
						['mask_1'] = 0,     ['mask_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = -1,     ['ears_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['bproof_1'] = 0,  ['bproof_2'] = 4
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					ESX.UI.Menu.CloseAll()
					--TriggerEvent("clothes:openmenucop")
					else
					local clothesSkin = {
						['tshirt_1'] = 36,      ['tshirt_2'] = 0,
						['ears_1'] = -1,        ['ears_2'] = 0,
						['torso_1'] = 0,       ['torso_2'] = 0,
						['decals_1'] = 0,      ['decals_2']= 0,
						['mask_1'] = 0,         ['mask_2'] = 0,
						['arms'] = 76,
						['pants_1'] = 100,       ['pants_2'] = 2,
						['shoes_1'] = 36,        ['shoes_2'] = 0,
						['helmet_1']  = 60,     ['helmet_2'] = 1,
						['bags_1'] = 0,         ['bags_2'] = 0,
						['glasses_1'] = 27,      ['glasses_2'] = 0,
						['chain_1'] = 0,        ['chain_2'] = 0,
						['bproof_1'] = 0,       ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end, false)

			RegisterCommand("radar", function()
				if radar.shown then
					radar.shown = false
					radar.info = string.format("00AAA00A    000  KM/H")
					radar.info2 = string.format("00AAA00A    000  KM/H")
				else
					radar.shown = true
				end
			end,false)

			RegisterCommand("velocidade", function(source, args, raw)
				SpeedLimit = tonumber(round(args[1]))
				exports["mythic_notify"]:SendAlert("success", "Limite Alterado")
			end,false)

			function LocalPed()
				return GetPlayerPed(PlayerId())
			end

			function CreateSpikes(amount)
				local spawnCoords = GetOffsetFromEntityInWorldCoords(LocalPed(), 0.0, 2.0, 0.0)
				for a = 1, amount do
					local spike = CreateObject(GetHashKey(spikemodel), spawnCoords.x, spawnCoords.y, spawnCoords.z, true,true,true)

					local netid = NetworkGetNetworkIdFromEntity(spike)
					SetNetworkIdExistsOnAllMachines(netid, true)
					SetNetworkIdCanMigrate(netid, false)
					SetEntityHeading(spike, GetEntityHeading(LocalPed()))
					PlaceObjectOnGroundProperly(spike)
					spawnCoords = GetOffsetFromEntityInWorldCoords(spike, 0.0, 4.0, 0.0)
					table.insert(SpawnedSpikes, netid)
				end
				spikesSpawned = true
			end

			Citizen.CreateThread(function()
				TriggerEvent('chat:addSuggestion', '/chapeu', 'Colocar chapeu (Policia de Los Santos)')
				TriggerEvent('chat:addSuggestion', '/boina', 'Boina UEP (Policia de Los Santos)')
				TriggerEvent('chat:addSuggestion', '/colete', 'Colocar colete à prova de bala (Policia de Los Santos)')
				TriggerEvent('chat:addSuggestion', '/coleterf', 'Colocar colete retrorefletor (Policia de Los Santos)')
			end)

			function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)

				SetTextFont(font)

				SetTextProportional(0)

				SetTextScale(sc, sc)

				N_0x4e096588b13ffeca(jus)

				SetTextColour(r, g, b, a)

				SetTextDropShadow(0, 0, 0, 0,255)

				SetTextEntry("STRING")

				AddTextComponentString(text)

				DrawText(x - 0.1+w, y - 0.02+h)

			end

			function round( num )
				return tonumber( string.format( "%.0f", num ) )
			end


		elseif PlayerData.job.name == 'sheriff' then

			local radar = {

				shown = false,

				freeze = false,

				info = "00AAA00A    000  KM/H",

				info2 = "00AAA00A    000  KM/H",

				minSpeed = 5.0,

				maxSpeed = 75.0,

			}

			function OpenPoliceActionsMenu()
				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions',
				{
					title    = 'Policia de Blaine County',
					align    = 'bottom-right',
					elements = {
						{label = _U('citizen_interaction'),	value = 'citizen_interaction'},
						{label = _U('vehicle_interaction'),	value = 'vehicle_interaction'},
						{label = "Fita de pregos",      value = 'pregos_script'}
					}
				}, function(data, menu)

					if data.current.value == 'citizen_interaction' then
						local elements = {
							{label = 'Arrastar',			value = 'drag'},
							{label = 'Colocar no Veículo',			value = 'putVeh'},
							{label = 'Tirar do Veículo',			value = 'takeVeh'},
							{label = '-------------------------------------------------------------------------',			value = '7'},
							{label = 'Cartão de Cidadão',			value = 'identity_card'},
							{label = '-------------------------------------------------------------------------',			value = '1'},
							{label = 'MULTAS',			value = '2'},
							{label = '-------------------------------------------------------------------------',			value = '3'},
							{label = _U('fine'),			value = 'fine'},
							{label = 'Multa personalizada',			value = 'fine2'},
							{label = 'Multa não pagas',			value = 'fine3'},
							{label = '-------------------------------------------------------------------------',			value = '4'},
							{label = 'LICENÇAS',			value = 'licences'},
							{label = '-------------------------------------------------------------------------',			value = '6'},
						}

						ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'citizen_interaction',
						{
							title    = _U('citizen_interaction'),
							align    = 'bottom-right',
							elements = elements
						}, function(data2, menu2)
							local player, distance = ESX.Game.GetClosestPlayer()
							if distance ~= -1 and distance <= 3.0 then
								local action = data2.current.value

								if data2.current.value == 'licences' then
									local elements3 = {
										{label = 'Atribuir porte de arma',			value = 'license_weapon_add'},
										{label = 'Atribuir Licença de Caça',			value = 'license_weapon_add_2'},
										{label = 'Atribuir Carta de Motociclos',            value = 'license_moto_add'},
										{label = 'Atribuir Carta de Pesados',            value = 'license_camion_add'},
										{label = 'Atribuir Carta de Ligeiros',            value = 'license_voiture_add'},
										{label = 'Atribuir Código de Condução',            value = 'license_code_add'},
										{label = 'Retirar Porte de Arma',            value = 'license_weapon_remove'},
										{label = 'Retirar Carta de Motociclos',            value = 'license_moto_remove'},
										{label = 'Retirar Carta de Pesados',            value = 'license_camion_remove'},
										{label = 'Retirar Carta de Ligeiros',            value = 'license_voiture_remove'},
										{label = 'Retirar Código de Condução',            value = 'license_code_remove'}
									}
									ESX.UI.Menu.Open(
										'default', GetCurrentResourceName(), 'licences',
										{
											title    = "Licenças",
											align    = 'bottom-right',
											elements = elements3
										}, function(data3, menu3)
											if data3.current.value == 'license_weapon_add' then
												if PlayerData.job.grade > 3 then
													TriggerServerEvent('tqrp_policejob:addLicense', GetPlayerServerId(player), 'weapon')
												else
													exports["mythic_notify"]:SendAlert("error", "Pede a um superior para fazer isso.")
												end
											end
			
											if data3.current.value == 'license_weapon_add_2' then
												if PlayerData.job.grade > 3 then
													TriggerServerEvent('tqrp_policejob:addLicense', GetPlayerServerId(player), 'hunt')
												else
													exports["mythic_notify"]:SendAlert("error", "Pede a um superior para fazer isso.")
												end
											end
			
											if data3.current.value == 'license_moto_add' then
												TriggerServerEvent('tqrp_policejob:addLicense', GetPlayerServerId(player), 'drive_bike')
											end
			
											if data3.current.value == 'license_camion_add' then
												TriggerServerEvent('tqrp_policejob:addLicense', GetPlayerServerId(player), 'drive_truck')
											end
			
											if data3.current.value == 'license_voiture_add' then
												TriggerServerEvent('tqrp_policejob:addLicense', GetPlayerServerId(player), 'drive')
											end
			
											if data3.current.value == 'license_code_add' then
												TriggerServerEvent('tqrp_policejob:addLicense', GetPlayerServerId(player), 'dmv')
											end
			
											if data3.current.value == 'license_weapon_remove' then
												TriggerServerEvent('tqrp_policejob:deletelicense', GetPlayerServerId(player), 'weapon')
											end
			
											if data3.current.value == 'license_moto_remove' then
												TriggerServerEvent('tqrp_policejob:deletelicense', GetPlayerServerId(player), 'drive_bike')
											end
			
											if data3.current.value == 'license_camion_remove' then
												TriggerServerEvent('tqrp_policejob:deletelicense', GetPlayerServerId(player), 'drive_truck')
											end
			
											if data3.current.value == 'license_voiture_remove' then
												TriggerServerEvent('tqrp_policejob:deletelicense', GetPlayerServerId(player), 'drive')
											end
			
											if data3.current.value == 'license_code_remove' then
												TriggerServerEvent('tqrp_policejob:deletelicense', GetPlayerServerId(player), 'dmv')
											end
									end, function(data3, menu3)
										menu3.close()
									end)
								end

								if data2.current.value == 'identity_card' then
									OpenIdentityCardMenu(player)
								end

								if data2.current.value == 'body_search' then
									OpenBodySearchMenu(player)
								end

								if data2.current.value == 'fine' then
									OpenFineMenu(player)
								end

								if data2.current.value == 'fine2' then
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing',
									{
										title = 'Valor fatura'
									},
									function(data, menu)
										local amount = tonumber(data.value)
										if amount == nil then
											TriggerEvent('esx:notifyPl','Valor inválido')
										else
											menu.close()
											local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
											if closestPlayer == -1 or closestDistance > 3.0 then
												TriggerEvent('esx:notifyPl','Não há jogadores próximos')
											else
												TriggerServerEvent('tqrp_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Multa Policia de Los Santos', amount)
											end
										end
									end,
									function(data, menu)
										menu.close()
									end)
								end
								if data2.current.value == 'fine3' then
									OpenUnpaidBillsMenu(player)
								end
								
								if data2.current.value == 'drag' then
									TriggerServerEvent('tqrp_policejob:drag', GetPlayerServerId(player))
								end

								if data2.current.value == 'putVeh' then
									TriggerServerEvent("tqrp_policejob:putInVehicle", GetPlayerServerId(player))
								end

								if data2.current.value == 'takeVeh' then
									TriggerServerEvent("tqrp_policejob:OutVehicle", GetPlayerServerId(player))
								end
								--  GetPlayerServerId(closestPlayer)
							else
								TriggerEvent('esx:notifyPl', "Não há pessoas próximas de ti")
							end
						end, function(data2, menu2)
							menu2.close()
						end)


					elseif data.current.value == 'vehicle_interaction' then
						local elements  = {}
						local vehicle   = ESX.Game.GetVehicleInDirection()

						if DoesEntityExist(vehicle) then
							table.insert(elements, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
							table.insert(elements, {label = _U('impound'),		value = 'impound'})
						end

						ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'vehicle_interaction',
						{
							title    = _U('vehicle_interaction'),
							align    = 'bottom-right',
							elements = elements
						}, function(data2, menu2)
							vehicle = ESX.Game.GetVehicleInDirection()
							action  = data2.current.value
							if DoesEntityExist(vehicle) then
								local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
								if action == 'hijack_vehicle' then
									if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
										--TaskStartScenarioInPlace(PlayerPed, "WORLD_HUMAN_WELDING", 0, true)
										TaskStartScenarioInPlace(PlayerPed, "PROP_HUMAN_BUM_BIN", 0, true)
										Citizen.Wait(20000)
										ClearPedTasksImmediately(PlayerPed)

										SetVehicleDoorsLocked(vehicle, 1)
										SetVehicleDoorsLockedForAllPlayers(vehicle, false)
										ESX.ShowNotification(_U('vehicle_unlocked'))
									end
								elseif action == 'impound' then

									-- is the script busy?
									if CurrentTask.Busy then
										return
									end
									TaskStartScenarioInPlace(PlayerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

									CurrentTask.Busy = true
									CurrentTask.Task = ESX.SetTimeout(10000, function()
										ClearPedTasks(PlayerPed)
										ImpoundVehicle(vehicle)
										Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
									end)

									-- keep track of that vehicle!
									Citizen.CreateThread(function()
										while CurrentTask.Busy do
											Citizen.Wait(1500)

											vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
											if not DoesEntityExist(vehicle) and CurrentTask.Busy then
												ESX.ShowNotification(_U('impound_canceled_moved'))
												ESX.ClearTimeout(CurrentTask.Task)
												ClearPedTasks(PlayerPed)
												CurrentTask.Busy = false
												break
											end
										end
									end)
								end
							else
								ESX.ShowNotification(_U('no_vehicles_nearby'))
							end

						end, function(data2, menu2)
							menu2.close()
						end)

					elseif data.current.value == 'pregos_script' then

						ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'pregos_script',
						{
							title    = "Fita de pregos",
							align    = 'bottom-right',
							elements = {
							{label = "Colocar 1",         value = 'colocar_pregos1'},
							{label = "Colocar 2",         value = 'colocar_pregos2'},
							{label = "Colocar 3",         value = 'colocar_pregos3'},
							{label = "Remover",           value = 'remover_pregos'}

							},
						},
						function(data2, menu2)

						if data2.current.value == 'colocar_pregos1' then
							CreateSpikes(1)
						end

						if data2.current.value == 'colocar_pregos2' then
							CreateSpikes(2)
						end

						if data2.current.value == 'colocar_pregos3' then
							CreateSpikes(3)
						end

						if data2.current.value == 'remover_pregos' then
							RemoveSpikes()
							spikesSpawned = false
						end

						end,
						function(data2, menu2)
							menu2.close()
						end)
					end
				end,
				function(data, menu)
				  menu.close()
				end)
			end

			function OpenIdentityCardMenu(player)

				ESX.TriggerServerCallback('tqrp_policejob:getOtherPlayerData', function(data)

					local elements    = {}
					local nameLabel   = _U('name', data.name)
					local dobLabel    = nil
					local heightLabel = nil
					local idLabel     = nil

					if true then

						nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)

						if data.dob ~= nil then
							dobLabel = _U('dob', data.dob)
						else
							dobLabel = _U('dob', _U('unknown'))
						end

						if data.height ~= nil then
							heightLabel = _U('height', data.height)
						else
							heightLabel = _U('height', _U('unknown'))
						end

						if data.name ~= nil then
							idLabel = _U('id', data.name)
						else
							idLabel = _U('id', _U('unknown'))
						end

					end

					local elements = {
						{label = nameLabel, value = nil},
						{label = jobLabel,  value = nil},
					}

					if true then
						table.insert(elements, {label = dobLabel, value = nil})
						table.insert(elements, {label = heightLabel, value = nil})
						table.insert(elements, {label = idLabel, value = nil})
					end

					if data.drunk ~= nil then
						table.insert(elements, {label = _U('bac', data.drunk), value = nil})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
					{
						title    = _U('citizen_interaction'),
						align    = 'bottom-right',
						elements = elements,
					}, function(data, menu)

					end, function(data, menu)
						menu.close()
					end)

				end, GetPlayerServerId(player))

			end

			function OpenFineMenu(player)

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine',
				{
					title    = _U('fine'),
					align    = 'bottom-right',
					elements = {
						{label = "AUTOS DE TRANSITO", value = 0},
						{label = "CRIMES BÁSICOS",   value = 1},
						{label = "ASSALTOS", value = 2},
						{label = "CRIMES ADICIONAIS",   value = 3},
						{label = "CRIMES LEVES",   value = 4},
						{label = "CRIMES MÉDIOS",   value = 5},
						{label = "CRIMES GRAVES",   value = 6},
						{label = "PORTE ILEGAL DE ARMAS",   value = 7}
					}
				}, function(data, menu)
					OpenFineCategoryMenu(player, data.current.value)
				end, function(data, menu)
					menu.close()
				end)

			end

			function OpenFineCategoryMenu(player, category)

				ESX.TriggerServerCallback('tqrp_policejob:getFineList', function(fines)

					local elements = {}

					for i=1, #fines, 1 do
						table.insert(elements, {
							label     = fines[i].label .. ' <span style="color: green;">€' .. fines[i].amount .. '</span>',
							value     = fines[i].id,
							amount    = fines[i].amount,
							fineLabel = fines[i].label
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category',
					{
						title    = _U('fine'),
						align    = 'bottom-right',
						elements = elements,
					}, function(data, menu)

						local label  = data.current.fineLabel
						local amount = data.current.amount

						menu.close()
						TriggerServerEvent('tqrp_billing:sendBill', GetPlayerServerId(player), 'society_police', _U('fine_total', label), amount)

						ESX.SetTimeout(300, function()
							OpenFineCategoryMenu(player, category)
						end)

					end, function(data, menu)
						menu.close()
					end)

				end, category)

			end

			function OpenUnpaidBillsMenu(player)
				local elements = {}

				ESX.TriggerServerCallback('tqrp_billing:getTargetBills', function(bills)
					for i=1, #bills, 1 do
						table.insert(elements, {
							label = bills[i].label .. " | " .. bills[i].day .. "/" .. bills[i].month ..' - <span style="color: red;">€' .. bills[i].amount .. '</span>',
							value = bills[i].id
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
					{
						title    = 'Divída fiscal',
						align    = 'bottom-right',
						elements = elements
					}, function(data, menu)

					end, function(data, menu)
						menu.close()
					end)
				end, GetPlayerServerId(player))
			end

			function RemoveSpikes()
				for a = 1, #SpawnedSpikes do
					TriggerServerEvent("Spikes:TriggerDeleteSpikes", SpawnedSpikes[a])
				end
				SpawnedSpikes = {}
			end

			RegisterNetEvent("Spikes:DeleteSpikes")
			AddEventHandler("Spikes:DeleteSpikes", function(netid)
				Citizen.CreateThread(function()
					local spike = NetworkGetEntityFromNetworkId(netid)
					DeleteEntity(spike)
				end)
			end)

			RegisterNetEvent("Spikes:SpawnSpikes")
			AddEventHandler("Spikes:SpawnSpikes", function(config)
				CreateSpikes(config.amount)
			end)

			AddEventHandler('tqrp_policejob:hasEnteredMarker', function(part, partNum)

				if part == 'BossActions' then

					CurrentAction     = 'menu_boss_actions'
					CurrentActionData = {}

				end

			end)

			AddEventHandler('tqrp_policejob:hasEnteredEntityZone', function(entity)

				if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

					if IsPedInAnyVehicle(PlayerPed, false) then
						local vehicle = GetVehiclePedIsIn(PlayerPed)

						for i=0, 7, 1 do
							SetVehicleTyreBurst(vehicle, i, true, 1000)
						end
					end
				end
			end)

			AddEventHandler('tqrp_policejob:hasExitedEntityZone', function(entity)

				if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

					if IsPedInAnyVehicle(PlayerPed,  false) then

						local vehicle = GetVehiclePedIsIn(PlayerPed)

						for i=0, 7, 1 do
							SetVehicleTyreBurst(vehicle,  i,  true,  1000)
						end

					end

			  	end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == 'sheriff' and PlayerData.job.grade_name == 'boss' do
					Citizen.Wait(7)
					letSleep = true
					if GetDistanceBetweenCoords(coords, Config.Jobs[PlayerData.job.name].Zones.BossActions.x, Config.Jobs[PlayerData.job.name].Zones.BossActions.y, Config.Jobs[PlayerData.job.name].Zones.BossActions.z, true) < 15 then
						DrawMarker(27, Config.Jobs[PlayerData.job.name].Zones.BossActions.x, Config.Jobs[PlayerData.job.name].Zones.BossActions.y, Config.Jobs[PlayerData.job.name].Zones.BossActions.z - 1, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
						if GetDistanceBetweenCoords(coords, Config.Jobs[PlayerData.job.name].Zones.BossActions.x, Config.Jobs[PlayerData.job.name].Zones.BossActions.y, Config.Jobs[PlayerData.job.name].Zones.BossActions.z, true) < Config.DrawDistance then
							DrawText3Ds(Config.Jobs[PlayerData.job.name].Zones.BossActions.x, Config.Jobs[PlayerData.job.name].Zones.BossActions.y, Config.Jobs[PlayerData.job.name].Zones.BossActions.z, "[~g~E~w~] Policia de Blaine County")
							CurrentAction = 'menu_boss_actions'
						else
							CurrentAction = nil
						end
					else
						Citizen.Wait(1500)
					end
				end
			end)

			Citizen.CreateThread(function()
				while PlayerData.job.name == 'sheriff' do
					Citizen.Wait(7)
					if CurrentAction ~= nil then
						if IsControlJustReleased(0, 38) then

							if CurrentAction == 'menu_boss_actions' then
								ESX.UI.Menu.CloseAll()
								TriggerEvent('tqrp_society:openBossMenu', 'sheriff', function(data, menu)
									menu.close()
									CurrentAction     = 'menu_boss_actions'
									CurrentActionMsg  = _U('open_bossmenu')
									CurrentActionData = {}
								end, { wash = false })
							end
							CurrentAction = nil
						end
					end

					if radar.shown and inVeh then
						waitRadar = 7
						if radar.freeze == false then

							local veh = GetVehiclePedIsIn(PlayerPed, false)
							local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
							local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
							local frontcar = StartShapeTestCapsule(coordA, coordB, 6.0, 10, veh, 7)

							local a, b, c, d, e = GetShapeTestResult(frontcar)


							if IsEntityAVehicle(e) then
								local fvspeed = GetEntitySpeed(e)*3.6
								local fplate = GetVehicleNumberPlateText(e)
								radar.info = string.format("%s   %s KM/H", fplate, round(fvspeed, 0))
							end


							local bcoordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, -105.0, 0.0)
							local rearcar = StartShapeTestCapsule(coordA, bcoordB, 3.0, 10, veh, 7)
							local f, g, h, i, j = GetShapeTestResult(rearcar)


							if IsEntityAVehicle(j) then
								local bvspeed = GetEntitySpeed(j)*3.6
								local bplate = GetVehicleNumberPlateText(j)
								radar.info2 = string.format("%s   %s KM/H", bplate, round(bvspeed, 0))

								if bvspeed > SpeedLimit then
									PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
									radar.freeze = true
								end
							end
						end
						--DrawRect(0.262, 0.86, 0.182, 0.0565, 0, 0, 0, 150)

						if radar.freeze == false then
							DrawAdvancedText(0.140, 0.80, 0.17, 0.05, 0.3, "FRONTAL", 106, 153, 74, 255, 4, 0)
							DrawAdvancedText(0.215, 0.80, 0.19, 0.05, 0.3, "TRASEIRA", 106, 153, 74, 255, 4, 0)
						else
							DrawAdvancedText(0.140, 0.80, 0.17, 0.05, 0.3, "FRONTAL", 245, 66, 66, 255, 4, 0)
							DrawAdvancedText(0.215, 0.80, 0.19, 0.05, 0.3, "TRASEIRA", 245, 66, 66, 255, 4, 0)
						end

						DrawAdvancedText(0.140, 0.776, 0.17, 0.05, 0.45, radar.info, 255, 255, 255, 255, 4, 0)
						DrawAdvancedText(0.215, 0.776, 0.19, 0.05, 0.45, radar.info2, 255, 255, 255, 255, 4, 0)


						if IsControlJustPressed(1, 311) and IsPedInAnyPoliceVehicle(PlayerPed) then
							if radar.freeze then
								radar.freeze = false
								radar.info = string.format("00AAA00A    000  KM/H")
								radar.info2 = string.format("00AAA00A    000  KM/H")
								exports["mythic_notify"]:SendAlert("success", "Radar Debloqueado")

							else
								radar.freeze = true
								exports["mythic_notify"]:SendAlert("error", "Radar Bloqueado")
							end
						end

					end

					if IsControlJustReleased(0, 289) and not isDead and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
						OpenPoliceActionsMenu()
					end

					if IsDisabledControlJustPressed(1, 161) and GetLastInputMethod(0) then
						TriggerEvent('tqrp_outlaw:openMenu')
					end

					if IsControlJustReleased(0, 38) and CurrentTask.Busy then
						ESX.ShowNotification(_U('impound_canceled'))
						ESX.ClearTimeout(CurrentTask.Task)
						ClearPedTasks(PlayerPed)
						CurrentTask.Busy = false
					end
				end
			end)

			function ImpoundVehicle(vehicle)
				--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
				ESX.Game.DeleteVehicle(vehicle)
				ESX.ShowNotification(_U('impound_successful'))
				CurrentTask.Busy = false
			end

			RegisterCommand("chapeu", function()
				if temChapeu then
					temChapeu = false
					LoadAnimDict( "missheist_agency2ahelmet" )
					TaskPlayAnim(PlayerPed, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1500)
					ClearPedTasks(PlayerPed)
					ClearPedProp(PlayerPed, 0)
				else
					temChapeu = true
					LoadAnimDict( "missheistdockssetup1hardhat@" )
					TaskPlayAnim(PlayerPed, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1000)
					SetPedPropIndex(PlayerPed, 0, 13, 2, true)
					Wait(1050)
					ClearPedTasks(PlayerPed)
				end
			end, false)

			RegisterCommand("chapeu2", function()

				if temChapeu then
					temChapeu = false
					LoadAnimDict( "missheist_agency2ahelmet" )
					TaskPlayAnim(PlayerPed, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1500)
					ClearPedTasks(PlayerPed)
					ClearPedProp(PlayerPed, 0)
				else
					temChapeu = true
					LoadAnimDict( "missheistdockssetup1hardhat@" )
					TaskPlayAnim(PlayerPed, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1000)
					SetPedPropIndex(PlayerPed, 0, 14, 1, true)
					Wait(1050)
					ClearPedTasks(PlayerPed)
				end
			end,false)

			RegisterCommand("coleterf", function()
				if temColete then
					temColete = false
					AddArmourToPed(PlayerPed, 0)
					SetPedComponentVariation(PlayerPed, 9, 13, 0, 0)
				else
					temColete = true
					SetPedComponentVariation(PlayerPed, 9, 10, 0, 0)
					end
			end,false)

			RegisterCommand("radar", function()
				if radar.shown then
					radar.shown = false
					radar.info = string.format("00AAA00A    000  KM/H")
					radar.info2 = string.format("00AAA00A    000  KM/H")
				else
					radar.shown = true
				end
			end,false)

			RegisterCommand("velocidade", function(source, args, raw)
				SpeedLimit = tonumber(round(args[1]))
				exports["mythic_notify"]:SendAlert("success", "Limite Alterado")
			end,false)

			function LocalPed()
				return GetPlayerPed(PlayerId())
			end

			function CreateSpikes(amount)
				local spawnCoords = GetOffsetFromEntityInWorldCoords(LocalPed(), 0.0, 2.0, 0.0)
				for a = 1, amount do
					local spike = CreateObject(GetHashKey(spikemodel), spawnCoords.x, spawnCoords.y, spawnCoords.z, true,true,true)

					local netid = NetworkGetNetworkIdFromEntity(spike)
					SetNetworkIdExistsOnAllMachines(netid, true)
					SetNetworkIdCanMigrate(netid, false)
					SetEntityHeading(spike, GetEntityHeading(LocalPed()))
					PlaceObjectOnGroundProperly(spike)
					spawnCoords = GetOffsetFromEntityInWorldCoords(spike, 0.0, 4.0, 0.0)
					table.insert(SpawnedSpikes, netid)
				end
				spikesSpawned = true
			end

			Citizen.CreateThread(function()
				TriggerEvent('chat:addSuggestion', '/chapeu', 'Colocar chapeu (Policia de Blaine County)')
				TriggerEvent('chat:addSuggestion', '/coleterf', 'Colocar colete retrorefletor (Policia de Blaine County)')
			end)

			function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
				SetTextFont(font)
				SetTextProportional(0)
				SetTextScale(sc, sc)
				N_0x4e096588b13ffeca(jus)
				SetTextColour(r, g, b, a)
				SetTextDropShadow(0, 0, 0, 0,255)
				SetTextEntry("STRING")
				AddTextComponentString(text)
				DrawText(x - 0.1+w, y - 0.02+h)
			end

			function round( num )
				return tonumber( string.format( "%.0f", num ) )
			end

		end
	end
end

function cleanPlayer(PlayerPed)
	ClearPedBloodDamage(PlayerPed)
	ResetPedVisibleDamage(PlayerPed)
	ClearPedLastWeaponDamage(PlayerPed)
	ResetPedMovementClipset(PlayerPed, 0)
end

local GetPlayers = function()
	local players = {}

	for i = 0, 31 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, i)
		end
	end

	return players
end

function LoadAnim (dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)

		Citizen.Wait(1)
	end
end

function LoadModel (model)
	while not HasModelLoaded(model) do
		RequestModel(model)

		Citizen.Wait(1)
	end
end

Sit = function(wheelchairObject)
	local closestPlayer, closestPlayerDist = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 3) then
			return
		end
	end

	LoadAnim("missfinale_c2leadinoutfin_c_int")

	AttachEntityToEntity(PlayerPed, wheelchairObject, 0, 0, 0.0, 0.4, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)

	local heading = GetEntityHeading(wheelchairObject)

	while IsEntityAttachedToEntity(PlayerPed, wheelchairObject) do
		Citizen.Wait(5)

		if IsPedDeadOrDying(PlayerPed) then
			DetachEntity(PlayerPed, true, true)
		end

		if not IsEntityPlayingAnim(PlayerPed, 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 3) then
			TaskPlayAnim(PlayerPed, 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 8.0, 8.0, -1, 69, 1, false, false, false)
		end

		if IsControlPressed(0, 32) then
			local x, y, z  = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * -0.02)
			SetEntityCoords(wheelchairObject, x,y,z)
			PlaceObjectOnGroundProperly(wheelchairObject)
		end

		if IsControlPressed(1,  34) then
			heading = heading + 0.4

			if heading > 360 then
				heading = 0
			end

			SetEntityHeading(wheelchairObject,  heading)
		end

		if IsControlPressed(1,  9) then
			heading = heading - 0.4

			if heading < 0 then
				heading = 360
			end

			SetEntityHeading(wheelchairObject,  heading)
		end

		if IsControlJustPressed(0, 73) then
			DetachEntity(PlayerPed, true, true)

			local x, y, z = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * - 0.7)

			SetEntityCoords(PlayerPed, x,y,z)
		end
	end
end

PickUp = function(wheelchairObject)
	local closestPlayer, closestPlayerDist = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@box_carry@', 'idle', 3) then
			return
		end
	end

	NetworkRequestControlOfEntity(wheelchairObject)

	LoadAnim("anim@heists@box_carry@")

	AttachEntityToEntity(wheelchairObject, PlayerPed, GetPedBoneIndex(PlayerPed,  28422), -0.00, -0.3, -0.73, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

	while IsEntityAttachedToEntity(wheelchairObject, PlayerPed) do
		Citizen.Wait(10)

		if not IsEntityPlayingAnim(PlayerPed, 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(PlayerPed, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if IsPedDeadOrDying(PlayerPed) then
			DetachEntity(wheelchairObject, true, true)
		end

		if IsControlJustPressed(0, 73) then
			DetachEntity(wheelchairObject, true, true)
		end
	end
end

RegisterCommand("escudo", function()
	if PlayerData.job.name == 'police' then
		if shieldActive then
			DisableShield()
		else
			EnableShield()
		end
	end
end, false)

function EnableShield()
    shieldActive = true
    local ped = GetPlayerPed(-1)
    local pedPos = GetEntityCoords(ped, false)
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end

    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

    RequestModel(GetHashKey(prop))
    while not HasModelLoaded(GetHashKey(prop)) do
        Citizen.Wait(100)
    end

    local shield = CreateObject(GetHashKey(prop), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
    shieldEntity = shield
    AttachEntityToEntity(shieldEntity, ped, GetEntityBoneIndexByName(ped, "IK_L_Hand"), 0.0, -0.05, -0.10, -30.0, 180.0, 40.0, 0, 0, 1, 0, 0, 1)
    SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))

    if GetSelectedPedWeapon(ped) == pistol then
        SetCurrentPedWeapon(ped, pistol, 1)
        hadPistol = true
    else
        GiveWeaponToPed(ped, pistol, 300, 0, 1)
        SetCurrentPedWeapon(ped, pistol, 1)
        hadPistol = false
    end
    --SetEnableHandcuffs(ped, true)
end

function DisableShield()
    local ped = GetPlayerPed(-1)
    DeleteEntity(shieldEntity)
    ClearPedTasksImmediately(ped)
    SetWeaponAnimationOverride(ped, GetHashKey("Default"))

    if not hadPistol then
        RemoveWeaponFromPed(ped, pistol)
    end
    --SetEnableHandcuffs(ped, false)
    hadPistol = false
    shieldActive = false
end

Citizen.CreateThread(function()
    while true do
		if shieldActive then
            local ped = GetPlayerPed(-1)
            if not IsEntityPlayingAnim(ped, animDict, animName, 1) then
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    Citizen.Wait(100)
                end
            
                TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
            end
		else
			Citizen.Wait(4000)
		end
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('tqrp_policejob:drag')
AddEventHandler('tqrp_policejob:drag', function(copId)
	if IsHandcuffed then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

Citizen.CreateThread(function()
	local wasDragged

	while true do
		Citizen.Wait(1000)
		local playerPed = PlayerPedId()

		if IsHandcuffed and dragStatus.isDragged then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Citizen.Wait(1000)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)

				if IsPedInAnyVehicle(targetPed, true) then
					local veh = GetVehiclePedIsIn(targetPed, false)
					local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(veh)

					for i=maxSeats - 1, 0, -1 do
						if IsVehicleSeatFree(veh, i) then
							freeSeat = i
							break
						end
					end
					TaskWarpPedIntoVehicle(playerPed, veh, freeSeat)
				end
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		else
			Citizen.Wait(2000)
		end
	end
end)


-------------------------------
------ TESTE ------------------
-------------------------------


function GetDistanceBetweenEntities(entity1, entity2)
	local ent1Coords = GetEntityCoords(entity1)
	local ent2Coords = GetEntityCoords(entity1)
	return #(ent1Coords - ent2Coords)
end

function GetDistanceToGround(entity)
	local entCoords = GetEntityCoords(entity)
	local x, groundZ = GetGroundZFor_3dCoord(entCoords.x, entCoords.y, entCoords.z, 0)
	return #(entCoords - vector3(entCoords.x, entCoords.y, groundZ))
end

function GetClosentVehicleFromPedPos(ped, maxDistance, maxHeight, vehicleInside)
	local veh = nil
	local smallestDistance = maxDistance
	local vehs = {}	 	table.setn(vehs, 1024)
	local count = GetAllVehicles(vehs)

	if vehs ~= nil then
		for i = 0, #count do
			if DoesEntityExist(vehs[i]) and (vehicleInside or IsPedInAnyVehicle(ped, vehs[i], false) == false) then
				local dist = GetDistanceBetweenEntities(ped, vehs[i])
				local height = GetDistanceToGround(vehs[i])
				if distance <= smallestDistance and height <= maxHeight and height >= 0 and IsVehicleDriveable(vehs[i], true) then
                    smallestDistance = dist
                    veh = vehs[i]
				end
			end
		end
	end
	return veh
end

-------------------------------
------ TESTE ------------------
-------------------------------





RegisterNetEvent('tqrp_policejob:putInVehicle')
AddEventHandler('tqrp_policejob:putInVehicle', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				if freeSeat then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
					dragStatus.isDragged = false
				end
			end
		end
	end
end)

RegisterNetEvent('tqrp_policejob:OutVehicle')
AddEventHandler('tqrp_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)

local prCar = nil

RegisterCommand('carroPR', function()
	if PlayerData.job.name == 'pr' and #(vector3(-1329.97, -565.25, 20.8) - coords) < 15 then
		local vehHash = `sspres`
		local veh = GetVehiclePedIsIn(PlayerPed, false)
		if prCar ~= nil then
			DeleteVehicle(prCar)
			prCar = nil
		else
			LoadModel(vehHash)
			prCar = CreateVehicle(vehHash, coords.x, coords.y, coords.z, GetEntityHeading(PlayerPed), 1, 0)
			SetVehicleNumberPlateText(prCar, "PR")
			SetVehicleExtra(prCar, 10, true)
			SetVehicleExtra(prCar, 11, false)
			SetVehicleExtra(prCar, 12, true)
			SetPedIntoVehicle(PlayerPed, prCar, -1)
			TriggerEvent('onyx:updatePlates', "PR")
		end
	end
end)