#!/usr/bin/env bash
dir=$(dirname -- "$( readlink -f -- "$0"; )";)

if [ -n "$1" ]
then
  dockerfiles=("$1")
else
  dockerfiles=("Dockerfile.ubuntu" "Dockerfile.debian" "Dockerfile.fedora" "Dockerfile.archlinux")
fi

set -ex
for dockerfile in "${dockerfiles[@]}"; do
	[[ ! -e ${dockerfile} ]] && echo "Dockerfile ${dockerfile} does not exist." && exit 1
	echo "=== Testing ${dockerfile} ==="
	iid=$(docker build -q -f ${dir}/${dockerfile} ${dir})
	# NOTE: old version of systemd doesn't wait for `systemctl is-system-running --wait`, so we have `until` loop here.
	docker run -t --rm --privileged $iid sh -exc "until systemctl is-system-running --wait; do sleep 1; done; systemctl status --no-pager"
	docker image rm $iid
done
