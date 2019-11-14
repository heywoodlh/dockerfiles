FROM archlinux:latest
MAINTAINER heywoodlh

RUN echo '[multilib]' | tee -a /etc/pacman.conf &&\
	echo 'Include = /etc/pacman.d/mirrorlist' | tee -a /etc/pacman.conf

RUN pacman -Sy --noconfirm wine wine-mono
RUN useradd -ms /bin/bash wine
RUN passwd -l wine
RUN passwd -l root

USER wine
WORKDIR /home/wine
