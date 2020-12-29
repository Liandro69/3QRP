fx_version 'adamant'

game 'gta5'

description 'ESX Outlaw Alert'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua'
}
server_export 'ShowAlert'
export 'ShowAlert'

ui_page {
    'html/ui.html',
}

files {
	'html/ui.html',
	'html/js/app.js', 
	'html/js/jquery.min.js', 
	'html/css/style.css',
	'html/css/bootstrap.min.css'
}