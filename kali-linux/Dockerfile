FROM debian
LABEL maintainer=heywoodlh

ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'deb [trusted=yes] http://http.kali.org/kali kali-rolling main contrib non-free' >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y kali-linux-core \
	pciutils \
	bash-completion &&\
	apt-get autoremove -y &&\
	apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
