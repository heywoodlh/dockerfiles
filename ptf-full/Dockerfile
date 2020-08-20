FROM heywoodlh/ptf
LABEL maintainer=heywoodlh

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
WORKDIR /opt/ptf
RUN ptf --update-all -y

RUN rm -rf /var/lib/apt/lists/*
