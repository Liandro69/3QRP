-- NAME tqrp_phone

ESX = nil
PlayerData = {}
isPhoneOpen = false
openingCd = false
InstaLink = ""

muted = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  
  while PlayerData == nil do
    Citizen.Wait(10)
  end

  ESX.TriggerServerCallback('tqrp_phone:server:getLink', function(callback)
      InstaLink = callback
  end)

  TriggerServerEvent("tqrp_phone:server:SetupApps") -- Apps
  TriggerServerEvent('tqrp_phone:server:GetAds') -- Paginas Amarelas
  TriggerServerEvent("tqrp_phone:server:getPlayerVehicles") -- Garage
  TriggerServerEvent('tqrp_phone:server:UpdateTwitter') -- Twitter
  TriggerServerEvent('tqrp_phone:server:UpdateIsta') -- Insta
  TriggerServerEvent('tqrp_phone:server:UpdateContact') -- Contactos
  TriggerServerEvent('tqrp_phone:server:GetTexts') -- msg
  TriggerServerEvent('tqrp_phone:server:SetUpHistory') -- historico
  TriggerServerEvent('tqrp_phone:server:SetupInfo') -- INFO
end)

RegisterNetEvent('tqrp_phone:client:UpdateData')
AddEventHandler('tqrp_phone:client:UpdateData', function()
  TriggerServerEvent('tqrp_phone:server:UpdateTwitter') -- Twitter
  TriggerServerEvent('tqrp_phone:server:UpdateIsta') -- Insta
  TriggerServerEvent('tqrp_phone:server:UpdateContact') -- Contactos
  TriggerServerEvent('tqrp_phone:server:GetTexts') -- msg
  TriggerServerEvent('tqrp_phone:server:SetUpHistory') -- historico
  TriggerServerEvent('tqrp_phone:server:SetupInfo') -- INFO
end)

-- remover
--Citizen.CreateThread(function()
--  Wait(5000)
--  TriggerServerEvent("tqrp_phone:server:CharacterSpawned")
--end)

--[[ actionCb = {}

RegisterNetEvent('tqrp_phone:client:ActionCallback')
AddEventHandler('tqrp_phone:client:ActionCallback', function(identifier, data)
	if actionCb[identifier] ~= nil then
	    actionCb[identifier](data)
	    actionCb[identifier] = nil
	end
end) ]]

RegisterNetEvent('tqrp_phone:client:SetupData')
AddEventHandler('tqrp_phone:client:SetupData', function(data)
	SendNUIMessage({
	    action = 'setup',
	    data = data
	})
end)

-- Abrir telemóvel + atualizar relógio
local counter = 0

Citizen.CreateThread(function()
  while true do
    if IsDisabledControlPressed(0, 288) then
      ESX.TriggerServerCallback('tqrp_phone:getItemAmount', function(result)
        if result > 0 then
            TogglePhone()
        else
          exports['mythic_notify']:SendAlert('error', 'Não tens nenhum telemóvel')
        end
      end, 'phone')
      Wait(500)
    end

    if counter <= 0 then
      local time = CalculateTimeToDisplay()
      SendNUIMessage({
        action = 'updateTime',
        time = time.hour .. ':' .. time.minute
      })
      counter = 100
    else
      counter = counter - 1
    end

    Citizen.Wait(5)
  end
end)

RegisterCommand("setupdata", function(source, args)
  TriggerServerEvent("tqrp_phone:server:SetupApps") -- Apps
  TriggerServerEvent('tqrp_phone:server:GetAds') -- Paginas Amarelas
  TriggerServerEvent("tqrp_phone:server:SetupInfo") -- Info
  TriggerServerEvent("tqrp_phone:server:RefreshBills") -- Faturas
  TriggerServerEvent("tqrp_phone:server:getPlayerVehicles") -- Garagem
  TriggerServerEvent('tqrp_phone:server:UpdateTwitter') -- Twitter
  TriggerServerEvent('tqrp_phone:server:UpdateIsta') -- Insta
  TriggerServerEvent('tqrp_phone:server:UpdateContact') -- Contactos
  TriggerServerEvent('tqrp_phone:server:GetTexts') -- msg
  TriggerServerEvent('tqrp_phone:server:SetUpHistory') -- historico
end,false)




RegisterNUICallback('ClosePhone', function(data, cb)
  TogglePhone()
end)

RegisterNUICallback('RefreshBills', function(data, cb)
  TriggerServerEvent("tqrp_phone:server:RefreshBills")
  Wait(1000)
end)

RegisterCommand("fechartelemovel", function()
  TogglePhone()
end,false)

RegisterCommand("atender", function()
  if Call.status == 0 and not IsEntityDead(PlayerPedId()) then
    TriggerServerEvent('tqrp_phone:server:AcceptCall')
  end
end,false)

RegisterCommand("desligar", function()
  if Call.status == 0 and not IsEntityDead(PlayerPedId()) then
    TriggerServerEvent('tqrp_phone:server:EndCall', Call)
  end
end,false)

