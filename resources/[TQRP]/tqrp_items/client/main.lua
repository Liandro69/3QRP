
  ESX = nil
  Citizen.CreateThread(function()
      while ESX == nil do
          TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
          Citizen.Wait(10)
      end
  
      while ESX.GetPlayerData().job == nil do
          Citizen.Wait(10)
      end

  end)

  RegisterNetEvent('lsrp-items:getplayerloc')
  AddEventHandler('lsrp-items:getplayerloc', function()

    local playerPed		= GetPlayerPed()
    local coords		= GetEntityCoords(playerPed)
    print(coords.x..' '..coords.y..' '..coords.z)

  end)


  RegisterNetEvent('lsrp-items:rolljoint')
  AddEventHandler('lsrp-items:rolljoint', function()
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 5000,
        label = "A enrrolar canhão",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
        },
        prop = {
            
        }
    }, function(status)
        if not status then
            TriggerServerEvent('lsrp-items:rolljoints')
        end
    end)
  end)