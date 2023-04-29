FROM docker.io/lizardbyte/sunshine:nightly-archlinux
LABEL MAINTAINER=heywoodlh

USER root

RUN printf "[multilib]\nInclude = /etc/pacman.d/mirrorlist\n" >> /etc/pacman.conf \
    && pacman -Sy --noconfirm steam \
    && pacman -Scc --noconfirm 

RUN mkdir -p /steam &&\
    chown -R lizard /steam &&\
    mkdir -p /home/lizard/.local/share &&\
    ln -s /steam /home/lizard/.local/share/Steam &&\
    chown -R lizard /home/lizard/.local

USER lizard

VOLUME /steam

ENTRYPOINT steam && sunshine
