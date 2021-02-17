resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

name 'tqrp Phone'

client_scripts {
	'client/main.lua',
	'client/animation.lua',
    'config/*.lua',
    "client/apps/home.lua",
    "client/apps/contacts.lua",
    "client/apps/phone.lua",
    "client/apps/messages.lua",
    "client/apps/twitter.lua",
    "client/apps/insta.lua",

    "client/apps/faturas.lua",
    "client/apps/google.lua",
    "client/apps/info.lua",
    "client/apps/notas.lua",
    "client/apps/vehicles.lua",
    "client/apps/yellowPages.lua",
    "client/apps/wallpaper.lua",
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config/*.lua',
    'server/main.lua',
    'server/items.lua',
    'server/commands.lua',
    'server/apps/contacts.lua',
    'server/apps/notas.lua',
    'server/apps/faturas.lua',
    'server/apps/insta.lua',
    'server/apps/messages.lua',
    'server/apps/phone.lua',
    'server/apps/twitter.lua',
    'server/apps/vehicles.lua',
    'server/apps/yellowPages.lua',
    --'server/apps/*.lua',
}

ui_page {
	'html/index.html'
}

files {
	'html/index.html',

	'html/css/materialize.css',
	'html/css/style.css',

	------------------ css/apps
	'html/css/apps/contacts.css',
	'html/css/apps/home.css',
	'html/css/apps/messages.css',
	'html/css/apps/phone.css',
	'html/css/apps/twitter.css',
    'html/css/apps/insta.css',

    'html/css/apps/faturas.css',
    'html/css/apps/google.css',
    'html/css/apps/notas.css',
    'html/css/apps/vehicles.css',
    'html/css/apps/yellowPages.css',
    'html/css/apps/info.css',
    'html/css/apps/wallpaper.css',

	------------------ css/config
	'html/css/apps/config.css',

    'html/libs/jquery-ui.min.css',

    'html/js/app.js',

    'html/js/app.js',

    'html/js/apps/contacts.js',
    'html/js/apps/home.js',
    'html/js/apps/twitter.js',
    'html/js/apps/insta.js',

    'html/js/apps/yellowPages.js',
    'html/js/apps/info.js',
    'html/js/apps/notas.js',
    'html/js/apps/faturas.js',
    'html/js/apps/google.js',
    'html/js/apps/vehicles.js',
    'html/js/apps/wallpaper.js',

    'html/js/apps/messages/convo.js',
    'html/js/apps/messages/messages.js',

    'html/js/apps/phone/call.js',
    'html/js/apps/phone/phone.js',
    
	--------------------libs
    'html/libs/all.min.css',
    'html/libs/jquery.min.js',
    'html/libs/jquery.mask.min.js',
    'html/libs/jquery-ui.min.js',
    'html/libs/materialize.min.js',
    'html/libs/moment.min.js',

	--------------------fontawesome
    'html/webfonts/fa-brands-400.eot',
    'html/webfonts/fa-brands-400.svg',
    'html/webfonts/fa-brands-400.ttf',
    'html/webfonts/fa-brands-400.woff',
    'html/webfonts/fa-brands-400.woff2',
    'html/webfonts/fa-regular-400.eot',
    'html/webfonts/fa-regular-400.svg',
    'html/webfonts/fa-regular-400.ttf',
    'html/webfonts/fa-regular-400.woff',
    'html/webfonts/fa-regular-400.woff2',
    'html/webfonts/fa-solid-900.eot',
    'html/webfonts/fa-solid-900.svg',
    'html/webfonts/fa-solid-900.ttf',
    'html/webfonts/fa-solid-900.woff',
    'html/webfonts/fa-solid-900.woff2',
	-----------------------------------
	--img
	'html/img/background1.png',
	'html/img/background2.png',
	'html/img/background3.png',
    'html/img/background4.png',
    'html/img/background5.png',
    'html/img/background6.png',
	'html/img/phone-frame.png',

    'html/img/tweet.png',
    'html/img/insta.png',
    'html/img/google.png',
    'html/img/yellowPages.png',
}   
