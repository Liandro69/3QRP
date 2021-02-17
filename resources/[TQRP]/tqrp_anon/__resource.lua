description 'ESX Anonymous'

author 'Babooche#0001'

this_is_a_map 'yes'

version '0.0.1'

client_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'client/main.lua'
}

server_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'server/main.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/img/image.png',
    'html/css/app.css',
    'html/scripts/app.js'
}