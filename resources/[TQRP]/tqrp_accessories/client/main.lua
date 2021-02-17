ESX								= nil
local HasAlreadyEnteredMarker	= false
local LastZone					= nil
local CurrentAction				= nil
local CurrentActionData			= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)


RegisterCommand("m", function()
	local accessory = "Mask"
    ESX.TriggerServerCallback('tqrp_accessories:get', function(hasAccessory, accessorySkin)
        local _accessory = string.lower(accessory)
        if hasAccessory then
            TriggerEvent('skinchanger:getSkin', function(skin)
                local mAccessory = -1
                local mColor = 0
                if _accessory == "mask" then
                    mAccessory = 0
                end
                if skin[_accessory .. '_1'] == mAccessory then
					loadAnimDict( "misscommon@van_put_on_masks" )
					TaskPlayAnim(GetPlayerPed(-1), "misscommon@van_put_on_masks", "put_on_mask_rps", 500.0, -8, -1, 49, 0, 0, 0, 0)
                    Wait(500)
                    mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
					
                    local accessorySkin = {}
                    accessorySkin[_accessory .. '_1'] = mAccessory
                    accessorySkin[_accessory .. '_2'] = mColor
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    Wait(1700)
                    ClearPedTasks(GetPlayerPed(-1))
                else
					loadAnimDict( "missfbi4" )
					TaskPlayAnim(GetPlayerPed(-1), "missfbi4", "takeoff_mask", 500.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(1000)
					
                    local accessorySkin = {}
                    accessorySkin[_accessory .. '_1'] = mAccessory
                    accessorySkin[_accessory .. '_2'] = mColor
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    Wait(300)
                    ClearPedTasks(GetPlayerPed(-1))
                end
            end)
        else
		    exports['mythic_notify']:SendAlert('error', _U('no_' .. _accessory))
        end
    end, accessory)
end,false)

RegisterCommand("b", function(src, args, raw)
	SetUnsetAccessory('Ears')
end)

RegisterCommand("c", function()
	local accessory = "Helmet"
    ESX.TriggerServerCallback('tqrp_accessories:get', function(hasAccessory, accessorySkin)
        local _accessory = string.lower(accessory)
        if hasAccessory then     
            TriggerEvent('skinchanger:getSkin', function(skin)
                local mAccessory = -1
                local mColor = 0
                if skin[_accessory .. '_1'] == mAccessory then
					loadAnimDict( "missheistdockssetup1hardhat@" )
                    TaskPlayAnim(GetPlayerPed(-1), "missheistdockssetup1hardhat@", "put_on_hat", 8.0, -8, -1, 49, 0, 0, 0, 0)
                    
                    Wait(1500)
                    mAccessory = accessorySkin[_accessory .. '_1']
                    mColor = accessorySkin[_accessory .. '_2']
                    ClearPedTasks(GetPlayerPed(-1))
                else
					loadAnimDict( "missheist_agency2ahelmet")
					TaskPlayAnim(GetPlayerPed(-1), "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, -8, -1, 49, 0, 0, 0, 0)
					Wait(800)
					ClearPedTasks(GetPlayerPed(-1))
                end
                local accessorySkin = {}
                accessorySkin[_accessory .. '_1'] = mAccessory
                accessorySkin[_accessory .. '_2'] = mColor
                TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
            end)
        else
            exports['mythic_notify']:SendAlert('error', _U('no_' .. _accessory))
        end
    end, accessory)
end,false)

RegisterCommand("o", function()
	local accessory = "Glasses"
    ESX.TriggerServerCallback('tqrp_accessories:get', function(hasAccessory, accessorySkin)
        local _accessory = string.lower(accessory)
        if hasAccessory then
            TriggerEvent('skinchanger:getSkin', function(skin)
                local mAccessory = 0
                local mColor = 0

                if skin[_accessory .. '_1'] == mAccessory then
					loadAnimDict("clothingspecs")
					TaskPlayAnim(GetPlayerPed(-1), "clothingspecs", "put_on", 500.0, -8, -1, 49, 0, 0, 0, 0)
                    Wait(3500)
                    mAccessory = accessorySkin[_accessory .. '_1']
                    mColor = accessorySkin[_accessory .. '_2']
                    ClearPedTasks(GetPlayerPed(-1))
                else
					loadAnimDict("clothingspecs")
					TaskPlayAnim(GetPlayerPed(-1), "clothingspecs", "take_off", 500.0, -8, -1, 49, 0, 0, 0, 0)
                    Wait(1500)
                    ClearPedTasks(GetPlayerPed(-1))
                end
                local accessorySkin = {}
                accessorySkin[_accessory .. '_1'] = mAccessory
                accessorySkin[_accessory .. '_2'] = mColor
                TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
            end)
        else
            exports['mythic_notify']:SendAlert('error', _U('no_' .. _accessory))
        end
    end, accessory)
end,false)


function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('tqrp_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)
		if hasAccessory then
			loadAnimDict( "missheist_agency2ahelmet" )
			TaskPlayAnim(PlayerPedId(), "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, -8, -1, 49, 0, 0, 0, 0)	
			TriggerEvent("mythic_progbar:client:progress", {
				name = "unique_action_name",
				duration = 1000,
				label = "A mudar acessório",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}
				}, function(status)
				if not status then
					TriggerEvent('skinchanger:getSkin', function(skin)
						local mAccessory = -1
						local mColor = 0
		
						if _accessory == "mask" then
							mAccessory = 0
						end
		
						if skin[_accessory .. '_1'] == mAccessory then
							mAccessory = accessorySkin[_accessory .. '_1']
							mColor = accessorySkin[_accessory .. '_2']
						end
		
						local accessorySkin = {}
						accessorySkin[_accessory .. '_1'] = mAccessory
						accessorySkin[_accessory .. '_2'] = mColor
						TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
					end)
					ClearPedSecondaryTask(PlayerPedId())
				end
			end)
		else
			exports['mythic_notify']:SendAlert('error', _U('no_' .. _accessory))
		end

	end, accessory)
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
	  RequestAnimDict( dict )
	  Citizen.Wait(10)
	end
  end

function OpenShopMenu(accessory)
	local _accessory = string.lower(accessory)
	local restrict = {}

	restrict = { _accessory .. '_1', _accessory .. '_2' }
	
	TriggerEvent('tqrp_skin:openRestrictedMenu', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
		{
			title = _U('valid_purchase'),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes', ESX.Math.GroupDigits(Config.Price)), value = 'yes'}
			}
		}, function(data, menu)
			menu.close()
			if data.current.value == 'yes' then
				ESX.TriggerServerCallback('tqrp_accessories:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then
						TriggerServerEvent('tqrp_accessories:pay')
						TriggerEvent('skinchanger:getSkin', function(skin)
							TriggerServerEvent('tqrp_accessories:save', skin, accessory)
						end)
					else
						TriggerEvent('tqrp_skin:getLastSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)
						exports['mythic_notify']:SendAlert('error', 'not_enough_money')
					end
				end)
			end

			if data.current.value == 'no' then
				local player = PlayerPedId()
				TriggerEvent('tqrp_skin:getLastSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				if accessory == "Ears" then
					ClearPedProp(player, 2)
				elseif accessory == "Mask" then
					SetPedComponentVariation(player, 1, 0 ,0, 2)
				elseif accessory == "Helmet" then
					ClearPedProp(player, 0)
				elseif accessory == "Glasses" then
					SetPedPropIndex(player, 1, -1, 0, 0)
				end
			end
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}

		end)
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
	end, restrict)
end

AddEventHandler('tqrp_accessories:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = { accessory = zone }
end)

AddEventHandler('tqrp_accessories:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create Blips --
Citizen.CreateThread(function()
	for k,v in pairs(Config.ShopsBlips) do
		if v.Pos ~= nil then
			for i=1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

				SetBlipSprite(blip, v.Blip.sprite)
				SetBlipDisplay(blip, 4)
				SetBlipScale(blip, 0.6)
				SetBlipColour(blip, v.Blip.color)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('shop', _U(string.lower(k))))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

-- Display markers
Citizen.CreateThread(function()
	local sleep = 1000
	while true do
		Citizen.Wait(sleep)
		sleep = 1000
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				local distance = GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true)
				if distance < 5 then
					DrawMarker(27, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
					if distance < Config.DrawDistance then
						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 1, "Clica [~g~E~w~] para alterar visual")
					end
					sleep = 7
					break
				end
			end
			if sleep == 7 then
				break
			end
		end
	end
end)

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)

    local scale = 0.3

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
		SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end


Citizen.CreateThread(function()
	local sleep = 1000
	while true do
		Citizen.Wait(sleep)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.Size.x then
					isInMarker  = true
					currentZone = k
					sleep = 10
					break
				else
					isInMarker = false
					sleep = 1000
				end
			end
			if isInMarker then
				break
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('tqrp_accessories:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('tqrp_accessories:hasExitedMarker', LastZone)
		end

		if CurrentAction ~= nil then
			if IsControlJustReleased(0, 38) and CurrentActionData.accessory then
				OpenShopMenu(CurrentActionData.accessory)
				CurrentAction = nil
			end
		end

	end
end)

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end) -- Fix RAM leaks by collecting garbage