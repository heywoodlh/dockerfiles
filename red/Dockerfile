FROM alpine as build

#Masscan installation
RUN apk add --no-cache clang gcc libc-dev git make libc6-compat libpcap-dev linux-headers && \
    git clone https://github.com/robertdavidgraham/masscan /opt/masscan && \
    cd /opt/masscan && \
    make -j

#Nmap vulscan script
RUN git clone https://github.com/scipag/vulscan /opt/vulscan

#My red team scripts
RUN git clone https://github.com/heywoodlh/red-scripts /opt/red-scripts

FROM debian
LABEL maintainer="heywoodlh"

#Tools installation
RUN apt-get update && apt-get install -y nmap prips dnsutils nbtscan &&\
	rm -rf /var/lib/apt/lists/*

#Masscan installation
COPY --from=build /opt/masscan/bin/masscan /usr/local/bin/masscan

#Vulscan nmap script
COPY --from=build /opt/vulscan /usr/share/nmap/scripts/vulscan

#My red team scripts
COPY --from=build /opt/red-scripts /opt/red-scripts

WORKDIR /opt/red-scripts
CMD "/bin/bash"
