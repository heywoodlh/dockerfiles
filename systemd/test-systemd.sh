#!/bin/bash
dir=$(dirname -- "$( readlink -f -- "$0"; )";)
dockerfiles=("Dockerfile.ubuntu" "Dockerfile.debian" "Dockerfile.fedora" "Dockerfile.archlinux")

set -ex
for dockerfile in "${dockerfiles[@]}"; do
	echo "=== Testing ${dockerfile} ==="
	iid=$(docker build -q -f ${dir}/${dockerfile} ${dir})
	# NOTE: old version of systemd doesn't wait for `systemctl is-system-running --wait`, so we have `until` loop here.
	docker run -t --rm --privileged $iid sh -exc "until systemctl is-system-running --wait; do sleep 1; done; systemctl status --no-pager"
	docker image rm $iid
done
