FROM heywoodlh/metasploit:latest
LABEL maintainer=heywoodlh

RUN apt-get update \
	&& apt-get install -y openssh-server sudo shellinabox supervisor john hydra vim nano curl wget \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash msfbox \
        && echo 'msfbox:msfbox' | chpasswd \
        && echo 'msfbox ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/msfbox

RUN sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config \
	&& mkdir -p /run/sshd

RUN printf '#!/usr/bin/env bash\necho "Launching Metasploit (this may take a few moments)"\nsudo msfconsole\n' > /usr/bin/su-msfconsole \
	&& chmod +x /usr/bin/su-msfconsole \
	&& echo '/usr/bin/su-msfconsole' >> /etc/shells \
	&& chsh -s /usr/bin/su-msfconsole msfbox

EXPOSE 22
EXPOSE 4200

VOLUME /home/msfbox/.msf4

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY wordlists/staff-passwords.txt /opt/staff-passwords.txt

RUN chown -R msfbox:msfbox /opt/staff-passwords.txt

ENTRYPOINT [ "/usr/bin/supervisord" ]
