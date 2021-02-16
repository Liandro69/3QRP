fx_version 'adamant'

game 'gta5'

client_scripts {
  'utils.lua',
  'incl.lua',
  'config.lua',
	'client.lua',
}

server_scripts {	
  '@mysql-async/lib/MySQL.lua',
  'utils.lua',
  'incl.lua',
	'config.lua',
	'server.lua',
}