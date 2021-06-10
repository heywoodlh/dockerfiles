FROM golang:latest AS build

RUN apt-get update && apt-get install -y man git

RUN git clone https://github.com/emersion/hydroxide /opt/hydroxide
WORKDIR /opt/hydroxide
RUN GO111MODULE=on go build ./cmd/hydroxide

FROM debian:latest
COPY --from=build /opt/hydroxide/cmd/hydroxide /usr/local/bin/hydroxide

ENTRYPOINT "/usr/local/bin/hydroxide"
