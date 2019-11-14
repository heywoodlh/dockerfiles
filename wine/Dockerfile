FROM debian:buster
LABEL maintainer="heywoodlh"

RUN apt-get update &&\
	apt-get install -y wine winetricks && \
	dpkg --add-architecture i386 &&\
        apt-get update &&\
        apt-get install -y wine32

RUN useradd -ms /bin/bash wine
RUN chown -R wine:wine /opt/
RUN passwd -l root
RUN passwd -l wine

USER wine
WORKDIR /home/wine/
