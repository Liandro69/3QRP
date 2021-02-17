

local maxLivePig = 10   -- max ammount of live pigs you can hold
local maxDeadPig = 20   -- how many dead pigs you can hold
local maxPackegePig = 20    --how many meat  you can hold

---------------------------
---DONT TOUCH IF UR NOOB---
---------------------------
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('tqrp:apanhagalinha2')
AddEventHandler('tqrp:apanhagalinha2', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local AlivePiggs = xPlayer.getInventoryItem('alive_pig').count

if AlivePiggs < maxLivePig then
Citizen.Wait(1000)
xPlayer.addInventoryItem('alive_pig', 5)
Wait(1500)
else
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Só podes carregar ' ..maxLivePig.. ' porcos de uma vez!'})
Wait(2500)
end
end)

RegisterServerEvent('tqrp:mataporco')
AddEventHandler('tqrp:mataporco', function(projetofalhado)
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local AlivePiggs = xPlayer.getInventoryItem('alive_pig').count
local DeadPiggs = xPlayer.getInventoryItem('slaughtered_pig').count
local PackegedPiggs = xPlayer.getInventoryItem('packaged_pig').count

if projetofalhado == 1 then
	if AlivePiggs > 0 and DeadPiggs < maxDeadPig then
	Citizen.Wait(1000)
	xPlayer.removeInventoryItem('alive_pig', 1)
	Citizen.Wait(1000)
	xPlayer.addInventoryItem('slaughtered_pig', 2)
	Wait(1500)
	else
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Só podes carregar ' ..maxDeadPig.. ' porcos mortos á vez!'})
	Wait(2500)
	end
end

if projetofalhado == 2 then
	if DeadPiggs > 0 and PackegedPiggs < maxPackegePig then
	Citizen.Wait(1000)
	xPlayer.removeInventoryItem('slaughtered_pig', 2)
	Citizen.Wait(1000)
	xPlayer.addInventoryItem('packaged_pig', 2)
	Wait(1500)
	else
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Só podes levar ' ..maxDeadPig.. ' porcos mortos á vez!'})
	Wait(2500)
	end
end

if projetofalhado == 3 then
	if PackegedPiggs > 4 then
	Citizen.Wait(1000)
	xPlayer.removeInventoryItem('packaged_pig', 5)
	xPlayer.addMoney(math.random(105,150)) --Ammount of money you get from selling the meat
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Vendes te costoletas embaladas!'})
	Wait(1500)
	else
	TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'Não tens embalagens suficientes.'})
	end
end

end)
