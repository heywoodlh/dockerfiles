FROM golang:alpine AS build

RUN apk add --no-cache git

RUN go install github.com/tomnomnom/assetfinder@latest

RUN go install github.com/tomnomnom/gf@latest
RUN mkdir /root/.gf
COPY gf-examples/*.json /root/.gf/  

RUN go install github.com/tomnomnom/gron@latest
RUN go install github.com/tomnomnom/httprobe@latest
RUN go install github.com/tomnomnom/meg@latest
RUN go install github.com/tomnomnom/unfurl@latest
RUN go install github.com/tomnomnom/waybackurls@latest

FROM alpine
LABEL maintainer="heywoodlh"

COPY --from=build /go/bin/* /usr/local/bin/
COPY --from=build /root/.gf /root/.gf

RUN mkdir /data

CMD "/bin/ash"
