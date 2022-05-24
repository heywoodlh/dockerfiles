FROM archlinux:latest

RUN printf '[multilib]\nInclude = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf &&\
	pacman -Sy --noconfirm steam
RUN pacman -Sy --noconfirm awk grep file

RUN useradd -ms /bin/bash steam &&\
	passwd -d steam &&\
	passwd -d root

USER steam
RUN mkdir -p /home/steam/.local/share/Steam

ENTRYPOINT "/usr/bin/steam"
