#!/usr/bin/env bash
# This script fetches the latest Dockerfile CI from the official repository for a base image
# Build the base builder image for a static executable
if [ -n "${FRESH_BUILDER}" ]
then
    mkdir -p ./upstream
    curl --silent -L https://raw.githubusercontent.com/tstack/lnav/refs/heads/master/.github/actions/muslbuilder/Dockerfile -o ./upstream/Dockerfile
    curl --silent -L https://raw.githubusercontent.com/tstack/lnav/refs/heads/master/.github/actions/muslbuilder/entrypoint.sh -o ./upstream/entrypoint.sh
fi

if [ -n "${PUSH}" ]
then
    # Multiarch support
    docker buildx ls | grep -q multiarch || docker buildx create --name multiarch --driver docker-container --use
    docker buildx ls | grep multiarch | grep linux/amd64 | grep -q linux/arm64 || docker run --privileged --rm docker.io/tonistiigi/binfmt --install all
    echo "Building multiarch image and pushing"
    [[ -n "${FRESH_BUILDER}" ]] && docker buildx build --platform linux/amd64,linux/arm64,linux/armhf --push -t docker.io/heywoodlh/lnav:builder -f ./upstream/Dockerfile ./upstream
else
    echo "Running locally, building"
    [[ -n "${FRESH_BUILDER}" ]] && docker build -t docker.io/heywoodlh/lnav:builder -f ./upstream/Dockerfile ./upstream
fi

# Build and the lnav test image
set -ex
docker build -t docker.io/heywoodlh/lnav:test -f Dockerfile --target=test . || exit 53
