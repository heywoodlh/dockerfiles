FROM archlinux

RUN pacman -Sy --noconfirm nodejs npm
RUN passwd -l root

RUN useradd -ms /bin/bash node
RUN passwd -l node

RUN npm install -g localtunnel

USER node
ENTRYPOINT ["/usr/sbin/lt"]
