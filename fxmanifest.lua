fx_version 'cerulean'

game 'gta5'

author 'JL Development, Renewed, and others'

lua54 'yes' -- Add in case you want to use lua 5.4 (https://www.lua.org/manual/5.4/manual.html)

shared_scripts {
    '@qb-core/shared/locale.lua',
	'locales/*.lua',
    'shared/config.lua',
    'shared/boosting.lua',
    'shared/bennys.lua',
    'shared/darkweb.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/js/index.js',
    'html/assets/index.css',
    'html/assets/logo.png',
    'html/assets/pop.ogg',
    'html/assets/*.png',
    'html/assets/*.jpg',
    'html/images/*.jpg',
    'html/images/*.png',
    'html/images/apps/*.png',
}
