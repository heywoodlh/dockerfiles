FROM docker.io/alpine:latest AS base

RUN apk --no-cache add socat
ENV ENABLE_SSL=false

COPY server.sh /server.sh
COPY attach.sh /attach.sh
COPY client.sh /client.sh

# Client image
FROM base AS client

ENV SERVER_ADDR=
ENV SERVER_PORT=

# Add bash for richer shell experience
RUN apk --no-cache add bash nix

# Add container management tools
RUN apk --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community add docker kubectl

# Add nix with flakes enabled for additional packages if desired
RUN apk add --no-cache curl git nix \
    && printf "\nextra-experimental-features = nix-command flakes\n" >> /etc/nix/nix.conf

ENTRYPOINT ["/client.sh"]

# Server image
FROM base AS server

ENV LISTEN_PORT=

RUN apk --no-cache add coreutils openssl

RUN apk add --no-cache shadow \
    && addgroup --gid 1000 shell \
    && useradd --shell /bin/ash --uid 1000 --gid 1000 --create-home --home-dir /home/shell shell

ENV SSL_CERT_FILE=/ssl/cert.pem
ENV SSL_KEY_FILE=/ssl/key.pem
RUN mkdir -p /data /ssl \
    && chown -R shell:shell /data /ssl

VOLUME /data
VOLUME /ssl

ENTRYPOINT ["/server.sh"]
