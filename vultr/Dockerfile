FROM golang:latest
MAINTAINER heywoodlh

RUN go install github.com/vultr/vultr-cli/v2@v2.15.0
RUN apt-get update && apt-get install -y coreutils jq fzf openssh-client mosh \
    && rm -rf /var/lib/apt/lists/*
RUN mv /go/bin/vultr-cli /usr/bin/vultr-cli
COPY vultr.sh /vultr.sh

ENTRYPOINT ["/vultr.sh"]
