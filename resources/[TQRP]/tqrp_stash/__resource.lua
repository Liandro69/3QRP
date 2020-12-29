resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

name 'Monster Vault'
description 'An Vault script built for Monster ESX Framework - A Monster ESX Framework built for MonsterSrRP NOHD Nightmare'
author 'TaerAttO'
version 'v1.0.0'
url 'https://discord.io/secretTH'

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'tqrp_addonaccount',
	'tqrp_addoninventory',
	'tqrp_datastore'
}

exports {
	"getMonsterVaultLicense"
}