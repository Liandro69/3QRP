-------------------------------------
------- Created by Hamza#1234 -------
-------------------------------------

local ESX 				= nil

local HeistTimer = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local YachtHeist 		= Config.Yacht

AddEventHandler('esx:playerLoaded', function(source)
    TriggerClientEvent('tqrp_assaltoiate:load', source, YachtHeist)
end)

RegisterServerEvent('tqrp_assaltoiate:refreshHeist')
AddEventHandler('tqrp_assaltoiate:refreshHeist', function()
    TriggerClientEvent('tqrp_assaltoiate:load', -1, YachtHeist)
end)

RegisterServerEvent('tqrp_assaltoiate:goonsSpawned')
AddEventHandler('tqrp_assaltoiate:goonsSpawned', function(id, status)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].GoonsSpawned=status
        TriggerClientEvent('tqrp_assaltoiate:statusGoonsSpawnedSend', -1, YachtHeist[id].pairs, status)
    end
    YachtHeist[id].GoonsSpawned=status
    TriggerClientEvent('tqrp_assaltoiate:statusGoonsSpawnedSend', -1, id, status)
end)

RegisterServerEvent('tqrp_assaltoiate:JobPlayer')
AddEventHandler('tqrp_assaltoiate:JobPlayer', function(id, status)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].JobPlayer=status
        TriggerClientEvent('tqrp_assaltoiate:statusJobPlayerSend', -1, YachtHeist[id].pairs, status)
    end
    YachtHeist[id].JobPlayer=status
    TriggerClientEvent('tqrp_assaltoiate:statusJobPlayerSend', -1, id, status)
end)

RegisterServerEvent('tqrp_assaltoiate:status')
AddEventHandler('tqrp_assaltoiate:status', function(id, status)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].started=status
        TriggerClientEvent('tqrp_assaltoiate:statusSend', -1, YachtHeist[id].pairs, status)
    end
    YachtHeist[id].started=status
    TriggerClientEvent('tqrp_assaltoiate:statusSend', -1, id, status)
end)

local policeOnline

