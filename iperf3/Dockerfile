FROM alpine:latest
LABEL maintainer=heywoodlh

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main iperf3

RUN addgroup -S iperf3 && adduser -S iperf3 -G iperf3
USER iperf3

EXPOSE 5201
ENTRYPOINT ["iperf3"]
