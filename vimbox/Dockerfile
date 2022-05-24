FROM debian:bullseye
LABEL maintainer=heywoodlh

RUN apt-get update \
	&& apt-get install -y sudo shellinabox supervisor vim git pass gnupg curl wget tmux openssh-client neofetch less\
	&& rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash vim \
        && usermod -aG sudo vim

RUN passwd -l root

EXPOSE 4200

COPY bashrc /home/vim/.bashrc
COPY tmux.conf /home/vim/.tmux.conf
COPY start.sh /start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN echo '' > /etc/motd

ENTRYPOINT [ "/usr/bin/supervisord" ]
