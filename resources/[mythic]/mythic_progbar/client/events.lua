RegisterNetEvent("mythic_progbar:client:progress")
AddEventHandler("mythic_progbar:client:progress", function(action, finish)
	Process(action, nil, nil, finish)
end)

RegisterCommand('teste', function(source, args, rawCommand)
	--1
    --loadAnimDict( "random@arrests@busted" )
	--TaskPlayAnim(PlayerPedId(), "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
	--2
	--loadAnimDict( "random@arrests" )
	--TaskPlayAnim( PlayerPedId(), "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
	--3
	--loadAnimDict( "random@arrests@busted" )
	--TaskPlayAnim( PlayerPedId(), "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
	local player = GetPlayerPed( -1 )
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( "random@arrests" )
		loadAnimDict( "random@arrests@busted" )
		if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
			TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (3000)
			TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
		else
			TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (4000)
			TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (500)
			TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (1000)
			TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
		end     
	end
end)

RegisterNetEvent("mythic_progbar:client:ProgressWithStartEvent")
AddEventHandler("mythic_progbar:client:ProgressWithStartEvent", function(action, start, finish)
	Process(action, start, nil, finish)
end)

RegisterNetEvent("mythic_progbar:client:ProgressWithTickEvent")
AddEventHandler("mythic_progbar:client:ProgressWithTickEvent", function(action, tick, finish)
	Process(action, nil, tick, finish)
end)

RegisterNetEvent("mythic_progbar:client:ProgressWithStartAndTick")
AddEventHandler("mythic_progbar:client:ProgressWithStartAndTick", function(action, start, tick, finish)
	Process(action, start, tick, finish)
end)

RegisterNetEvent("mythic_progbar:client:cancel")
AddEventHandler("mythic_progbar:client:cancel", function()
	Cancel()
end)

RegisterNUICallback('actionFinish', function(data, cb)
	Finish()
end)