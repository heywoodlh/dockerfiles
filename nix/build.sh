#!/usr/bin/env bash
# Script to test out multi-arch container build, to replicate GitHub Actions behavior
# docker buildx behaves differently from docker build (i.e. in GitHub Actions)

# Create multiarch builder
docker buildx ls 2>/dev/null | grep -q multiarch || docker buildx create --name multiarch --driver docker-container --use &>/dev/null

set -ex
# Default target
docker build --tag heywoodlh/nix-local:latest --target=test .
export nix_version="$(docker run -i --rm heywoodlh/nix-local:latest nix --version | rev | awk '{print $1}' | rev)"
docker buildx build --tag docker.io/heywoodlh/nix:"${nix_version}" --tag docker.io/heywoodlh/nix:latest --platform linux/amd64,linux/arm64 --target=base .

# Static target
docker build --tag heywoodlh/nix-static:latest --target=static-test .
export nix_static_version="$(docker run -i --rm heywoodlh/nix-static:latest nix --version | rev | awk '{print $1}' | rev)"
docker buildx build --tag docker.io/heywoodlh/nix:static-"${nix_static_version}" --tag docker.io/heywoodlh/nix:static --platform linux/amd64,linux/arm64 --target=static .

