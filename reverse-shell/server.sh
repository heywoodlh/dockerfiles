#!/bin/ash

# Check for required env variables
[[ -z ${LISTEN_PORT} ]] && echo "LISTEN_PORT variable not set. Exiting." && exit 0

# Start listener
socat TCP-LISTEN:${LISTEN_PORT},reuseaddr,fork,max-children=1 UNIX-LISTEN:/tmp/reverse-shell.sock
