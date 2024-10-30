#!/usr/bin/env bash
operating_systems=("ubuntu" "debian" "centos" "archlinux")
dir=$(dirname -- "$( readlink -f -- "$0"; )";)
date_tag=$(date +%Y_%m_snapshot)

for os in "${operating_systems[@]}"
do
  arches="amd64,arm64"
  # Skip arm64 if archlinux
  [[ ${os} == "archlinux" ]] && arches="amd64"
	docker buildx build --no-cache --platform "${arches}" --squash -t "heywoodlh/systemd:${os}" -t "docker.io/heywoodlh/systemd:${os}_${date_tag}" -f ${dir}/Dockerfile.${os} . --push
done

# Set default image to Ubuntu
docker buildx build --no-cache --platform "amd64,arm64" --squash -t "heywoodlh/systemd:latest" -t "docker.io/heywoodlh/systemd:${date_tag}" -f ${dir}/Dockerfile.ubuntu . --push
