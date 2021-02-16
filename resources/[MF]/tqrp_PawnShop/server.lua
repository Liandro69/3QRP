-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFP = MF_PawnShop
local RSC = ESX.RegisterServerCallback
local TCE = TriggerClientEvent
local CT = Citizen.CreateThread

--[[function MFP:Awake(...)
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

--No IP Check ;)
function MFP:Awake(...)
  while not ESX do Citizen.Wait(10); end
    self:DSP(true)
    self.dS = true
    --print("MF_PawnShop: Started")
    self:sT()
end

function MFP:ErrorLog(msg) print(msg) end
function MFP:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function MFP:DSP(val) self.cS = val; end
function MFP:sT(...)
  if self.dS and self.cS then 
    MySQL.Async.fetchAll('SELECT * FROM pawnshops',{},function(data)
      local shopData = {}
      if data and data[1] then
        for k,v in pairs(data) do
          local data = json.decode(v.shopdata)
          local dataBuy = data.buy or {}
          local dataSell = data.sell or {}
          local delTab = {}
          local cfgShop = self:GetShops()
          for key,val in pairs(dataBuy) do
            local doAdd = false
            if cfgShop[v.id] and cfgShop[v.id].buy and cfgShop[v.id].buy[key] then
              if cfgShop[v.id].buy[key].item == val.item then doAdd = true; end
            end
            if not doAdd then table.insert(delTab,key); end
          end
          for key,val in pairs(delTab) do dataBuy[val] = nil; end

          delTab = {}
          local cfgShop = self:GetShops()
          for key,val in pairs(dataSell) do
            local doAdd = false
            if cfgShop[v.id] and cfgShop[v.id].sell and cfgShop[v.id].sell[key] then
              if cfgShop[v.id].sell[key].item == val.item then doAdd = true; end
            end
            if not doAdd then table.insert(delTab,key); end
          end
          for key,val in pairs(delTab) do table.remove(dataSell,val); end
          data.buy = dataBuy
          data.sell = dataSell
          table.insert(shopData,{shopdata = data, id = v.id})
        end
      else
        for k,v in pairs(self:GetShops()) do
          if v.buy then for k,v in pairs(v.buy) do v.count = 0; end; end
          if v.sell then for k,v in pairs(v.sell) do v.count = 0; end; end
          table.insert(shopData,{shopdata = v, id = k})
        end
      end

      for k,v in pairs(self:GetShops()) do
        local match = false
        for key,val in pairs(shopData) do
          if k == val.id then match = true; end
        end
        if not match then 
          if v.buy then for k,v in pairs(v.buy) do v.count = 0; end; end
          if v.sell then for k,v in pairs(v.sell) do v.count = 0; end; end
          table.insert(shopData,{shopdata = v, id = k})
        end
      end

      for key,val in pairs(self:GetShops()) do
        local cfgBuy = val.buy or false
        local tabBuy = shopData[key] and shopData[key].shopdata and shopData[key].shopdata.buy or false

        if cfgBuy then 
          for k,v in pairs(cfgBuy) do 
            local tabVal = tabBuy[k] or false
            if tabVal then
              if v.price ~= tabVal.price then
                shopData[key].shopdata.buy[k].price = v.price
              end
            else
              v.count = v.startcount or 0
              table.insert(shopData[key].shopdata.buy,v)
            end
          end
        end

        local cfgSell = val.sell or false
        local tabSell = shopData[key] and shopData[key].shopdata and shopData[key].shopdata.sell or false
        if cfgSell then 
          for k,v in pairs(cfgSell) do 
            local tabVal = tabSell[k] or false
            if tabVal then
              if v.price ~= tabVal.price then
                shopData[key].shopdata.sell[k].price = v.price
              end
            else
              v.count = 0
              table.insert(shopData[key].shopdata.sell,v)
            end
          end
        end
      end

      self.ShopData = shopData
      self.wDS = true
      self:SqlSaveAll()
      --print("MF_PawnShop: Started")
    end)
  end
end

function MFP:SqlSaveAll(...)
  MySQL.Async.fetchAll('SELECT * FROM pawnshops',{},function(data)
    for k,v in pairs(self.ShopData) do
      local match = false
      for key,val in pairs(data) do
        val = {shopdata = json.decode(val.shopdata), id = val.id}
        if v.id == val.id then
          match = val
        end
      end
      if match then
        MySQL.Async.execute('UPDATE pawnshops SET shopdata=@shopdata WHERE id=@id',{['@shopdata'] = json.encode(v.shopdata),['@id'] = v.id})
      else
        MySQL.Async.execute('INSERT INTO pawnshops SET shopdata=@shopdata,id=@id',{['@shopdata'] = json.encode(v.shopdata),['@id'] = v.id})
      end
    end
  end)
end

function MFP:SqlSaveOne(shop)
  while self.IsBusy do Citizen.Wait(10); end
  self.IsBusy = true
  MySQL.Async.execute('UPDATE pawnshops SET shopdata=@shopdata WHERE id=@id',{['@shopdata'] = json.encode(shop.shopdata),['@id'] = shop.id},function(...) self.IsBusy = false; end)
end

function MFP:TryUseShop(shop)
  for k,v in pairs(self.ShopData) do
    if v.id == shop.id then
      if v.BeingUsed then
        return false
      else
        self.ShopData[k].BeingUsed = true
        return true
      end
    end
  end
end

function MFP.StopUsing(source,shop)
  local self = MFP
  for k,v in pairs(self.ShopData) do
    if v.id == shop.id then
      if v.BeingUsed then
        self.ShopData[k].BeingUsed = nil
        return
      end
    end
  end
end

function MFP.Buy(source,shop,itemdata,quantity)
  local self = MFP
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(source); Citizen.Wait(10); end
  local serverShop = false
  local item = false
  for k,v in pairs(self.ShopData) do
    if v.id == shop.id then
      serverShop = v
      for k,v in pairs(v.shopdata.buy) do
        if v.label == itemdata.label then item = k; end
      end
    end
  end
  if serverShop and item then
    if xPlayer.getMoney() >= quantity * itemdata.price then
      if serverShop.shopdata.buy[item].count >= quantity then
        local itemTable = serverShop.shopdata.buy[item]
        serverShop.shopdata.buy[item].count = serverShop.shopdata.buy[item].count - quantity
        if serverShop.shopdata.sell[item] then
          serverShop.shopdata.sell[item].count = serverShop.shopdata.sell[item].count - quantity
        end

        if itemTable.weapon then
          xPlayer.addWeapon(string.upper(itemTable.item))
          quantity = 1
        else
          xPlayer.addInventoryItem(itemTable.item,quantity)
        end
        xPlayer.removeMoney(quantity * itemTable.price)

        self:SqlSaveOne(serverShop)
        TriggerClientEvent('MF_PawnShop:SyncData',-1,self.ShopData)
      else
        self:NotifyClient(source,"The shopkeeper doesn't have that many.")
      end
    else
      self:NotifyClient(source,"You can't afford that.")
    end
  else
    self:NotifyClient(source,"Something went wrong.")
  end
end

function MFP.Sell(source,shop,itemdata,quantity)
  local self = MFP
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(source); Citizen.Wait(10); end
  local serverShop = false
  local item = false
  for k,v in pairs(self.ShopData) do
    if v.id == shop.id then
      serverShop = v
      for k,v in pairs(v.shopdata.sell) do
        if v.label == itemdata.label then item = k; end
      end
    end
  end
  if serverShop and item then
    local playerItem,loadout
    if itemdata.weapon then 
      playerItem = xPlayer.hasWeapon(string.upper(itemdata.item))
      quantity = 1
    else
      playerItem = xPlayer.getInventoryItem(itemdata.item)
    end
    if (playerItem and type(playerItem) ~= "boolean" and playerItem.count and playerItem.count >= quantity) or (playerItem and type(playerItem) == "boolean") then
      if serverShop.shopdata.sell[item].count + quantity <= serverShop.shopdata.sell[item].max then
        local itemTable = serverShop.shopdata.sell[item]
        serverShop.shopdata.sell[item].count = serverShop.shopdata.sell[item].count + quantity
        if serverShop.shopdata.buy[item] then
          serverShop.shopdata.buy[item].count = serverShop.shopdata.buy[item].count + quantity
        end

        if itemTable.weapon then
          xPlayer.removeWeapon(string.upper(itemTable.item))
        else
          xPlayer.removeInventoryItem(itemTable.item,quantity)
        end
        xPlayer.addMoney(quantity * itemTable.price)

        self:SqlSaveOne(serverShop)
        TriggerClientEvent('MF_PawnShop:SyncData',-1,self.ShopData)
      else
        self:NotifyClient(source,"The shopkeeper won't buy that many.")
      end
    else
      self:NotifyClient(source,"You don't have that many.")
    end
  else
    self:NotifyClient(source,"Something went wrong.")
  end
end

function MFP:NotifyClient(source,msg)
  TriggerClientEvent('MF_PawnShop:NotifyClient',source,msg)
end

CT(function(...) MFP:Awake(...); end)
RSC('MF_PawnShop:GetShopData', function(s,c) local m = MFP; while not m.dS or not m.cS or not m.wDS do Citizen.Wait(10); end; c(m.cS,m.ShopData); end)
RSC('MF_PawnShop:TryUse',function(source,cb,shop) cb(MFP:TryUseShop(shop)); end)
NewEvent(true,MFP.StopUsing,'MF_PawnShop:StopUsing')
NewEvent(true,MFP.Buy,'MF_PawnShop:Buy')
NewEvent(true,MFP.Sell,'MF_PawnShop:Sell')