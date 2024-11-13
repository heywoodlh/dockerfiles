FROM docker.io/alpine AS base

RUN apk --no-cache add socat

COPY server.sh /server.sh
COPY attach.sh /attach.sh
COPY client.sh /client.sh

# Client image
FROM base AS client

ENV SERVER_ADDR=
ENV SERVER_PORT=

# Add bash for richer shell experience
RUN apk --no-cache add bash

# Add container management tools
RUN apk --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community add docker kubectl

ENTRYPOINT ["/client.sh"]

# Server image
FROM base AS server

ENV LISTEN_PORT=

ENTRYPOINT ["/server.sh"]
