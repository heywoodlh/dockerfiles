FROM ubuntu:18.04
MAINTAINER heywoodlh

ENV LANG C.UTF-8
RUN  apt-get update &&\
	apt-get install -y wget software-properties-common supervisor &&\
	add-apt-repository -y universe &&\
	wget http://apt-stable.ntop.org/18.04/all/apt-ntop-stable.deb -O /tmp/apt-ntop-stable.deb &&\
	apt-get install -y /tmp/apt-ntop-stable.deb &&\
	apt-get update &&\
	apt-get install --no-install-recommends --no-install-suggests -y pfring nprobe ntopng ntopng-data &&\
	apt-get clean &&\
	rm -rf /tmp/* &&\
	rm -rf /var/tmp/* &&\
	rm -rf /var/lib/apt/lists/*

COPY supervisord.conf /etc/supervisord.conf
ENTRYPOINT ["/usr/bin/supervisord"]
