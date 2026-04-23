FROM golang:1.25-bookworm AS build

RUN git clone https://github.com/emersion/hydroxide /opt/hydroxide

WORKDIR /opt/hydroxide
RUN GO111MODULE=on go build ./cmd/hydroxide

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/hydroxide/hydroxide /usr/local/bin/hydroxide
RUN chmod +x /usr/local/bin/hydroxide

ENTRYPOINT ["/usr/local/bin/hydroxide"]
