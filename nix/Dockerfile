# Alpine base image
FROM docker.io/alpine AS alpine-base

## Dependencies
RUN apk add --no-cache curl bash shadow git sudo xz coreutils \
    && mkdir -p /etc/nix \
    && mkdir -p /nix

## Copy some shared files
COPY install.sh /install.sh
COPY nix.sh /nix.sh
COPY entrypoint.sh /entrypoint.sh

ENV PATH="${PATH}:/home/nix/.nix-profile/bin:/nix/var/nix/profiles/default/bin"

ENTRYPOINT [ "/entrypoint.sh" ]

# "Normal" Nix installation
FROM alpine-base AS nix

RUN /install.sh "default" && rm /install.sh
USER nix

# Determinate Nix
FROM docker.io/ubuntu AS determinate

## Dependencies for installation
RUN apt update \
    && apt install -y curl git sudo \
    && rm -rf /var/lib/apt/lists/*

## Install Nix
COPY install.sh /install.sh
COPY nix.sh /nix.sh
RUN /install.sh "determinate" && rm /install.sh
USER nix

COPY entrypoint.sh /entrypoint.sh

ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"

ENTRYPOINT [ "/entrypoint.sh" ]

# Target for building the static nix binaries
FROM docker.io/curlimages/curl AS static-fetcher

USER root

# Hydra Nix project: https://hydra.nixos.org/project/nix
# Example 2.24 version job list URL: https://hydra.nixos.org/jobset/nix/maintenance-2.24#tabs-jobs
# Related issue https://github.com/NixOS/nixpkgs/issues/357949#issuecomment-2528781690
RUN curl -L https://hydra.nixos.org/job/nix/maintenance-2.25/buildStatic.nix.$(arch)-linux/latest/download-by-type/file/binary-dist -o /nix \
    && chmod +x /nix \
    && /nix --version

# static target
FROM alpine-base AS static

COPY --from=static-fetcher /nix /usr/bin/nix

RUN /install.sh "static" && rm /install.sh

COPY nix.conf /etc/nix/nix.conf
COPY static.sh /entrypoint.sh
USER nix

# Testing targets
FROM nix AS test
RUN nix run nixpkgs#hello

FROM determinate AS determinate-test
RUN nix run nixpkgs#hello

FROM static AS static-test
RUN nix run nixpkgs#hello

# If no target provided, just use nix target
FROM nix
