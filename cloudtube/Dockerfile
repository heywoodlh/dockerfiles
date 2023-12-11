FROM node:18-bullseye
LABEL maintainer=heywoodlh

ENV DEBIAN_FRONTEND noninteractive

ENV UID="1000"
ENV GID="1000"

USER root
RUN deluser --remove-home node

RUN apt-get update && apt-get install -y git python3 make gcc libc-dev g++ &&\
	rm -rf /var/lib/apt/lists/* &&\
	git clone https://git.sr.ht/~cadence/cloudtube /opt/cloudtube

WORKDIR /opt/cloudtube
RUN npm install

RUN addgroup --gid $GID cloudtube &&\
	adduser --uid $UID --gecos "" --disabled-password --home /opt/cloudtube --shell /sbin/nologin --ingroup cloudtube cloudtube &&\
	mkdir -p /opt/cloudtube/db &&\
	chown -R cloudtube:cloudtube /opt/cloudtube

COPY run.sh /opt/run.sh
RUN chmod +x /opt/run.sh

EXPOSE 10412
VOLUME /opt/cloudtube/db
VOLUME /opt/cloudtube/config

USER cloudtube
ENTRYPOINT /opt/run.sh
