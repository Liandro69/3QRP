local Status = {}

function GetStatusData(minimal)
	local status = {}

	for i=1, #Status, 1 do

		if minimal then

			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				percent = (Status[i].val / Config.StatusMax) * 100,
			})

		else

			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				color   = Status[i].color,
				visible = Status[i].visible(Status[i]),
				max     = Status[i].max,
				percent = (Status[i].val / Config.StatusMax) * 100,
			})

		end

		Citizen.Wait(250)

	end

	return status

end

AddEventHandler('tqrp_status:registerStatus', function(name, default, color, visible, tickCallback)
	local s = CreateStatus(name, default, color, visible, tickCallback)
	table.insert(Status, s)
end)

RegisterNetEvent('tqrp_status:load')
AddEventHandler('tqrp_status:load', function(status)

	for i=1, #Status, 1 do
		for j=1, #status, 1 do
			if Status[i].name == status[j].name then
				Status[i].set(status[j].val)
			end
		end
	end

	Citizen.CreateThread(function()
	  while true do
	  	for i=1, #Status, 1 do
	  		Status[i].onTick()
	  	end

			SendNUIMessage({
				update = true,
				status = GetStatusData()
			})

	    Citizen.Wait(Config.TickTime)

	  end
	end)

end)

RegisterNetEvent('tqrp_status:set')
AddEventHandler('tqrp_status:set', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].set(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('tqrp_status:update', GetStatusData(true))

end)

RegisterNetEvent('tqrp_status:add')
AddEventHandler('tqrp_status:add', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].add(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('tqrp_status:update', GetStatusData(true))

end)

RegisterNetEvent('tqrp_status:remove')
AddEventHandler('tqrp_status:remove', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].remove(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('tqrp_status:update', GetStatusData(true))

end)

AddEventHandler('tqrp_status:getStatus', function(name, cb)
	
	for i=1, #Status, 1 do
		if Status[i].name == name then
			cb(Status[i])
			return
		end
	end

end)

AddEventHandler('tqrp_status:setDisplay', function(val)

	SendNUIMessage({
		setDisplay = true,
		display    = val
	})

end)
-- Loaded event
Citizen.CreateThread(function()
	TriggerEvent('tqrp_status:loaded')
end)

-- Update server
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.UpdateInterval)
		TriggerServerEvent('tqrp_status:update', GetStatusData(true))
	end
end)

Citizen.CreateThread(function() while true do Citizen.Wait(15000) collectgarbage() end end)-- Prevents RAM LEAKS :)