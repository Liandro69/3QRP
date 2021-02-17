--------------------------------------------------
-- 				Don't edit anything here		--
--					Made by Tazio				--
--------------------------------------------------

local inMenu = false

-- Events
RegisterNetEvent("invest:nui")
AddEventHandler("invest:nui", function (data)
	SendNUIMessage(data)
end)

RegisterNetEvent("invest:open")
AddEventHandler("invest:open", function (data)
	openUI()
	TriggerServerEvent("invest:balance")
end)

-- UI callbacks
RegisterNUICallback('close', function(data, cb) 
	if(inMenu) then
		closeUI()
	end
end)

RegisterNUICallback("newBanking", function()
	if(inMenu) then
		closeUI()
		exports.new_banking:openUI()
	end
end)

RegisterNUICallback("list", function()
	TriggerServerEvent("invest:list")
end)

RegisterNUICallback("all", function()
	TriggerServerEvent("invest:all", false)
end)

RegisterNUICallback("sell", function()
	TriggerServerEvent("invest:all", true)
end)

RegisterNUICallback("sellInvestment", function(data, cb)
	TriggerServerEvent("invest:sell", data.job)
end)

RegisterNUICallback("buyInvestment", function(data, cb)
	TriggerServerEvent("invest:buy", data.job, data.amount, data.boughtRate)
end)

RegisterNUICallback("balance", function(data, cb)
	TriggerServerEvent("invest:balance")
end)

-- Open UI
function openUI()
	inMenu = true
	SetNuiFocus(true, true)
    SendNUIMessage({type = "open"})
end

-- Close UI
function closeUI() 
	inMenu = false
	SetNuiFocus(false, false)
    SendNUIMessage({type = "close"})
end

-- Close menu on close
AddEventHandler('onResourceStop', function (resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
    end
    if inMenu then
        closeUI()
    end
end)