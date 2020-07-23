FROM archlinux
MAINTAINER "heywoodlh"

RUN pacman -Sy --noconfirm links libevent

RUN useradd -ms /bin/bash links
RUN passwd -d links

USER links
WORKDIR /home/links
ENTRYPOINT ["/usr/bin/links"]
