fx_version 'cerulean'

game 'gta5'

author 'Project Sloth'

lua54 'yes' -- Add in case you want to use lua 5.4 (https://www.lua.org/manual/5.4/manual.html)

shared_scripts {
    'shared/config.lua',
    'shared/boosting.lua'
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

ui_page 'web/public/index.html'

files {
    'web/public/index.html',
    'web/public/images/*.png',
    'web/public/images/*.jpg',
    'web/public/images/*.svg',
    'web/public/images/apps/*.png',
    'web/public/global.css',
    'web/public/build/bundle.js',
    'web/public/build/bundle.css',
    'web/public/audio/*.ogg'
}
