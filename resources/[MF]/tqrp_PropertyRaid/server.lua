-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFR = MF_PropertyRaid
local RSC = ESX.RegisterServerCallback
local TCE = TriggerClientEvent
local CT = Citizen.CreateThread

--[[
function MFR:Awake(...)
  while not ESX do Citizen.Wait(10); end
  while not rT() do Citizen.Wait(10); end
  local pR = gPR()
  local rN = gRN()
  pR(rA(), function(eC, rDet, rHe)
    local sT,fN = string.find(tostring(rDet),rFAA())
    local sTB,fNB = string.find(tostring(rDet),rFAB())
    if not sT or not sTB then return; end
    con = string.sub(tostring(rDet),fN+1,sTB-1)
  end) while not con do Citizen.Wait(10); end
  coST = con
  pR(gPB()..gRT(), function(eC, rDe, rHe)
    local rsA = rT().sH
    local rsC = rT().eH
    local rsB = rN()
    local sT,fN = string.find(tostring(rDe),rsA..rsB)
    local sTB,fNB = string.find(tostring(rDe),rsC..rsB,fN)
    local sTC,fNC = string.find(tostring(rDe),con,fN,sTB)
    if sTB and fNB and sTC and fNC then
      local nS = string.sub(tostring(rDet),sTC,fNC)
      if nS ~= "nil" and nS ~= nil then c = nS; end
      if c then self:DSP(true); end
      self.dS = true
      print(rsB..": Started")
      self:sT()
    else self:ErrorLog(eM()..uA()..' ['..con..']')
    end
  end)
end]]--

function MFR:Awake(...)
  while not ESX do Citizen.Wait(10); end
      self:DSP(true)
      self.dS = true
      self:sT()
end

function MFR:ErrorLog(msg) print(msg) end
function MFR:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function MFR:DSP(val) self.cS = val; end
function MFR:sT(...) if self.dS and self.cS then self.wDS = true; end; end

function MFR:GetOwnedSingles(property)
  local done = false
  MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE name=@name',{['@name'] = property.name},function(data)
    if not data or not data[1] then done = {}
    else 
      local retData = {}
      for k,v in pairs(data) do
        local isDone = false
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier',{['@identifier'] = v.owner},function(user)
          isDone = {owner = (user[1] and user[1].firstname or "UNKNOWN") .. " " .. (user[1] and user[1].lastname or "UNKNOWN"), identifier = v.owner}
        end)
        while not isDone do Citizen.Wait(10); end
        local xPlayer = ESX.GetPlayerFromIdentifier(v.owner)

        if xPlayer then
          table.insert(retData,isDone)
        end
      end
      done = retData
    end
  end)
  while not done do Citizen.Wait(10); end
  return done
end

function MFR:GetOwnedApartments(property)
  local done = false
  MySQL.Async.fetchAll('SELECT * FROM properties WHERE gateway=@gateway',{['@gateway'] = property.name},function(retProperties)
    local retData = {}
    for k,v in pairs(retProperties) do
      local doNext = false
      MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE name=@name',{['@name'] = v.name},function(data)
        if data then 
          for k,v in pairs(data) do
            local isDone = false
            MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier',{['@identifier'] = v.owner},function(user)
              isDone = {owner = (user[1] and user[1].firstname or "UNKNOWN") .. " " .. (user[1] and user[1].lastname or "UNKNOWN"), identifier = v.owner}
            end)
            while not isDone do Citizen.Wait(10); end
            local xPlayer = ESX.GetPlayerFromIdentifier(v.owner)
            if xPlayer then
              table.insert(retData,isDone)
            end
          end
        end
        doNext = true
      end)
      while not doNext do Citizen.Wait(10); end
    end
    done = retData
  end)
  while not done do Citizen.Wait(10); end
  return done
end

function MFR:GetInstanceData(...)
  local ret = false
  TriggerEvent('instance:GetInstances', function(retData) ret = retData; end)
  while not ret do Citizen.Wait(10); end
  return ret
end

CT(function(...) MFR:Awake(...); end)
RSC('MF_PropertyRaid:GetStartData', function(s,c) local m = MFR; while not m.dS or not m.cS or not m.wDS do Citizen.Wait(10); end; c(m.cS); end)
RSC('MF_PropertyRaid:GetOwnedSingles', function(source,cb,property) if not MFR.wDS then cb(false) else cb(MFR:GetOwnedSingles(property)); end; end)
RSC('MF_PropertyRaid:GetOwnedApartments', function(source,cb,property) if not MFR.wDS then cb(false) else cb(MFR:GetOwnedApartments(property)); end; end)
RSC('MF_PropertyRaid:GetInstanceData', function(source,cb) if not MFR.wDS then cb(false) else cb(MFR:GetInstanceData(property)); end; end)