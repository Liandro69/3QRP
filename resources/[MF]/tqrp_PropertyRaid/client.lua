-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFR = MF_PropertyRaid
local TSC = ESX.TriggerServerCallback
local TSE = TriggerServerEvent
local CT = Citizen.CreateThread

function MFR:Awake(...)
    while not ESX do Citizen.Wait(10); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(10); end
    self.PlayerData = ESX.GetPlayerData()
    TSC('MF_PropertyRaid:GetStartData', function(retVal) self.dS = true; self.cS = retVal; self:Start(); end)
end

function MFR:Start()
  TSC('tqrp_property:getProperties', function(properties)
    self.Properties = properties or {}
    self.Entrys = {}
    for k,v in pairs(self.Properties) do
      if v.entering then
        local entry = vector3(v.entering.x,v.entering.y,v.entering.z)
        v.entering = entry
        table.insert(self.Entrys,v)
      end
    end
    if self.dS and self.cS then self:Update(); end
  end)
end

function MFR:Update(...)
  local lastKey = GetGameTimer()
  while true do
    if self.PlayerData.job and self.PlayerData.job.name == self.PoliceJobName then
      Citizen.Wait(10)
      local plyPed = PlayerPedId()
      local plyPos = GetEntityCoords(PlayerPedId())
      local closest,closestDist = self:GetClosestMarker(plyPos)

      if closestDist and closestDist < self.DrawTextDist and not self.DoingAction then
        Utils.DrawText3D(closest.entering.x,closest.entering.y,closest.entering.z+1.0,"Press [~r~G~s~] to open the police menu.")
        if IsControlJustReleased(0,58) and (GetGameTimer() - lastKey) > 150 then
          lastKey = GetGameTimer()
          self.DoingAction = closest
          self:DoAction(closest)
        end
      end
    else
      Citizen.Wait(10 * 1000)
    end
  end
end

function MFR:DoAction(closest)
  local elements = {} 
  local hasReturned = false
  
  if closest.isSingle then
    TSC('MF_PropertyRaid:GetOwnedSingles', function(data)
      for k,v in pairs(data) do table.insert(elements,{label = v.owner,val = v.identifier}); end
      hasReturned = true
    end,closest)
  elseif closest.isGateway then
    TSC('MF_PropertyRaid:GetOwnedApartments', function(data)
      for k,v in pairs(data) do table.insert(elements,{label = v.owner,val = v.identifier}); end
      hasReturned = true
    end,closest)
  end
    
  while not hasReturned do Citizen.Wait(10); end

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Raid_Menu", { title = "Raid Property", align = 'right', elements = elements }, 
    function(data,menu)
      self:RaidPlace(data.current.val,closest.name)
      self.DoingAction = false
      menu.close() 
    end,    
    function(data,menu)
      self.DoingAction = false
      menu.close()
    end
  )
end

function MFR:RaidPlace(identifier,propertyName)
  TSC('MF_PropertyRaid:GetInstanceData', function(data)
    for k,v in pairs(data) do 
      if v.data.owner == identifier then
        TriggerEvent('instance:enter',v)
        return
      end 
    end
    ESX.ShowNotification("That person isn't home at the moment.")
  end)
end

function MFR:GetClosestMarker(pos)
  local closest,closestDist
  for k,v in pairs(self.Entrys) do
    local dist = Utils.GetVecDist(pos, v.entering)
    if not closestDist or dist < closestDist then
      closestDist = dist
      closest = v
    end
  end
  if closestDist then return closest,closestDist
  else return false,99999999
  end
end

function MFR.SetJob(source,job)
  local self = MFR
  if not source then return; end
  if not job then job = source; end
  if self.PlayerData and self.PlayerData.job then 
    self.PlayerData.job = job
  else 
    self.PlayerData = ESX.GetPlayerData()
  end
end

CT(function(...) MFR:Awake(...); end)
NewEvent(true,MFR.SetJob,'esx:setJob')