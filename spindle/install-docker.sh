#!/usr/bin/env bash
set -ex

apt update && apt install -y gnupg ca-certificates curl uidmap iproute2
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

apt update && apt install -y docker-ce-cli docker-ce docker-ce-rootless-extras

echo spindle:10000:5000 > /etc/subuid
echo spindle:10000:5000 > /etc/subgid

rm -rf /var/cache/apt/archives /var/lib/apt/lists/*
