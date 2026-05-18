# Spindle relies on go-sqlite3, which requires glibc -- not musl
# Therefore, using Debian base :)
ARG DEBIAN_VERSION="bookworm"
ARG GO_VERSION="1.26"

FROM docker.io/golang:${GO_VERSION}-${DEBIAN_VERSION} AS builder

RUN apt update && apt install -y git \
    && git clone https://tangled.org/tangled.org/core /opt/tangled \
    && git -C /opt/tangled rev-parse --short HEAD > /VERSION.txt \
    && cd /opt/tangled \
    && go mod download \
    && go build -o /spindle cmd/spindle/main.go \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

FROM docker.io/heywoodlh/nix:determinate AS spindle-run-builder

RUN out=$(nix build "git+https://tangled.org/heywoodlh.io/spindle-run#spindle-run-bin" \
    --no-link \
    --option sandbox false \
    --print-out-paths) \
    && cp "$out/bin/spindle-run" /home/nix/spindle-run

# Target to simply print the version
FROM builder AS version

ENTRYPOINT [ "cat", "/VERSION.txt" ]

FROM docker.io/debian:${DEBIAN_VERSION} AS base

# Install spindle
COPY --from=builder /spindle /usr/bin/spindle

# Install spindle-run
COPY --from=spindle-run-builder /home/nix/spindle-run /usr/local/bin/spindle-run

# Install docker-client
COPY --chmod=777 ./install-docker.sh /install-docker.sh

# Install dependencies, create unprivileged user
RUN /install-docker.sh \
    && rm /install-docker.sh \
    && apt update \
    && apt install -y supervisor fuse-overlayfs \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/* \
    && addgroup --gid 1000 spindle \
    && useradd --shell /bin/bash --uid 1000 --gid 1000 --create-home --home-dir /data spindle \
    && mkdir -p /var/log/spindle /run/user/1000 \
    && chown -R spindle:spindle /var/log/spindle /data /run/user/1000 /etc/supervisor

WORKDIR /data
USER spindle

VOLUME /data
VOLUME /var/log/spindle

ENV SPINDLE_SERVER_LISTEN_ADDR="0.0.0.0:6555"
ENV SPINDLE_SERVER_DB_PATH="/data/spindle.db"
ENV SPINDLE_SERVER_HOSTNAME="localhost"
ENV SPINDLE_SERVER_JETSTREAM_ENDPOINT="wss://jetstream1.us-west.bsky.network/subscribe"
ENV SPINDLE_SERVER_OWNER=""
ENV SPINDLE_PIPELINES_NIXERY="nixery.tangled.sh"
ENV SPINDLE_PIPELINES_WORKFLOW_TIMEOUT="5m"

# Dev mode by default
ENV SPINDLE_SERVER_DEV=true

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY --chmod=777 dockerd.sh /dockerd.sh
COPY --chmod=777 spindle.sh /spindle.sh

ENTRYPOINT ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

# Special target for fly.io, does not seem to like unprivileged user
FROM base AS root
USER root

ENV SPINDLE_SERVER_DOCKER_SOCKET="/var/run/docker.sock"

# Allow invoked containers to use `tcp://host.docker.internal:2375` for docker
COPY daemon.json /etc/docker/daemon.json

# Default final target (unprivileged)
FROM base

# Configure unprivileged docker
ENV DOCKER_HOST=unix:///run/user/1000/docker.sock

ENV SPINDLE_SERVER_DOCKER_SOCKET="/run/user/1000/docker.sock"
ENV XDG_RUNTIME_DIR=/run/user/1000
