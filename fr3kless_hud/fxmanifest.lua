fx_version "cerulean"
game "gta5"

lua54 "yes"
author 'ogfr3kless'
description 'vanerp hud'
version '07.10.2023'

exports {
    'talking',
    'changeproximity'
}

client_scripts {
    "client.lua"
}

shared_scripts {
    '@ox_lib/init.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
}

files {
    "html/ui.html",
    "html/ui.css",
    "html/ui.js"
}

ui_page "html/ui.html"