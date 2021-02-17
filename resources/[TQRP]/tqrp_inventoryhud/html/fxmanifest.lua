fx_version 'adamant'

game 'gta5'

description "ESX Inventory HUD"

version "1.1"

ui_page "html/ui.html"

client_scripts {
  "@es_extended/locale.lua",
  "client/main.lua",
  "client/shop.lua",
  "client/trunk.lua",
  "client/property.lua",
  "client/motels.lua",
  "client/beds.lua",
  "client/player.lua",
  "client/glovebox.lua",
  "client/vault.lua",
  "client/weapons.lua",
  "common/weapons.lua",
  "locales/cs.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "config.lua"
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  "@es_extended/locale.lua",
  "server/main.lua",
  "common/weapons.lua",
  "locales/cs.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "config.lua"
}

files {
  "html/ui.html",
  "html/css/ui.css",
  "html/css/jquery-ui.css",
  "html/js/inventory.js",
  "html/js/config.js",
  -- JS LOCALES
  "html/locales/cs.js",
  "html/locales/en.js",
  "html/locales/fr.js",
  -- IMAGES
  "html/img/bullet.png"

}
