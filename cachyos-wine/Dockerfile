FROM docker.io/ubuntu:24.04

COPY ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources
COPY build.sh /build.sh

RUN dpkg --add-architecture i386 \
  && apt -y build-dep -y wine \
  && apt update \
  && apt install -y apt-transport-https \
    git \
    ca-certificates \
    cabextract \
    git \
    gosu \
    gpg-agent \
    locales \
    p7zip \
    sudo \
    tzdata \
    unzip \
    wget \
    winbind \
    xvfb \
    zenity

ENTRYPOINT [ "/build.sh" ]
