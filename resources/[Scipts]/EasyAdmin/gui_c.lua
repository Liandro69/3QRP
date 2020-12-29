------------------------------------
------------------------------------
---- DONT TOUCH ANY OF THIS IF YOU DON'T KNOW WHAT YOU ARE DOING
---- THESE ARE **NOT** CONFIG VALUES, USE THE CONVARS IF YOU WANT TO CHANGE SOMETHING
------------------------------------
------------------------------------

isAdmin = false
showLicenses = false

config = {
    controls = {
        -- [[Controls, list can be found here : https://docs.fivem.net/game-references/controls/]]
        openKey = 288, -- [[F2]]
        goUp = 85, -- [[Q]]
        goDown = 38, -- [[E]]
        turnLeft = 34, -- [[A]]
        turnRight = 35, -- [[D]]
        goForward = 32,  -- [[W]]
        goBackward = 33, -- [[S]]
        changeSpeed = 21, -- [[L-Shift]]
    },

    speeds = {
        -- [[If you wish to change the speeds or labels there are associated with then here is the place.]]
        { label = "Very Slow", speed = 0},
        { label = "Slow", speed = 0.5},
        { label = "Normal", speed = 2},
        { label = "Fast", speed = 4},
        { label = "Very Fast", speed = 6},
        { label = "Extremely Fast", speed = 10},
        { label = "Extremely Fast v2.0", speed = 20},
        { label = "Max Speed", speed = 25}
    },

    offsets = {
        y = 0.5, -- [[How much distance you move forward and backward while the respective button is pressed]]
        z = 0.2, -- [[How much distance you move upward and downward while the respective button is pressed]]
        h = 3, -- [[How much you rotate. ]]
    },

    -- [[Background colour of the buttons. (It may be the standard black on first opening, just re-opening.)]]
    bgR = 0, -- [[Red]]
    bgG = 0, -- [[Green]]
    bgB = 0, -- [[Blue]]
    bgA = 80, -- [[Alpha]]
}

local noclipActive = false
local coordsOnScreen = false
local playerBlipActive = false
local headNamesActive = false
index = 1 -- [[Used to determine the index of the speeds table.]]

settings = {
	button = 289,
	forceShowGUIButtons = false,
}

permissions = {
	ban = false,
	kick = false,
	spectate = false,
	unban = false,
	teleport = false,
	manageserver = false,
	slap = false,
	freeze = false,
	screenshot = false,
	immune = false,
	anon = false,
	blips = false,
	mute = false,
}

_menuPool = NativeUI.CreatePool()

-- generate "slap" table once
local SlapAmount = {}
for i=1,20 do
	table.insert(SlapAmount,i)
end

function handleOrientation(orientation)
	if orientation == "right" then
		return 1320
	elseif orientation == "middle" then
		return 730
	elseif orientation == "left" then
		return 0
	end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	TriggerServerEvent("EasyAdmin:amiadmin")
end)

Citizen.CreateThread(function()
	TriggerServerEvent("EasyAdmin:amiadmin")
	TriggerServerEvent("EasyAdmin:requestBanlist")
	TriggerServerEvent("EasyAdmin:requestCachedPlayers")
	if not GetResourceKvpString("ea_menuorientation") then
		SetResourceKvp("ea_menuorientation", "right")
		SetResourceKvpInt("ea_menuwidth", 0)
		menuWidth = 0
		menuOrientation = handleOrientation("right")
	else
		menuWidth = GetResourceKvpInt("ea_menuwidth")
		menuOrientation = handleOrientation(GetResourceKvpString("ea_menuorientation"))
	end 
	mainMenu = NativeUI.CreateMenu("EasyAdmin", "~b~Admin Menu", menuOrientation, 0)
	_menuPool:Add(mainMenu)
	
	mainMenu:SetMenuWidthOffset(menuWidth)	
	_menuPool:ControlDisablingEnabled(false)
	_menuPool:MouseControlsEnabled(false)
	
		
	while true do
		if isAdmin == true then --M by default	
			if _menuPool and _menuPool:IsAnyMenuOpen() then
				_menuPool:ProcessMenus()
			end
			if (IsControlJustReleased(0, settings.button) and GetLastInputMethod( 0 ) ) then
				if strings then
					banLength = {
						{label = GetLocalisedText("permanent"), time = 10444633200},
						{label = GetLocalisedText("oneday"), time = 86400},
						{label = GetLocalisedText("threedays"), time = 259200},
						{label = GetLocalisedText("oneweek"), time = 518400},
						{label = GetLocalisedText("twoweeks"), time = 1123200},
						{label = GetLocalisedText("onemonth"), time = 2678400},
						{label = GetLocalisedText("oneyear"), time = 31536000},
					}
					if mainMenu:Visible() then
						mainMenu:Visible(false)
						_menuPool:Remove()
					else
						GenerateMenu()
						mainMenu:Visible(true)
					end
				end
			end
		else
			Citizen.Wait(5000)
		end
		
		Citizen.Wait(7)
	end
end)

function DrawPlayerInfo(target)
	drawTarget = target
	drawInfo = true
end

function StopDrawPlayerInfo()
	drawInfo = false
	drawTarget = 0
end

local banlistPage = 1
function GenerateMenu() -- this is a big ass function
	TriggerServerEvent("EasyAdmin:requestCachedPlayers")
	_menuPool:Remove()
	_menuPool = NativeUI.CreatePool()
	if not GetResourceKvpString("ea_menuorientation") then
		SetResourceKvp("ea_menuorientation", "right")
		SetResourceKvpInt("ea_menuwidth", 0)
		menuWidth = 0
		menuOrientation = handleOrientation("right")
	else
		menuWidth = GetResourceKvpInt("ea_menuwidth")
		menuOrientation = handleOrientation(GetResourceKvpString("ea_menuorientation"))
	end 
	
	mainMenu = NativeUI.CreateMenu("EasyAdmin", "~b~Admin Menu", menuOrientation, 0)
	_menuPool:Add(mainMenu)
	
	mainMenu:SetMenuWidthOffset(menuWidth)	
	_menuPool:ControlDisablingEnabled(false)
	_menuPool:MouseControlsEnabled(false)
	
	playermanagement = _menuPool:AddSubMenu(mainMenu, GetLocalisedText("playermanagement"),"",true)
	servermanagement = _menuPool:AddSubMenu(mainMenu, GetLocalisedText("servermanagement"),"",true)
	settingsMenu = _menuPool:AddSubMenu(mainMenu, GetLocalisedText("settings"),"",true)

	mainMenu:SetMenuWidthOffset(menuWidth)	
	playermanagement:SetMenuWidthOffset(menuWidth)	
	servermanagement:SetMenuWidthOffset(menuWidth)	
	settingsMenu:SetMenuWidthOffset(menuWidth)	

	-- util stuff
	players = {}
	local localplayers = {}
	for _, i in ipairs(GetActivePlayers()) do
		table.insert( localplayers, GetPlayerServerId(i) )
	end
	table.sort(localplayers)
	for i,thePlayer in ipairs(localplayers) do
		table.insert(players,GetPlayerFromServerId(thePlayer))
	end

	for i,thePlayer in ipairs(players) do
		thisPlayer = _menuPool:AddSubMenu(playermanagement,"["..GetPlayerServerId(thePlayer).."] "..GetPlayerName(thePlayer),"",true)
		thisPlayer:SetMenuWidthOffset(menuWidth)
		-- generate specific menu stuff, dirty but it works for now
		if permissions.kick then
			local thisKickMenu = _menuPool:AddSubMenu(thisPlayer,GetLocalisedText("kickplayer"),"",true)
			thisKickMenu:SetMenuWidthOffset(menuWidth)
			
			local thisItem = NativeUI.CreateItem(GetLocalisedText("reason"),GetLocalisedText("kickreasonguide"))
			thisKickMenu:AddItem(thisItem)
			KickReason = GetLocalisedText("noreason")
			thisItem:RightLabel(KickReason)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 128 + 1)
				
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					
					Citizen.Wait( 0 )
				end
				
				local result = GetOnscreenKeyboardResult()
				
				if result and result ~= "" then
					KickReason = result
					thisItem:RightLabel(result) -- this is broken for now
				else
					KickReason = GetLocalisedText("noreason")
				end
			end
			
			local thisItem = NativeUI.CreateItem(GetLocalisedText("confirmkick"),GetLocalisedText("confirmkickguide"))
			thisKickMenu:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				if KickReason == "" then
					KickReason = GetLocalisedText("noreason")
				end
				TriggerServerEvent("EasyAdmin:kickPlayer", GetPlayerServerId( thePlayer ), KickReason)
				BanTime = 1
				BanReason = ""
				_menuPool:CloseAllMenus() print("asd")
				Citizen.Wait(800)
				GenerateMenu()
				playermanagement:Visible(true)
			end	
		end
		
		if permissions.ban then
			local thisBanMenu = _menuPool:AddSubMenu(thisPlayer,GetLocalisedText("banplayer"),"",true)
			thisBanMenu:SetMenuWidthOffset(menuWidth)
			
			local thisItem = NativeUI.CreateItem(GetLocalisedText("reason"),GetLocalisedText("banreasonguide"))
			thisBanMenu:AddItem(thisItem)
			BanReason = GetLocalisedText("noreason")
			thisItem:RightLabel(BanReason)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 128 + 1)
				
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait( 0 )
					
				end
				
				local result = GetOnscreenKeyboardResult()
				
				if result and result ~= "" then
					BanReason = result
					thisItem:RightLabel(result) -- this is broken for now
				else
					BanReason = GetLocalisedText("noreason")
				end
			end

			local bt = {}
			for i,a in ipairs(banLength) do
				table.insert(bt, a.label)
			end
			
			local thisItem = NativeUI.CreateListItem(GetLocalisedText("banlength"),bt, 1,GetLocalisedText("banlengthguide") )
			thisBanMenu:AddItem(thisItem)
			local BanTime = 1
			thisItem.OnListChanged = function(sender,item,index)
				BanTime = index
			end
		
			local thisItem = NativeUI.CreateItem(GetLocalisedText("confirmban"),GetLocalisedText("confirmbanguide"))
			thisBanMenu:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				if BanReason == "" then
					BanReason = GetLocalisedText("noreason")
				end
				TriggerServerEvent("EasyAdmin:banPlayer", GetPlayerServerId( thePlayer ), BanReason, banLength[BanTime].time, GetPlayerName( thePlayer ))
				BanTime = 1
				BanReason = ""
				_menuPool:CloseAllMenus() print("asd")
				Citizen.Wait(800)
				GenerateMenu()
				playermanagement:Visible(true)
			end	
			
		end
		
		if permissions.mute then			
			local thisItem = NativeUI.CreateItem(GetLocalisedText("mute"),GetLocalisedText("muteguide"))
			thisPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				TriggerServerEvent("EasyAdmin:mutePlayer", GetPlayerServerId( thePlayer ))
			end
		end

		if permissions.spectate then
			local thisItem = NativeUI.CreateItem(GetLocalisedText("spectateplayer"), "")
			thisPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				TriggerServerEvent("EasyAdmin:requestSpectate",GetPlayerServerId(thePlayer))
			end
		end
		
		if permissions.teleport then
			local thisItem = NativeUI.CreateItem(GetLocalisedText("teleporttoplayer"),"")
			thisPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(thePlayer),true))
				local heading = GetEntityHeading(GetPlayerPed(player))
				SetEntityCoords(PlayerPedId(), x,y,z,0,0,heading, false)
			end
		end
		
		if permissions.teleport then
			local thisItem = NativeUI.CreateItem(GetLocalisedText("teleportplayertome"),"")
			thisPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				local px,py,pz = table.unpack(GetEntityCoords(PlayerPedId(),true))
				TriggerServerEvent("EasyAdmin:TeleportPlayerToCoords", GetPlayerServerId(thePlayer), px,py,pz)
			end
		end
		
		if permissions.slap then
			local thisItem = NativeUI.CreateSliderItem(GetLocalisedText("slapplayer"), SlapAmount, 20, false, false)
			thisPlayer:AddItem(thisItem)
			thisItem.OnSliderSelected = function(index)
				TriggerServerEvent("EasyAdmin:SlapPlayer", GetPlayerServerId(thePlayer), index*10)
			end
		end

		if permissions.freeze then
			local sl = {GetLocalisedText("on"), GetLocalisedText("off")}
			local thisItem = NativeUI.CreateListItem(GetLocalisedText("setplayerfrozen"), sl, 1)
			thisPlayer:AddItem(thisItem)
			thisPlayer.OnListSelect = function(sender, item, index)
					if item == thisItem then
							i = item:IndexToItem(index)
							if i == GetLocalisedText("on") then
								TriggerServerEvent("EasyAdmin:FreezePlayer", GetPlayerServerId(thePlayer), true)
							else
								TriggerServerEvent("EasyAdmin:FreezePlayer", GetPlayerServerId(thePlayer), false)
							end
					end
			end
		end
	
		if permissions.screenshot then
			local thisItem = NativeUI.CreateItem(GetLocalisedText("takescreenshot"),"")
			thisPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				TriggerServerEvent("EasyAdmin:TakeScreenshot", GetPlayerServerId(thePlayer))
			end
		end
		
		_menuPool:ControlDisablingEnabled(false)
		_menuPool:MouseControlsEnabled(false)
	end
	
	thisPlayer = _menuPool:AddSubMenu(playermanagement,GetLocalisedText("allplayers"),"",true)
	thisPlayer:SetMenuWidthOffset(menuWidth)
	if permissions.teleport then
		-- "all players" function
		local thisItem = NativeUI.CreateItem(GetLocalisedText("teleporttome"), GetLocalisedText("teleporttomeguide"))
		thisPlayer:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			local px,py,pz = table.unpack(GetEntityCoords(PlayerPedId(),true))
			TriggerServerEvent("EasyAdmin:TeleportPlayerToCoords", -1, px,py,pz)
		end
	end

	CachedList = _menuPool:AddSubMenu(playermanagement,GetLocalisedText("cachedplayers"),"",true)
	CachedList:SetMenuWidthOffset(menuWidth)
	if permissions.ban then
		for i, cachedplayer in pairs(cachedplayers) do
			if cachedplayer.droppedTime then
				thisPlayer = _menuPool:AddSubMenu(CachedList,"["..cachedplayer.id.."] "..cachedplayer.name,"",true)
				thisPlayer:SetMenuWidthOffset(menuWidth)
				local thisBanMenu = _menuPool:AddSubMenu(thisPlayer,GetLocalisedText("banplayer"),"",true)
				thisBanMenu:SetMenuWidthOffset(menuWidth)
				
				local thisItem = NativeUI.CreateItem(GetLocalisedText("reason"),GetLocalisedText("banreasonguide"))
				thisBanMenu:AddItem(thisItem)
				BanReason = GetLocalisedText("noreason")
				thisItem:RightLabel(BanReason)
				thisItem.Activated = function(ParentMenu,SelectedItem)
					DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 128 + 1)
					
					while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
						
						Citizen.Wait( 0 )
					end
					
					local result = GetOnscreenKeyboardResult()
					
					if result and result ~= "" then
						BanReason = result
						thisItem:RightLabel(result) -- this is broken for now
					else
						BanReason = GetLocalisedText("noreason")
					end
				end
				local bt = {}
				for i,a in ipairs(banLength) do
					table.insert(bt, a.label)
				end
				
				local thisItem = NativeUI.CreateListItem(GetLocalisedText("banlength"),bt, 1,GetLocalisedText("banlengthguide") )
				thisBanMenu:AddItem(thisItem)
				local BanTime = 1
				thisItem.OnListChanged = function(sender,item,index)
					BanTime = index
				end
			
				local thisItem = NativeUI.CreateItem(GetLocalisedText("confirmban"),GetLocalisedText("confirmbanguide"))
				thisBanMenu:AddItem(thisItem)
				thisItem.Activated = function(ParentMenu,SelectedItem)
					if BanReason == "" then
						BanReason = GetLocalisedText("noreason")
					end
					TriggerServerEvent("EasyAdmin:offlinebanPlayer", cachedplayer.id, BanReason, banLength[BanTime].time, cachedplayer.name)
					BanTime = 1
					BanReason = ""
					_menuPool:CloseAllMenus() print("asd")
					Citizen.Wait(800)
					GenerateMenu()
					playermanagement:Visible(true)
				end	
			end
		end
	end

	if permissions.manageserver then
		local thisItem = NativeUI.CreateItem(GetLocalisedText("setgametype"), GetLocalisedText("setgametypeguide"))
		servermanagement:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 32 + 1)
			
			while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
				
				Citizen.Wait( 0 )
			end
			
			local result = GetOnscreenKeyboardResult()
			
			if result then
				TriggerServerEvent("EasyAdmin:SetGameType", result)
			end
		end
		
		local thisItem = NativeUI.CreateItem(GetLocalisedText("setmapname"), GetLocalisedText("setmapnameguide"))
		servermanagement:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 32 + 1)
			
			while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
				
				Citizen.Wait( 0 )
			end
			
			local result = GetOnscreenKeyboardResult()
			
			if result then
				TriggerServerEvent("EasyAdmin:SetMapName", result)
			end
		end
		
		local thisItem = NativeUI.CreateItem(GetLocalisedText("startresourcebyname"), GetLocalisedText("startresourcebynameguide"))
		servermanagement:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 32 + 1)
			
			while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
				
				Citizen.Wait( 0 )
			end
			
			local result = GetOnscreenKeyboardResult()
			
			if result then
				TriggerServerEvent("EasyAdmin:StartResource", result)
			end
		end
		
		local thisItem = NativeUI.CreateItem(GetLocalisedText("stopresourcebyname"), GetLocalisedText("stopresourcebynameguide"))
		servermanagement:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 32 + 1)
			
			while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
				
				Citizen.Wait( 0 )
			end
			
			local result = GetOnscreenKeyboardResult()
			
			if result then
				if result ~= GetCurrentResourceName() and result ~= "NativeUI" then
					TriggerServerEvent("EasyAdmin:StopResource", result)
				else
					TriggerEvent("chat:addMessage", { args = { "EasyAdmin", GetLocalisedText("badidea") } })
				end
			end
		end
		
	end
	
	if permissions.unban then
		unbanPlayer = _menuPool:AddSubMenu(servermanagement,GetLocalisedText("unbanplayer"),"",true)
		unbanPlayer:SetMenuWidthOffset(menuWidth)
		local reason = ""
		local identifier = ""

		for i,theBanned in ipairs(banlist) do
			if i<(banlistPage*10)+1 and i>(banlistPage*10)-10 then
				if theBanned then
					reason = theBanned.reason or "No Reason"
					local thisItem = NativeUI.CreateItem(reason, GetLocalisedText("unbanplayerguide"))
					unbanPlayer:AddItem(thisItem)
					thisItem.Activated = function(ParentMenu,SelectedItem)
						TriggerServerEvent("EasyAdmin:unbanPlayer", theBanned.banid)
						TriggerServerEvent("EasyAdmin:requestBanlist")
						_menuPool:CloseAllMenus() print("asd")
						Citizen.Wait(800)
						GenerateMenu()
						unbanPlayer:Visible(true)
					end	
				end
			end
		end


		if #banlist > (banlistPage*10) then 
			local thisItem = NativeUI.CreateItem(GetLocalisedText("lastpage"), "")
			unbanPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				banlistPage = math.ceil(#banlist/10)
				_menuPool:CloseAllMenus() print("asd")
				Citizen.Wait(300)
				GenerateMenu()
				unbanPlayer:Visible(true)
			end	
		end

		if banlistPage>1 then 
			local thisItem = NativeUI.CreateItem(GetLocalisedText("firstpage"), "")
			unbanPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				banlistPage = 1
				_menuPool:CloseAllMenus() print("asd")
				Citizen.Wait(300)
				GenerateMenu()
				unbanPlayer:Visible(true)
			end	
			local thisItem = NativeUI.CreateItem(GetLocalisedText("previouspage"), "")
			unbanPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				banlistPage=banlistPage-1
				_menuPool:CloseAllMenus() print("asd")
				Citizen.Wait(300)
				GenerateMenu()
				unbanPlayer:Visible(true)
			end	
		end
		if #banlist > (banlistPage*10) then
			local thisItem = NativeUI.CreateItem(GetLocalisedText("nextpage"), "")
			unbanPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				banlistPage=banlistPage+1
				_menuPool:CloseAllMenus() print("asd")
				Citizen.Wait(300)
				GenerateMenu()
				unbanPlayer:Visible(true)
			end	
		end 


	end

	if permissions.unban then
		local sl = {GetLocalisedText("unbanreasons"), GetLocalisedText("unbanlicenses")}
		local thisItem = NativeUI.CreateListItem(GetLocalisedText("banlistshowtype"), sl, 1,GetLocalisedText("banlistshowtypeguide"))
		settingsMenu:AddItem(thisItem)
		settingsMenu.OnListChange = function(sender, item, index)
				if item == thisItem then
						i = item:IndexToItem(index)
						if i == GetLocalisedText(unbanreasons) then
							showLicenses = false
						else
							showLicenses = true
						end
				end
		end
	end	
	
	if permissions.unban then
		local thisItem = NativeUI.CreateItem(GetLocalisedText("refreshbanlist"), GetLocalisedText("refreshbanlistguide"))
		settingsMenu:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			TriggerServerEvent("EasyAdmin:updateBanlist")
		end
	end

	if permissions.ban then
		local thisItem = NativeUI.CreateItem(GetLocalisedText("refreshcachedplayers"), GetLocalisedText("refreshcachedplayersguide"))
		settingsMenu:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			TriggerServerEvent("EasyAdmin:requestCachedPlayers")
		end
	end
	
	local thisItem = NativeUI.CreateItem(GetLocalisedText("refreshpermissions"), GetLocalisedText("refreshpermissionsguide"))
	settingsMenu:AddItem(thisItem)
	thisItem.Activated = function(ParentMenu,SelectedItem)
		TriggerServerEvent("amiadmin")
	end
	
	local sl = {GetLocalisedText("left"), GetLocalisedText("middle"), GetLocalisedText("right")}
	local thisItem = NativeUI.CreateListItem(GetLocalisedText("menuOrientation"), sl, 1, GetLocalisedText("menuOrientationguide"))
	settingsMenu:AddItem(thisItem)
	settingsMenu.OnListChange = function(sender, item, index)
			if item == thisItem then
					i = item:IndexToItem(index)
					if i == GetLocalisedText("left") then
						SetResourceKvp("ea_menuorientation", "left")
					elseif i == GetLocalisedText("middle") then
						SetResourceKvp("ea_menuorientation", "middle")
					else
						SetResourceKvp("ea_menuorientation", "right")
					end
			end
	end
	local sl = {}
	for i=0,150,10 do
		table.insert(sl,i)
	end
	local thisi = 0
	for i,a in ipairs(sl) do
		if menuWidth == a then
			thisi = i
		end
	end
	local thisItem = NativeUI.CreateSliderItem(GetLocalisedText("menuOffset"), sl, thisi, GetLocalisedText("menuOffsetguide"), false)
	settingsMenu:AddItem(thisItem)
	thisItem.OnSliderSelected = function(index)
		i = thisItem:IndexToItem(index)
		SetResourceKvpInt("ea_menuwidth", i)
		menuWidth = i
	end
	thisi = nil
	sl = nil


	local thisItem = NativeUI.CreateItem(GetLocalisedText("resetmenuOffset"), "")
	settingsMenu:AddItem(thisItem)
	thisItem.Activated = function(ParentMenu,SelectedItem)
		SetResourceKvpInt("ea_menuwidth", 0)
		menuWidth = 0
	end
	
	if permissions.anon then
		local thisItem = NativeUI.CreateCheckboxItem(GetLocalisedText("anonymous"), anonymous or false, GetLocalisedText("anonymousguide"))
		settingsMenu:AddItem(thisItem)
		settingsMenu.OnCheckboxChange = function(sender, item, checked_)
			if item == thisItem then
				anonymous = checked_
				TriggerServerEvent("EasyAdmin:SetAnonymous", checked_)
			end
		end
	end
	
	--===== NO-CLIP =====--
	local NoclipItem = NativeUI.CreateCheckboxItem(GetLocalisedText("NoClip"), noclipActive, GetLocalisedText("NoClip"))
	NoclipItem.checked_ = noclipActive
	settingsMenu:AddItem(NoclipItem)

	--===== PLAYERBLIPS =====--
	local ActivateplayerItem = NativeUI.CreateCheckboxItem(GetLocalisedText("PlayerBlips"), playerBlipActive, GetLocalisedText("PlayerBlips"))
	settingsMenu:AddItem(ActivateplayerItem)

	--===== COORDS =====--
	local coordItem = NativeUI.CreateCheckboxItem(GetLocalisedText("coordsOnScreen"), coordsOnScreen, GetLocalisedText("coordsOnScreen"))
	settingsMenu:AddItem(coordItem)
	settingsMenu.OnCheckboxChange = function(sender, item, checked_)

		if item == coordItem then
			coordsOnScreen = checked_
			if coordsOnScreen then
				activateCoords()
			end
		elseif item == NoclipItem then
			noclipActive = checked_
			if noclipActive then
				activateNoclip()
			end
		elseif item == ActivateplayerItem then
			playerBlipActive = checked_
			if playerBlipActive then
				playerBlips()
			end
		end
	end

	--===== TP WAYPOINT =====--
	local tpWaypointItem = NativeUI.CreateItem(GetLocalisedText("tpWaypoint"), "")
	settingsMenu:AddItem(tpWaypointItem)
	tpWaypointItem.Activated = function(ParentMenu,SelectedItem)
		d2()
	end

	--===== CLEAR AREA =====--
	local ClearAreaItem = NativeUI.CreateItem(GetLocalisedText("ClearAreaItem"), "")
	settingsMenu:AddItem(ClearAreaItem)
	ClearAreaItem.Activated = function(ParentMenu,SelectedItem)
		local coords = GetEntityCoords(PlayerPedId())
		ClearAreaOfEverything(coords.x, coords.y, coords.z, 50.0, false, false, false, false)
	end
	
	--===== FIX ENGINE =====--
	local fixEngine = NativeUI.CreateItem(GetLocalisedText("fixEngine"), "")
	settingsMenu:AddItem(fixEngine)
	fixEngine.Activated = function(ParentMenu,SelectedItem)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		else
			local coords = GetEntityCoords(PlayerPedId())
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			SetVehicleEngineHealth(vehicle, 1000)
			SetVehicleEngineOn( vehicle, true, true )
			while  GetVehicleEngineHealth(vehicle) < 999.0 do
				SetVehicleEngineHealth(vehicle, 1000)
				SetVehicleEngineOn(vehicle, true, true)
				Citizen.Wait(0)
			end
			--SetVehicleFixed(vehicle)
		end
	end

	--===== FIX ALL =====--
	local FixALL = NativeUI.CreateItem(GetLocalisedText("FixALL"), "")
	settingsMenu:AddItem(FixALL)
	FixALL.Activated = function(ParentMenu,SelectedItem)
		SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId(), false))
	end

	--===== MAX FUEL =====--
	local MaxFuel = NativeUI.CreateItem(GetLocalisedText("MaxFuel"), "")
	settingsMenu:AddItem(MaxFuel)
	MaxFuel.Activated = function(ParentMenu,SelectedItem)
		exports["tqrp_base"]:SetFuel(GetVehiclePedIsIn(PlayerPedId(), false), 100)
	end

	_menuPool:ControlDisablingEnabled(false)
	_menuPool:MouseControlsEnabled(false)
	
	_menuPool:RefreshIndex() -- refresh indexes
