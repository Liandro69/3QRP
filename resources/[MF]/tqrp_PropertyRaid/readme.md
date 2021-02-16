-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

Requirements
- ESX
- tqrp_Property (and all dependencies)

Installation
- Extract to resources folder
- Start in server.cfg
- If sql file provided, import it.
- Make sure you read the config for things you might need to change.
- Make sure requirements are installed and started in server.cfg (if not provided, please ask via discord).
- Head to tqrp_property/server/main.lua
- Find the 'tqrp_property:getPropertyInventory' server callback, and replace it with the following:

ESX.RegisterServerCallback('tqrp_property:getPropertyInventory', function(source, cb, owner)
  local blackMoney = 0
  local items      = {}
  local weapons    = {}

  TriggerEvent('tqrp_addonaccount:getAccount', 'property_black_money', owner, function(account)
    blackMoney = account.money
  end)

  TriggerEvent('tqrp_addoninventory:getInventory', 'property', owner, function(inventory)
    items = inventory.items
  end)

  TriggerEvent('tqrp_datastore:getDataStore', 'property', owner, function(store)
    weapons = store.get('weapons') or {}
  end)

  cb({
    blackMoney = blackMoney,
    items      = items,
    weapons    = weapons
  })
end)

- Head into instance/server/main.lua
- Paste this at the bottom of the file, and save:

RegisterNetEvent('instance:GetInstances')
AddEventHandler('instance:GetInstances', function(cb) cb(Instances); end)

- Make sure you're added to webhook. If you have no idea what that is, head to the link above and create a ticket.


--------------------
Important Read notes
--------------------

Due to the whacky way that instancing and tqrp_property work together, this mod is limited to working only when the target player is online and inside their house.
You won't be able to remove items from their tqrp_property inventory, but you will be able to look inside. This is mostly tailored to those who are using instanced
objects and storages, such as PlayerSafes and DopePlant, while disabling the standard tqrp_property inventory.