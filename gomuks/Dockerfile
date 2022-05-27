FROM golang:alpine3.16 AS build

RUN apk --no-cache add olm-dev git gcc libc-dev libstdc++ g++ \
	&& git clone https://github.com/tulir/gomuks /opt/gomuks

COPY keybindings.yaml /opt/gomuks/config/keybindings.yaml

WORKDIR /opt/gomuks
RUN go build 

FROM alpine:3.16 
LABEL MAINTAINER=heywoodlh

COPY --from=build /opt/gomuks/gomuks /usr/local/bin/gomuks

RUN apk --no-cache add shadow olm-dev

RUN passwd -l root
RUN useradd -ms /bin/ash gomuks
RUN passwd -l gomuks

USER gomuks
ENTRYPOINT ["/usr/local/bin/gomuks"]
