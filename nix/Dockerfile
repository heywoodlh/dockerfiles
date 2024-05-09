FROM alpine:latest AS base
LABEL maintainer=heywoodlh

RUN apk add --no-cache curl bash \
    && curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --init none --no-confirm --extra-conf "filter-syscalls = false"

ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"
VOLUME /nix

# Target for building the static nix binaries
FROM base AS static-builder
RUN nix build -o /opt/nix nixpkgs#nixStatic

# static target
FROM alpine:latest AS static

COPY --from=static-builder /opt/nix /opt/nix
ENV PATH="${PATH}:/opt/nix/bin"

# Testing targets
FROM base AS test
RUN nix run nixpkgs#hello

FROM static AS static-test
RUN nix run nixpkgs#hello

# Default target
FROM base
