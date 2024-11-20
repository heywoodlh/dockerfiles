#!/usr/bin/env bash
# Script to test out multi-arch container build
# docker buildx behaves differently from docker build (i.e. in GitHub Actions)

arch_target=("amd64" "arm64")
root_dir=$(pwd)
date_tag=$(date +%Y_%m_snapshot)

# Create multiarch builder
docker buildx ls | grep -q multiarch || docker buildx create --name multiarch --driver docker-container --use &>/dev/null

set -ex
# Default target
docker build --tag nix-test:latest --target=test .
export nix_version="$(docker run -i --rm nix-test nix --version | awk '{print $3}')"
docker buildx build --tag docker.io/heywoodlh/nix:"${nix_version}" --tag docker.io/heywoodlh/nix:latest --platform linux/amd64,linux/arm64 --target=base .

# Static target
docker build --tag nix-test:static --target=static-test .
export nix_static_version="$(docker run -i --rm nix-test:static nix --version | awk '{print $3}')"
docker buildx build --tag docker.io/heywoodlh/nix:static-"${nix_static_version}" --tag docker.io/heywoodlh/nix:static --platform linux/amd64,linux/arm64 --target=static .

