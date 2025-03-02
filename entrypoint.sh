#!/usr/bin/env sh
cd ~

/usr/games/steamcmd +runscript ~/script.txt

cd /app/hldms
./srcds_run "$@"