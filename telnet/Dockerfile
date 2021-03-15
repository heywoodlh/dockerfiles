FROM alpine as build

#Masscan installation
RUN apk add --no-cache clang gcc libc-dev git make libc6-compat libpcap-dev linux-headers && \
    git clone --depth=1 https://github.com/robertdavidgraham/masscan /opt/masscan && \
    cd /opt/masscan && \
    git fetch --unshallow && \
    make -j

#Nmap vulscan script
RUN git clone https://github.com/scipag/vulscan /opt/vulscan

FROM alpine
LABEL maintainer="heywoodlh"

#Telnet, netcat and nmap installation
RUN apk add --no-cache busybox-extras netcat-openbsd nmap nmap-scripts libpcap libpcap-dev

#Masscan installation
COPY --from=build /opt/masscan/bin/masscan /usr/local/bin/masscan

#Vulscan nmap script
COPY --from=build /opt/vulscan /usr/share/nmap/scripts/vulscan

CMD "/bin/ash"
