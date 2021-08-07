games {'gta5'}

fx_version 'cerulean'

description "Spontane Roleplay | Duty System | 16.06.2021"

client_scripts {
  "client/cl_*.lua"
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  "server/sv_*.lua"
}