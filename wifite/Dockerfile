FROM kalilinux/kali-rolling:latest
LABEL maintainer="heywoodlh"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get install -y \
	wifite \
	hcxdumptool \
	hcxtools \
	macchanger \
	bully \
	hashcat \
	&& rm -rf /var/lib/apt/lists/*

# Pyrit install (attack module for wifite)
RUN apt-get update \
	&& apt-get install -y \
	python2 \
	python2-dev \
	python-pip \
	git \
	libpq-dev \
	zlib1g-dev \
	libpcap-dev \
	&& ln -s $(which python2) /usr/bin/python \
	&& git clone https://github.com/JPaulMora/Pyrit.git /opt/pyrit \
	&& pip2 install psycopg2 scapy \
	&& cd /opt/pyrit \
	&& python2 setup.py clean \
	&& python setup.py build \
	&& python setup.py install \
	&& rm -rf /var/lib/apt/lists/*


ENTRYPOINT ["/usr/sbin/wifite"]
