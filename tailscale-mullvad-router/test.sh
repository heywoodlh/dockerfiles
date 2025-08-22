#!/usr/bin/env bash
set -e
onepassword_item="ohelo3flfw26d3ddenrssvdxqq"
WIREGUARD_ENDPOINT=$(op read "op://Automation/$onepassword_item/WIREGUARD_ENDPOINT")
WIREGUARD_ENDPOINT_PUBKEY=$(op read "op://Automation/$onepassword_item/WIREGUARD_ENDPOINT_PUBKEY")
WIREGUARD_PRIVKEY=$(op read "op://Automation/$onepassword_item/WIREGUARD_PRIVKEY")
WIREGUARD_ADDRESS=$(op read "op://Automation/$onepassword_item/WIREGUARD_ADDRESS")
TS_AUTH_KEY=$(op read "op://Automation/$onepassword_item/TS_AUTH_KEY")

docker volume create tailscale-test &>/dev/null || true # ignore error if exists
docker build -t heywoodlh/tailscale-mullvad-router .
docker run -it --rm \
    --privileged \
    -v tailscale-test:/var/lib/tailscale \
    -e WIREGUARD_ENDPOINT="${WIREGUARD_ENDPOINT}" \
    -e WIREGUARD_ENDPOINT_PUBKEY="${WIREGUARD_ENDPOINT_PUBKEY}" \
    -e WIREGUARD_PRIVKEY="${WIREGUARD_ENDPOINT_PUBKEY}" \
    -e WIREGUARD_ADDRESS="${WIREGUARD_ADDRESS}" \
    -e TS_AUTHKEY="${TS_AUTH_KEY}" \
    heywoodlh/tailscale-mullvad-router

