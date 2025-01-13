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

FILE=/app/hldms/srcds_run
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "$FILE does not exist."
	/usr/games/steamcmd +runscript $HOME/script1.txt
fi


/usr/games/steamcmd +runscript $HOME/script2.txt
#./steamcmd.sh "$@"

cd /app/hldms
./srcds_run "$@"