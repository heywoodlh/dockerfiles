FROM debian
MAINTAINER heywoodlh

RUN apt-get update && apt-get install -y --no-install-recommends openssh-server \
	&& rm -rf /var/lib/apt/lists/*
RUN passwd -l root

RUN useradd -ms /bin/bash ssh-user
RUN sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config
RUN passwd -l ssh-user
RUN mkdir -p /run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
