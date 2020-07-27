FROM golang:latest AS build

RUN apt-get update && apt-get install -y man git

RUN git clone https://git.sr.ht/~sircmpwn/scdoc /opt/scdoc
WORKDIR /opt/scdoc
RUN make && make install

RUN git clone https://git.sr.ht/~sircmpwn/aerc /opt/aerc
WORKDIR /opt/aerc
RUN make && make install

FROM debian:latest
MAINTAINER "heywoodlh"

RUN useradd -ms /bin/bash aerc
RUN passwd -d aerc

RUN apt-get update && apt-get install --no-install-recommends -y git \
	vim nano perl \
	w3m \
	dante-server \
	dante-client \
	pass \
	khard \
	fzf

COPY --from=build /usr/local/bin/aerc /usr/local/bin/
COPY --from=build /usr/local/share/aerc/ /usr/local/share/aerc/

RUN ln -s /usr/bin/pinentry-curses /usr/local/bin/pinentry-curses

USER aerc
WORKDIR /home/aerc
ENTRYPOINT ["/usr/local/bin/aerc"]
