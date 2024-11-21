FROM docker.io/nixos/nix AS base
LABEL maintainer=heywoodlh

# Enable flakes
ENV NIX_CONFIG="extra-experimental-features = nix-command flakes"

# Target for building the static nix binaries
FROM base AS static-fetcher

# Hydra Nix project: https://hydra.nixos.org/project/nix
# Example 2.24 version job list URL: https://hydra.nixos.org/jobset/nix/maintenance-2.24#tabs-jobs
RUN nix run "nixpkgs#curl" -- -L https://hydra.nixos.org/job/nix/maintenance-$(nix --version | nix run "nixpkgs#gawk" -- '{print $3}' | cut -d'.' -f1-2)/buildStatic.nix.$(nix run "nixpkgs#busybox" -- arch)-linux/latest/download-by-type/file/binary-dist -o /nix-bin \
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
