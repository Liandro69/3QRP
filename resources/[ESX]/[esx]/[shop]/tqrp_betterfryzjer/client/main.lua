local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

RegisterNetEvent("welldone_wlosy:otworzWlosy")
AddEventHandler("welldone_wlosy:otworzWlosy", function()
	currentWlosy = {}
	TriggerEvent('skinchanger:getSkin', function(skin)
		if  tonumber(skin.sex) == 1 then
			OpenShopMenu2Female()
		elseif tonumber(skin.sex) < 1 or tonumber(skin.sex > 1) then
			OpenShopMenu2Male()
		end
	end)
end)

function OpenShopMenu2Male()
	wSklepie = true
	local elements = {}

	for _,k in pairs(Config.HairCategoriesMale) do
		table.insert(elements, {label= k.name, value = k.value})
	end

	if DoesCamExist(cam) then
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wlosyM_shop', {
		title    = 'Under Hair',
		align    = 'left',
		elements = elements
	}, function(data, menu)
		local currentLabel, currentValue = data.current.label, data.current.value

		if data.current.value ~= nil then
			elements = {}

			for i,k in pairs(Config.HairListMale[data.current.value]) do
				table.insert(elements, {
					label = 'Hair '..i..' - $'..ESX.Math.GroupDigits(k.price),
					value = i,
					price = k.price
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wlosyM_shop_categories', {
				title    = currentLabel,
				align    = 'left',
				elements = elements
			}, function(data2, menu2)
				local price = data2.current.price
				if data2.current.value ~= nil then

					ESX.TriggerServerCallback('welldonecenter_wlosy:purchaseHair', function(success)
						if success then
							table.insert(currentWlosy, {collection = currentValue, texture = data2.current.value})
						end
					end, currentWlosy, price, {collection = currentValue, texture = data2.current.value})
					TriggerEvent("welldone_wlosy:dodaj")

				else
					OpenShopMenu2Male()
					RenderScriptCams(false, false, 0, 1, 0)
					DestroyCam(cam, false)
					cleanPlayer()
					Citizen.Wait(1500)
					TriggerEvent("welldone_wlosy:dodaj")
				end

			end, function(data2, menu2)
				menu2.close()
				RenderScriptCams(false, false, 0, 1, 0)
				DestroyCam(cam, false)
				setPedSkinMale()
				wSklepie = false
			end, function(data2, menu2)
				if data2.current.value ~= nil then
					drawHairMale(data2.current.value, currentValue)
				end
			end)
		end
	end, function(data, menu)
		menu.close()
		setPedSkinMale()
		wSklepie = false
	end)
end

function OpenShopMenu2Female()
	wSklepie = true
	local elements = {}

	for _,k in pairs(Config.HairCategoriesFemale) do
		table.insert(elements, {label= k.name, value = k.value})
	end
	if DoesCamExist(cam) then
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wlosyF_shop', {
		title    = 'Podkład Włosów',
		align    = 'left',
		elements = elements
	}, function(data, menu)
		local currentLabel, currentValue = data.current.label, data.current.value

		if data.current.value ~= nil then
			elements = {}

			for i,k in pairs(Config.HairListFemale[data.current.value]) do
				table.insert(elements, {
					label = '$'..ESX.Math.GroupDigits(k.price),
					value = i,
					price = k.price
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wlosyF_shop_categories', {
				title    = currentLabel,
				align    = 'left',
				elements = elements
			}, function(data2, menu2)
				local price = data2.current.price
				if data2.current.value ~= nil then

					Citizen.Wait(2500)
					ESX.TriggerServerCallback('welldonecenter_wlosy:purchaseHair', function(success)
						if success then
							table.insert(currentWlosy, {collection = currentValue, texture = data2.current.value})
						end
					end, currentWlosy, price, {collection = currentValue, texture = data2.current.value})
					TriggerEvent("welldone_wlosy:dodaj")
				else
					OpenShopMenu2Female()
					RenderScriptCams(false, false, 0, 1, 0)
					DestroyCam(cam, false)
					cleanPlayer()
					Citizen.Wait(1500)
					TriggerEvent("welldone_wlosy:dodaj")
				end

			end, function(data2, menu2)
				menu2.close()
				RenderScriptCams(false, false, 0, 1, 0)
				DestroyCam(cam, false)
				setPedSkinFemale()
				wSklepie = false
			end, function(data2, menu2)
				if data2.current.value ~= nil then
					drawHairFemale(data2.current.value, currentValue)
				end
			end)
		end
	end, function(data, menu)
		menu.close()
		setPedSkinFemale()
		wSklepie = false
	end)
