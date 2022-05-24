FROM heywoodlh/kali-minimal
LABEL maintainer=heywoodlh

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	amap \
	commix \
	dsniff \
	dirb \
	dnschef dnsenum dnsmap dnsrecon dnswalk \
	exploitdb \
	hping3 \
	hydra \
	medusa \
	netdiscover ndiff nmap \
	man \
	nikto \
	padbuster \
	openjdk-17-jre-headless \
	reaver \
	responder \
	set \
	sqlmap \
	socat \
	theharvester \
	tshark \
	webscarab \
	wpscan \
	yersinia \
	zaproxy \
	bash-completion \
	neofetch &&\
	apt-get autoremove -y &&\
	apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
