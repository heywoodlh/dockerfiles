FROM heywoodlh/vulnerable:latest
LABEL maintainer=heywoodlh

RUN userdel vuln

RUN apt-get update \
	&& apt-get install -y vim \
	&& apt-get autoremove -y \
        && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/*	

## Set root password for challenges
RUN echo root:volleyball | chpasswd

## Create vulnerable user for challenges
RUN useradd --create-home -s /bin/bash security \
        && echo security:123security | chpasswd \
	&& groupadd admin \
	&& usermod -aG admin security

## Create vulnerable user for challenges
RUN useradd --create-home -s /bin/bash -g staff staff \
        && echo staff:Jahhaangiecunais9biego | chpasswd

## Create a flag for privilege escalation challenge
RUN echo 'igotrootasthesecurityuser' > /opt/security-check.txt \
	&& chmod 600 /opt/security-check.txt

## Set chewbacca password manually so it can show up in cracked passwords
RUN echo chewbacca:rwaaaaawr5 | chpasswd

## Set up sudo privileges
COPY sudoers.d/security /etc/sudoers.d/security
COPY sudoers.d/staff /etc/sudoers.d/staff
