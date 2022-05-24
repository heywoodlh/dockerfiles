FROM alpine
LABEL maintainer=heywoodlh

RUN apk --no-cache add swatch ssmtp

RUN mkdir -p /logs
VOLUME /logs
ENTRYPOINT [ "swatchdog", "--config-file", "/etc/swatch/swatchrc"]

