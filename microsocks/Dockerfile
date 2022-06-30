FROM alpine:3.16 AS build

RUN apk --no-cache add make gcc linux-headers git musl-dev

RUN git clone https://github.com/rofl0r/microsocks /opt/microsocks
WORKDIR /opt/microsocks

RUN make

FROM alpine:3.16
LABEL MAINTAINER=heywoodlh

COPY --from=build /opt/microsocks/microsocks /usr/local/bin/microsocks

ENTRYPOINT ["/usr/local/bin/microsocks"]
