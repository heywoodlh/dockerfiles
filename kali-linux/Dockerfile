FROM kalilinux/kali-rolling 
LABEL maintainer=heywoodlh

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	kali-linux-headless \
	amap \
	dnswalk \
	medusa \
	ndiff \
	man \
	padbuster \
	webscarab \
	yersinia \
	bash-completion \
	neofetch &&\
	apt-get autoremove -y &&\
	apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
