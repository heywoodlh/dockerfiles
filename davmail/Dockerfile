FROM ghcr.io/linuxserver/baseimage-kasmvnc:fedora41
RUN dnf install -y firefox \
  && dnf install -y https://download.opensuse.org/repositories/home:/mguessan:/davmail/Fedora_41/noarch/davmail-6.8.1-2.1.noarch.rpm

# Run as unprivileged `adc` user
ENV PUID=1000
ENV PGID=1000

COPY davmail.sh /davmail.sh
VOLUME /home/abc/.config/davmail

RUN mkdir -p /defaults \
  && echo "/davmail.sh" > /defaults/autostart

