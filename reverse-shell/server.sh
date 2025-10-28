#!/bin/ash
# shellcheck shell=bash

rm -f /data/reverse-shell.sock

# Check for required env variables
[ -z "${LISTEN_PORT}" ] && echo "LISTEN_PORT variable not set. Exiting." && exit 1

if [ ! -e "${SSL_CERT_FILE}" ] || [ ! -e "${SSL_KEY_FILE}" ]
then
    [ "${ENABLE_SSL}" == "true" ] && openssl req -newkey rsa:4096 -nodes -keyout "${SSL_KEY_FILE}" -x509 -days 1000 -subj '/CN=reverse-shell/O=Reverse Shell, Inc./C=US' -out "${SSL_CERT_FILE}"
fi

chown -R 1000:1000 /data
chown -R 1000:1000 /ssl

# Start listener
if [ -e "${SSL_CERT_FILE}" ] && [ "${ENABLE_SSL}" == "true" ]
then
    echo "Starting encrypted listener at ${LISTEN_PORT}"
    set -ex
    su shell -c "socat OPENSSL-LISTEN:${LISTEN_PORT},cert=${SSL_CERT_FILE},key=${SSL_KEY_FILE},reuseaddr,fork,max-children=1,verify=0 UNIX-LISTEN:/data/reverse-shell.sock"
else
    echo "Starting unencrypted listener at ${LISTEN_PORT}"
    set -ex
    su shell -c "socat TCP-LISTEN:${LISTEN_PORT},reuseaddr,fork,max-children=1 UNIX-LISTEN:/data/reverse-shell.sock"
fi
