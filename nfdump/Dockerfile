FROM alpine
LABEL MAINTAINER=heywoodlh

ENV GID 1000
ENV UID 1000

RUN apk --no-cache add nfdump

EXPOSE 9995

ENTRYPOINT ["nfdump"]
