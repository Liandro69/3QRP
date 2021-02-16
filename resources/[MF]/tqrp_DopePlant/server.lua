RegisterNetEvent('MF_DopePlant:SyncPlant')
RegisterNetEvent('MF_DopePlant:RemovePlant')

local MFD = MF_DopePlant

function MFD:Awake(...)
  while not ESX do 
    Citizen.Wait(10); 
  end

  self:DSP(true);
  self.dS = true
  self:Start()
end

function MFD:DSP(val) self.cS = val; end
function MFD:Start(...)
  if self.dS and self.cS then self:Update(); end
end

function MFD:Update(...)
  -- while self.dS and self.cS do
  --   Citizen.Wait(10)
  -- end
end

function MFD:SyncPlant(plant,delete)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  local identifier = xPlayer.getIdentifier()
  plant["Owner"] = identifier
  if delete then 
    if xPlayer.job.label ~= self.PoliceJobLabel then
      self:RewardPlayer(source, plant)
    end
  end
  self:PlantCheck(identifier,plant,delete) 
  TriggerClientEvent('MF_DopePlant:SyncPlant',-1,plant,delete)
end

function MFD:RewardPlayer(source,plant)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  if not source or not plant then return; end
  if plant.Gender == "Male" then
    local r = math.random(1000,5000)
    if r < 3000 then
      if plant.Quality > 95 then
        xPlayer.addInventoryItem('highgrademaleseed',2)
        xPlayer.addInventoryItem('highgradefemaleseed',  math.random(40, 70))
      else
        xPlayer.addInventoryItem('highgradefemaleseed',  math.random(3, 40))
        xPlayer.addInventoryItem('highgrademaleseed',1)
      end
    else
      if plant.Quality > 95 then
        xPlayer.addInventoryItem('highgradefemaleseed',  math.random(40, 70))
        xPlayer.addInventoryItem('highgrademaleseed',2)
      else
        xPlayer.addInventoryItem('highgradefemaleseed',  math.random(3, 40))
        xPlayer.addInventoryItem('highgrademaleseed',1)
      end
    end
  else
    if plant and plant.Quality and plant.Quality > 80 then
      xPlayer.addInventoryItem('trimmedweed', math.floor( math.random( math.floor(plant.Quality), math.floor(plant.Quality*2) ) ) )
    else
      xPlayer.addInventoryItem('trimmedweed', math.floor( math.random( math.floor(plant.Quality/2), math.floor(plant.Quality) ) ) )
    end
  end
  xPlayer.addInventoryItem('plantpot', 1 )
end

function MFD:PlantCheck(identifier, plant, delete)
  if not plant or not identifier then return; end
  local data = MySQL.Sync.fetchAll('SELECT * FROM dopeplants WHERE plantid=@plantid',{['@plantid'] = plant.PlantID})
  if not delete then
    if not data or not data[1] then  
      MySQL.Async.execute('INSERT INTO dopeplants (owner, plantid, plant) VALUES (@owner, @id, @plant)',{['@owner'] = identifier,['@id'] = plant.PlantID, ['@plant'] = json.encode(plant)})
    else
      MySQL.Sync.execute('UPDATE dopeplants SET plant=@plant WHERE plantid=@plantid',{['@plant'] = json.encode(plant),['@plantid'] = plant.PlantID})
    end
  else
    if data and data[1] then
      MySQL.Async.execute('DELETE FROM dopeplants WHERE plantid=@plantid', {['@plantid'] = plant.PlantID})
    end
  end
end

