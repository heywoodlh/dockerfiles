FROM golang:latest as build

RUN go get -d github.com/VirusTotal/vt-cli/vt

WORKDIR /go/src/github.com/VirusTotal/vt-cli
RUN make install

FROM debian
MAINTAINER heywoodlh

RUN passwd -l root
RUN useradd -ms /bin/bash vt
RUN passwd -l vt

COPY --from=build /go/bin/vt /usr/local/bin/vt
RUN mkdir -p /data

USER vt
ENTRYPOINT "/usr/local/bin/vt"
