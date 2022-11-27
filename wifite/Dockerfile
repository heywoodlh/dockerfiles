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

ENTRYPOINT ["/usr/sbin/wifite"]
