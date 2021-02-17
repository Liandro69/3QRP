ESX = nil
local arrayWeight = {}

TriggerEvent(
  "esx:getSharedObject",
  function(obj)
    ESX = obj
  end
)

AddEventHandler("onMySQLReady",function()
    MySQL.Async.execute("DELETE FROM trunk_inventory WHERE owned = 0", {}, function(rowsChanged)
      if rowsChanged ~= nil then
        TriggerEvent("tqrp_base:serverlog", "Apagados ["..rowsChanged.."] Veículos sem dono.", "SERVER", GetCurrentResourceName())
      end
    end)
end)


RegisterServerEvent("tqrp_trunk_inventory:getOwnedVehicule")
AddEventHandler("tqrp_trunk_inventory:getOwnedVehicule", function()
  local vehicules = {}
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  if xPlayer ~= nil then
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner",
    {
      ["@owner"] = xPlayer.identifier
    },
    function(result)
      if result ~= nil and #result > 0 then
        for _, v in pairs(result) do
          local vehicle = json.decode(v.vehicle)
          table.insert(vehicules, {plate = vehicle.plate, props = vehicle})
        end
      end
      TriggerClientEvent("tqrp_trunk_inventory:setOwnedVehicule", _source, vehicules)
    end)
  end
end)

function getItemWeight(item,xplayer)
  local weight = 0
  local itemWeight = 0
  if item ~= nil then
      itemWeight = xplayer.getInventoryItem(item).weight
  end
  return itemWeight
end

function getInventoryWeight(inventory,xplayer)
  local weight = 0
  local itemWeight = 0
  if inventory ~= nil then
    for i = 1, #inventory, 1 do
        if inventory[i].name ~= nil then
          itemWeight = getItemWeight(inventory[i].name, xplayer)
        end
        weight = weight + (itemWeight * (inventory[i].count or 1))
    end
  end
  return weight
end

function getTotalInventoryWeight(plate, playerid)
  local total
  local xPlayer = ESX.GetPlayerFromId(playerid)
  TriggerEvent("tqrp_trunk:getSharedDataStore", plate, function(store)
    local W_weapons = getInventoryWeight(store.get("weapons") or {}, xPlayer)
    local W_coffre = getInventoryWeight(store.get("coffre") or {}, xPlayer)
    local W_blackMoney = 0
    local blackAccount = (store.get("black_money")) or 0
    if blackAccount ~= 0 then
      W_blackMoney = blackAccount[1].amount / 10
    end
    total = W_weapons + W_coffre + W_blackMoney
  end)
  return total
end

ESX.RegisterServerCallback("tqrp_trunk:getInventoryV",function(source, cb, plate)
  TriggerEvent("tqrp_trunk:getSharedDataStore", plate, function(store)
    local _source = source
    local blackMoney = 0
    local items = {}
    local weapons = {}
    weapons = (store.get("weapons") or {})

    local blackAccount = (store.get("black_money")) or 0
    if blackAccount ~= 0 then
      blackMoney = blackAccount[1].amount
    end
    local coffre = (store.get("coffre") or {})
    for i = 1, #coffre, 1 do
      table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
    end

    local weight = getTotalInventoryWeight(plate, _source)
    cb({
        blackMoney = blackMoney,
        items = items,
        weapons = weapons,
        weight = weight
      })
  end)
end)

