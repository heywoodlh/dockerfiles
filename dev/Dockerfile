FROM docker.io/heywoodlh/nix:determinate
LABEL MAINTAINER=heywoodlh

USER root

RUN apt update && apt install -y ttyd curl openssh-server mosh supervisor sudo \
    && rm -rf /var/lib/apt/lists/*

RUN userdel --remove nix \
    && groupadd heywoodlh --gid 1000 \
    && useradd --shell /bin/bash --uid 1000 --gid 1000 --create-home --home-dir /home/heywoodlh heywoodlh \
    && mkdir -p /etc/sudoers.d \
    && echo "heywoodlh ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/heywoodlh \
    && touch /home/heywoodlh/.hushlogin \
    && chown heywoodlh:heywoodlh /home/heywoodlh/.hushlogin \
    && chown -R heywoodlh:heywoodlh /nix

USER heywoodlh
ENV HOME=/home/heywoodlh

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY sshd.sh /sshd.sh
COPY ttyd.sh /ttyd.sh
COPY heywoodlh.sh /heywoodlh.sh
EXPOSE 22
EXPOSE 8080

VOLUME /nix
VOLUME /home/heywoodlh

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
