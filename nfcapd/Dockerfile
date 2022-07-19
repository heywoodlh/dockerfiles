FROM alpine
LABEL MAINTAINER=heywoodlh

RUN apk --no-cache add nfdump

VOLUME /flows

EXPOSE 9995
ENTRYPOINT ["nfcapd"]
CMD ["-w", "-S", "2", "-l", "/flows/", "-p", "9995"]
