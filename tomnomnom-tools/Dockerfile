FROM golang:alpine AS build

RUN apk add --no-cache git

RUN go get -u github.com/tomnomnom/assetfinder

RUN go get -u github.com/tomnomnom/gf
RUN mkdir /root/.gf
COPY gf-examples/*.json /root/.gf/  

RUN go get -u github.com/tomnomnom/gron
RUN go get -u github.com/tomnomnom/httprobe
RUN go get -u github.com/tomnomnom/meg
RUN go get -u github.com/tomnomnom/unfurl
RUN go get github.com/tomnomnom/waybackurls

FROM alpine
LABEL maintainer="heywoodlh"

COPY --from=build /go/bin/* /usr/local/bin/
COPY --from=build /root/.gf /root/.gf

RUN mkdir /data

CMD "/bin/ash"
