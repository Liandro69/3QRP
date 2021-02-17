ESX = nil

local currentTattoos = {}
local cam = -1
local inMenu = false
Citizen.CreateThread(function()
	while ESX == nil do
   	 TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
   	 Citizen.Wait(10)
  	end

	addBlips()

	while true do
		Citizen.Wait(7)
		--drawMarkers()

		if(inMenu) then
			if(IsControlJustPressed(1, 177)) then
				ESX.UI.Menu.CloseAll()
				FreezeEntityPosition(PlayerPedId(), false)
--[[ 				RenderScriptCams(false, false, 0, 1, 0)
				DestroyCam(cam, false) ]]
				setPedSkin()
				inMenu = false
			end
--[[ 		elseif(DoesCamExist(cam)) then
			RenderScriptCams(false, false, 0, 1, 0)
			DestroyCam(cam, false) ]]
		end

		if(isNearTattoosShop()) then
			--Info(Config.TextToOpenMenu)
			--Draw3DText(322.07,180.36,103.59 +0.5, ("Faz a tua tatuagem"))
			if not inMenu then
				Draw3DText(1322.39, -1652.85, 52.28 +0.2, '[~g~E~w~] Falar com o tatuador')
			end
			if(IsControlJustPressed(1, Config.KeyToOpenMenu)) then
				inMenu = not inMenu
				ESX.UI.Menu.CloseAll()
				if(inMenu) then
					FreezeEntityPosition(PlayerPedId(), true)
					openMenu()
				else
					FreezeEntityPosition(PlayerPedId(), false)
					setPedSkin()
				end
			end
		else
			Citizen.Wait(3000)
		end
	end

end)


function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0*scale, 0.25*scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end






function openMenu()
	local elements = {}

	for _,k in pairs(tattoosCategories) do
		table.insert(elements, {label= k.name, value = k.value})
    end
    --table.insert(elements, {label=Config.TextRemoveTattoos .. " 	("..Config.TattooRemovePrice..Config.MoneySymbol..")", value = 'tattoo_remove', removePrice = Config.TattooRemovePrice})
--[[ 
	if(DoesCamExist(cam)) then
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
	end ]]

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'Tattoos_menu',
      {
        title    = 'Tatuagens',
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)
      	local currentLabel = data.current.label
        local currentValue = data.current.value
          
        --[[if (data.current.value == 'tattoo_remove') then

            local elements = {}
            table.insert(elements, {label=Config.TextRemoveTattoos .. " 	("..Config.TattooRemovePrice..Config.MoneySymbol..")", value = 'yes', removePrice = Config.TattooRemovePrice})
            ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'Tattoos_Delete_menu',
              {
                title = 'Supressão de tatuagens ('..Config.TattooRemovePrice..Config.MoneySymbol..')',
                align = 'top-left',
                elements = elements
              },
              function(data2, menu2)
                if data2.current.value == 'yes' then
                  menu2.close()
                  menu.close()
                  inMenu = false
                  FreezeEntityPosition(PlayerPedId(), false)
                  removePrice = Config.TattooRemovePrice
                  TriggerServerEvent("tattoos:delete", removePrice)
                  setPedRemoveSkin()
                  Citizen.Wait(1500)
                  ClearPedDecorations(PlayerPedId())
                end
              end
            )

        end ]]
        if(data.current.value ~= nil and data.current.value ~= 'tattoo_remove') then
      		elements = {}

      		--table.insert(elements, {label=Config.TextGoBackIntoMenu, value = nil})
      		for i,k in pairs(tattoosList[data.current.value]) do
      			table.insert(elements, {label= "Tatuagem n°"..i.."	("..k.price..Config.MoneySymbol..")", value = i, price = k.price})
            end

      		ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'Tattoos_Categories_menu',
				{
					title    = 'Tatuagem | '..currentLabel,
					align    = 'top-left',
					elements = elements,
				},
			function(data2, menu2)
				local price = data2.current.price
				if(data2.current.value ~= nil) then
                    TriggerServerEvent("tattoos:save", currentTattoos, price, {collection = currentValue, texture = data2.current.value})
                    Citizen.Wait(100)
                    setPedSkin()
				else
					openMenu()
--[[ 					RenderScriptCams(false, false, 0, 1, 0)
					DestroyCam(cam, false) ]]
					cleanPlayer()
				end

			end,
			function(data2, menu2)
			    menu2.close()
