#!/usr/bin/env sh
~/steamcmd/steamcmd.sh +runscript ~/script.txt

cd /app/hldms
./srcds_run -debug "$@"