function MFD:GetLoginData(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  local data = MySQL.Sync.fetchAll('SELECT * FROM dopeplants WHERE owner=@owner',{['@owner'] = xPlayer.identifier})
  if not data or not data[1] then return false; end
  local aTab = {}
  for k = 1,#data,1 do
    local v = data[k]
    if v and v.plant then
      local data = json.decode(v.plant)
      table.insert(aTab,data)
    end
  end
  return aTab
end

function MFD:ItemTemplate()
  return {
       ["Type"] = "Water",
    ["Quality"] = 0.0,
  }
end

function MFD:PlantTemplate()
  return {
   ["Gender"] = "Female",
  ["Quality"] = 0.0,
   ["Growth"] = 0.0,
    ["Water"] = 20.0,
     ["Food"] = 20.0,
    ["Stage"] = 1,
  ["PlantID"] = math.random(math.random(999999,9999999),math.random(99999999,999999999))
  }
end

ESX.RegisterServerCallback('MF_DopePlant:GetLoginData', function(source,cb) cb(MFD:GetLoginData(source)); end)
ESX.RegisterServerCallback('MF_DopePlant:GetStartData', function(source,cb) while not MFD.dS do Citizen.Wait(10); end; cb(MFD.cS); end)
AddEventHandler('MF_DopePlant:SyncPlant', function(plant,delete) MFD:SyncPlant(plant,delete); end)
AddEventHandler('playerConnected', function(...) MFD:DoLogin(source); end)
Citizen.CreateThread(function(...) MFD:Awake(...); end)

-- Maintenance Items
ESX.RegisterUsableItem('wateringcan', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('wateringcan').count > 0 then 
    --xPlayer.removeInventoryItem('wateringcan', 1)
    local template = MFD:ItemTemplate()
    template.Type = "Water"
    template.Quality = 0.1
    TriggerClientEvent('tm1_stores:addWater', source, 25)
    TriggerClientEvent('MF_DopePlant:UseItem',source,template)
  end
end)

ESX.RegisterUsableItem('purifiedwater', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('purifiedwater').count > 0 then 
    xPlayer.removeInventoryItem('purifiedwater', 1)

    local template = MFD:ItemTemplate()
    template.Type = "Water"
    template.Quality = 0.2

    TriggerClientEvent('MF_DopePlant:UseItem',source,template)
  end
end)

--[[ESX.RegisterUsableItem('lowgradefert', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('lowgradefert').count > 0 then 
    xPlayer.removeInventoryItem('lowgradefert', 1)

    local template = MFD:ItemTemplate()
    template.Type = "Food"
    template.Quality = 0.1

    TriggerClientEvent('MF_DopePlant:UseItem',source,template)
  end
end)]]

ESX.RegisterUsableItem('highgradefert', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('highgradefert').count > 0 then 
    xPlayer.removeInventoryItem('highgradefert', 1)

    local template = MFD:ItemTemplate()
    template.Type = "Food"
    template.Quality = 0.2

    TriggerClientEvent('MF_DopePlant:UseItem',source,template)
  end
end)

--[[ Seed Items
ESX.RegisterUsableItem('lowgrademaleseed', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('lowgrademaleseed').count > 0 and xPlayer.getInventoryItem('plantpot').count > 0 then 
    xPlayer.removeInventoryItem('lowgrademaleseed', 1)
    xPlayer.removeInventoryItem('plantpot', 1)

    local template = MFD:PlantTemplate()
    template.Gender = "Male"
    template.Quality = math.random(1,100)/10
    template.Food =  math.random(100,200)/10
    template.Water = math.random(100,200)/10

    TriggerClientEvent('MF_DopePlant:UseSeed',source,template)
  end
end)]]

ESX.RegisterUsableItem('highgrademaleseed', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('highgrademaleseed').count > 0 and xPlayer.getInventoryItem('plantpot').count > 0 then
    xPlayer.removeInventoryItem('highgrademaleseed', 1)
    xPlayer.removeInventoryItem('plantpot', 1)
    TriggerEvent("tqrp_base:serverlog", "[PLANTOU] highgrademaleseed", source, GetCurrentResourceName())
    local template = MFD:PlantTemplate()
    template.Gender = "Male"
    template.Quality = 0.2
    template.Quality = math.random(200,500)/10
    template.Food =  math.random(200,400)/10
    template.Water = math.random(200,400)/10

    TriggerClientEvent('MF_DopePlant:UseSeed',source,template)
  end
end)

--[[ESX.RegisterUsableItem('lowgradefemaleseed', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('lowgradefemaleseed').count > 0 and xPlayer.getInventoryItem('plantpot').count > 0 then
    xPlayer.removeInventoryItem('lowgradefemaleseed', 1)
    xPlayer.removeInventoryItem('plantpot', 1)

    local template = MFD:PlantTemplate()
    template.Gender = "Female"
    template.Quality = 0.1
    template.Quality = math.random(1,100)/10
    template.Food =  math.random(100,200)/10
    template.Water = math.random(100,200)/10

    TriggerClientEvent('MF_DopePlant:UseSeed',source,template)
  end
end)]]

ESX.RegisterUsableItem('trimmedweed', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  local canUse = false
  local msg = ''
  if xPlayer.getInventoryItem('trimmedweed').count >= 200 and xPlayer.getInventoryItem('acidbat').count >= 5 then
    TriggerClientEvent("mythic_progbar:client:progress", source, {
      name = "unique_action_name",
      duration = 60000,
      label = "A produzir...",
      useWhileDead = false,
      canCancel = true,
      controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true
      },
      animation = {
          animDict = "missheistdockssetup1clipboard@idle_a",
          anim = "idle_a"
      },
      prop = {}
    }, nil)
    xPlayer.removeInventoryItem('acidbat', 5)
    xPlayer.removeInventoryItem('trimmedweed', 200)
    xPlayer.addInventoryItem('weed_brick', 1)
    canUse = true
    --msg = "Tu meteste "..MFD.WeedPerBag.." erva cortada dentro do saco"
    msg = ""
  elseif xPlayer.getInventoryItem('trimmedweed').count > 99 then
    msg = "Precisas de um ácido!"
  else
    msg = "Não tens marijuana suficiente!"
  end
end)

