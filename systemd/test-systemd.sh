#!/usr/bin/env bash
dir=$(dirname -- "$( readlink -f -- "$0"; )";)
dockerfiles=("Dockerfile.ubuntu" "Dockerfile.debian" "Dockerfile.fedora" "Dockerfile.archlinux")

# Dockerfile.archlinux requires the OBS system:systemd repo which only publishes
# x86_64 packages. Running x86_64 emulation on arm64 hits seccomp restrictions,
# so skip it on non-x86_64 hosts.
arch=$(uname -m)
if [ "$arch" != "x86_64" ]; then
    echo "NOTE: skipping Dockerfile.archlinux on $arch (OBS repo only has x86_64 packages)"
    dockerfiles=("Dockerfile.ubuntu" "Dockerfile.debian" "Dockerfile.fedora")
fi

set -ex
for dockerfile in "${dockerfiles[@]}"; do
	echo "=== Testing ${dockerfile} ==="
	iid=$(docker build -q -f ${dir}/${dockerfile} ${dir})
	# NOTE: old version of systemd doesn't wait for `systemctl is-system-running --wait`, so we have `until` loop here.
	docker run -t --rm --privileged $iid sh -exc "until systemctl is-system-running --wait; do sleep 1; done; systemctl status --no-pager"
	docker image rm $iid
done
