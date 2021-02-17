ESX          = nil
local isDead = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

function ShowBillsMenu()

	ESX.TriggerServerCallback('tqrp_billing:getBills', function(bills)
		ESX.UI.Menu.CloseAll()
		local elements = {}

		for i=1, #bills, 1 do
			table.insert(elements, {
				label  = (('%s - <span style="color:red;">%s</span>'):format(bills[i].label, _U('invoices_item', ESX.Math.GroupDigits(bills[i].amount) ) ) ..": ".. bills[i].day .. "/".. bills[i].month),
				billID = bills[i].id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
		{
			title    = _U('invoices'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			ESX.TriggerServerCallback('tqrp_billing:payBill', function()
				ShowBillsMenu()
			end, data.current.billID)
		end, function(data, menu)
			menu.close()
		end)
	end)

end

RegisterNetEvent('tqrp_billing:OpenBilling')
AddEventHandler('tqrp_billing:OpenBilling', function()
	if not isDead and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'billing') then
		ShowBillsMenu()
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)
