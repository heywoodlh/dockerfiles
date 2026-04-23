FROM golang:1.25-bookworm AS build

RUN git clone https://github.com/acheong08/ferroxide /opt/ferroxide

WORKDIR /opt/ferroxide
RUN GO111MODULE=on go build ./cmd/ferroxide

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/ferroxide/ferroxide /usr/local/bin/ferroxide
RUN chmod +x /usr/local/bin/ferroxide

ENTRYPOINT ["/usr/local/bin/ferroxide"]
