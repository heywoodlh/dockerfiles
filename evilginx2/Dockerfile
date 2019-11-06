FROM golang:buster

MAINTAINER heywoodlh

ENV DEBIAN_FRONTEND noninteractive
ENV PORTS 443 80 53/udp

RUN apt-get update && apt-get install --no-install-recommends -y ca-certificates make git

RUN go get -u github.com/kgretzky/evilginx2

WORKDIR /go/src/github.com/kgretzky/evilginx2
RUN make && make install

EXPOSE ${PORTS}

CMD evilginx \
