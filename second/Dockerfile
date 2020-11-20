FROM alpine as build

RUN apk --no-cache add git &&\
	git clone https://git.sr.ht/~cadence/Second /opt/second

FROM python:alpine
LABEL maintainer=heywoodlh

ENV UID="1000"
ENV GID="1000"
ENV WEBSITE_ORIGIN="http://second:3000"

COPY --from=build /opt/second /opt/second

RUN pip3 install -r /opt/second/requirements.txt &&\
	echo "website_origin = \"$WEBSITE_ORIGIN\"" > /opt/second/configuration.py

RUN addgroup -g $GID -S second &&\
	adduser -u $UID -D -S -h /opt/second -s /sbin/nologin -G second second &&\
	passwd -d second &&\
	chown -R second:second /opt/second

COPY run.sh /opt/run.sh
RUN chmod +x /opt/run.sh

EXPOSE 3000

USER second
ENTRYPOINT /opt/run.sh
