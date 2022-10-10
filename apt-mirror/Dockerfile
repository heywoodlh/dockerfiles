FROM ubuntu:latest
LABEL MAINTAINER=heywoodlh

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
	apt-mirror &&\
	apt-get autoremove -y &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8

VOLUME ["/var/spool/apt-mirror"]

ENTRYPOINT ["apt-mirror"]
