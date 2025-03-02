FROM debian:latest

# create user for steam
RUN adduser \
	--home /home/steam \
	--disabled-password \
	--shell /bin/bash \
	--gecos "user for running steam" \
	--quiet \
	steam
	
RUN echo steam steam/license note '' | debconf-set-selections &&\
	echo steam steam/question select "I AGREE" | debconf-set-selections
	
RUN apt-get update &&\
	apt-get install -y software-properties-common &&\
	apt-add-repository -U http://deb.debian.org/debian -c main -c contrib -c non-free-firmware -c non-free &&\
	apt-add-repository -U http://deb.debian.org/debian -c main -c contrib -c non-free-firmware -c non-free &&\
	dpkg --add-architecture i386 &&\
	apt-get update -y &&\
	apt-get install -y lib32gcc-s1 &&\
	apt-get install -y steamcmd

# make some directories
RUN mkdir -p /app
RUN mkdir -p /app/hldms
RUN chown -R steam /app/hldms

# copy some files over
COPY ./script.txt /home/steam/script.txt
COPY ./entrypoint.sh /home/steam/entrypoint.sh
RUN chown -R steam /home/steam
RUN chmod +x /home/steam/entrypoint.sh

# open some ports
EXPOSE 27015
EXPOSE 27015/udp
EXPOSE 27005/udp

# SteamCMD should not be used as root, here we set up user and variables
USER steam

RUN ls

# Execution vector
ENTRYPOINT ["/home/steam/entrypoint.sh"]
CMD ["-game hl1mp", "+map crossfire", "-maxplayers 16", "+sv_lan 0"]