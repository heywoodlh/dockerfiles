FROM debian AS masscan-build

RUN apt-get update \
	&& apt-get install -y git make gcc \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/robertdavidgraham/masscan /opt/masscan \
	&& cd /opt/masscan \
	&& make 

FROM debian
LABEL maintainer=heywoodlh

COPY --from=masscan-build /opt/masscan/bin/masscan /usr/local/bin/masscan

RUN apt-get update \
	&& apt-get install -y telnet nmap netcat-openbsd \
	&& rm -rf /var/lib/apt/lists/*

