FROM debian as builder

RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/xwmx/nb /opt/nb

FROM node:current-buster
LABEL maintainer=heywoodlh

ENV TERM=xterm-256color

RUN apt-get update && apt-get install -y ca-certificates git vim less pass nano pandoc ripgrep w3m tig lsb-release &&\
	rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/pinentry* /usr/local/bin/

COPY --from=builder /opt/nb/nb /usr/local/bin/nb

RUN chmod +x /usr/local/bin/nb
RUN yes | nb env install

WORKDIR /app

RUN useradd -ms /bin/bash nb
RUN passwd -d nb

USER nb
WORKDIR /home/nb

ENTRYPOINT "nb"
