#!/usr/bin/env bash
if [[ -z "$1" ]]
then
    operating_systems=("ubuntu" "debian" "fedora" "archlinux")
else
    operating_systems=("$@")
fi
dir=$(dirname -- "$( readlink -f -- "$0"; )";)

validate_version() {
    local ver="$1"
    [[ -n "$ver" ]] || { echo >&2 "ERROR: myversion is empty"; exit 1; }
    [[ "$ver" =~ ^[a-zA-Z0-9][a-zA-Z0-9._-]*$ ]] || { echo >&2 "ERROR: myversion '${ver}' is not a valid Docker tag"; exit 1; }
}

docker buildx ls | grep -q multiarch || docker buildx create --name multiarch --driver docker-container --use

set -ex

for os in "${operating_systems[@]}"
do
  arches="amd64,arm64"
  # Skip arm64 if archlinux
  [[ ${os} == "archlinux" ]] && arches="amd64"
  docker build -t "heywoodlh/systemd:${os}-local" -f "${dir}/Dockerfile.${os}" .
  myversion=$(docker run -i --rm --entrypoint=systemctl heywoodlh/systemd:${os}-local --version | head -1 | cut -d'(' -f2 | cut -d')' -f1 | grep -oE '^[0-9]+\.[0-9]+')
  validate_version "$myversion"
  docker buildx build --no-cache --platform "${arches}" -t "docker.io/heywoodlh/systemd:${os}" -t "docker.io/heywoodlh/systemd:${os}-${myversion}" -f "${dir}/Dockerfile.${os}" . --push

  # Ubuntu LTS releases
  if [[ ${os} == "ubuntu" ]]
  then
    ubuntu_versions=("20.04" "22.04" "24.04" "26.04")
    latest_ubuntu="26.04"
    for version in "${ubuntu_versions[@]}"
    do
      upstream="true"
      [[ "${version}" != "${latest_ubuntu}" ]] && upstream="false"
      docker build --build-arg="UBUNTU_VERSION=${version}" --build-arg="UPSTREAM=${upstream}" -t "heywoodlh/systemd:ubuntu-${version}-local" -f "${dir}/Dockerfile.ubuntu" .
      myversion=$(docker run -i --rm --entrypoint=systemctl heywoodlh/systemd:ubuntu-${version}-local --version | head -1 | cut -d'(' -f2 | cut -d')' -f1 | grep -oE '^[0-9]+\.[0-9]+')
      validate_version "$myversion"
      docker buildx build --build-arg="UBUNTU_VERSION=${version}" --build-arg="UPSTREAM=${upstream}" --no-cache --platform "${arches}" -t "docker.io/heywoodlh/systemd:ubuntu-${version}" -t "docker.io/heywoodlh/systemd:ubuntu-${version}-${myversion}" -f "${dir}/Dockerfile.${os}" . --push
    done

    # Set default image to Ubuntu
    export lts="26.04"
    myversion=$(docker run -i --rm --entrypoint=systemctl "heywoodlh/systemd:ubuntu-${lts}-local" --version | head -1 | cut -d'(' -f2 | cut -d')' -f1 | grep -oE '^[0-9]+\.[0-9]+')
    validate_version "$myversion"
    docker buildx build --no-cache --platform "amd64,arm64" -t "docker.io/heywoodlh/systemd:latest" -t "docker.io/heywoodlh/systemd:${myversion}" -f "${dir}/Dockerfile.ubuntu" . --push
  fi

  # Debian releases
  if [[ ${os} == "debian" ]]
  then
    debian_versions=("trixie" "bullseye" "sid")
    latest_debian="sid"
    for version in "${debian_versions[@]}"
    do
      upstream="true"
      [[ "${version}" != "${latest_debian}" ]] && upstream="false"
      docker build --build-arg="DEBIAN_VERSION=${version}" --build-arg="UPSTREAM=${upstream}" -t "heywoodlh/systemd:debian-${version}-local" -f "${dir}/Dockerfile.debian" .
      myversion=$(docker run -i --rm --entrypoint=systemctl heywoodlh/systemd:debian-${version}-local --version | head -1 | cut -d'(' -f2 | cut -d')' -f1 | grep -oE '^[0-9]+\.[0-9]+')
      validate_version "$myversion"
      docker buildx build --build-arg="DEBIAN_VERSION=${version}" --build-arg="UPSTREAM=${upstream}" --no-cache --platform "${arches}" -t "docker.io/heywoodlh/systemd:debian-${version}" -t "docker.io/heywoodlh/systemd:debian-${version}-${myversion}" -f "${dir}/Dockerfile.${os}" . --push
    done
  fi

done

