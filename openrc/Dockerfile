FROM docker.io/alpine:latest AS base

RUN apk add --no-cache openrc
RUN mkdir -p /run/openrc && touch /run/openrc/softlevel
RUN sed -i 's/VSERVER/DOCKER/Ig' /lib/rc/sh/init.sh || true # sometimes fails on GitHub Actions

# configured /etc/rc.conf for docker
RUN sed -i '/getty/d' /etc/inittab

COPY openrc.sh /openrc.sh
ENTRYPOINT ["/openrc.sh"]