ESX.RegisterUsableItem('weed_brick', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  local canUse = false
  local msg = ''
  if xPlayer.getInventoryItem('weed_brick').count >= 1 and xPlayer.getInventoryItem('fishingknife').count >= 1 and xPlayer.getInventoryItem('drugscales').count >= 1 then
    TriggerClientEvent("mythic_progbar:client:progress", source, {
      name = "unique_action_name",
      duration = 60000,
      label = "A cortar o tijolo...",
      useWhileDead = false,
      canCancel = true,
      controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true
      },
      animation = {
          animDict = "missheistdockssetup1clipboard@idle_a",
          anim = "idle_a"
      },
      prop = {}
    }, nil)
    xPlayer.removeInventoryItem('weed_brick', 1)
    xPlayer.removeInventoryItem('fishingknife', 1)
    xPlayer.addInventoryItem('weed_100', 10)
    canUse = true
    --msg = "Tu meteste "..MFD.WeedPerBag.." erva cortada dentro do saco"
    msg = ""
  elseif xPlayer.getInventoryItem('fishingknife').count >= 1 then
    msg = "Precisas de uma faca!"
  else
    msg = "Precisas de uma balança!"
  end
end)

ESX.RegisterUsableItem('dopebag', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  local canUse = false
  local msg = ''
  if xPlayer.getInventoryItem('dopebag').count >= 1 and xPlayer.getInventoryItem('weed_100').count >= 1 and xPlayer.getInventoryItem('drugscales').count >= 1 then
    TriggerClientEvent("mythic_progbar:client:progress", source, {
      name = "unique_action_name",
      duration = 60000,
      label = "A empacotar as doses...",
      useWhileDead = false,
      canCancel = true,
      controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true
      },
      animation = {
          animDict = "missheistdockssetup1clipboard@idle_a",
          anim = "idle_a"
      },
      prop = {}
    }, nil)
    xPlayer.removeInventoryItem('weed_100', 1)
    xPlayer.removeInventoryItem('dopebag', 1)
    xPlayer.addInventoryItem('bagofdope', 50)
    canUse = true
    --msg = "Tu meteste "..MFD.WeedPerBag.." erva cortada dentro do saco"
    msg = ""
  elseif xPlayer.getInventoryItem('dopebag').count >= 1 and xPlayer.getInventoryItem('meth').count >= 1 and xPlayer.getInventoryItem('drugscales').count >= 1 then
    TriggerClientEvent("mythic_progbar:client:progress", source, {
      name = "unique_action_name",
      duration = 60000,
      label = "A empacotar as doses...",
      useWhileDead = false,
      canCancel = true,
      controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true
      },
      animation = {
          animDict = "missheistdockssetup1clipboard@idle_a",
          anim = "idle_a"
      },
      prop = {}
    }, nil)
    xPlayer.removeInventoryItem('meth', 1)
    xPlayer.removeInventoryItem('dopebag', 1)
    xPlayer.addInventoryItem('bagofmeth', 50)
    canUse = true
  end
end)

ESX.RegisterUsableItem('rolpaper', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  local canUse = false
  local msg = ''
  if xPlayer.getInventoryItem('bagofdope').count >= 1 and xPlayer.getInventoryItem('filter').count >= 1 and xPlayer.getInventoryItem('rolpaper').count >= 1 then
    TriggerClientEvent("mythic_progbar:client:progress", source, {
      name = "unique_action_name",
      duration = 5000,
      label = "A enrolar...",
      useWhileDead = false,
      canCancel = true,
      controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true
      },
      animation = {
          animDict = "missheistdockssetup1clipboard@idle_a",
          anim = "idle_a"
      },
      prop = {}
    }, nil)
    xPlayer.removeInventoryItem('bagofdope', 1)
    xPlayer.removeInventoryItem('rolpaper', 1)
    xPlayer.removeInventoryItem('filter', 1)
    xPlayer.addInventoryItem('joint', 1)
    canUse = true
    --msg = "Tu meteste "..MFD.WeedPerBag.." erva cortada dentro do saco"
    msg = ""
  end
end)

ESX.RegisterUsableItem('highgradefemaleseed', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(10); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('highgradefemaleseed').count > 0 and xPlayer.getInventoryItem('plantpot').count > 0 then
    xPlayer.removeInventoryItem('highgradefemaleseed', 1)
    xPlayer.removeInventoryItem('plantpot', 1)

    local template = MFD:PlantTemplate()
    template.Gender = "Female"
    template.Quality = 0.2
    template.Quality = math.random(200,500)/10
    template.Food =  math.random(200,400)/10
    template.Water = math.random(200,400)/10

    TriggerClientEvent('MF_DopePlant:UseSeed',source,template)
  end
end)