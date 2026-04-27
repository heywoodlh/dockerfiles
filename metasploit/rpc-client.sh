#!/usr/bin/env bash

# Disable SSL by default
SSL_ARGS="-S"
if [[ "${MSF_SSL}" != "false" ]]
then
  SSL_ARGS=""
fi

while ! nc -q0 "${MSF_HOST}" "${MSF_PORT}" < /dev/null > /dev/null 2>&1
do
  echo "$(date): waiting for ${MSF_HOST}:${MSF_PORT}"
  sleep 10
done

/entrypoint.sh msfrpc -U "${MSF_USERNAME}" -P "${MSF_PASSWORD}" -a "${MSF_HOST}" -p "${MSF_PORT}" "${SSL_ARGS}"
