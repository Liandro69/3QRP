fx_version 'adamant'

game 'gta5'

client_scripts {
  'incl.lua',
  'utils.lua',
  'config.lua',
	'client.lua',
}

server_scripts {	
  '@mysql-async/lib/MySQL.lua',
  'incl.lua',
  'utils.lua',
	'config.lua',
	'server.lua',
}