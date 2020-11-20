FROM node:alpine
LABEL maintainer=heywoodlh

ENV UID="1000"
ENV GID="1000"

USER root
RUN userdel --remove-home node

RUN apk --no-cache add git python3 make gcc libc-dev g++ &&\
	git clone https://git.sr.ht/~cadence/cloudtube /opt/cloudtube

WORKDIR /opt/cloudtube
RUN npm install

RUN addgroup -g $GID -S cloudtube &&\
	adduser -u $UID -D -S -h /opt/cloudtube -s /sbin/nologin -G cloudtube cloudtube &&\
	passwd -d cloudtube &&\
	chown -R cloudtube:cloudtube /opt/cloudtube

COPY run.sh /opt/run.sh
RUN chmod +x /opt/run.sh

EXPOSE 10412
VOLUME /opt/cloudtube/db

USER cloudtube
ENTRYPOINT /opt/run.sh
