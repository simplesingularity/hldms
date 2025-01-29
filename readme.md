# Dockerized Half-Life Deathmatch Source Dedicated Server
The only working HLDMS dedicated server available right now, thanks to a bug that makes it hard to install on Linux systems.

# How do I build this image?
There are many ways, but I usually use Portainer running on Ubuntu Server, I go under Images -> Build a new image -> Upload .tar

# OS/Linux
Designed to run on Ubuntu and Debian

# Easy to deploy
Use a Portainer stack using the sample Docker compose file provided. Designed to use bound volumes out of the box.

# Ports
27015/tcp and 27005/udp

# How do I configure and customize my server?
After successful first run of the image, shell/putty into your host device and open "~/hldms/hl1mp/cfg" and create your server.cfg file (may have to use sudo nano server.cfg)

# Known bugs and contributing
Use VS code or other editor and make sure line breaks are LF (not Windows CRLF) this will mess up entrypoint.sh at least
Only known bug afaik is if you choose to bind folder /app/hldms to a local one (default), then it wont copy ./server.cfg for some reason. But just make your own.

# Bonus list of items/weapons/ammo 
Can't find this anywhere on the internet for some reason
```
weapon_snark
weapon_handgrenade
weapon_hornetgun
weapon_357
weapon_gauss
weapon_mp5
weapon_satchel
weapon_shotgun
weapon_rpg
weapon_egon
weapon_crossbow

ammo_buckshot
ammo_9mmAR
ammo_rpgclip
ammo_gaussclip
ammo_357
ammo_ARgrenades
ammo_crossbow

item_longjump
item_healthkit
item_battery
```
