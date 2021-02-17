guiEnabled = false
Citizen.CreateThread(function()
  while true do
      if guiEnabled then
          DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
          DisableControlAction(0, 2, guiEnabled) -- LookUpDown

          DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate

          DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

      end
      Citizen.Wait(7) --MH LUA
  end
end)
  
RegisterNUICallback('NUIFocusOff', function()
  Gui(false)
end)

RegisterCommand("fecharnews", function()
  Gui(false)
end, false)

RegisterNetEvent("tqrp_news:openNews")
AddEventHandler("tqrp_news:openNews", function()
  if guiEnabled then
    Gui(false)
  else
    Gui(true)
  end
end)



function Gui(toggle, link)
  SetNuiFocus(toggle, toggle)
  guiEnabled = toggle

  SendNUIMessage({
      type = "enableui",
      enable = toggle
  })
end


AddEventHandler('onClientResourceStart', function(resourceName) --When resource starts, stop the GUI showing. 
    if GetCurrentResourceName() == resourceName then
      Gui(false)
    end
end)






--RegisterNetEvent("output")
--AddEventHandler("output", function(argument)
  --  TriggerEvent("chatMessage", "[Success]", {0,255,0}, argument)
--end)