RegisterServerEvent("tqrp_trunk:getItem")
AddEventHandler("tqrp_trunk:getItem", function(plate, type, item, count, max, owned)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  if item ~= nil then
    if type == "item_standard" then
      --local targetItem = xPlayer.getInventoryItem(item)
      if xPlayer.canCarryItem(item, count) then
        TriggerEvent(
          "tqrp_trunk:getSharedDataStore",
          plate,
          function(store)
            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              if coffre[i].name == item then
                if (coffre[i].count >= count and count > 0) then
                  xPlayer.addInventoryItem(item, count)
                  TriggerEvent("tqrp_base:serverlog", "**Tirou mala do carro** " .. item .. " x" .. count .. " [" .. plate .. "]", _source, GetCurrentResourceName())
                  if (coffre[i].count - count) == 0 then
                    table.remove(coffre, i)
                  else
                    coffre[i].count = coffre[i].count - count
                  end

                  break
                else
                  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Quantidade inválida!' })
                end
              end
            end

            store.set("coffre", coffre)

            local blackMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end

            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
            end

            local weight = getTotalInventoryWeight(plate,_source)

            text = _U("trunk_info", plate, weight , max )
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("tqrp_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, items, weapons)
          end
        )
      else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Sem espaço no inventário!' })
      end
    end

    if type == "item_account" then
      TriggerEvent(
        "tqrp_trunk:getSharedDataStore",
        plate,
        function(store)
          local blackMoney = store.get("black_money")
          if (blackMoney[1].amount >= count and count > 0) then
            blackMoney[1].amount = blackMoney[1].amount - count
            store.set("black_money", blackMoney)
            xPlayer.addAccountMoney(item, count)
            TriggerEvent("tqrp_base:serverlog", "**Tirou mala do carro** " .. item .. " x" .. count .. " [" .. plate .. "]", _source, GetCurrentResourceName())
            local blackMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end

            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
            end

            local weight = getTotalInventoryWeight(plate, _source)

            text = _U("trunk_info", plate, (weight / 1000), (max / 1000))
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("tqrp_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, items, weapons)
          else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Quantidade inválida!' })
          end
        end
      )
    end

    if type == "item_weapon" then
      TriggerEvent(
        "tqrp_trunk:getSharedDataStore",
        plate,
        function(store)
          local storeWeapons = store.get("weapons")

          if storeWeapons == nil then
            storeWeapons = {}
          end

          local weaponName = nil
          local ammo = nil

          for i = 1, #storeWeapons, 1 do
            if storeWeapons[i].name == item then
              weaponName = storeWeapons[i].name
              ammo = storeWeapons[i].ammo

              table.remove(storeWeapons, i)

              break
            end
          end
          store.set("weapons", storeWeapons)
          xPlayer.addWeapon(weaponName, ammo)
          TriggerEvent("tqrp_base:serverlog", "**Tirou mala do carro** " .. weaponName .. " x" .. ammo .. " [" .. plate .. "]", _source, GetCurrentResourceName())
          local blackMoney = 0
          local items = {}
          local weapons = {}
          weapons = (store.get("weapons") or {})

          local blackAccount = (store.get("black_money")) or 0
          if blackAccount ~= 0 then
            blackMoney = blackAccount[1].amount
          end

          local coffre = (store.get("coffre") or {})
          for i = 1, #coffre, 1 do
            table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
          end

          local weight = getTotalInventoryWeight(plate, _source)

          text = _U("trunk_info", plate, (weight / 1000), (max / 1000))
          data = {plate = plate, max = max, myVeh = owned, text = text}
          TriggerClientEvent("tqrp_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, items, weapons)
        end
      )
    end
  end
end)

RegisterServerEvent("tqrp_trunk:putItem")
AddEventHandler("tqrp_trunk:putItem",function(plate, type, item, count, max, owned, label)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

    if type == "item_standard" then
      local playerItemCount = xPlayer.getInventoryItem(item).count
      if (playerItemCount >= count and count > 0) then
        TriggerEvent(
          "tqrp_trunk:getSharedDataStore",
          plate,
          function(store)
            local found = false
            local coffre = (store.get("coffre") or {})

            for i = 1, #coffre, 1 do
              if coffre[i].name == item then
                coffre[i].count = coffre[i].count + count
                found = true
              end
            end
            if not found then
              table.insert(
                coffre,
                {
                  name = item,
                  count = count
                }
              )
            end
            if (getTotalInventoryWeight(plate,_source) + xPlayer.getInventoryItem(item).weight * count) > max then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não há espaço suficiente!' })
            else
              -- Checks passed, storing the item.
              store.set("coffre", coffre)
              xPlayer.removeInventoryItem(item, count)
              TriggerEvent("tqrp_base:serverlog", "**Colocou na mala do carro** " .. item .. " x" .. count .. " [" .. plate .. "] | OWNED: " .. tostring(owned), _source, GetCurrentResourceName())
            end
          end
        )
      else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Quantidade inválida!' })
      end
    end

    if type == "item_account" then
      local playerAccountMoney = xPlayer.getAccount(item).money

      if (playerAccountMoney >= count and count > 0) then
        TriggerEvent(
          "tqrp_trunk:getSharedDataStore",
          plate,
          function(store)
            local blackMoney = (store.get("black_money") or nil)
            if blackMoney ~= nil then
              blackMoney[1].amount = blackMoney[1].amount + count
            else
              blackMoney = {}
              table.insert(blackMoney, {amount = count})
            end

            if (getTotalInventoryWeight(plate, _source) + blackMoney[1].amount / 10) > max then
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Sem espaço no veículo!' })
            else
              -- Checks passed. Storing the item.
              xPlayer.removeAccountMoney(item, count)
              store.set("black_money", blackMoney)
              TriggerEvent("tqrp_base:serverlog", "**Colocou na mala do carro** " .. item .. " x" .. count .. " [" .. plate .. "] | OWNED: "..owned, _source, GetCurrentResourceName())
            end
          end
        )
      else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Quantidade inválida!' })
      end
    end

    if type == "item_weapon" then
      TriggerEvent(
        "tqrp_trunk:getSharedDataStore",
        plate,
        function(store)
          local storeWeapons = store.get("weapons")

          if storeWeapons == nil then
            storeWeapons = {}
          end

          table.insert(
            storeWeapons,
            {
              name = item,
              label = label,
              ammo = count
            }
          )
          if (getTotalInventoryWeight(plate, _source) + (getItemWeight(item, xPlayer))) > max then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Quantidade inválida!' })
          else
            store.set("weapons", storeWeapons)
            xPlayer.removeWeapon(item)
            TriggerEvent("tqrp_base:serverlog", "**Colocou na mala do carro** " .. item .. " [" .. plate .. "] | OWNED: "..owned, _source, GetCurrentResourceName())
          end
        end
      )
    end
    TriggerEvent(
      "tqrp_trunk:getSharedDataStore",
      plate,
      function(store)
        local blackMoney = 0
        local items = {}
        local weapons = {}
        weapons = (store.get("weapons") or {})

        local blackAccount = (store.get("black_money")) or 0
        if blackAccount ~= 0 then
          blackMoney = blackAccount[1].amount
        end

        local coffre = (store.get("coffre") or {})
        for i = 1, #coffre, 1 do
          table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
        end

        local weight = getTotalInventoryWeight(plate, _source)

        text = _U("trunk_info", plate, weight, max)
        data = {plate = plate, max = max, myVeh = owned, text = text}
        TriggerClientEvent("tqrp_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, items, weapons)
      end
    )
  end
)

ESX.RegisterServerCallback(
  "tqrp_trunk:getPlayerInventory",
  function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackMoney = xPlayer.getAccount("black_money").money
    local items = xPlayer.inventory

    cb(
      {
        blackMoney = blackMoney,
        items = items
      }
    )
  end
)

function all_trim(s)
  if s then
    return s:match "^%s*(.*)":match "(.-)%s*$"
  else
    return "noTagProvided"
  end
end
