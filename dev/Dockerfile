FROM heywoodlh/conf:latest
LABEL MAINTAINER=heywoodlh

USER root
RUN apk --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing add ttyd openssh-server mosh supervisor runuser neofetch

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY sshd.sh /sshd.sh

## Setup SSH
RUN usermod -p '*' heywoodlh \
    && echo '' | tee /etc/motd

EXPOSE 22
EXPOSE 7681
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
