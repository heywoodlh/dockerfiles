FROM alpine as build

ENV nbtscan_version='1.0.35'
ENV prips_version='1.1.1'
ENV enum4linux_version='0.8.9'
ENV polenum_version='0.2'

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
	mv /tmp/enum4linux/enum4linux-$enum4linux_version/enum4linux.pl /usr/local/bin/enum4linux &&\
	wget --no-check-certificate https://labs.portcullis.co.uk/download/polenum-$polenum_version.tar.bz2 -O /tmp/polenum.tar.bz2 &&\
	mkdir -p /tmp/polenum && tar xjf /tmp/polenum.tar.bz2 -C /tmp/polenum &&\
	sed -i -e '1s:#!/usr/bin/python:#!/usr/bin/python2:' /tmp/polenum/polenum-$polenum_version/polenum.py &&\
	mv /tmp/polenum/polenum-$polenum_version/polenum.py /usr/local/bin/polenum.py

FROM heywoodlh/telnet
LABEL maintainer="heywoodlh"

#Tools installation
RUN apk add --no-cache bash \
	nmap nmap-scripts bind-tools libpcap libpcap-dev \
	samba-client-libs samba-dev samba-client perl openldap-clients

#Prips installation
COPY --from=build /usr/local/bin/prips /usr/local/bin/

#NBTScan installation
COPY --from=build /usr/local/bin/nbtscan /usr/local/bin/

#Enum4linux installation
COPY --from=build /usr/local/bin/enum4linux /usr/local/bin/enum4linux

#Polenum.py installation
COPY --from=build /usr/local/bin/polenum.py /usr/local/bin/polenum.py
RUN apk --no-cache add gcc musl-dev libffi-dev openssl-dev python2 python2-dev &&\
	wget https://bootstrap.pypa.io/pip/2.7/get-pip.py -O /tmp/get-pip.py &&\
	python2 /tmp/get-pip.py &&\
	rm /tmp/get-pip.py &&\
	python2 -m pip --no-cache-dir install impacket

#Tomnomnom tools
COPY --from=heywoodlh/tomnomnom-tools /usr/local/bin/ /usr/local/bin/
COPY --from=heywoodlh/tomnomnom-tools /root/.gf/ /root/.gf/

#My red team scripts
COPY --from=build /opt/red-scripts/ /opt/red-scripts/
RUN ln -s /opt/red-scripts/netscan.sh /usr/local/bin/netscan

WORKDIR /opt/red-scripts
CMD "/bin/bash"
