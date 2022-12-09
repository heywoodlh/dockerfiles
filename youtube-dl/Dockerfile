FROM alpine:latest
LABEL MAINTAINER=heywoodlh

RUN apk --no-cache add youtube-dl shadow

RUN useradd -m -s /bin/bash youtube-dl

USER youtube-dl

ENTRYPOINT ["youtube-dl"]
