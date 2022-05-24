FROM golang:bullseye AS build

RUN apt-get update \
	&& apt-get install -y git curl \
	&& rm -rf /var/lib/apt/lists/*

RUN go install github.com/tomnomnom/httprobe@latest
RUN go install github.com/tomnomnom/meg@latest


RUN git clone https://github.com/heywoodlh/netscan /opt/netscan

FROM heywoodlh/kali-minimal:latest
LABEL MAINTAINER=heywoodlh

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
	&& apt-get install -y nbtscan prips enum4linux polenum masscan nmap dnsutils \
	&& rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/netscan/netscan.sh /usr/bin/netscan
COPY --from=build /opt/netscan/VERSION /opt/VERSION
ADD https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/combined_directories.txt /etc/paths


RUN chmod +x /usr/bin/netscan

#Tomnomnom tools
COPY --from=build /go/bin/* /usr/bin/
COPY --from=heywoodlh/tomnomnom-tools /root/.gf/ /root/.gf/

ENTRYPOINT ["netscan"]