end

function setPedSkinMale()
	ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

	Citizen.Wait(1500)

	for _,k in pairs(currentWlosy) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.HairListMale[k.collection][k.texture].nameHash))
	end
	TriggerEvent("welldone_wlosy:dodaj")
end

function setPedSkinFemale()
	ESX.TriggerServerCallback('tqrp_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

	Citizen.Wait(1500)

	for _,k in pairs(currentWlosy) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.HairListFemale[k.collection][k.texture].nameHash))
	end
	TriggerEvent("welldone_wlosy:dodaj")
end

function drawHairMale(current, collection)
	SetEntityHeading(PlayerPedId(), 297.7296)

	for _,k in pairs(currentWlosy) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.HairListMale[k.collection][k.texture].nameHash))
	end

	TriggerEvent('skinchanger:loadSkin', {
		sex      = 1,
		tshirt_1 = 14,
		tshirt_2 = 0,
		arms     = 15,
		arms_2	 = 0,
		torso_1  = 82,
		torso_2  = 0,
		pants_1  = 17,
		pants_2  = 0,
		hat 	 = -1
	})

	ApplyPedOverlay(PlayerPedId(), GetHashKey(collection), GetHashKey(Config.HairListMale[collection][current].nameHash))

	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
		SetCamRot(cam, 0.0, 0.0, 0.0)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 0, true, true)
		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
	end

	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

	SetCamCoord(cam, x + Config.HairListMale[collection][current].addedX, y + Config.HairListMale[collection][current].addedY, z + Config.HairListMale[collection][current].addedZ)
	SetCamRot(cam, 0.0, 0.0, Config.HairListMale[collection][current].rotZ)
end

function drawHairFemale(current, collection)
	SetEntityHeading(PlayerPedId(), 297.7296)

	for _,k in pairs(currentWlosy) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.HairListFemale[k.collection][k.texture].nameHash))
	end

	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadSkin', {
				sex      = 0,
				tshirt_1 = 15,
				tshirt_2 = 0,
				arms     = 15,
				arms_2	 = 0,
				torso_1  = 91,
				torso_2  = 0,
				pants_1  = 14,
				pants_2  = 0,
				hat 	 = -1
			})
		else
			TriggerEvent('skinchanger:loadSkin', {
				sex      = 1,
				tshirt_1 = 14,
				tshirt_2 = 0,
				arms     = 15,
				arms_2	 = 0,
				torso_1  = 82,
				torso_2  = 0,
				pants_1  = 17,
				pants_2  = 0,
				hat 	 = -1
			})
		end
	end)

	ApplyPedOverlay(PlayerPedId(), GetHashKey(collection), GetHashKey(Config.HairListFemale[collection][current].nameHash))

	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
		SetCamRot(cam, 0.0, 0.0, 0.0)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 0, true, true)
		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
	end

	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

	SetCamCoord(cam, x + Config.HairListFemale[collection][current].addedX, y + Config.HairListFemale[collection][current].addedY, z + Config.HairListFemale[collection][current].addedZ)
	SetCamRot(cam, 0.0, 0.0, Config.HairListFemale[collection][current].rotZ)
end

function cleanPlayer()
	for _,k in pairs(currentWlosy) do
		TriggerEvent('skinchanger:getSkin', function(skin)
			if  tonumber(skin.sex) == 1 then
				ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.HairListFemale[k.collection][k.texture].nameHash))
			elseif tonumber(skin.sex) < 1 or tonumber(skin.sex > 1) then
				ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.HairListMale[k.collection][k.texture].nameHash))
			end
		end)
	end
end