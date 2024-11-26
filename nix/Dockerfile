FROM docker.io/ubuntu AS base

# https://github.com/DeterminateSystems/nix-installer/issues/1305#issuecomment-2494150324
RUN apt update \
    && apt install -y curl \
    && curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix/pr/1311 | sh -s -- install linux \
      --extra-conf "sandbox = false" \
      --init none \
      --no-confirm \
      --extra-conf='filter-syscalls = false' \
    && . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"

# Target for building the static nix binaries
FROM base AS static-fetcher

# Hydra Nix project: https://hydra.nixos.org/project/nix
# Example 2.24 version job list URL: https://hydra.nixos.org/jobset/nix/maintenance-2.24#tabs-jobs
RUN curl -L https://hydra.nixos.org/job/nix/maintenance-$(nix --version | awk '{print $3}' | cut -d'.' -f1-2)/buildStatic.nix.$(arch)-linux/latest/download-by-type/file/binary-dist -o /nix-bin \
    && chmod +x /nix-bin

# static target
FROM alpine:latest AS static

COPY --from=static-fetcher /nix-bin /usr/bin/nix
ENV NIX_CONFIG="extra-experimental-features = nix-command flakes"

# Add dependencies and create build users
RUN apk add --no-cache curl bash shadow \
    && mkdir -p /etc/nix \
    && groupadd nixbld \
    && for n in $(seq 1 10); do useradd -c "Nix build user $n" \
    -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(which nologin)" \
    nixbld$n; done

# Testing targets
FROM base AS test
RUN nix run nixpkgs#hello

FROM static AS static-test
RUN nix run nixpkgs#hello
