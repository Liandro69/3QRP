RegisterServerEvent('kuana:modifystate')
RegisterServerEvent('kuana:checkvehi')

ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Vehicle fetch

ESX.RegisterServerCallback('kuana:getVehicles', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}
	if xPlayer ~= nil then
		MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier AND state != 3 AND state != 2",{['@identifier'] = xPlayer.getIdentifier()}, function(data) 
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(vehicules, {vehicle = vehicle, state = v.state, plate = v.plate})
			end
			cb(vehicules)
		end)
	end
end)

-- End vehicle store
-- Change state of vehicle

AddEventHandler('kuana:modifystate', function(plate, state)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	local state = state
	for _,v in pairs(vehicules) do
		MySQL.Sync.execute("UPDATE owned_vehicles SET state = @state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
		break		
	end
end)

ESX.RegisterServerCallback('kuana:getOutVehicles',function(source, cb)	
	local vehicules = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE state=@state AND state != 3 AND state != 2",{['@state'] = false}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicules, vehicle)
		end
		cb(vehicules)
	end)
end)

function getPlayerVehicles(identifier)
	local vehicles = {}
	local data = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier})	
	for _,v in pairs(data) do
		local vehicle = json.decode(v.vehicle)
		table.insert(vehicles, {id = v.id, plate = v.plate})
	end
	return vehicles
end

AddEventHandler('onMySQLReady', function()
	MySQL.Sync.execute("UPDATE owned_vehicles SET state=true WHERE state=false", {})
end)

AddEventHandler('kuana:checkvehi', function(plate)
	local _source = source
	MySQL.Async.fetchAll('SELECT x, y, z FROM owned_vehicles WHERE plate = @plate AND state != 3', {['@plate'] = plate}, function(result)
		if result[1] ~= nil and #result > 0 then
			TriggerClientEvent('kuana:checkveh', _source, result[1].x, result[1].y, result[1].z)
		end
	end)
end)

RegisterServerEvent('garagem:apre')
AddEventHandler('garagem:apre', function(plate, x, y, z, headings, he, vehicle)
	local h = headings
	MySQL.Async.execute("UPDATE owned_vehicles SET x=@x, y=@y, z=@z, h=@h, health=@he, vehicle=@vehicle WHERE plate=@plate",{
		['@x'] = x, 
		['@y'] = y, 
		['@z'] = z, 
		['@h'] = h, 
		['@he'] = he,
		['@vehicle'] = json.encode(vehicle),
		['@plate'] = plate
	})
end)

