FROM golang:latest
MAINTAINER heywoodlh

RUN go get -u github.com/vultr/vultr-cli

ENTRYPOINT "/go/bin/vultr-cli"
