fx_version 'bodacious'

game 'gta5'

description 'A advanced job system'

lua54 'true'

author 'Haroki and Boost'

server_scripts {
    'server/**/**.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/**/**.lua',
}
