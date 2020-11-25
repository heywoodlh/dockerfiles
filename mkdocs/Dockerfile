FROM python:alpine
LABEL maintainer=heywoodlh

ENV UID="1000"
ENV GID="1000"

RUN apk --no-cache add gcc make musl-dev

RUN pip3 install mkdocs
RUN mkdir -p /mkdocs

RUN addgroup -g $GID -S mkdocs &&\
	adduser -u $UID -D -S -h /mkdocs -s /sbin/nologin -G mkdocs mkdocs &&\
	passwd -d mkdocs &&\
	chown -R mkdocs:mkdocs /mkdocs

VOLUME /mkdocs
WORKDIR /mkdocs

USER mkdocs
ENTRYPOINT [ "mkdocs", "build" ]
