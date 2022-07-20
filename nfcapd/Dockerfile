FROM alpine
LABEL MAINTAINER=heywoodlh

ENV GID 1000
ENV UID 1000

RUN apk --no-cache add nfdump shadow

RUN addgroup -g $GID -S nfdump \
    && adduser -u $UID -D -S -h /flows -s /bin/ash -G nfdump nfdump

VOLUME /flows

EXPOSE 9995

USER nfdump
ENTRYPOINT ["nfcapd"]
CMD ["-w", "-S", "2", "-l", "/flows/", "-p", "9995"]
