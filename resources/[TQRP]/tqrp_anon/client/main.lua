
local cameraMode              = false
ESX                           = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
end)

-- Display markers
Citizen.CreateThread(function()
    while true do

      Wait(7)
      if cameraMode == true then
        SendNUIMessage({openCamera = true})
        ESX.UI.HUD.SetDisplay(0.0)
        TriggerEvent('tqrp_status:setDisplay', 0.0)
        DisplayRadar(false)
        SetTimecycleModifier("scanline_cam_cheap")
        SetTimecycleModifierStrength(2.0)
      else
        Citizen.Wait(3500)
      end
    end
end)

RegisterNetEvent("tqrp_anon:start")
AddEventHandler("tqrp_anon:start", function()
  cameraMode = not cameraMode
  if not cameraMode then
    SendNUIMessage({openCamera = false})
    ESX.UI.HUD.SetDisplay(1.0)
    TriggerEvent('tqrp_status:setDisplay', 1.0)
    DisplayRadar(true)
    ClearTimecycleModifier("scanline_cam_cheap")
  end
end)
