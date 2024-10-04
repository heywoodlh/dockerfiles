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
# -l: base directory
# -p: port
# -S 2: %Y/%m/%d/%H year/month/day/hour subdir format
CMD ["-w", "/flows", "-p", "9995", "-S", "2"]
