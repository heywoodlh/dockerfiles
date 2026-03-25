FROM docker.io/ubuntu AS base

# Dependencies for installation
RUN apt update \
    && apt install -y curl git sudo \
    && rm -rf /var/lib/apt/lists/*

# Use unprivileged "nix" user (temporarily privileged for install)
RUN rm -rf /home/ubuntu && userdel ubuntu \
    && groupadd --gid 1000 nix \
    && adduser --uid 1000 --gecos "" --disabled-password --home /home/nix --shell /bin/bash --ingroup nix nix \
    && mkdir -p /etc/sudoers.d \
    && echo "nix ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nix

USER nix

# Run install as non-root
RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux \
      --extra-conf "sandbox = false" \
      --init none \
      --no-confirm \
      --extra-conf='filter-syscalls = false' \
    && sudo chown -R 1000:1000 /nix \
    && . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# Remove sudo privileges
USER root
RUN rm /etc/sudoers.d/nix
USER nix

ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"

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
FROM docker.io/alpine:latest AS static

COPY --from=static-fetcher /nix /usr/bin/nix
ENV NIX_CONFIG="extra-experimental-features = nix-command flakes"

# Add dependencies and create build users
RUN apk add --no-cache curl bash shadow git \
    && mkdir -p /etc/nix \
    && mkdir -p /nix \
    && groupadd nixbld \
    && for n in $(seq 1 10); do useradd -c "Nix build user $n" \
    -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(which nologin)" \
    nixbld$n; done

# Testing targets
FROM base AS test
RUN nix run nixpkgs#hello

FROM static AS static-test
RUN nix run nixpkgs#hello

# lix-builder target
FROM ghcr.io/lix-project/lix AS lix-builder

RUN nix --extra-experimental-features "flakes nix-command" build "github:nixos/nixpkgs/nixpkgs-unstable#lixStatic" -o /tmp/lix-static \
    && cp /tmp/lix-static/bin/nix /nix \
    && /nix --version

# lix target
FROM docker.io/alpine:latest AS lix

COPY --from=lix-builder /nix /usr/bin/nix
ENV NIX_CONFIG="extra-experimental-features = nix-command flakes"

# Add dependencies and create build users
RUN apk add --no-cache curl bash shadow git \
    && mkdir -p /etc/nix \
    && mkdir -p /nix \
    && groupadd nixbld \
    && for n in $(seq 1 10); do useradd -c "Nix build user $n" \
    -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(which nologin)" \
    nixbld$n; done

FROM lix AS lix-test
RUN nix run nixpkgs#hello
