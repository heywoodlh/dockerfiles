FROM golang:alpine
MAINTAINER heywoodlh

RUN apk add --no-cache git shadow openssl
RUN go get -u github.com/golang/dep &&\
	git clone https://github.com/groob/moroz /opt/moroz &&\
	cd /opt/moroz/cmd/moroz &&\
	go build &&\
	cp /opt/moroz/cmd/moroz/moroz /go/bin
RUN apk del git 


RUN mkdir -p /opt/moroz/config
RUN mkdir -p /opt/moroz/ssl

WORKDIR /opt/moroz

ADD run.sh /opt/moroz/run.sh

RUN useradd -ms /bin/ash moroz
RUN passwd -d moroz
RUN cp -r /opt/moroz/configs /opt/moroz/configs.orig
RUN chown -R moroz:moroz /opt/moroz

USER moroz
ENTRYPOINT ["/opt/moroz/run.sh"]
