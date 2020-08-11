FROM alpine

LABEL maintainer="heywoodlh"

#Telnet, netcat and nmap installation
RUN apk add --no-cache busybox-extras netcat-openbsd nmap nmap-scripts

#Masscan installation
RUN apk add --no-cache clang gcc libc-dev git make libc6-compat libpcap-dev linux-headers && \
    cd /tmp && \
    git clone https://github.com/robertdavidgraham/masscan && \
    cd masscan && \
    make -j && \
    mv bin/masscan /usr/local/bin && \
    rm -rf /tmp/masscan
    
#Nmap NSE setup
RUN git clone https://github.com/scipag/vulscan /usr/share/nmap/scripts/vulscan

#Cleanup
RUN apk del clang git make linux-headers libc-dev gcc


CMD "/bin/ash"
