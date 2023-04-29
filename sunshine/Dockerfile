FROM docker.io/lizardbyte/sunshine:nightly-archlinux
LABEL MAINTAINER=heywoodlh

RUN pacman -Sy --noconfirm steam \
    && pacman -Scc --noconfirm 

RUN useradd -m -s /bin/bash steam 

RUN mkdir -p /steam &&
    chown -R steam:steam /steam

VOLUME /steam

ENTRYPOINT steam && sunshine
