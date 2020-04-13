FROM archlinux

MAINTAINER "heywoodlh"


RUN useradd -ms /bin/bash wtf
RUN passwd -d wtf
RUN passwd -d root

RUN pacman -Sy --noconfirm make gcc\
	go \
	git \
	libffi \
	vim \
	wget \
	nano

RUN git clone https://github.com/aserebryakov/vim-todo-lists /tmp/vim-todo-lists &&\
	mkdir -p /home/wtf/.vim &&\
	mv /tmp/vim-todo-lists/* /home/wtf/.vim/ &&\
	rm -rf /tmp/vim-todo-lists
	

RUN git clone https://github.com/wtfutil/wtf /opt/wtf
WORKDIR /opt/wtf
RUN make && make install

RUN pacman -Sc --noconfirm

USER wtf
WORKDIR /home/wtf
ENTRYPOINT ["/opt/wtf/bin/wtfutil"]
