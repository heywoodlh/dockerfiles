FROM archlinux
MAINTAINER heywoodlh

# Install Ghex
RUN pacman -Sy --noconfirm ghex

RUN useradd -ms /bin/bash ghex
RUN passwd -l ghex &&\
	passwd -l root

USER ghex
WORKDIR /home/ghex

ENTRYPOINT ["ghex"]
