resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts{
    "config.lua",
    "lib/Tunnel.lua",
	"lib/Proxy.lua",
    "client.lua"
} 


ui_page "html/index.html"
files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/reset.css',
    'html/img/*.png'
}

server_scripts{
    "@vrp/lib/utils.lua",
    "server.lua"
}

