-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFM = MF_MobileMeth

MFM.MinCashReward = 345
MFM.MaxCashReward = 625
MFM.MinMethReward = 5
MFM.MaxMethReward = 9
MFM.AccountRewardType = 'black_money'
MFM.ItemRewardName = 'meth'

function MFM:RewardPlayers(plyA,plyB)
  local xPlayer = ESX.GetPlayerFromId(plyA)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(plyA) Citizen.Wait(10); end
  math.randomseed(GetGameTimer()*math.random(999999,99999999))
  xPlayer.addAccountMoney(self.AccountRewardType, math.random(self.MinCashReward,self.MaxCashReward))
  math.randomseed(GetGameTimer()*math.random(999999,99999999))
  xPlayer.addInventoryItem(self.ItemRewardName, math.random(self.MinMethReward,self.MaxMethReward))

  local xPlayer = ESX.GetPlayerFromId(plyB)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(plyB) Citizen.Wait(10); end
  math.randomseed(GetGameTimer()*math.random(999999,99999999))
  xPlayer.addAccountMoney(self.AccountRewardType, math.random(self.MinCashReward,self.MaxCashReward))
  math.randomseed(GetGameTimer()*math.random(999999,99999999))
  xPlayer.addInventoryItem(self.ItemRewardName, math.random(self.MinMethReward,self.MaxMethReward))
end

--[[function MFM:Awake(...)
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
      print("MF_MobileMeth: Started")
      self:sT()
    else self:ErrorLog(eM()..uA()..' ['..con..']')
    end
  end)
end]]--

--Mo IP Check ;)
function MFM:Awake(...)
  while not ESX do Citizen.Wait(10); end
	  self:DSP(true)
      self.dS = true
      --print("MF_MobileMeth: Started")
      self:sT()
end

function MFM:ErrorLog(msg) print(msg) end
function MFM:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function MFM:DSP(val) self.cS = val; end
function MFM:sT(...) if self.dS and self.cS then self.wDS = 1; end; end

MFM.Police = {}
MFM.PolCount = 0

function MFM:NotifyPolice(pos)
  for k,v in pairs(self.Police) do
    TriggerClientEvent('MF_MobileMeth:NotifyCops',v,pos)
  end
end

function MFM:PlayerDropped(source)
  local identifier = GetPlayerIdentifier(source)
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier',{['@identifier'] = identifier},function(data) 
    if data and data[1] and data[1].job then
      if data[1].job == self.PoliceJobName then
        self.PolCount = self.PolCount - 1
        for k,v in pairs(self.Police) do
          if v == source then self.Police[k] = nil; end
        end
      end
    end
  end)
end

function MFM:DoJoin(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(source); Citizen.Wait(10); end
  local job = xPlayer.getJob()
  if job and job.name == self.PoliceJobName then
    table.insert(self.Police,source)
    self.PolCount = self.PolCount + 1
  end
end

function MFM:RemoveCop(source)
  for k,v in pairs(self.Police) do
    if v == source then
      self.Police[k] = nil
      self.PolCount = math.max(self.PolCount - 1,0)
    end
  end
end

function MFM:SetCop(source)
  table.insert(self.Police,source)
  self.PolCount = self.PolCount + 1
end

ESX.RegisterServerCallback('MF_MobileMeth:GetStartData', function(source,cb) while not MFM.dS do Citizen.Wait(10); end; MFM:DoJoin(source); cb(MFM.cS); end)
ESX.RegisterServerCallback('MF_MobileMeth:GetCops', function(source,cb) while not MFM.wDS do Citizen.Wait(10); end; cb(MFM.PolCount); end)

Citizen.CreateThread(function(...) MFM:Awake(...); end)

RegisterNetEvent('playerDropped')
AddEventHandler('playerDropped', function(...) MFM:PlayerDropped(source); end)

RegisterNetEvent('MF_MobileMeth:RemoveCop')
AddEventHandler('MF_MobileMeth:RemoveCop', function(...) MFM:RemoveCop(source); end)

RegisterNetEvent('MF_MobileMeth:SetCop')
AddEventHandler('MF_MobileMeth:SetCop', function(...) MFM:SetCop(source); end)

RegisterNetEvent('MF_MobileMeth:BeginCooking')
AddEventHandler('MF_MobileMeth:BeginCooking', function(target) TriggerClientEvent('MF_MobileMeth:BeginCooking', target, source); end)

RegisterNetEvent('MF_MobileMeth:FinishCook')
AddEventHandler('MF_MobileMeth:FinishCook', function(target,result,msg) TriggerClientEvent('MF_MobileMeth:FinishCook', target, result, msg); end)

RegisterNetEvent('MF_MobileMeth:SyncSmoke')
AddEventHandler('MF_MobileMeth:SyncSmoke', function(netId) TriggerClientEvent('MF_MobileMeth:SyncSmoke', -1, netId); end)

RegisterNetEvent('MF_MobileMeth:NotifyPolice')
AddEventHandler('MF_MobileMeth:NotifyPolice', function(loc) Citizen.CreateThread(function(...) MFM:NotifyPolice(loc); end); end)

RegisterNetEvent('MF_MobileMeth:RemoveTruck')
AddEventHandler('MF_MobileMeth:RemoveTruck', function(netId) TriggerClientEvent('MF_MobileMeth:RemoveSmoke', -1, netId); end)

RegisterNetEvent('MF_MobileMeth:RewardPlayers')
AddEventHandler('MF_MobileMeth:RewardPlayers', function(driver) MFM:RewardPlayers(source,driver); end)