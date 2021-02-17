ESX = nil
local arrayWeight = Config.localWeight
local VehicleList = {}
local VehicleInventory = {}

TriggerEvent(
  "esx:getSharedObject",
  function(obj)
    ESX = obj
  end
)

AddEventHandler(
  "onMySQLReady",
  function()
    MySQL.Async.execute("DELETE FROM `glovebox_inventory` WHERE `owned` = 0", {})
  end
)

RegisterServerEvent("tqrp_glovebox_inventory:getOwnedVehicle")
AddEventHandler("tqrp_glovebox_inventory:getOwnedVehicle",function()
    local vehicules = {}
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer then
      MySQL.Async.fetchAll(
        "SELECT * FROM owned_vehicles WHERE owner = @owner",
        {
          ["@owner"] = 	xPlayer.identifier
        },
        function(result)
          if result ~= nil and #result > 0 then
            for _, v in pairs(result) do
              local vehicle = json.decode(v.vehicle)
              table.insert(vehicules, {plate = vehicle.plate})
            end
          end
          TriggerClientEvent("tqrp_glovebox_inventory:setOwnedVehicle", _source, vehicules)
        end
      )
    end
  end)

function getItemWeight(item)
  local weight = 0
  local itemWeight = 0
  if item ~= nil then
    itemWeight = Config.DefaultWeight
    if arrayWeight[item] ~= nil then
      itemWeight = arrayWeight[item]
    end
  end
  return itemWeight
end

function getInventoryWeight(inventory)
  local weight = 0
  local itemWeight = 0
  if inventory ~= nil then
    for i = 1, #inventory, 1 do
      if inventory[i] ~= nil then
        itemWeight = Config.DefaultWeight
        if arrayWeight[inventory[i].name] ~= nil then
          itemWeight = arrayWeight[inventory[i].name]
        end
        weight = weight + (itemWeight * (inventory[i].count or 1))
      end
    end
  end
  return weight
end

function getTotalInventoryWeight(plate)
  local total
  TriggerEvent(
    "tqrp_glovebox:getSharedDataStore",
    plate,
    function(store)
      local W_weapons = getInventoryWeight(store.get("weapons") or {})
      local W_coffres = getInventoryWeight(store.get("coffres") or {})
      local W_blackMoney = 0
      local blackAccount = (store.get("black_money")) or 0
      if blackAccount ~= 0 then
        W_blackMoney = blackAccount[1].amount / 10
      end
      total = W_weapons + W_coffres + W_blackMoney
    end
  )
  return total
end

ESX.RegisterServerCallback(
  "tqrp_glovebox:getInventoryV",
  function(source, cb, plate)
    TriggerEvent(
      "tqrp_glovebox:getSharedDataStore",
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

        local coffres = (store.get("coffres") or {})
        for i = 1, #coffres, 1 do
          table.insert(items, {name = coffres[i].name, count = coffres[i].count, label = ESX.GetItemLabel(coffres[i].name)})
        end

        local weight = getTotalInventoryWeight(plate)
        cb(
          {
            blackMoney = blackMoney,
            items = items,
            weapons = weapons,
            weight = weight
          }
        )
      end
    )
  end
)

