FROM heywoodlh/archlinux
LABEL MAINTAINER=heywoodlh

RUN pacman -Sy --noconfirm sudo shadow binutils fakeroot git pacutils perl-libwww perl-term-ui perl-json perl-data-dump perl-lwp-protocol-https perl-term-readline-gnu

RUN mkdir -p /etc/sudoers.d/ \
	&& echo 'trizen ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/trizen

RUN useradd -ms /bin/bash trizen \
	&& passwd -l trizen

RUN git clone https://aur.archlinux.org/trizen.git /opt/trizen
WORKDIR /opt/trizen
USER trizen
RUN sudo chown -R trizen /opt/trizen \
	&& makepkg -si --noconfirm

WORKDIR /home/trizen

RUN sudo pacman -Scc --noconfirm \
	&& sudo rm -rf /opt/trizen
