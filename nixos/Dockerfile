FROM docker.io/heywoodlh/nix:static AS builder

RUN mkdir -p /mnt/etc/nixos
COPY configuration.nix /mnt/etc/nixos/configuration.nix
RUN nix shell "nixpkgs#nixos-install-tools" "nixpkgs#nix" --command bash -c "nixos-install --no-channel-copy -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz --no-root-passwd"

FROM scratch

COPY --from=builder /mnt /
COPY systemd.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