RegisterServerEvent("tqrp_glovebox:getItem")
AddEventHandler(
  "tqrp_glovebox:getItem",
  function(plate, type, item, count, max, owned)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if type == "item_standard" then
      local targetItem = xPlayer.getInventoryItem(item)
        if xPlayer.canCarryItem(item, count) then
        TriggerEvent(
          "tqrp_glovebox:getSharedDataStore",
          plate,
          function(store)
            local coffres = (store.get("coffres") or {})
            for i = 1, #coffres, 1 do
              if coffres[i].name == item then
                if (coffres[i].count >= count and count > 0) then
                  xPlayer.addInventoryItem(item, count)
                  if (coffres[i].count - count) == 0 then
                    table.remove(coffres, i)
                  else
                    coffres[i].count = coffres[i].count - count
                  end

                  break
                else
                  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Quantidade inválida!' })
                end
              end
            end

            store.set("coffres", coffres)

            local blackMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end

            local coffres = (store.get("coffres") or {})
            for i = 1, #coffres, 1 do
              table.insert(items, {name = coffres[i].name, count = coffres[i].count, label = ESX.GetItemLabel(coffres[i].name)})
            end

            local weight = getTotalInventoryWeight(plate)

            text = _U("glovebox_info", plate, (weight / 1000), (max / 1000))
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("tqrp_inventoryhud:refreshGloveboxInventory", _source, data, blackMoney, items, weapons)
          end
        )
      else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Sem espaço no inventário!' })
      end
    end

    if type == "item_account" then
      TriggerEvent(
        "tqrp_glovebox:getSharedDataStore",
        plate,
        function(store)
          local blackMoney = store.get("black_money")
          if (blackMoney[1].amount >= count and count > 0) then
            blackMoney[1].amount = blackMoney[1].amount - count
            store.set("black_money", blackMoney)
            xPlayer.addAccountMoney(item, count)

            local blackMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end

            local coffres = (store.get("coffres") or {})
            for i = 1, #coffres, 1 do
              table.insert(items, {name = coffres[i].name, count = coffres[i].count, label = ESX.GetItemLabel(coffres[i].name)})
            end

            local weight = getTotalInventoryWeight(plate)

            text = _U("glovebox_info", plate, (weight / 1000), (max / 1000))
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("tqrp_inventoryhud:refreshGloveboxInventory", _source, data, blackMoney, items, weapons)
          else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Quantidade inválida!' })
          end
        end
      )
    end

    if type == "item_weapon" then
      TriggerEvent(
        "tqrp_glovebox:getSharedDataStore",
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

          local blackMoney = 0
          local items = {}
          local weapons = {}
          weapons = (store.get("weapons") or {})

          local blackAccount = (store.get("black_money")) or 0
          if blackAccount ~= 0 then
            blackMoney = blackAccount[1].amount
          end

          local coffres = (store.get("coffres") or {})
          for i = 1, #coffres, 1 do
            table.insert(items, {name = coffres[i].name, count = coffres[i].count, label = ESX.GetItemLabel(coffres[i].name)})
          end

          local weight = getTotalInventoryWeight(plate)

          text = _U("glovebox_info", plate, (weight / 1000), (max / 1000))
          data = {plate = plate, max = max, myVeh = owned, text = text}
          TriggerClientEvent("tqrp_inventoryhud:refreshGloveboxInventory", _source, data, blackMoney, items, weapons)
        end
      )
    end
  end
)

RegisterServerEvent("tqrp_glovebox:putItem")
AddEventHandler(
  "tqrp_glovebox:putItem",
  function(plate, type, item, count, max, owned, label)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

    if type == "item_standard" then
      local playerItemCount = xPlayer.getInventoryItem(item).count

      if (playerItemCount >= count and count > 0) then
        TriggerEvent(
          "tqrp_glovebox:getSharedDataStore",
          plate,
          function(store)
            local found = false
            local coffres = (store.get("coffres") or {})

            for i = 1, #coffres, 1 do
              if coffres[i].name == item then
                coffres[i].count = coffres[i].count + count
                found = true
              end
            end
            if not found then
              table.insert(
                coffres,
                {
                  name = item,
                  count = count
                }
              )
            end
            if (getTotalInventoryWeight(plate) + (getItemWeight(item) * count)) > max then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Não há espaço suficiente!' })
            else
              -- Checks passed, storing the item.
              store.set("coffres", coffres)
              xPlayer.removeInventoryItem(item, count)
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
          "tqrp_glovebox:getSharedDataStore",
          plate,
          function(store)
            local blackMoney = (store.get("black_money") or nil)
            if blackMoney ~= nil then
              blackMoney[1].amount = blackMoney[1].amount + count
            else
              blackMoney = {}
              table.insert(blackMoney, {amount = count})
            end

            if (getTotalInventoryWeight(plate) + blackMoney[1].amount / 10) > max then
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Sem espaço no veículo!' })
            else
              -- Checks passed. Storing the item.
              xPlayer.removeAccountMoney(item, count)
              store.set("black_money", blackMoney)
            end
          end
        )
      else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Quantidade inválida!' })
      end
    end

    if type == "item_weapon" then
      TriggerEvent(
        "tqrp_glovebox:getSharedDataStore",
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
          if (getTotalInventoryWeight(plate) + (getItemWeight(item))) > max then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Quantidade inválida!' })
          else
            store.set("weapons", storeWeapons)
            xPlayer.removeWeapon(item)
          end
        end
      )
    end

    TriggerEvent(
      "tqrp_glovebox:getSharedDataStore",
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

        local coffres = (store.get("coffres") or {})
        for i = 1, #coffres, 1 do
          table.insert(items, {name = coffres[i].name, count = coffres[i].count, label = ESX.GetItemLabel(coffres[i].name)})
        end

        local weight = getTotalInventoryWeight(plate)

        text = _U("glovebox_info", plate, (weight / 1000), (max / 1000))
        data = {plate = plate, max = max, myVeh = owned, text = text}
        TriggerClientEvent("tqrp_inventoryhud:refreshGloveboxInventory", _source, data, blackMoney, items, weapons)
      end
    )
  end
)

ESX.RegisterServerCallback(
  "tqrp_glovebox:getPlayerInventory",
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
