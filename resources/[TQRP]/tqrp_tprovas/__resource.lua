resource_manifest_version "44fhb6ba-d386-j61k-lfbjk-587127f4edm89"

client_scripts {
  'client/main.lua',
  'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}
