FROM steamcmd/steamcmd:latest
WORKDIR $HOME
RUN whoami
RUN mkdir -p /app
RUN mkdir -p /app/hldms
RUN mkdir -p /app/hldms/hl1mp
RUN mkdir -p /app/hldms/hl1mp/cfg
EXPOSE 27015
EXPOSE 27015/udp
EXPOSE 27005/udp
COPY ./entrypoint.sh ./entrypoint.sh
COPY ./server.cfg /app/hldms/hl1mp/cfg/server.cfg
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
CMD ["-game hl1mp", "+map crossfire", "-maxplayers 16", "+sv_lan 0"]

# So our Steam files are currently in
# $HOME/.local/ and $HOME/.steam/ and our executable is supposedly usr/bin/steamcmd or usr/games/steamcmd

# And our server files are in /app/hldms
# The reason I run as windows, then linux is because of a bug 
# that makes people unable to download the linux version of Half-Life DeathMatch Source Dedicated Server
# but the workaround is mentioned here: https://github.com/ihaveamac/srcds-nix/issues/1