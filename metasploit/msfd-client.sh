#!/usr/bin/env ash

while ! nc -q0 "${MSFD_HOST}" "${MSFD_PORT}" < /dev/null > /dev/null 2>&1
do
  echo "$(date): waiting for ${MSFD_HOST}:${MSFD_PORT}"
  sleep 10
done

set -ex

nc "${MSFD_HOST}" "${MSFD_PORT}"
