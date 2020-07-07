FROM archlinux AS stage0

RUN pacman -Sy --noconfirm make gcc\
	go \
	man scdoc \
	pandoc \
	git 

RUN git clone https://git.sr.ht/~sircmpwn/aerc /opt/aerc
WORKDIR /opt/aerc
RUN make && make install

RUN pacman -Sc --noconfirm &&\
	ln -s /usr/lib/libffi.so.7 /usr/lib/libffi.so.6

FROM archlinux AS stage1
MAINTAINER "heywoodlh"

RUN useradd -ms /bin/bash aerc
RUN passwd -d aerc

RUN pacman -Sy --noconfirm git \
	vim nano \
	w3m \
	libffi \
	openssh \
	dante \
	pass \
	khard \
	fzf \
	perl

COPY --from=stage0 /usr/local/bin/aerc /usr/local/bin/
COPY --from=stage0 /usr/local/share/aerc/ /usr/local/share/aerc/

RUN ln -s /usr/lib/perl?/?.??/core_perl/CORE/libperl.so /usr/lib/

USER aerc
WORKDIR /home/aerc
ENTRYPOINT ["/usr/local/bin/aerc"]
