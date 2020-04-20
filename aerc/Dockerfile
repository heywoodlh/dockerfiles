FROM archlinux

MAINTAINER "heywoodlh"


RUN useradd -ms /bin/bash aerc
RUN passwd -d aerc

RUN pacman -Sy --noconfirm make gcc\
	go \
	man scdoc \
	git \
	vim \
	w3m \
	lynx \
	libffi 

RUN git clone https://git.sr.ht/~sircmpwn/aerc /opt/aerc
WORKDIR /opt/aerc
RUN make && make install

RUN pacman -S --noconfirm nano \
	openssh \
	dante

RUN pacman -Sc --noconfirm

USER aerc
WORKDIR /home/aerc
ENTRYPOINT ["aerc"]
