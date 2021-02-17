

local maxChicken = 30   -- max ammount of live chickens you can hold
local maxDeadChicken = 60   -- how many dead chickens you can hold
local maxPackChicken = 30    --how many packed chickens you can hold

-----------------------------------
---DON´T TOUCH IF U KNOW NOTHING---
-----------------------------------
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('tqrp:apanhagalinha')
AddEventHandler('tqrp:apanhagalinha', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local aliveChicken = xPlayer.getInventoryItem('alive_chicken').count

if aliveChicken < maxChicken then
Citizen.Wait(1000)
xPlayer.addInventoryItem('alive_chicken', 5)
Wait(1500)
else
TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = 'Só podes ter.' ..maxDeadChicken.. 'á vez'})
Wait(2500)
end
end)

RegisterServerEvent('tqrp:mataagalinha')
AddEventHandler('tqrp:mataagalinha', function(projetodamerda)
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local aliveChicken = xPlayer.getInventoryItem('alive_chicken').count
local deadChicken = xPlayer.getInventoryItem('slaughtered_chicken').count
local packChicken = xPlayer.getInventoryItem('packaged_chicken').count

if projetodamerda == 1 then
	if aliveChicken > 0 and deadChicken < maxDeadChicken then
	Citizen.Wait(1000)
	xPlayer.removeInventoryItem('alive_chicken', 1)
	Citizen.Wait(1000)
	xPlayer.addInventoryItem('slaughtered_chicken', 2)
	Wait(1500)
	else
	TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = 'Só podes ter.' ..maxDeadChicken.. 'á vez'})
	Wait(2500)
	end
end

if projetodamerda == 2 then
	if deadChicken > 0 and packChicken < maxPackChicken then
	Citizen.Wait(1000)
	xPlayer.removeInventoryItem('slaughtered_chicken', 2)
	Citizen.Wait(1000)
	xPlayer.addInventoryItem('packaged_chicken', 2)
	Wait(1500)
	else
	TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = 'Só podes ter.' ..maxDeadChicken.. 'á vez'})
	Wait(2500)
	end
end

if projetodamerda == 3 then
	if packChicken > 4 then
	Citizen.Wait(1000)
	xPlayer.removeInventoryItem('packaged_chicken', 5)
	xPlayer.addMoney(math.random(70,110))
	TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = 'Vendeste frango ao Burger Shot.'})
	Wait(1500)
	else
	TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'Não tens embalagens suficientes.'})
	end
end

end)
