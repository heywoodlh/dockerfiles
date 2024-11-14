#!/bin/ash

# Check for required env variables
[[ -z ${LISTEN_PORT} ]] && echo "LISTEN_PORT variable not set. Exiting." && exit 1

# Start listener
echo "Started listener at ${LISTEN_PORT}"
socat TCP-LISTEN:${LISTEN_PORT},reuseaddr,fork,max-children=1 UNIX-LISTEN:/tmp/reverse-shell.sock
