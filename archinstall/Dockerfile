FROM heywoodlh/archlinux
LABEL MAINTAINER="heywoodlh"

RUN pacman -Sy --noconfirm archinstall \
	&& pacman -Scc --noconfirm

ENTRYPOINT ["archinstall"]
