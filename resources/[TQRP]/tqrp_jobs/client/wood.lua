----------------------------------
-------------FUNCIONES------------
---------------------------------
X.ClickW = function(v)
  if v then
    if v.health > 0 then
       if X.Clicks >= Config.ClicksToCutNeeded then 
        exports['mythic_progbar']:Progress({
          name = "housrob",
          duration = 20000,
          label = "A recolher madeira",
          useWhileDead = false,
          canCancel = true,
          controlDisables = {},
          animation = {},
          prop = {},
        }, function(status)
          if not status then
          X.Clicks = 0
          v.health = v.health - 10
          TriggerServerEvent('tm1_stores:giveWood', v.data)
          TriggerServerEvent('tm1_stores:getDataWood',Config.Woods)
          end
        end)
        else
          X.Clicks = X.Clicks + 1 
        end
    end
  end
end

X.CraftW = function(item)
  Citizen.CreateThread(function()
    --X.startAnim("mini@repair", "fixing_a_ped")
    Wait(0)
    ClearPedTasks(PlayerPedId())
    X.IsProcessing = false
    TriggerServerEvent('tm1_stores:craftWood',item)
  end)
end

X.CanPickW = function(coords)
  for i,v in pairs(Config.Woods) do
    if GetDistanceBetweenCoords(coords.x,coords.y,coords.z,v.x,v.y,v.z) < 75 then
      if v.health >= v.max / 2 then
        X.DrawText3D({x = v.x, y = v.y, z = v.z}, Local.treeOf.."~b~"..Local[v.data].."~w~ : ~g~"..v.health.."/"..v.max)
      elseif v.health >= v.max / 4 then
        X.DrawText3D({x = v.x, y = v.y, z = v.z}, Local.treeOf.."~b~"..Local[v.data].."~w~ : ~b~"..v.health.."/"..v.max)
      elseif v.health < v.max / 4 and v.health ~= 0 then
        X.DrawText3D({x = v.x, y = v.y, z = v.z}, Local.treeOf.."~b~"..Local[v.data].."~w~ : ~y~"..v.health.."/"..v.max)
      elseif v.health <= 0 then
        X.DrawText3D({x = v.x, y = v.y, z = v.z}, Local.treeOf.."~b~"..Local[v.data].."~w~ : ~r~ "..v.health.."/"..v.max)  
      end
    end
    if GetCurrentPedWeapon(PlayerPedId(),"WEAPON_HATCHET",true) then
      if IsControlJustReleased(1,  24) then
        if GetDistanceBetweenCoords(coords.x,coords.y,coords.z,v.x,v.y,v.z) < 2.5 and v.health > 0 then
          if v then
            X.ClickW(v)
          end
        end
      end
    end
  end
end

X.OpenProcesser = function()
  local elements = {
    {label = Local.process..Local.pine,value = "pine"}
  }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'processer',
    {
      title  = Local.woodProcesser,
      align    = 'bottom-right',
      elements = elements
    },
    function(data, menu)  
      if data.current.value and X.IsProcessing == false then
        X.IsProcessing = true
        exports['mythic_progbar']:Progress({
          name = "processar_madeira",
          duration = 15000,
          label = "A processar madeira...",
          useWhileDead = true,
          canCancel = true,
          controlDisables = {
              disableMovement = true,
              disableCarMovement = true,
              disableMouse = false,
              disableCombat = true,
          },
          animation = {},
          prop = {},
          propTwo = {},
      })
      Citizen.Wait(15000)
      X.CraftW(data.current.value)
      end
      menu.close()
    end,
    function(data, menu)
      menu.close()
    end
  )
end