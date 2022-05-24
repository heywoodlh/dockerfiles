FROM heywoodlh/filesystem-livesync:latest
LABEL maintainer=heywoodlh

RUN apt-get update \
	&& apt-get install -y shellinabox supervisor vim openssh-server less \
	&& rm -rf /var/lib/apt/lists/*

RUN sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config \
        && mkdir -p /run/sshd

RUN cp -r /etc/ssh /etc/ssh.template

RUN passwd -l root

COPY start.sh /start.sh
COPY bashrc /etc/bashrc.template
COPY vimrc /etc/vimrc.template
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN echo '' > /etc/motd

VOLUME /data
EXPOSE 4200
EXPOSE 22

ENTRYPOINT [ "/usr/bin/supervisord" ]