ESX.RegisterServerCallback('kuana:checkcoordsall', function(source, cb, plate)
	--local result = MySQL.Sync.fetchScalar("SELECT lastpos FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
	MySQL.Async.fetchAll('SELECT x, y, z, h, health, lockcheck, vehicle FROM owned_vehicles WHERE plate = @plate', {['@plate'] = plate}, function(result)
		if result[1] ~= nil and #result > 0 then
			if (result[1].x == "757.05") and (result[1].y == "-238.43") and (result[1].z == "37.62") then
				cb(106.06, -1062.86, 29.19, 59.77, result[1].health, result[1].lockcheck, result[1].vehicle)
			else
				cb(result[1].x, result[1].y, result[1].z, result[1].h, result[1].health, result[1].lockcheck, result[1].vehicle)
			end
		end
	end)
end)


--[[RegisterServerEvent('kuana:updateall')
AddEventHandler('kuana:updateall', function()
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local identifierr = xPlayer.getIdentifier()
		local vehicules = getPlayerVehicles(identifierr)
		for _,v in pairs(vehicules) do
			MySQL.Sync.execute("UPDATE owned_vehicles SET state = @state WHERE owner=@dono",{['@state'] = state , ['@dono'] = xPlayer.getIdentifier()})	
		end
end)]]

RegisterServerEvent('garagem:lockveh')
AddEventHandler('garagem:lockveh', function(plate, state)
	MySQL.Sync.execute("UPDATE owned_vehicles SET lockcheck=@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
end)

ESX.RegisterServerCallback('kuana:checklock',function(source, cb, plate)
	local checklocka = MySQL.Sync.fetchScalar("SELECT lockcheck FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate}) 
	
	if checklocka == 0 then
		cb(false)
	elseif checklocka == 1 then
		cb(true)
	end
end)

ESX.RegisterServerCallback('kuana:checkcarfind',function(source, cb, plate)
	local vehicules = {}
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate=@plate AND state != 3',{['@plate'] = plate}, function(data)
		if data[1] ~= nil then
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				local owner = v.owner
				table.insert(vehicules, {vehicle = vehicle, state = v.state, lock = v.lockcheck, target = owner})
			end
		end
		cb(vehicules)
	end)
end)

ESX.RegisterServerCallback('kuana:checkcarowner',function(source, cb, target)
	local identifier = ""..target..""
	local name = {}
	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier=@identifier",{['@identifier'] = identifier}, function(data) 
		for _,v in pairs(data) do
			local first = ""..v.firstname
			local last  = ""..v.lastname
			local names = ""..first.." "..last
			local sex = ""
			if v.sex == "M" then
				sex = "Masculino"
			else
				sex = "Feminino"
			end
				
			table.insert(name, {names = names, sex = v.sex, height = v.height})
		end
		cb(name)
	end)
end)

-- E N G I N E --
AddEventHandler('chatMessage', function(s, n, m)
	local message = string.lower(m)
	--[[if message == "/engine off" then
		CancelEvent()
		--------------
		TriggerClientEvent('engineoff', s)
	elseif message == "/engine on" then
		CancelEvent()
		--------------
		TriggerClientEvent('engineon', s)
	else]]if message == "/engine" then
		CancelEvent()
		--------------
		TriggerClientEvent('engine', s)
	end
end)


-- T R U N K -


-- R E A R  D O O R S --
AddEventHandler('chatMessage', function(s, n, m)
	local message = string.lower(m)
	if message == "/portas" then
		CancelEvent()
		--------------
		TriggerClientEvent('portas', s)
	end
end)

-- L O C K --
AddEventHandler('chatMessage', function(s, n, m)
	local message = string.lower(m)
	if message == "/lock" then
		CancelEvent()
		--------------
		TriggerClientEvent('lock', s)
	end
end)
-- S A V E --
AddEventHandler('chatMessage', function(s, n, m)
	local message = string.lower(m)
	if message == "/save" then
		CancelEvent()
		--------------
		TriggerClientEvent('save', s)
	end
end)

ESX.RegisterServerCallback('tqrp_givecarkeys:requestPlayerCars', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier',
	{
		['@identifier'] = xPlayer.identifier
	},
	function(result)
		local found = false
		for i=1, #result, 1 do
			local vehicleProps = json.decode(result[i].vehicle)
			if trim(vehicleProps.plate) == trim(plate) then
				found = true
				break
			end
		end
		if found then
			cb(true)
		else
			cb(false)
		end
	end)
end)

RegisterServerEvent('tqrp_givecarkeys:setVehicleOwnedPlayerId')
AddEventHandler('tqrp_givecarkeys:setVehicleOwnedPlayerId', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE owned_vehicles SET owner=@owner WHERE plate=@plate',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate
	},

	function (rowsChanged)
		TriggerClientEvent('mythic_notify:client:SendAlert', playerId, { type = 'true', text = 'Tens um veículo novo', length = 5000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })

	end)
end)

function trim(s)
    if s ~= nil then
		return s:match("^%s*(.-)%s*$")
	else
		return nil
    end
end

TriggerEvent('es:addCommand', 'darcarro', function(source, args, user)
	TriggerClientEvent('tqrp_givecarkeys:keys', source)
end)

--STATE 3 = APREENDIDO
--STATE 2 = GUARDADO GARAGEM
--STATE 1 = GUARDADO FORA
--STATE 0 = FORA