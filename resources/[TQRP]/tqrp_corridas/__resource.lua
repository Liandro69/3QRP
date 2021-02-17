resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "html/hud.html"

files {
	"html/hud.html",
	"html/js/gauge.min.js",
	"html/js/hud.js",
	"html/css/hud.css",
	"html/fonts/Oswald-Light.eot",
	"html/fonts/Oswald-Light.svg",
	"html/fonts/Oswald-Light.ttf",
	"html/fonts/Oswald-Light.woff",
	"html/fonts/Oswald-Light.woff2",
	"html/fonts/Oswald-Regular.eot",
	"html/fonts/Oswald-Regular.svg",
	"html/fonts/Oswald-Regular.ttf",
	"html/fonts/Oswald-Regular.woff",
	"html/fonts/Oswald-Regular.woff2",
	"html/images/speedcircle.png",
}

server_scripts {
    "config.lua",
    "port_sv.lua",
    "races_sv.lua",
}

client_scripts {
    "config.lua",
    "races_cl.lua",
}
