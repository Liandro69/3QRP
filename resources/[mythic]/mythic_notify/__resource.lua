fx_version 'adamant'

game 'gta5'

ui_page {
    'html/ui.html'
}

files {
	'html/ui.html',
	'html/js/app.js', 
	'html/css/style.css'
}

client_scripts {
	'client/main.lua'
}

server_scripts {
	'server/main.lua'
}

exports {
	'SendAlert',
	'PersistentAlert'
}

dependencies {
	'es_extended'
}