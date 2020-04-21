FROM archlinux

MAINTAINER "heywoodlh"


RUN useradd -ms /bin/bash pass
RUN passwd -d pass

RUN pacman -Sy --noconfirm pass gnupg pinentry

RUN pacman -Sc --noconfirm

USER pass
WORKDIR /home/pass
CMD ["pass"]
