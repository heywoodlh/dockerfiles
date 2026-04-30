#!/usr/bin/env bash

EXTRA_ARGS=""

# Support basic auth
if [[ -n "${HTTP_AUTH_PASSWORD}" ]]
then
  EXTRA_ARGS="-c ${HTTP_AUTH_USERNAME}:${HTTP_AUTH_PASSWORD}"
fi

mkdir -p /home/nix/ttyd

source /opt/hermes/.venv/bin/activate

/usr/bin/ttyd --port 8080 --writable --cwd /home/nix/ttyd $EXTRA_ARGS /opt/hermes/.venv/bin/hermes
