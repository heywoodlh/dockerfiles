FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine321
RUN apk add --no-cache firefox \
  && apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing davmail

# Run as unprivileged `adc` user
ENV PUID=1000
ENV PGID=1000

COPY davmail.sh /davmail.sh
VOLUME /home/abc/.config/davmail

RUN mkdir -p /defaults \
  && echo "/davmail.sh" > /defaults/autostart

