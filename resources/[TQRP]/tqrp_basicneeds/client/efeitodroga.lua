
RegisterNetEvent("tqrp_drugs:activate_meth")
AddEventHandler("tqrp_drugs:activate_meth",function()
    local ped = PlayerPedId()
	if not IsPedInAnyVehicle(PlayerPedId()) then
		TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, true)
		exports['progressBars']:startUI(10000, "SMOKING METH")
		Citizen.Wait(10000)
		ClearPedTasks(PlayerPedId())
	else
		exports['progressBars']:startUI(10000, "SMOKING METH")
		Citizen.Wait(10000)
	end	
    SetTimecycleModifier("spectator5")
	SetPedMotionBlur(playerPed, true)
    if GetEntityHealth(ped) <= 180 then
        SetEntityHealth(ped,GetEntityHealth(ped)+20)
    elseif GetEntityHealth(ped) <= 199 then
        SetEntityHealth(ped,200)
    end
	Citizen.Wait(10000)
    SetTimecycleModifier("default")
	SetPedMotionBlur(playerPed, false)
end)

RegisterNetEvent("tqrp_drugs:activate_weed")
AddEventHandler("tqrp_drugs:activate_weed",function()
    local ped = PlayerPedId()
	if not IsPedInAnyVehicle(PlayerPedId()) then
		TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, true)
		exports['progressBars']:startUI(10000, "SMOKING JOINT")
		Citizen.Wait(10000)
		ClearPedTasks(PlayerPedId())
	else
		exports['progressBars']:startUI(10000, "SMOKING JOINT")
		Citizen.Wait(10000)
	end	
    SetTimecycleModifier("spectator5")
	SetPedMotionBlur(playerPed, true)
    if GetPedArmour(ped) <= 90 then
        AddArmourToPed(ped,10)
    elseif GetPedArmour(ped) <= 99 then
        SetPedArmour(ped,100)
    end
	Citizen.Wait(10000)
    SetTimecycleModifier("default")
	SetPedMotionBlur(playerPed, false)
end)

RegisterNetEvent("tqrp_drugs:activate_coke")
AddEventHandler("tqrp_drugs:activate_coke",function()
    local playerPed = PlayerId()
	if not IsPedInAnyVehicle(PlayerPedId()) then
		TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, true)
		exports['progressBars']:startUI(10000, "SMOKING CRACK COCAINE")
		Citizen.Wait(10000)
		ClearPedTasks(PlayerPedId())
	else
		exports['progressBars']:startUI(10000, "SMOKING CRACK COCAINE")
		Citizen.Wait(10000)
	end
	local timer = 0
	while timer < 60 do
    SetRunSprintMultiplierForPlayer(playerPed,1.2)
    SetTimecycleModifier("spectator5")
	SetPedMotionBlur(playerPed, true)
	ResetPlayerStamina(PlayerId())
	Citizen.Wait(2000)
	timer = timer + 2
	end
    SetTimecycleModifier("default")
	SetPedMotionBlur(playerPed, false)
    SetRunSprintMultiplierForPlayer(playerPed,1.0)
end)


