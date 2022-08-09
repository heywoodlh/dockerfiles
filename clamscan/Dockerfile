FROM alpine
LABEL MAINTAINER=heywoodlh

RUN apk --no-cache add clamav-scanner

VOLUME /var/lib/clamav
VOLUME /etc/clamav

CMD ["clamscan"]
