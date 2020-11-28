FROM alpine
LABEL maintainer=heywoodlh

RUN apk --no-cache add swatch

RUN mkdir -p /logs
VOLUME /logs
ENTRYPOINT [ "swatchdog", "--daemon", "--config-file", "/etc/swatch/swatchrc"]
