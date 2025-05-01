# See `./build.sh`
FROM docker.io/heywoodlh/lnav:builder AS builder

RUN ash /entrypoint.sh

FROM docker.io/ubuntu:24.04 AS base
LABEL maintainer=heywoodlh

COPY --from=builder /lnav/lbuild/src/lnav /usr/local/bin/lnav

ENV DEBIAN_FRONTEND=noninteractive

# Deps from https://github.com/tstack/lnav/blob/master/demo/Dockerfile
RUN apt update \
    && apt install --yes --no-install-recommends bind9-dnsutils iputils-ping iproute2 curl ca-certificates htop wget unzip openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Test target
FROM base AS test

RUN lnav --version

# Default target
FROM base
