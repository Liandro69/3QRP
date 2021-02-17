fx_version 'adamant'
game 'gta5'

mod 'tqrp_base'
version '1.0.0'

ui_page "Jobs/html/menu.html"

client_scripts {
	'@es_extended/locale.lua',
	'General/prop.lua',
	'General/3dme_cl.lua',
	'General/cctv_cl.lua',
 	'General/script_cl.lua',
	'General/blips_cl.lua',
	'General/bino_cl.lua',
	'General/flatbed.lua',
	'General/carry_cl.lua',
	'General/discord_cl.lua',
	'General/wob_cl.lua',
	'Jobs/locales/en.lua',
	'Jobs/locales/br.lua',
	'Jobs/gui.lua',
	'Jobs/config.lua',
	'Jobs/client/main.lua',
	'Tasks/Fuel/config.lua',
	'Tasks/Fuel/functions/functions_client.lua',
	'Tasks/Fuel/source/fuel_client.lua',
	'Tasks/Garbage/client/functions.lua',
	'Tasks/Garbage/client/main.lua',
	'Tasks/Uber/config.lua',
	'Tasks/Uber/client/client.lua',
	--'Tasks/SitLay/client.lua',
	--'Tasks/SitChair/client.lua',
	'Tasks/Scrap/client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'General/script_sv.lua',
	'General/3dme_sv.lua',
	'General/id_sv.lua',
	'General/carry_sv.lua',
	'General/bino_sv.lua',
	'Jobs/locales/en.lua',
	'Jobs/locales/br.lua',
	'Jobs/config.lua',
	'Jobs/server/main.lua',
	'Tasks/Fuel/config.lua',
	'Tasks/Fuel/source/fuel_server.lua',
	'Tasks/Garbage/server/functions.lua',
	'Tasks/Garbage/server/main.lua',
	'Tasks/Uber/config.lua',
	'Tasks/Uber/server/server.lua',
--	'Tasks/SitLay/server.lua',
	--'Tasks/SitChair/server.lua',
	'Tasks/Scrap/server/main.lua'
}


files {
	"Jobs/html/menu.html",
	"Jobs/html/raphael.min.js",
    "Jobs/html/wheelnav.min.js",
	"Jobs/html/logout.png",
	"Jobs/html/faturas.png",
    "Jobs/html/anim.png",
	"Jobs/html/limp.png",
	"Jobs/html/del.png",
    "Jobs/html/rebocar.png",
	"Jobs/html/logout.png",
	"Jobs/html/spawn.png",
	"Jobs/html/cone.png",
	"Jobs/html/macaco.png",
	"Jobs/html/exhaust.png",
	"Jobs/html/amb.png",
	"Jobs/html/bandage.png",
	"Jobs/html/life.png",
	"Jobs/html/medkit.png",
	"Jobs/html/medbox.png",
	"Jobs/html/luvas.png",
	"Jobs/html/ferramentas.png"
	
}

dependencies {
	'es_extended',
	'tqrp_billing'
}

exports {
	'attach',
	'removeall',
	'GetPlayerNames',
	'GetFuel',
	'SetFuel',
	'hasKeys'
}



