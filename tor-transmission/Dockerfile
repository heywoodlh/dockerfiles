FROM archlinux:latest

MAINTAINER heywoodlh

## Core packages
RUN pacman -Syu --noconfirm &&\
	pacman -S --noconfirm transmission-cli tor torsocks

RUN passwd -l root
RUN passwd -l transmission

#ADD https://raw.githubusercontent.com/heywoodlh/dockerfiles/master/files/sandbox/torrc.default /etc/tor/torrc.default

RUN chown -R transmission:transmission /etc/tor/ &&\
	chown -R transmission:transmission /var/lib/tor/

ADD 'https://raw.githubusercontent.com/heywoodlh/dockerfiles/master/tor-transmission/start.sh' /opt/start.sh

RUN chown transmission:transmission /opt/start.sh &&\
	chmod +x /opt/start.sh

USER transmission
ENTRYPOINT ["/opt/start.sh"]