Citizen.CreateThread(function()
  TriggerEvent('chat:addSuggestion', '/atender', 'Atende a chamada')
    TriggerEvent('chat:addSuggestion', '/desligar', 'Desliga a chamada')
end)

function TogglePhone()
  if not IsEntityDead(PlayerPedId()) then
    if not openingCd or isPhoneOpen then
      isPhoneOpen = not isPhoneOpen
      if isPhoneOpen == true then
          PhonePlayIn()
          SetNuiFocus(true, true)
          if Call ~= nil then
            SendNUIMessage( { action = 'show', number = Call.number, initiator = Call.initiator } )
          else
            SendNUIMessage( { action = 'show' } )
          end
      else
          SetNuiFocus(false, false)
          if not IsInCall() then
            PhonePlayOut()
          end
          SendNUIMessage( { action = 'hide' } )
      end
      
      openingCd = true
    end

    Citizen.CreateThread(function()
      Citizen.Wait(1000)
      openingCd = false
    end)
  end
end

--[[ RegisterNUICallback('OpenCamera', function(data, cb)
  TogglePhone()
  TriggerEvent("tqrp_camera:openCellphoneCam")
end) ]]

RegisterNUICallback('OpenNEWS', function(data, cb)
  TogglePhone()
  TriggerEvent("tqrp_news:openNews")
end)

RegisterNUICallback('RemoveFocus', function(data, cb)
  SetNuiFocus(false, false)
end)

RegisterNUICallback('SetMuted', function(data, cb)
  muted = true
end)

RegisterNUICallback('SetNotMuted', function(data, cb)
  muted = false
end)

function CalculateTimeToDisplay()
  hour = GetClockHours()
  minute = GetClockMinutes()
  
  local obj = {}
  
  if hour <= 9 then
    hour = "0" .. hour
  end
  
  if minute <= 9 then
    minute = "0" .. minute
  end
  
  obj.hour = hour
  obj.minute = minute

  return obj
end

function DisableControls()
  Citizen.CreateThread(function()
      while isPhoneOpen do
          DisableControlAction(0, 1, true) -- LookLeftRight
          DisableControlAction(0, 2, true) -- LookUpDown
          DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
          DisableControlAction(0, 30, true) -- disable left/right
          DisableControlAction(0, 31, true) -- disable forward/back
          DisableControlAction(0, 36, true) -- INPUT_DUCK
          DisableControlAction(0, 21, true) -- disable sprint
          DisableControlAction(0, 63, true) -- veh turn left
          DisableControlAction(0, 64, true) -- veh turn right
          DisableControlAction(0, 71, true) -- veh forward
          DisableControlAction(0, 72, true) -- veh backwards
          DisableControlAction(0, 75, true) -- disable exit vehicle

          DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing
          DisableControlAction(0, 24, true) -- disable attack
          DisableControlAction(0, 25, true) -- disable aim
          DisableControlAction(1, 37, true) -- disable weapon select
          DisableControlAction(0, 47, true) -- disable weapon
          DisableControlAction(0, 58, true) -- disable weapon
          DisableControlAction(0, 140, true) -- disable melee
          DisableControlAction(0, 141, true) -- disable melee
          DisableControlAction(0, 142, true) -- disable melee
          DisableControlAction(0, 143, true) -- disable melee
          DisableControlAction(0, 263, true) -- disable melee
          DisableControlAction(0, 264, true) -- disable melee
          DisableControlAction(0, 257, true) -- disable melee
          Citizen.Wait(5)
      end
  end)
end

Citizen.CreateThread(function()
    while true do
        if IsInCall() then
            if Call.status == 0 then
              DrawUIText("A ligar ~g~[CAPS LOCK]~w~ desligar", 4, 1, 0.5, 0.965, 0.65, 255, 255, 255, 255)
            else
              DrawUIText("Em chamada ~g~[CAPS LOCK]~w~ desligar", 4, 1, 0.5, 0.965, 0.65, 255, 255, 255, 255)
            end
            if (IsControlPressed(1, 137)) then
                TriggerServerEvent('tqrp_phone:server:EndCall', Call)
                Wait(1000)
            end
            Citizen.Wait(5)
        else
            Citizen.Wait(1000)
        end
    end
end)


function DrawUIText(text, font, centre, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y) 
end

---------------------- DAR NUMERO

RegisterCommand("num", function()
  local player, distance = ESX.Game.GetClosestPlayer()
  
  if distance ~= -1 and distance <= 5.0 then
    ESX.TriggerServerCallback('tqrp_phone:server:GetPhoneNumber', function(num)
      TriggerServerEvent("tqrp_phone:server:giveNumber", num, GetPlayerServerId(player))
    end)
  else
    exports["mythic_notify"]:SendAlert('error', 'Ninguém nas proximidades!')
  end
end,false)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/num', 'Dar o número de telemóvel à pessoa mais perto')
end)

RegisterNetEvent('tqrp_phone:client:showNumToMe')
AddEventHandler('tqrp_phone:client:showNumToMe', function(num)
    PlaySoundFrontend(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", 1)
    exports["mythic_notify"]:SendAlert('error', 'Número recebido: ' .. num)
end)