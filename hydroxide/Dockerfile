FROM golang:1.16-buster AS build

RUN git clone https://github.com/emersion/hydroxide /opt/hydroxide

## Patch for iOS to work with Hydroxide
RUN sed -ie '310,313d' /opt/hydroxide/imap/mailbox.go

WORKDIR /opt/hydroxide
RUN GO111MODULE=on go build ./cmd/hydroxide

FROM debian:buster

RUN apt-get update && apt-get install -y ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/hydroxide/hydroxide /usr/local/bin/hydroxide
RUN chmod +x /usr/local/bin/hydroxide

ENTRYPOINT ["/usr/local/bin/hydroxide"]
