#!/usr/bin/env bash
operating_systems=("ubuntu" "debian" "fedora" "archlinux")
dir=$(dirname -- "$( readlink -f -- "$0"; )";)

docker buildx ls | grep -q multiarch || docker buildx create --name multiarch --driver docker-container --use

for os in "${operating_systems[@]}"
do
  arches="amd64,arm64"
  # Skip arm64 if archlinux
  [[ ${os} == "archlinux" ]] && arches="amd64"
  docker build -t "heywoodlh/systemd:${os}-local" -f "${dir}/Dockerfile.${os}" .
  myversion=$(docker run -it --rm --entrypoint=systemctl heywoodlh/systemd:${os}-local --version | head -1 | cut -d'(' -f2 | cut -d')' -f1 | grep -oE '^[0-9]+.[0-9]+-[0-9]+')
  docker buildx build --no-cache --platform "${arches}" -t "docker.io/heywoodlh/systemd:${os}" -t "docker.io/heywoodlh/systemd:${os}-${myversion}" -f "${dir}/Dockerfile.${os}" . --push
done

# Set default image to Ubuntu
myversion=$(docker run -it --rm --entrypoint=systemctl "heywoodlh/systemd:ubuntu-local" --version | head -1 | cut -d'(' -f2 | cut -d')' -f1 | head)
docker buildx build --no-cache --platform "amd64,arm64" -t "docker.io/heywoodlh/systemd:latest" -t "docker.io/heywoodlh/systemd:${myversion}" -f "${dir}/Dockerfile.ubuntu" . --push
