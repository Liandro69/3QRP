resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependencies {
	'es_extended',
}

client_script {
    "client.lua",
    "config.lua"
}

server_script {
    "server.lua",
	"config.lua"
}

ui_page "html/menu.html"

files {
	"html/menu.html",
	"html/raphael.min.js",
    "html/wheelnav.min.js",
    "html/doors.png",
    "html/engine.png",
    "html/save.png",
    "html/pessoal.png",
	"html/locked.png",
    "html/docs.png",
    "html/anim.png",
    "html/anim2.png",
    "html/anim3.png",
	"html/drag.png",
    "html/hood.png",
    "html/key.png",
	"html/see.png",
    "html/give.png",
    "html/idcard.png",
    "html/idcar.png",
	"html/idgun.png",
    "html/give.png",
    "html/job.png",
    "html/windows.png",
    "html/more.png",
    "html/logout.png",
	"html/money.png",
	"html/colocarplate.png",
	"html/search.png",
	"html/cuff.png",
    "html/uncuff.png",
    "html/carry.png",
    "html/putintrunk.png",
    "html/putouttrunk.png",
    "html/porta2.png",
    "html/portas.png",
    "html/inveh.png",
    "html/entertrunk.png",
    "html/leavetrunk.png",
	"html/outveh.png",
    "html/trunk.png",
    "html/craft.png"
}