--[[ 			    RenderScriptCams(false, false, 0, 1, 0)
				DestroyCam(cam, false) ]]
				setPedSkin()
			end,
			function(data2,menu2)
				if(data2.current.value ~= nil) then
					drawTattoo(data2.current.value, currentValue)
				end
			end,
			function()

			end)

      	end

      end,
      function(data, menu)
        menu.close()
        setPedSkin()
      end
    )
end





function addBlips()
	for _,k in pairs(tattoosShops) do
		local blip = AddBlipForCoord(k.x, k.y, k.z)
		SetBlipSprite(blip, 75)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)
		SetBlipScale(blip, 0.6)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Loja Tatuagens")
		EndTextCommandSetBlipName(blip)
	end

end


function drawMarkers()
	for _,k in pairs(tattoosShops) do
		DrawMarker(27,k.x,k.y,k.z-0.9,0,0,0,0,0,0,3.001,3.0001,0.5001,0,155,255,200,0,0,0,0)
	end
end

function isNearTattoosShop()

	for _,k in pairs(tattoosShops) do
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), k.x,k.y,k.z, true)

		if(distance < 3) then
			return true
		end
	end

	return false
end



function setPedSkin()
	ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin, jobSkin)
        local model = nil

        if skin.sex == 0 then
          model = GetHashKey("mp_m_freemode_01")
        else
          model = GetHashKey("mp_f_freemode_01")
        end

        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(1)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
    end)

    Citizen.Wait(1500)

    for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
	end
end


function setPedRemoveSkin()
	ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin, jobSkin)
        local model = nil

        if skin.sex == 0 then
          model = GetHashKey("mp_m_freemode_01")
        else
          model = GetHashKey("mp_f_freemode_01")
        end

        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(1)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
    end)

    Citizen.Wait(1500)

end



function drawTattoo(current, collection)


	SetEntityHeading(PlayerPedId(), 297.7296)

	ClearPedDecorations(PlayerPedId())
	for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
	end

	if(GetEntityModel(PlayerPedId()) == -1667301416) then  -- GIRL SKIN
		SetPedComponentVariation(PlayerPedId(), 8, 34,0, 2)
		SetPedComponentVariation(PlayerPedId(), 3, 15,0, 2)
		SetPedComponentVariation(PlayerPedId(), 11, 101,1, 2)
		SetPedComponentVariation(PlayerPedId(), 4, 16,0, 2)
	else 													  -- BOY SKIN
		SetPedComponentVariation(PlayerPedId(), 8, 15,0, 2)
		SetPedComponentVariation(PlayerPedId(), 3, 15,0, 2)
		SetPedComponentVariation(PlayerPedId(), 11, 91,0, 2)
		SetPedComponentVariation(PlayerPedId(), 4, 14,0, 2)
	end



	ApplyPedOverlay(PlayerPedId(), GetHashKey(collection), GetHashKey(tattoosList[collection][current].nameHash))

--[[ 	if(not DoesCamExist(cam)) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
		SetCamRot(cam, 0.0, 0.0, 0.0)
		SetCamActive(cam,  true)
		RenderScriptCams(true,  false,  0,  true,  true)

		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
	end ]]

	--[[ local x,y,z = table.unpack(GetEntityCoords(PlayerPedId())) ]]

--[[ 	SetCamCoord(cam, x+tattoosList[collection][current].addedX, y+tattoosList[collection][current].addedY, z+tattoosList[collection][current].addedZ)
	SetCamRot(cam, 0.0, 0.0, tattoosList[collection][current].rotZ) ]]
end


function cleanPlayer()
	ClearPedDecorations(PlayerPedId())
	for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
	end
end


function Info(text, loop)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, loop, 1, 0)
end


RegisterNetEvent("tattoos:getPlayerTattoos")
AddEventHandler("tattoos:getPlayerTattoos", function(playerTattoosList)
	if playerTattoosList ~= nil then
		for _,k in pairs(playerTattoosList) do
			ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
		end
		currentTattoos = playerTattoosList
	else
		currentTattoos = nil
	end
end)



local firstLoad = false
AddEventHandler("skinchanger:loadSkin", function(skin)
	if(not firstLoad) then
		Citizen.CreateThread(function()

			while not (GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01")) do
				Citizen.Wait(10)
			end
			Citizen.Wait(750)
			TriggerServerEvent("tattoos:GetPlayerTattoos_s")
		end)
		firstLoad = true
	else
		Citizen.Wait(750)
		for _,k in pairs(currentTattoos) do
			ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
		end
	end
end)


RegisterNetEvent("tattoo:buySuccess")
AddEventHandler("tattoo:buySuccess", function(value)
	table.insert(currentTattoos, value)
end)