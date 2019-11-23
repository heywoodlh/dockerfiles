FROM archlinux:latest
MAINTAINER heywoodlh

RUN pacman -Sy --noconfirm git python2 python2-pip

RUN git clone https://github.com/insecurityofthings/jackit /opt/jackit &&\
	cd /opt/jackit &&\
	pip2 install -e .

WORKDIR /opt/jackit
CMD ["/usr/sbin/jackit"]
