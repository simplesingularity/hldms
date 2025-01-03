#!/usr/bin/env sh
cd $HOME

cat << EOF >> $HOME/script1.txt
@sSteamCmdForcePlatformType windows
@ShutdownOnFailedCommand 1
@NoPromptForPassword 1
force_install_dir /app/hldms
login anonymous
app_update 255470
quit
EOF

cat << EOF >> $HOME/script2.txt
@sSteamCmdForcePlatformType linux
@ShutdownOnFailedCommand 1
@NoPromptForPassword 1
force_install_dir /app/hldms
login anonymous
app_update 255470 validate
quit
EOF

/usr/games/steamcmd +runscript $HOME/script1.txt
/usr/games/steamcmd +runscript $HOME/script2.txt
#./steamcmd.sh "$@"

cd /app/hldms
./srcds_run "$@"