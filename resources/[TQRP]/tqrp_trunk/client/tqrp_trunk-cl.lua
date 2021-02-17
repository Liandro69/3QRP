ESX = nil
local GUI = {}
local PlayerData = {}
local lastVehicle = nil
local lastOpen = false
GUI.Time = 0
local veh, vehicleProps = {}, {}
local arrayWeight = Config.localWeight
local CloseToVehicle = false
local entityWorld = nil
local globalplate = nil
local lastChecked = 0
local loading = false
Citizen.CreateThread(
  function()
    while ESX == nil do
      TriggerEvent(
        "esx:getSharedObject",
        function(obj)
          ESX = obj
        end
      )
      Citizen.Wait(10)
    end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
	--TriggerServerEvent("tqrp_trunk_inventory:getOwnedVehicule")
  lastChecked = GetGameTimer()
  end
)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
  "esx:playerLoaded",
  function(xPlayer)
    PlayerData = xPlayer
    TriggerServerEvent("tqrp_trunk_inventory:getOwnedVehicule")
    lastChecked = GetGameTimer()
  end
)

AddEventHandler(
  "onResourceStart",
  function()
    PlayerData = xPlayer
    TriggerServerEvent("tqrp_trunk_inventory:getOwnedVehicule")
    lastChecked = GetGameTimer()
  end
)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
  while job == nil do
		Citizen.Wait(10)
	end
  PlayerData.job = job
end)

RegisterNetEvent("tqrp_trunk_inventory:setOwnedVehicule")
AddEventHandler("tqrp_trunk_inventory:setOwnedVehicule", function(vehicle, props)
    veh = vehicle
    vehicleProps = props
    loading = false
end)

function VehicleInFront()
  local pos = GetEntityCoords(PlayerPedId())
  local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 4.0, 0.0)
  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
  local a, b, c, d, result = GetRaycastResult(rayHandle)
  return result
end

function openmenuvehicle()
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  local vehicle = VehicleInFront()
  local vehProps = ESX.Game.GetVehicleProperties(vehicle)
  globalplate = GetVehicleNumberPlateText(vehicle)
  if not IsPedInAnyVehicle(playerPed) then
    loading = true
    TriggerServerEvent("tqrp_trunk_inventory:getOwnedVehicule")
    while loading do
      Citizen.Wait(10)
    end
    myVeh = false
    PlayerData = ESX.GetPlayerData()
    for i = 1, #veh do
      if vehProps == veh[i].props then
        myVeh = true
      end
    end

    if not Config.CheckOwnership or (Config.AllowPolice and PlayerData.job.name == "police") or (Config.CheckOwnership and myVeh) then
      if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
        CloseToVehicle = true
        local vehFront = VehicleInFront()

        if vehFront > 0 and vehFront ~= nil and GetPedInVehicleSeat(vehFront, -1) ~= PlayerPedId() then
          lastVehicle = vehFront
          local locked = GetVehicleDoorLockStatus(vehFront)
          local class = GetVehicleClass(vehFront)
          ESX.UI.Menu.CloseAll()

          if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "inventory") then
            SetVehicleDoorShut(vehFront, 5, false)
          else
            if locked == 1 or class == 15 or class == 16 or class == 14 then
              SetVehicleDoorOpen(vehFront, 5, false, false)
              ESX.UI.Menu.CloseAll()

              if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
                CloseToVehicle = true
                OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), Config.VehicleLimit[class], myVeh)
              end
            else
              exports['mythic_notify']:SendAlert('error', 'Mala fechada!')
              
            end
          end
        end
        lastOpen = true
        GUI.Time = GetGameTimer()
      end
    else
      exports['mythic_notify']:SendAlert('error', 'Este veículo não é teu!')
    end
  end
end
local count = 0

-- Key controls
Citizen.CreateThread(
  function()
    while true do
      Wait(10)
      if not IsPedInAnyVehicle(PlayerPedId()) then
        if IsControlJustReleased(0, Config.OpenKey) and (GetGameTimer() - GUI.Time) > 1000 then
          openmenuvehicle()
          GUI.Time = GetGameTimer()
        end
      else
        Citizen.Wait(1500)
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Wait(10)
      local pos = GetEntityCoords(PlayerPedId())
      if CloseToVehicle then
        local vehicle = GetClosestVehicle(pos["x"], pos["y"], pos["z"], 2.0, 0, 70)
        if DoesEntityExist(vehicle) then
          CloseToVehicle = true
        else
          CloseToVehicle = false
          lastOpen = false
          ESX.UI.Menu.CloseAll()
          SetVehicleDoorShut(lastVehicle, 5, false)
        end
      else
        Citizen.Wait(1500)
      end
    end
  end
)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
  "esx:playerLoaded",
  function(xPlayer)
    PlayerData = xPlayer
    TriggerServerEvent("tqrp_trunk_inventory:getOwnedVehicule")
    lastChecked = GetGameTimer()
  end
)

function OpenCoffreInventoryMenu(plate, max, myVeh)
  ESX.TriggerServerCallback(
    "tqrp_trunk:getInventoryV",
    function(inventory)
      text = _U("trunk_info", plate, inventory.weight, max)
      data = {plate = plate, max = max, myVeh = myVeh, text = text}
      TriggerEvent("tqrp_inventoryhud:openTrunkInventory", data, inventory.blackMoney, inventory.items, inventory.weapons)
    end,
    plate
  )
end

function all_trim(s)
  if s then
    return s:match "^%s*(.*)":match "(.-)%s*$"
  else
    return "noTagProvided"
  end
end

function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end
