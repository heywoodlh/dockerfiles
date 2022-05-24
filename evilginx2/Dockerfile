FROM golang:buster AS build

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /go/src/github.com/hash3liZer/ && \
	git clone https://github.com/hash3liZer/evilginx2/ /go/src/github.com/hash3liZer/evilginx2

WORKDIR /go/src/github.com/hash3liZer/evilginx2

RUN go build -o ./bin/evilginx main.go

RUN git clone https://github.com/hash3liZer/phishlets/ /go/src/github.com/hash3liZer/phishlets/

FROM debian:buster
LABEL maintainer=heywoodlh

WORKDIR /app
COPY --from=build /go/src/github.com/hash3liZer/evilginx2/bin/evilginx /app/evilginx
COPY --from=build /go/src/github.com/hash3liZer/phishlets/*.yaml /app/phishlets/

RUN apt-get update && apt-get install --no-install-recommends -y ca-certificates &&\
	rm -rf /var/lib/apt/lists/*

EXPOSE 443 80 53/udp

ENTRYPOINT ["/app/evilginx"]
