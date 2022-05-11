fx_version 'cerulean'

game 'gta5'

author 'T&J, JL, Fjamzoo and others'

client_scripts {
    'client/*.lua'
}

server_scripts {
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
    'web/public/build/bundle.js.map',
    'web/public/audio/*.ogg'
}

lua54 'yes'