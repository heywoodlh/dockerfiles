FROM archlinux:latest

MAINTAINER heywoodlh

## Core packages
RUN pacman -Sy --noconfirm python python-pip

RUN useradd -ms /bin/bash shodan
RUN passwd -l root
RUN passwd -l shodan

USER shodan

RUN pip install --user shodan

ENTRYPOINT ["/home/shodan/.local/bin/shodan"] 
