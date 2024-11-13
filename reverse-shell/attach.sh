#!/bin/ash

[[ -e /tmp/reverse-shell.sock ]] && socat - UNIX-CONNECT:/tmp/reverse-shell.sock
