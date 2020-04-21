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
	dante \
	pass

RUN pacman -Sc --noconfirm &&\
	ln -s /usr/lib/libffi.so.7 /usr/lib/libffi.so.6

USER aerc
WORKDIR /home/aerc
ENTRYPOINT ["aerc"]
