FROM debian:latest

ENV HOME=/home/steam

# create user for steam
RUN adduser \
	--system \
	--uid 1000 \
	--home /home/steam \
	--disabled-password \
	--shell /bin/bash \
	--gecos "user for running steam" \
	--quiet \
	steam
	
RUN echo steam steam/license note '' | debconf-set-selections &&\
	echo steam steam/question select "I AGREE" | debconf-set-selections
	
RUN apt-get update &&\
	apt-get install -y software-properties-common curl sudo &&\
	apt-add-repository -U http://deb.debian.org/debian -c main -c contrib -c non-free-firmware -c non-free &&\
	apt-add-repository -U http://deb.debian.org/debian -c main -c contrib -c non-free-firmware -c non-free &&\
	dpkg --add-architecture i386 &&\
	apt-get update -y &&\
	apt-get install -y lib32gcc-s1 &&\
	apt-get install -y steamcmd


# copy some files over
COPY ./script.txt /home/steam/script.txt
COPY ./entrypoint.sh /home/steam/entrypoint.sh
RUN chmod +x /home/steam/entrypoint.sh
RUN chmod +755 /home/steam/script.txt


RUN chown -R steam /home/steam
RUN chmod +x /home/steam/entrypoint.sh

RUN mkdir -m 777 -p /app/hldms
RUN chown -R steam /app/hldms /home/steam

RUN usermod -a -G tty steam && \
    chown -R steam /app /home/steam


#VOLUME /app/hldms /home/steam/steamcmd
WORKDIR /home/steam

RUN mkdir -m 777 -p /home/steam/steamcmd &&\
	cd /home/steam/steamcmd && \
	curl -s "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar -vxz &&\
	chown -R steam /home/steam/steamcmd

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