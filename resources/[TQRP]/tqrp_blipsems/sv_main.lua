local emstable = {}
local isCop = false
local _blip = " "
ESX                 = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addCommand', 'blip', function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)
	local Job = xPlayer.job.name
	if Job == 'police' or Job == 'ambulance' or Job == 'sheriff' then

	local info = getInfo()
	local id = GetPlayerIdentifier(source, steam)
	local blipname = table.concat(args, " ")

	if info == nil then info = {} end

	if #info > 0 then 
		for k,v in pairs(info) do
			if info[k].steam == id then
				table.remove(info,k)
			end
		end
	end
		 
	   table.insert(info, {
		steam = id,
		blipinfo = blipname
	   })

	SaveResourceFile(GetCurrentResourceName(), "blips.json", json.encode(info), -1)

	end
end)


------------------------------------------------------


RegisterServerEvent('tqrpblips:addEmsToTable')
AddEventHandler('tqrpblips:addEmsToTable',function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local Job = xPlayer.job.name

	if Job == 'police' or Job == 'ambulance' or Job == 'sheriff' then

		local id = GetPlayerIdentifier(source, steam)
		local i = GetPlayerName(source)

		local info = getInfo()
		
		if  #emstable > 0 then
		
			for k,v in pairs(emstable) do
				if emstable[k].i == i then
					table.remove(emstable,k)
					
				end
			end
		end
		
		if info ~= nil then	
			for a,b in pairs(info) do
				if info[a].steam == id and info[a].blipinfo ~= nil then
					table.insert(emstable, {
						i = i,
						_blip = info[a].blipinfo,
						drawBlips = true,
						isCop = Job
					})
				end
			end
			showblips = true
			TriggerEvent('tqrp_base:updateJobs',emstable)
			TriggerClientEvent('tqrpblips:updateEms',-1,emstable,i,showblips)
		end
	end
end)


RegisterServerEvent('tqrpblips:removeEmsFromTable')
AddEventHandler('tqrpblips:removeEmsFromTable',function()

	local i = GetPlayerName(source)	

	for k,v in pairs(emstable) do
		if emstable[k].i == i then
			table.remove(emstable,k)
		end
	end
		showblips = false
		TriggerEvent('tqrp_base:updateJobs',emstable)
		TriggerClientEvent('tqrpblips:updateEms',-1,emstable,i,showblips)
end)



---------------------------------------------------------------------------------

AddEventHandler("playerDropped", function()
	local i = GetPlayerName(source)	

	for k,v in pairs(emstable) do
		if emstable[k].i == i then
			table.remove(emstable,k)
		end
	end
		showblips = false
		TriggerEvent('tqrp_base:updateJobs',emstable)
		TriggerClientEvent('tqrpblips:updateEms',-1,emstable,i,showblips)
end)

---------------------------------------------------------------------------------

TriggerEvent('es:addCommand', 'blipOFF', function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		local i = GetPlayerName(source)	
		
		for k,v in pairs(emstable) do
			if emstable[k].i == i then
				emstable[k].drawBlips = false
			end
		end
		
		showblips = false
		TriggerEvent('tqrp_base:updateJobs',emstable)
		TriggerClientEvent('tqrpblips:updateEms',-1,emstable,i,showblips)
	
end)

TriggerEvent('es:addCommand', 'blipON', function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

	local Job = xPlayer.job.name

	if Job == 'police' or Job == 'ambulance' or Job == 'sheriff' then

		local id = GetPlayerIdentifier(source, steam)
		local i = GetPlayerName(source)
	
		local info = getInfo()
		
		if  #emstable > 0 then
			for k,v in pairs(emstable) do
				if emstable[k].i == i then
					table.remove(emstable,k)
				end
			end
		end
		
		if info ~= nil then	
			for a,b in pairs(info) do
				if info[a].steam == id and info[a].blipinfo ~= nil then
					table.insert(emstable, {
						i = i,
						_blip = info[a].blipinfo,
						drawBlips = true,
						isCop = Job
					})
				end
			end
			showblips = true
			TriggerEvent('tqrp_base:updateJobs',emstable)
			TriggerClientEvent('tqrpblips:updateEms',-1,emstable,i,showblips)
		end
	end
end)

--- FUNÇÃO LEITURA DOCUMENTO ----
function getInfo()
	local file = LoadResourceFile(GetCurrentResourceName(), "./blips.json")
	local info = json.decode(file)
	return(info)
end