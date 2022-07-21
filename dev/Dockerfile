FROM heywoodlh/conf:latest
LABEL MAINTAINER=heywoodlh

USER root
RUN apk --no-cache add ttyd openssh-server mosh supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY sshd.sh /sshd.sh

EXPOSE 22
EXPOSE 7681
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
