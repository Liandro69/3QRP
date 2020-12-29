
--===============================================================================
--=== Stworzone przez Alcapone aka suprisex. Zakaz rozpowszechniania skryptu! ===
--===================== na potrzeby LS-Story.pl =================================
--===============================================================================


-- ESX

ESX = nil
local PlayerData                = {}
local phoneProp = 0
local channels = {}

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(10)
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


local radioMenu = false

function PrintChatMessage(text)
    TriggerEvent('chatMessage', "system", { 255, 0, 0 }, text)
end

function newPhoneProp()
  deletePhone()
  RequestModel("prop_cs_walkie_talkie")
  while not HasModelLoaded("prop_cs_walkie_talkie") do
    Citizen.Wait(1)
  end

  phoneProp = CreateObject("prop_cs_walkie_talkie", 1.0, 1.0, 1.0, 1, 1, 0)
  local bone = GetPedBoneIndex(PlayerPedId(), 28422)
  AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

function deletePhone()
  if phoneProp ~= 0 then
    Citizen.InvokeNative(0xAE3CBE5BF394C9C9 , Citizen.PointerValueIntInitialized(phoneProp))
    phoneProp = 0
  end
end


function enableRadio(enable)
  if enable then
    local dict = "cellphone@"
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      dict = "anim@cellphone@in_car@ps"
    end

    loadAnimDict(dict)

    local anim = "cellphone_call_to_text"
    TaskPlayAnim(PlayerPedId(), dict, anim, 3.0, -1, -1, 50, 0, false, false, false)
    newPhoneProp()
  else
    ClearPedSecondaryTask(PlayerPedId())
    deletePhone()
  end

  SetNuiFocus(true, true)
  radioMenu = enable
  SendNUIMessage({
    type = "enableui",
    enable = enable
  })

end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end

--- sprawdza czy komenda /radio jest włączony

RegisterCommand('radio', function(source, args)
    if Config.enableCmd then
      enableRadio(true)
    end
end, false)

RegisterCommand('radiotest', function(source, args)
  local playerServerId = GetPlayerServerId(PlayerId())
  local data = exports.tokovoip_script:getPlayerData(playerServerId, "radio:channel")

  print(tonumber(data))

  if data == "nil" then
    exports['mythic_notify']:SendAlert('inform', Config.messages['not_on_radio'])
  else
   exports['mythic_notify']:SendAlert('inform', Config.messages['on_radio'] .. data .. ' MHz </b>')
 end

end, false)

-- dołączanie do radia

RegisterNUICallback('joinRadio', function(data, cb)
    local _source = source
    local PlayerData = ESX.GetPlayerData(_source)
    local playerServerId = GetPlayerServerId(PlayerId())
    local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerServerId, "radio:channel")

    if tonumber(data.channel) ~= tonumber(getPlayerRadioChannel) then
        if tonumber(data.channel) <= Config.RestrictedChannels then
          if(PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'sheriff') then
           --exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
            exports.tokovoip_script:setPlayerData(playerServerId, "radio:channel", tonumber(data.channel), true);
            exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
            TriggerServerEvent("tqrp_base:serverlog", "[JOIN RADIO] | "..data.channel .. ' MHz', GetPlayerServerId(PlayerId()), GetCurrentResourceName())
            exports['mythic_notify']:SendAlert('inform', Config.messages['joined_to_radio'] .. data.channel .. ' MHz </b>')
          elseif not (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'sheriff') then
            --- info że nie możesz dołączyć bo nie jesteś policjantem
            exports['mythic_notify']:SendAlert('error', Config.messages['restricted_channel_error'])
          end
        end
        if tonumber(data.channel) > Config.RestrictedChannels then
          exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
          exports.tokovoip_script:setPlayerData(playerServerId, "radio:channel", tonumber(data.channel), true);
          exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
          exports['mythic_notify']:SendAlert('inform', Config.messages['joined_to_radio'] .. data.channel .. ' MHz </b>')
          TriggerServerEvent("tqrp_base:serverlog", "[JOIN RADIO] | "..data.channel .. ' MHz', GetPlayerServerId(PlayerId()), GetCurrentResourceName())
        end
    else
      exports['mythic_notify']:SendAlert('error', Config.messages['you_on_radio'] .. data.channel .. ' MHz </b>')
    end
      --[[
    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
    exports.tokovoip_script:setPlayerData(playerServerId, "radio:channel", tonumber(data.channel), true);
    exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
    PrintChatMessage("radio: " .. data.channel)
    print('radiook')
      ]]--
    cb('ok')
end)

-- opuszczanie radia

RegisterNUICallback('leaveRadio', function(data, cb)
   local playerServerId = GetPlayerServerId(PlayerId())
   local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerServerId, "radio:channel")

    if getPlayerRadioChannel == "nil" then
      exports['mythic_notify']:SendAlert('inform', Config.messages['not_on_radio'])
        else
          exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
          exports.tokovoip_script:setPlayerData(playerServerId, "radio:channel", "nil", true)
          exports['mythic_notify']:SendAlert('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. ' MHz </b>')
    end

   cb('ok')

end)

RegisterNUICallback('escape', function(data, cb)

    enableRadio(false)
    SetNuiFocus(false, false)


    cb('ok')
end)

-- net eventy

RegisterNetEvent('ls-radio:use')
AddEventHandler('ls-radio:use', function()
  enableRadio(true)
end)

RegisterNetEvent('ls-radio:onRadioDrop')
AddEventHandler('ls-radio:onRadioDrop', function()
  local playerServerId = GetPlayerServerId(PlayerId())
  local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerServerId, "radio:channel")
  if getPlayerRadioChannel ~= "nil" then
    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
    exports.tokovoip_script:setPlayerData(playerServerId, "radio:channel", "nil", true)
    exports['mythic_notify']:SendAlert('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. ' MHz </b>')
  end
end)

Citizen.CreateThread(function()
    while true do
        if radioMenu then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown
            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride
            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        else
          Citizen.Wait(1500)
        end
        Citizen.Wait(10)
    end
end)
