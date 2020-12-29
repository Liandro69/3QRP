cachedData = {}

MoneyCheck = function(money)
    local playerMoney = ESX.GetPlayerData()["money"]

    if playerMoney >= money then
        return true
    else
        return false
    end
end

HireBoat = function(Info, PartNum)
	HandleCamera(Info["Camera"])
	local elements = {}
	
	for k,v in ipairs(Config.Boats[PartNum]) do
		table.insert(elements, {label = v.label .. ' - [<span style="color:green;">' .. v.price .. '</span>]', props = {model = v.model, plate = v.plate}, price = v.price})
	end

	if #elements then
		SpawnLocalVehicle(elements[1]["props"], Info["SpawnPosition"], false, false)
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'BoatMenu', {
		title    = Info["Title"],
		align    = 'right',
		elements = elements
	},
	function(data, menu)
		menu.close()
		-- ResetSettings(cam)
		if MoneyCheck(data.current.price) then
			AlreadyHiringBoat = true
			TriggerServerEvent("tqrp_alugabarco:pay", data.current.price)
			SpawnVehicle(ESX.Game.GetVehicleProperties(Boat), Info["SpawnPosition"], true, false)
		else
			AdvancedNotification("Não tens dinheiro.")
		end
	end, function(data, menu)
		menu.close()
		DeleteEntity(Boat)
		ResetSettings(cam)
	end, function(data, menu)
		local currentVehicle = data.current.props

		if currentVehicle then
			SpawnLocalVehicle(currentVehicle, Info["SpawnPosition"], false, false)
		end
	end)
end

SpawnLocalVehicle = function(props, position)

	WaitForModel(props["model"])

	if DoesEntityExist(Boat) then
		DeleteEntity(Boat)
	end

	if not ESX.Game.IsSpawnPointClear(position["Coords"], 5.0) then 
		AdvancedNotification('~y~' .. _U('boathiring'), _U('blockingspawn'))

		return
	end

	RequestModel(props["model"])
	while not HasModelLoaded(props["model"]) do
		Citizen.Wait(1)
	end

	Boat = CreateVehicle(props["model"], position["Coords"]["x"], position["Coords"]["y"], position["Coords"]["z"], position["Heading"], false, true)
	ESX.Game.SetVehicleProperties(Boat, props)
end

SpawnVehicle = function(props, position)

	WaitForModel(props["model"])

	if DoesEntityExist(Boat) then
		DeleteEntity(Boat)
	end

	if not ESX.Game.IsSpawnPointClear(position["Coords"], 5.0) then 
		AdvancedNotification('~y~' .. _U('boathiring'), _U('blockingspawn'))

		return
	end

	RequestModel(props["model"])
	while not HasModelLoaded(props["model"]) do
		Citizen.Wait(1)
	end

	HiredBoat = CreateVehicle(props["model"], position["Coords"]["x"], position["Coords"]["y"], position["Coords"]["z"], position["Heading"], true, true)
	ESX.Game.SetVehicleProperties(Boat, props)
	TaskWarpPedIntoVehicle(PlayerPedId(), HiredBoat, -1)
end

WaitForModel = function(model)
    local DrawScreenText = function(text, red, green, blue, alpha)
        SetTextFont(6)
        SetTextScale(0.0, 0.5)
        SetTextColour(red, green, blue, alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(true)
    
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(0.5, 0.5)
    end

	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	
	while not HasModelLoaded(model) do
		Citizen.Wait(10)
		DrawScreenText(_U('loading') .. ' ' .. GetLabelText(GetDisplayNameFromVehicleModel(model)) .. "...", 255, 255, 255, 150)
	end
end

HandleCamera = function(v)
	FreezeEntityPosition(PlayerPedId(), true)
	
	if not v then 
		return
	end

	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

	SetCamCoord(cam, v["Pos"]["x"], v["Pos"]["y"], v["Pos"]["z"])
	SetCamRot(cam, v["Rotation"]["x"], v["Rotation"]["y"], v["Rotation"]["z"])
	SetCamActive(cam, true)

	RenderScriptCams(1, 1, 750, 1, 1)

	Citizen.Wait(1500)
end
	
ResetSettings = function(caminfo)
	FreezeEntityPosition(PlayerPedId(), false)
    DestroyCam(caminfo, false)
    RenderScriptCams(0, 1, 750, 1, 0)
end

AdvancedNotification = function(sub, Message)
	ESX.ShowAdvancedNotification(_U('Title'), sub, Message, 'CHAR_MP_FM_CONTACT', 1)
end
