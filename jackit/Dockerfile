FROM debian
MAINTAINER heywoodlh

RUN apt-get update && apt-get install -y git \
	python python-pip \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/insecurityofthings/jackit /opt/jackit &&\
	cd /opt/jackit &&\
	pip2 install -e .

WORKDIR /opt/jackit
CMD ["/usr/sbin/jackit"]
