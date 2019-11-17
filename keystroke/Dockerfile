FROM archlinux:latest
MAINTAINER heywoodlh

RUN pacman -Sy --noconfirm sudo git make sdcc binutils python2 python2-pip fakeroot &&\
	pip2 install crcmod enum
RUN useradd -ms /bin/bash keystroke
RUN passwd -d keystroke
RUN mkdir -p /etc/sudoers.d/ && printf 'keystroke ALL=(ALL) ALL\n' | tee -a /etc/sudoers.d/keystroke
RUN chown -R keystroke:keystroke /opt/

USER keystroke
RUN git clone https://aur.archlinux.org/python-pyusb-git.git /opt/python-pyusb &&\
	cd /opt/python-pyusb &&\
	makepkg --noconfirm -si
RUN git clone https://github.com/marcnewlin/presentation-clickers /opt/presentation-clickers
WORKDIR /opt/presentation-clickers
RUN make

WORKDIR /opt/presentation-clickers/tools
CMD ["/bin/bash"]
