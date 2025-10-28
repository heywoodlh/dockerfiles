#!/bin/ash
# shellcheck shell=bash

set -ex
if [[ -e /data/reverse-shell.sock ]]
then
    socat - UNIX-CONNECT:/data/reverse-shell.sock
else
    echo "No reverse shell socket found at /data/reverse-shell.sock"
fi
