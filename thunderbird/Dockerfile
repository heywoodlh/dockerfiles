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


RUN useradd -ms /bin/bash thunderbird
RUN passwd -d thunderbird
USER thunderbird
WORKDIR /home/thunderbird
RUN mkdir -p /home/thunderbird/.thunderbird && chown -R thunderbird:thunderbird /home/thunderbird/.thunderbird

CMD ["thunderbird"]
