fx_version 'bodacious'
game 'gta5'

author 'Three Queens Roleplay'
description 'TQRP Car Wash'
version '1.0.0'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua'
}

client_script 'client/main.lua'