end


function d2() 
	if DoesBlipExist(GetFirstBlipInfoId(8)) then
		 local d3 = GetBlipInfoIdIterator(8) 
		 local blip = GetFirstBlipInfoId(8, d3) WaypointCoords = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector()) wp = true
	end;
	local d4 = 0.0;
	height = 1000.0;
	while wp do
		Citizen.Wait(10) 
		if wp then
			if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1) then 
				entity = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
			else 
				entity = GetPlayerPed(-1) 
			end;
			SetEntityCoords(entity, WaypointCoords.x, WaypointCoords.y, height) FreezeEntityPosition(entity, true) local d5 = GetEntityCoords(entity, true) 
			if d4 == 0.0 then 
				height = height - 25.0;
				SetEntityCoords(entity, d5.x, d5.y, height) bool, d4 = GetGroundZFor_3dCoord(d5.x, d5.y, d5.z, 0)
			else SetEntityCoords(entity, d5.x, d5.y, d4) FreezeEntityPosition(entity, false) wp = false;
				height = 1000.0;
				d4 = 0.0;
				break 
			end 
		end 
	end 
end;

function DrawTxt(text, x, y)
	SetTextFont(6)
	SetTextProportional(1)
	SetTextScale(0.0, 0.3)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

function activateCoords()
	Citizen.CreateThread(function()
		while coordsOnScreen do
			Citizen.Wait(7)
			ply = PlayerPedId()
			local entity = IsPedInAnyVehicle(ply) and GetVehiclePedIsIn(ply, false) or PlayerPedId()
			x, y, z = table.unpack(GetEntityCoords(entity, true))
			
			roundx = tonumber(string.format("%.2f", x))
			roundy = tonumber(string.format("%.2f", y))
			roundz = tonumber(string.format("%.2f", z))
			
			DrawTxt("~r~X:~s~ "..roundx, 0.05, 0.950)
			DrawTxt("~r~Y:~s~ "..roundy, 0.10, 0.950)
			DrawTxt("~r~Z:~s~ "..roundz, 0.15, 0.950)
	
			heading = GetEntityHeading(entity)
			roundh = tonumber(string.format("%.2f", heading))
			DrawTxt("~r~H:~s~ "..roundh, 0.20, 0.950)
	
			local rx,ry,rz = table.unpack(GetEntityRotation(ply, 1))
			DrawTxt("~r~RX:~s~ "..tonumber(string.format("%.2f", rx)), 0.25, 0.950)
			DrawTxt("~r~RY:~s~ "..tonumber(string.format("%.2f", ry)), 0.30, 0.950)
			DrawTxt("~r~RZ:~s~ "..tonumber(string.format("%.2f", rz)), 0.35, 0.950)
	
			camRotX = GetGameplayCamRot().x
			DrawTxt("~r~CR X: ~s~"..tonumber(string.format("%.2f", camRotX)), 0.50, 0.950)
	
			camRotY = GetGameplayCamRot().y
			DrawTxt("~r~CR Y: ~s~"..tonumber(string.format("%.2f", camRotY)), 0.55, 0.950)
	
			camRotZ = GetGameplayCamRot().z
			DrawTxt("~r~CR Z: ~s~"..tonumber(string.format("%.2f", camRotZ)), 0.60, 0.950)
	
			veheng = GetVehicleEngineHealth(GetVehiclePedIsUsing(ply))
			vehbody = GetVehicleBodyHealth(GetVehiclePedIsUsing(ply))
			if IsPedInAnyVehicle(ply, 1) then
				vehenground = tonumber(string.format("%.2f", veheng))
				vehbodround = tonumber(string.format("%.2f", vehbody))
	
				DrawTxt("~r~Eng Health: ~s~"..vehenground, 0.65, 0.950)
	
				DrawTxt("~r~Bod Health: ~s~"..vehbodround, 0.70, 0.950)
	
				DrawTxt("~r~Veh Fuel: ~s~"..tonumber(string.format("%.2f", GetVehicleFuelLevel(GetVehiclePedIsUsing(ply)))), 0.75, 0.950)
			end

			speed = GetEntitySpeed(ply)
			rounds = tonumber(string.format("%.2f", speed))
			DrawTxt("~r~Ply Speed: ~s~"..rounds, 0.40, 0.950)
	
			health = GetEntityHealth(ply)
			DrawTxt("~r~Ply Health: ~s~"..health, 0.45, 0.950)
		end
	end)
