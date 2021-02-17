
RegisterServerEvent("tqrp_phone:server:getPlayerVehicles")
AddEventHandler("tqrp_phone:server:getPlayerVehicles", function()
	local src = source
	local player = ESX.GetPlayerFromId(src)
	if player then

		MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @cid", { ["@cid"] = player["identifier"] }, function(responses)
			local playerVehicles = {}

			for key, v in ipairs(responses) do
				local veh = json.decode(v.vehicle)
				table.insert(playerVehicles, {
          			plate = v.plate,
         			garage = v.garage,
					vehicle = veh,
					vehicle_name = veh.name,
					health = v.health,
					state = v.state,
					x = v.x,
					y = v.y,
					z = v.z,
					h = v.h
				})
			end
			TriggerClientEvent('tqrp_phone:client:SetupData', src, {
				{ name = 'cars', data = playerVehicles }
			})
		end)
	end
end)

RegisterServerEvent("tqrp_phone:server:UpdateVehConfigBD")
AddEventHandler("tqrp_phone:server:UpdateVehConfigBD", function(coords, heading, data, health)
	local source = source
	MySQL.Async.execute("UPDATE owned_vehicles SET x=@x, y=@y, z=@z, h=@h, health=@he, vehicle=@vehicle WHERE plate=@plate",{
		['@x'] = coords.x, 
		['@y'] = coords.y, 
		['@z'] = coords.z, 
		['@h'] = heading, 
		['@he'] = health,
		['@vehicle'] = json.encode(data),
		['@plate'] = data.plate
	})
	TriggerClientEvent("tqrp_phone:client:UpdateVehConfig", source, coords, heading, data, health)
end)




-- soon

--[[ ESX.RegisterServerCallback("tqrp_phone:server:GetVehicleKeys", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if player then

		MySQL.Async.fetchAll("SELECT * FROM vehicle_keys WHERE identifier = @identifier", {
			["@identifier"] = player["identifier"]
		}, function(responses)
			local playerKeys = {}

			for k, v in ipairs(responses) do
				table.insert(playerKeys, {
          			owner = v,
					plate = v
				})
			end

			callback(playerKeys)
		end)
	else
		callback(false)
	end
end) ]]