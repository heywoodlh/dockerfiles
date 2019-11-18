FROM kalilinux/kali-linux-docker

LABEL maintainer="heywoodlh"

RUN apt-get -y update && \
	apt-get install -y \
	wifite \
	hcxdumptool \
	hcxtools \
	pyrit \
	macchanger \
	bully &&\
	apt-get autoremove -y && \
	apt-get clean

CMD "/usr/sbin/wifite"
