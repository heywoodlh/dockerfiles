FROM heywoodlh/ptf
LABEL maintainer=heywoodlh

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
WORKDIR /opt/ptf
RUN ptf --update-all -y

RUN rm -rf /var/lib/apt/lists/*
WORKDIR /pentest

RUN find /pentest -type f -executable | xargs -n1 -I{} ln -s {} /usr/local/bin/ || :
