FROM alpine as build

ENV nbtscan_version='1.0.35'
ENV prips_version='1.1.1'
ENV enum4linux_version='0.8.9'

#Red-team scripts installation
RUN apk add --no-cache git curl &&\
	git clone https://github.com/heywoodlh/red-scripts /opt/red-scripts

#NBTScan installation
RUN apk add --no-cache make gcc libc-dev &&\
	wget http://unixwiz.net/tools/nbtscan-source-$nbtscan_version.tgz -O /tmp/nbtscan.tgz &&\
	mkdir -p /tmp/nbtscan-src &&\
	tar xzf /tmp/nbtscan.tgz -C /tmp/nbtscan-src &&\
	cd /tmp/nbtscan-src &&\
	make &&\
	mv /tmp/nbtscan-src/nbtscan /usr/local/bin

#Prips installation
RUN wget http://devel.ringlet.net/files/sys/prips/prips-$prips_version.tar.gz -O /tmp/prips.tar.gz &&\
	mkdir -p /tmp/prips && tar xzf /tmp/prips.tar.gz -C /tmp/prips &&\
	cd /tmp/prips/prips-$prips_version &&\
	make && mv /tmp/prips/prips-$prips_version/prips /usr/local/bin/prips

#Enum4linux installation
RUN apk --no-cache add wget && wget --no-check-certificate https://labs.portcullis.co.uk/download/enum4linux-$enum4linux_version.tar.gz -O /tmp/enum4linux.tar.gz &&\
	mkdir -p /tmp/enum4linux && tar xzf /tmp/enum4linux.tar.gz -C /tmp/enum4linux &&\
	mv /tmp/enum4linux/enum4linux-$enum4linux_version/enum4linux.pl /usr/local/bin/enum4linux

FROM alpine
LABEL maintainer="heywoodlh"

#Tools installation
RUN apk add --no-cache bash \
	nmap bind-tools libpcap libpcap-dev \
	samba-client-libs samba-dev samba-client perl openldap-clients

#Prips installation
COPY --from=build /usr/local/bin/prips /usr/local/bin/

#NBTScan installation
COPY --from=build /usr/local/bin/nbtscan /usr/local/bin/

#Masscan installation
COPY --from=heywoodlh/telnet /usr/local/bin/masscan /usr/local/bin/masscan

#Enum4linux installation
COPY --from=build /usr/local/bin/enum4linux /usr/local/bin/enum4linux

#Tomnomnom tools
COPY --from=heywoodlh/tomnomnom-tools /usr/local/bin/ /usr/local/bin/
COPY --from=heywoodlh/tomnomnom-tools /root/.gf/ /root/.gf/

#Vulscan nmap script
COPY --from=heywoodlh/telnet /usr/share/nmap/scripts/vulscan/ /usr/share/nmap/scripts/vulscan/

#My red team scripts
COPY --from=build /opt/red-scripts/ /opt/red-scripts/
RUN ln -s /opt/red-scripts/netscan.sh /usr/local/bin/netscan

WORKDIR /opt/red-scripts
CMD "/bin/bash"
