#!/bin/sh
dir=$(dirname -- "$( readlink -f -- "$0"; )";)
dockerfile="Dockerfile"
set -ex
echo "=== Testing ${dockerfile} ==="
iid=$(docker build -q -f ${dir}/${dockerfile} ${dir})
docker run -t --rm --privileged $iid ash -c "rc-status && printf 'OpenRC running!\n'"
docker image rm $iid