ESX.RegisterServerCallback("tqrp_assaltoiate:GetPoliceOnline",function(source,cb)
	local Players = ESX.GetPlayers()
	policeOnline = 0
	for i = 1, #Players do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if xPlayer["job"]["name"] == Config.PoliceDBname then
			policeOnline = policeOnline + 1
		end
	end
	if policeOnline >= Config.RequiredPolice then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('tqrp_assaltoiate:statusHack')
AddEventHandler('tqrp_assaltoiate:statusHack', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].keypadHacked=state
        TriggerClientEvent('tqrp_assaltoiate:statusHackSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].keypadHacked=state
    TriggerClientEvent('tqrp_assaltoiate:statusHackSend', -1, id, state)
end)

RegisterServerEvent('tqrp_assaltoiate:currentlyHacking')
AddEventHandler('tqrp_assaltoiate:currentlyHacking', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].currentlyHacking=state
        TriggerClientEvent('tqrp_assaltoiate:statusCurrentlyHackingSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].currentlyHacking=state
    TriggerClientEvent('tqrp_assaltoiate:statusCurrentlyHackingSend', -1, id, state)
end)

RegisterServerEvent('tqrp_assaltoiate:statusVault')
AddEventHandler('tqrp_assaltoiate:statusVault', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].vaultLocked=state
        TriggerClientEvent('tqrp_assaltoiate:statusVaultSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].vaultLocked=state
    TriggerClientEvent('tqrp_assaltoiate:statusVaultSend', -1, id, state)
end)

RegisterServerEvent('tqrp_assaltoiate:HeistIsBeingReset')
AddEventHandler('tqrp_assaltoiate:HeistIsBeingReset', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
	-- started:
	YachtHeist[id].started=false
    TriggerClientEvent('tqrp_assaltoiate:statusSend', -1, id, false)
	Citizen.Wait(1000)
	-- recently robbed:
	TriggerEvent("tqrp_assaltoiate:heistCooldown")
	YachtHeist[id].recentlyRobbed=true
    TriggerClientEvent('tqrp_assaltoiate:statusRecentlyRobbed', -1, id, true)
	-- hacked:
    YachtHeist[id].keypadHacked=false
    TriggerClientEvent('tqrp_assaltoiate:statusHackSend', -1, id, false)
	-- currently hacking:
    YachtHeist[id].currentlyHacking=false
    TriggerClientEvent('tqrp_assaltoiate:statusCurrentlyHackingSend', -1, id, false)
	-- vault:
    YachtHeist[id].vaultLocked=true
    TriggerClientEvent('tqrp_assaltoiate:statusVaultSend', -1, id, true)
	-- safe:
    YachtHeist[id].safeRobbed=false
    TriggerClientEvent('tqrp_assaltoiate:statusSafeRobbedSend', -1, id, false)
	-- drilling:
    YachtHeist[id].drilling=false
    TriggerClientEvent('tqrp_assaltoiate:statusDrillingSend', -1, id, false)
	-- cashTaken:
    YachtHeist[id].cashTaken=false
    TriggerClientEvent('tqrp_assaltoiate:statusCashTakenSend', -1, id, false)
	-- stealing:
    YachtHeist[id].stealing=false
    TriggerClientEvent('tqrp_assaltoiate:statusStealingSend', -1, id, false)
	-- GoonsSpawned:
    YachtHeist[id].GoonsSpawned=false
    TriggerClientEvent('tqrp_assaltoiate:statusGoonsSpawnedSend', -1, id, false)
	-- JobPlayer:
    YachtHeist[id].JobPlayer=status
    TriggerClientEvent('tqrp_assaltoiate:statusJobPlayerSend', -1, id, status)
end)

RegisterServerEvent('tqrp_assaltoiate:drilling')
AddEventHandler('tqrp_assaltoiate:drilling', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].drilling=state
        TriggerClientEvent('tqrp_assaltoiate:statusDrillingSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].drilling=state
	TriggerClientEvent('tqrp_assaltoiate:statusDrillingSend', -1, id, state)
	xPlayer.removeInventoryItem('drill', 1)
end)

RegisterServerEvent('tqrp_assaltoiate:stealing')
AddEventHandler('tqrp_assaltoiate:stealing', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].stealing=state
        TriggerClientEvent('tqrp_assaltoiate:statusStealingSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].stealing=state
    TriggerClientEvent('tqrp_assaltoiate:statusStealingSend', -1, id, state)
end)

RegisterServerEvent('tqrp_assaltoiate:cashTaken')
AddEventHandler('tqrp_assaltoiate:cashTaken', function(id, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].cashTaken=state
        TriggerClientEvent('tqrp_assaltoiate:statusCashTakenSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].cashTaken=state
    TriggerClientEvent('tqrp_assaltoiate:statusCashTakenSend', -1, id, state)
end)

RegisterServerEvent('tqrp_assaltoiate:safeRobbed')
AddEventHandler('tqrp_assaltoiate:safeRobbed', function(id, state)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].safeRobbed=state
        TriggerClientEvent('tqrp_assaltoiate:statusSafeRobbedSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].safeRobbed=state
    TriggerClientEvent('tqrp_assaltoiate:statusSafeRobbedSend', -1, id, state)

	if policeOnline > 5 then
		policeReward = 5
	else
		policeReward = policeOnline
	end
	local cashReward = 0
	local itemReward = 0
	if Config.RewardBasedOnCops then
		cashReward = ((math.random(Config.SafeMinCash,Config.SafeMaxCash) * 1000) * policeReward)
		itemReward = ((math.random(Config.SafeMinItem,Config.SafeMaxItem) * 10) * policeReward)
	else
		cashReward = (math.random(Config.SafeMinCash,Config.SafeMaxCash) * 1000)
		itemReward = (math.random(Config.SafeMinItem,Config.SafeMaxItem) * 10)
	end
	xPlayer.addInventoryItem(Config.SafeBoxItem,itemReward)
	print(itemReward .. 'OF'.. Config.SafeBoxItem ..' TO '.. source)
	xPlayer.addMoney(cashReward)
	print(cashReward .. ' TO '.. source)
	TriggerClientEvent("esx:showNotification",source,"You received: ~r~$"..cashReward.."~s~ money and ~b~"..itemReward.."x~s~ ~y~Gold Watches~s~")
end)

ESX.RegisterServerCallback("tqrp_assaltoiate:updateCashTaken",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if policeOnline > 5 then
		policeReward = 5
	else
		policeReward = policeOnline
	end
	if xPlayer then
		local randomMoney = 0
		if Config.RewardBasedOnCops then
			randomMoney = ((math.random(Config.MinCashTake, Config.MaxCashTake) * 100) * policeReward)
		else
			randomMoney = (math.random(Config.MinCashTake, Config.MaxCashTake) * 100)
		end
	--	xPlayer.addMoney(randomMoney)
		print(randomMoney .. ' TO '.. source)
		cb(randomMoney)
	end
end)

ESX.RegisterUsableItem('drill', function(source)
    local _source  = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('tqrp_assaltoiate:useDrill', _source)
end)

-- Server Callback to get inventory hackerDevice:
ESX.RegisterServerCallback("tqrp_assaltoiate:getHackerDevice",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(Config.HackerDevice).count >= 1 then
		xPlayer.removeInventoryItem(Config.HackerDevice, 1)
		cb(true)
	else
		cb(false)
		TriggerClientEvent("esx:showNotification",source,"You need a ~y~Hacker Device~s~ to hack the terminal!")
	end
end)

-- Server Callback to get inventory drill:
ESX.RegisterServerCallback("tqrp_assaltoiate:getDrillItem",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(Config.DrillItem).count >= 1 then
		cb(true)
	else
		cb(false)
		TriggerClientEvent("esx:showNotification",source,"You need a ~y~Drill~s~ to drill the safe!")
	end
end)

ESX.RegisterServerCallback("tqrp_assaltoiate:getCooldownHeist",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if YachtHeist[1].recentlyRobbed == false then
		cb(true)
	else
		cb(false)
		TriggerClientEvent("esx:showNotification",source,string.format("New heist available in: ~b~%s minutes~s~",GetCooldownTimer()))
	end
end)

-- server side for cooldown timer
RegisterServerEvent("tqrp_assaltoiate:heistCooldown")
AddEventHandler("tqrp_assaltoiate:heistCooldown",function()
	table.insert(HeistTimer,{time = (Config.CooldownTimer * 60000)}) -- cooldown timer for doing missions
end)

-- thread for syncing the cooldown timer
Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for k,v in pairs(HeistTimer) do
			if v.time <= 0 then
				YachtHeist[1].recentlyRobbed=false
				TriggerClientEvent('tqrp_assaltoiate:statusRecentlyRobbed', -1, 1, false)
			else
				v.time = v.time - 1000
			end
		end
	end
end)

function GetCooldownTimer()
	for k,v in pairs(HeistTimer) do
		if v.time > 0 then
			return math.ceil(v.time/60000)
		end
	end
end
