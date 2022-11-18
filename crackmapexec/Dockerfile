FROM kalilinux/kali-rolling
LABEL MAINTAINER=heywoodlh

RUN apt-get update && apt-get install -y crackmapexec \
    && rm -rf /var/lib/apt/lists/*

VOLUME /root/.cme

ENTRYPOINT ["crackmapexec"]
