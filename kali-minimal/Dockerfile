FROM debian
LABEL maintainer="heywoodlh"

RUN  apt-get update \
	&& apt-get install -y gnupg2 \
	&& gpg --keyserver keyserver.ubuntu.com --recv-key  ED444FF07D8D0BF6 \
	&& gpg -a --export ED444FF07D8D0BF6 | apt-key add - \
	&& echo 'deb http://http.kali.org/kali kali-rolling main contrib non-free' >> /etc/apt/sources.list \
	&& rm -rf /var/lib/apt/lists/*

