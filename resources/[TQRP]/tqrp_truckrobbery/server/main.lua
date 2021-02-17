---======================---
---Written by Tościk#9715---          -----   ENGLISH VERSION BY RENGER | WWW.FIVEMLEAK.COM    -----
---======================---
local potrzebniPolicjanci = 0		--<< görevi etkinleştirmek için polislere ihtiyaç duyuldu
local czastimer = 60000 * 1000	    --<< timer co ile mozna robic misje, domyslnie 600 sekund
local gotowkaA = 29602 				--<< ile minimum mozesz dostac z rabunku
local gotowkaB = 32240 				--<< ile maximum mozesz dostac z rabunku
local KosztAktywacji = 5000 		--<< ile kosztuje aktywacja misji (czystej z banku)
-----------------------------------
local MisjaAktywna = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('napadtransport:akceptujto')
AddEventHandler('napadtransport:akceptujto', function()
	local copsOnDuty = 0
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local accountMoney = 0
	accountMoney = xPlayer.getMoney()
if MisjaAktywna == 0 then
	if accountMoney < KosztAktywacji then
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Precisas de mais do que 5000 $ em mão!" })
	else
		--if copsOnDuty >= potrzebniPolicjanci then
			TriggerClientEvent("napadtransport:Pozwolwykonac", _source)
			xPlayer.removeMoney(KosztAktywacji)
			OdpalTimer()
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Ação impossível de momento!" })
--		else
	--		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Ação impossível de momento!" })
--		end
	end
else
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "A carrinha já se encontra em circulação!" })
end
end)

function OdpalTimer()
MisjaAktywna = 1
Wait(czastimer)
MisjaAktywna = 0
end

RegisterServerEvent('napadtransport:zawiadompsy')
AddEventHandler('napadtransport:zawiadompsy', function(coords) 
    TriggerClientEvent('napadtransport:infodlalspd', -1, coords)
end)

RegisterServerEvent('napadtransport:graczZrobilnapad')
AddEventHandler('napadtransport:graczZrobilnapad', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
local LosujSiano = math.random(gotowkaA,gotowkaB)
xPlayer.addMoney(LosujSiano)

Wait(2500)
end)


