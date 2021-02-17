local AnnouncementScaleform

function StartDraw(type, time)
	Citizen.CreateThread(function()
		local fading = false
		while not AnnouncementScaleform do Wait(0) end
		local StartTime = GetGameTimer()
		while true do
			AnnouncementScaleform:Draw2D()

			if GetGameTimer() - StartTime > time * 1000 then 
				if type == 1 and not fading then 
					fading = true
					AnnouncementScaleform:CallFunction("SHARD_ANIM_OUT", 2, 1) 
				elseif type ~= 1 then
					AnnouncementScaleform:Dispose()
					return 
				end
			end

			if GetGameTimer() - StartTime > (time + 1.25) * 1000  then
				AnnouncementScaleform:Dispose()
				fading = false
				return 
			end
			Wait(10)
		end
	end)
end

RegisterNetEvent("Scaleform:Announce")
AddEventHandler("Scaleform:Announce", function(type, time, fontsize, announcement)
	--[[Citizen.CreateThread(function()
		StartDraw(type, time)
	end)]]
	if type == 1 then
		AnnouncementScaleform = Scaleform.Request("MIDSIZED_MESSAGE")
		TriggerEvent('mythic_notify:client:SendAlert', { type = 'adm', text = "RESTART IMINENTE" })
		TriggerEvent('InteractSound_CL:PlayOnOne', "demo", 0.1)
		--AnnouncementScaleform:CallFunction("SHOW_SHARD_MIDSIZED_MESSAGE", "RESTART IMINENTE", " ", 2, true, true)
	elseif type == 2 then
		AnnouncementScaleform = Scaleform.Request("TEXTFIELD")
		--AnnouncementScaleform:CallFunction("SET_TEXT", "RESTART IMINENTE")
		--AnnouncementScaleform:CallFunction("SET_TEXT_POINT_SIZE", fontsize)
		TriggerEvent('mythic_notify:client:SendAlert', { type = 'adm', text = "RESTART IMINENTE" })
		TriggerEvent('InteractSound_CL:PlayOnOne', "demo", 0.1)
	end
end)