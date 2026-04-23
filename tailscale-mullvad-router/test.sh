#!/usr/bin/env bash
set -e
onepassword_item="op://Kubernetes/kcntifehovxbdnp5exk4gwsvta"
WIREGUARD_ENDPOINT=$(op-wrapper read "${onepassword_item}/WIREGUARD_ENDPOINT")
WIREGUARD_ENDPOINT_PUBKEY=$(op-wrapper read "$onepassword_item/WIREGUARD_ENDPOINT_PUBKEY")
WIREGUARD_PRIVKEY=$(op-wrapper read "$onepassword_item/WIREGUARD_PRIVKEY")
WIREGUARD_ADDRESS=$(op-wrapper read "$onepassword_item/WIREGUARD_ADDRESS")
TS_AUTHKEY=$(op-wrapper read "$onepassword_item/TS_AUTHKEY")

docker volume create tailscale-test &>/dev/null || true # ignore error if exists
docker build -t heywoodlh/tailscale-mullvad-router-testing .
docker run -it --rm \
  --privileged \
  -v tailscale-test:/var/lib/tailscale \
  -e WIREGUARD_ENDPOINT="${WIREGUARD_ENDPOINT}" \
  -e WIREGUARD_ENDPOINT_PUBKEY="${WIREGUARD_ENDPOINT_PUBKEY}" \
  -e WIREGUARD_PRIVKEY="${WIREGUARD_PRIVKEY}" \
  -e WIREGUARD_ADDRESS="${WIREGUARD_ADDRESS}" \
  -e TS_AUTHKEY="${TS_AUTHKEY}" \
  -e TS_HOSTNAME="mullvad-socks-router-testing" \
  heywoodlh/tailscale-mullvad-router-testing