end

local headIDs = {}

function playerBlips()
	Citizen.CreateThread(function()
		print("1")
		local ds = true;
		local dt = true;
		while playerBlipActive do
			Wait(10) 
			for n,M in ipairs(GetActivePlayers()) do
				if NetworkIsPlayerActive(M) and GetPlayerPed(M)  ~= GetPlayerPed(-1) then 
					ped = GetPlayerPed(M) 
					blip = GetBlipFromEntity(ped) 
					x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true)) 
					x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(M), true)) 
					distance = math.floor(GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, true)) 
					headId = CreateFakeMpGamerTag(ped, GetPlayerName(M), false, false, "", false) 
					wantedLvl = GetPlayerWantedLevel(M) 
					if dt then 
						Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 0, true) 
						Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 7, true) 
						Citizen.InvokeNative(0xCF228E2AA03099C3, headId, 1) 
						--Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 7, false) 
						--if not headIDs[n] ~= nil then
							headIDs[n] = headId
						--end
					else 
						Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 7, false) 
						Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 9, false) 
						Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 0, false) 
					end
					if ds then
						if not DoesBlipExist(blip) then 
							blip = AddBlipForEntity(ped) SetBlipSprite(blip, 1) 
							Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true) 
							SetBlipNameToPlayerName(blip, M)
						else veh = GetVehiclePedIsIn(ped, false) blipSprite = GetBlipSprite(blip) 
							if not GetEntityHealth(ped) then
								if blipSprite ~= 274 then 
									SetBlipSprite(blip, 274) Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) SetBlipNameToPlayerName(blip, M) 
								end 
							elseif veh then 
								vehClass = GetVehicleClass(veh) 
								vehModel = GetEntityModel(veh) 
								if vehClass == 15 then
									if blipSprite ~= 422 then 
										SetBlipSprite(blip, 422) 
										Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) 
										SetBlipNameToPlayerName(blip, M) 
									end 
								elseif vehClass == 16 then
									if vehModel == GetHashKey("besra") or vehModel == GetHashKey("hydra") or vehModel == GetHashKey("lazer") then
										if blipSprite ~= 424 then 
											SetBlipSprite(blip, 424) Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) SetBlipNameToPlayerName(blip, M) 
										end 
									elseif blipSprite ~= 423 then 
										SetBlipSprite(blip, 423) 
										Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) 
									end 
								elseif vehClass == 14 then
									if blipSprite ~= 427 then 
										SetBlipSprite(blip, 427) Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) 
									end 
								elseif vehModel == GetHashKey("insurgent") or vehModel == GetHashKey("insurgent2") or vehModel == GetHashKey("limo2") then
									if blipSprite ~= 426 then 
										SetBlipSprite(blip, 426) 
										Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) 
										SetBlipNameToPlayerName(blip, M) 
									end 
								elseif vehModel == GetHashKey("rhino") then
									if blipSprite ~= 421 then 
										SetBlipSprite(blip, 421) 
										Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) 
										SetBlipNameToPlayerName(blip, M) 
									end 
								elseif blipSprite ~= 1 then 
									SetBlipSprite(blip, 1) 
									Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true) 
									SetBlipNameToPlayerName(blip, M) 
								end 
								passengers = GetVehicleNumberOfPassengers(veh) 
								if passengers then
									if not IsVehicleSeatFree(veh, -1) then 
										passengers = passengers + 1 
									end 
									ShowNumberOnBlip(blip, passengers)
									else HideNumberOnBlip(blip) end
									else HideNumberOnBlip(blip) 
										if blipSprite ~= 1 then 
											SetBlipSprite(blip, 1) Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true) 
											SetBlipNameToPlayerName(blip, M) 
										end 
									end 
									SetBlipRotation(blip, math.ceil(GetEntityHeading(veh))) 
									SetBlipNameToPlayerName(blip, M) 
									SetBlipScale(blip, 0.85) 
									if IsPauseMenuActive() then 
										SetBlipAlpha(blip, 255)
									else 
										x1, y1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true)) 
										x2, y2 = table.unpack(GetEntityCoords(GetPlayerPed(M), true)) 
										distance = math.floor(math.abs(math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))) / -1) + 900;
									if distance < 0 then 
										distance = 0 
									elseif distance > 255 then 
										distance = 255 
									end 
									SetBlipAlpha(blip, distance) 
								end 
						end
					end
				end
			end
		end
		for _,M in ipairs(GetActivePlayers()) do
			if NetworkIsPlayerActive(M) and GetPlayerPed(M)  ~= GetPlayerPed(-1) then 
				ped = GetPlayerPed(M) 
				blip = GetBlipFromEntity(ped) 
				RemoveBlip(blip)
				for i = 1, #headIDs do
					Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headIDs[i], 7, false) 
					Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headIDs[i], 9, false) 
					Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headIDs[i], 0, false)  
					--table.remove(headIDs, i)
				end
			end
		end
	end)
