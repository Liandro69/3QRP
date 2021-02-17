-- Manifest Version
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- UI
ui_page "ui/index.html"

files {
	"ui/index.html",
	"ui/assets/clignotant-droite.svg",
	"ui/assets/clignotant-gauche.svg",
	"ui/assets/feu-position.svg",
	"ui/assets/feu-route.svg",
	"ui/assets/fuel.svg",
	"ui/assets/belton.png",
	"ui/assets/beltoff.png",
	"ui/assets/belton2.png",
	"ui/assets/cruise.png",
	"ui/assets/engine1.png",
	"ui/assets/engine2.png",
	"ui/assets/compass.png",
	"ui/assets/keys.png",
	"ui/assets/beltoff2.png",
	"ui/fonts/fonts/ChaletComprimeCologneSixty.ttf",
	"ui/fonts/fonts/ChaletLondonNineteenSixty.ttf",
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js"
}

-- Client Scripts
client_scripts {
	'@es_extended/locale.lua',
	"client/heli_cl.lua",
	"client/client.lua",
	"config.lua"
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	"server/heli_sv.lua",
	"server/server.lua",
}
