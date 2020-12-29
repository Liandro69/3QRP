fx_version 'adamant'

game 'gta5'

description 'WellDone Center Salon Fryzjerski'

version '1.4.2'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/hairList.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'skinchanger',
	'tqrp_skin'
}
