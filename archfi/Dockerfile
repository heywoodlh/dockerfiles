FROM archlinux

MAINTAINER "heywoodlh"

RUN pacman -Sy --noconfirm git \
	parted \
	gptfdisk \
	arch-install-scripts \
	libnewt \
	slang \
	gpm \
	wget \
	dosfstools \
	exfat-utils \
	btrfs-progs

RUN git clone https://github.com/MatMoul/archfi /opt/archfi


ENTRYPOINT ["bash", "/opt/archfi/archfi"]
