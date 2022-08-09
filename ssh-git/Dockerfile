FROM heywoodlh/openssh:latest
LABEL maintainer=heywoodlh

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -m 700 -p /git/.ssh \
	&& addgroup --gid 1050 git \
        && adduser --uid 1050 --gecos "" --disabled-password --home /git --shell /bin/bash --ingroup git git \
        && chown -R git:git /git

VOLUME /git
VOLUME /git/.ssh

RUN printf 'match User git\n    AuthorizedKeysFile /git/.ssh/authorized_keys' >> /etc/ssh/sshd_config

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]
