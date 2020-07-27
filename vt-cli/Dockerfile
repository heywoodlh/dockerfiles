FROM golang:latest as build

RUN go get -d github.com/VirusTotal/vt-cli/vt

WORKDIR /go/src/github.com/VirusTotal/vt-cli
RUN make install

FROM archlinux
MAINTAINER heywoodlh

COPY --from=build /go/bin/vt /usr/local/bin/vt

ENTRYPOINT "/usr/local/bin/vt"
