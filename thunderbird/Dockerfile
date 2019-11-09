FROM archlinux:latest
MAINTAINER heywoodlh

# Install thunderbird
RUN pacman --noconfirm -Sy thunderbird \
        libcanberra \
        --assume-installed hwids \
        --assume-installed kbd \
        --assume-installed kmod \
        --assume-installed libseccomp \
        --assume-installed systemd

COPY init.sh /init.sh

CMD ["/init.sh"]
