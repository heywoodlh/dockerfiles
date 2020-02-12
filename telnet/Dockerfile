FROM alpine

LABEL maintainer="heywoodlh"

#Telnet, netcat and nmap installation
RUN apk add --no-cache busybox-extras netcat-openbsd nmap

#Masscan installation
RUN apk add --no-cache clang gcc libc-dev git make libc6-compat libpcap-dev linux-headers && \
    cd /tmp && \
    git clone https://github.com/robertdavidgraham/masscan && \
    cd masscan && \
    make -j && \
    mv bin/masscan /usr/local/bin && \
    rm -rf /tmp/masscan && \
    apk del clang git make linux-headers libc-dev gcc


CMD "/bin/ash"
