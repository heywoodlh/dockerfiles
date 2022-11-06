FROM golang:latest
MAINTAINER heywoodlh

RUN go get -u github.com/vultr/vultr-cli
RUN apt-get update && apt-get install -y coreutils jq fzf \
    && rm -rf /var/lib/apt/lists/*
RUN mv /go/bin/vultr-cli /usr/bin/vultr-cli
COPY vultr.sh /vultr.sh

ENTRYPOINT "/vultr.sh"
