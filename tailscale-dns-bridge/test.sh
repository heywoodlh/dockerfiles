#!/usr/bin/env bash
set -e
onepassword_item="5ujv4rys5u6obn3t6vaokwh2vm"
TS_AUTH_KEY=$(op read "op://Kubernetes/${onepassword_item}/password")

docker volume create tailscale-dns-test &>/dev/null || true # ignore error if exists
docker build -t heywoodlh/tailscale-dns-bridge .
docker run -it --rm \
    --privileged \
    --device /dev/net/tun \
    -p 5350:53/udp \
    -v tailscale-dns-test:/var/lib/tailscale \
    -e TS_AUTHKEY="${TS_AUTH_KEY}" \
    heywoodlh/tailscale-dns-bridge

# Test with: dig @127.0.0.1 -p 5350 +short tailscale-dns-bridge.barn-banana.ts.net