end

function activateNoclip()
	Citizen.CreateThread(function()

		buttons = setupScaleform("instructional_buttons")
	
		currentSpeed = config.speeds[index].speed
	
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
		else
			noclipEntity = PlayerPedId()
		end

		SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
		FreezeEntityPosition(noclipEntity, noclipActive)
		SetEntityInvincible(noclipEntity, noclipActive)
		SetVehicleRadioEnabled(noclipEntity, not noclipActive) -- [[Stop radio from appearing when going upwards.
		SetEntityVisible(noclipEntity, false, true)

		while noclipActive do
			Citizen.Wait(10)
	
			DrawScaleformMovieFullscreen(buttons)
	
			local yoff = 0.0
			local zoff = 0.0

			if IsControlJustPressed(1, config.controls.changeSpeed) then
				if index ~= 8 then
					index = index+1
					currentSpeed = config.speeds[index].speed
				else
					currentSpeed = config.speeds[1].speed
					index = 1
				end
				setupScaleform("instructional_buttons")
			end

			if IsControlPressed(0, config.controls.goForward) then
				yoff = config.offsets.y
			end
			
			if IsControlPressed(0, config.controls.goBackward) then
				yoff = -config.offsets.y
			end
			
			if IsControlPressed(0, config.controls.turnLeft) then
				SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)+config.offsets.h)
			end
			
			if IsControlPressed(0, config.controls.turnRight) then
				SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)-config.offsets.h)
			end
			
			if IsControlPressed(0, config.controls.goUp) then
				zoff = config.offsets.z
			end
			
			if IsControlPressed(0, config.controls.goDown) then
				zoff = -config.offsets.z
			end
			
			local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, yoff * (currentSpeed + 0.3), zoff * (currentSpeed + 0.3))
			local heading = GetEntityHeading(noclipEntity)

			
			SetEntityVelocity(noclipEntity, 0.0, 0.0, 0.0)
			SetEntityRotation(noclipEntity, 0.0, 0.0, 0.0, 0, false)
			SetEntityHeading(noclipEntity, heading)
			SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, noclipActive, noclipActive, noclipActive)
			SetEntityVisible(noclipEntity, false, false)
			SetLocalPlayerVisibleLocally(true)
			SetEntityAlpha(noclipEntity, 51, 0)
		end
		SetEntityCollision(noclipEntity, true, true)
		FreezeEntityPosition(noclipEntity, false)
		SetEntityInvincible(noclipEntity, false)
		SetVehicleRadioEnabled(noclipEntity, true) -- [[Stop radio from appearing when going upwards.
		SetEntityVisible(noclipEntity, true, true)
		SetEntityAlpha(noclipEntity, 255, 0)
	end)
end

function GetPlayers()
	local players = {}

	for _, player in ipairs(GetActivePlayers()) do
		table.insert(players, _)
	end

	return players
end

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function setupScaleform(scaleform)

    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(5)
    Button(GetControlInstructionalButton(2, config.controls.openKey, true))
    ButtonMessage("Disable Noclip")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(4)
    Button(GetControlInstructionalButton(2, config.controls.goUp, true))
    ButtonMessage("Go Up")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    Button(GetControlInstructionalButton(2, config.controls.goDown, true))
    ButtonMessage("Go Down")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(1, config.controls.turnRight, true))
    Button(GetControlInstructionalButton(1, config.controls.turnLeft, true))
    ButtonMessage("Turn Left/Right")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(1, config.controls.goBackward, true))
    Button(GetControlInstructionalButton(1, config.controls.goForward, true))
    ButtonMessage("Go Forwards/Backwards")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, config.controls.changeSpeed, true))
    ButtonMessage("Change Speed ("..config.speeds[index].label..")")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(config.bgR)
    PushScaleformMovieFunctionParameterInt(config.bgG)
    PushScaleformMovieFunctionParameterInt(config.bgB)
    PushScaleformMovieFunctionParameterInt(config.bgA)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(10)
		if drawInfo then
			local text = {}
			-- cheat checks
			local targetPed = GetPlayerPed(drawTarget)
			local targetGod = GetPlayerInvincible(drawTarget)
			if targetGod then
				table.insert(text,GetLocalisedText("godmodedetected"))
			else
				table.insert(text,GetLocalisedText("godmodenotdetected"))
			end
			if not CanPedRagdoll(targetPed) and not IsPedInAnyVehicle(targetPed, false) and (GetPedParachuteState(targetPed) == -1 or GetPedParachuteState(targetPed) == 0) and not IsPedInParachuteFreeFall(targetPed) then
				table.insert(text,GetLocalisedText("antiragdoll"))
			end
			-- health info
			table.insert(text,GetLocalisedText("health")..": "..GetEntityHealth(targetPed).."/"..GetEntityMaxHealth(targetPed))
			table.insert(text,GetLocalisedText("armor")..": "..GetPedArmour(targetPed))
			-- misc info
			table.insert(text,GetLocalisedText("wantedlevel")..": "..GetPlayerWantedLevel(drawTarget))
			table.insert(text,GetLocalisedText("exitspectator"))
			
			for i,theText in pairs(text) do
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.30)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString(theText)
				EndTextCommandDisplayText(0.3, 0.7+(i/30))
			end
			
			if IsControlJustPressed(0,103) then
				local targetPed = PlayerPedId()
				local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
	
				RequestCollisionAtCoord(targetx,targety,targetz)
				NetworkSetInSpectatorMode(false, targetPed)
				TriggerEvent("updateVoipTargetPed", targetPed, true)
				StopDrawPlayerInfo()
				ShowNotification(GetLocalisedText("stoppedSpectating"))
			end
		else
			Citizen.Wait(1500)
		end
	end
end)

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end)-- Prevents RAM LEAKS :)
