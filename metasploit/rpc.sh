#!/usr/bin/env bash

# database configuration
/db.sh
DB_ARGS=""
if [[ "${DB_ENABLE}" == "false" ]]
then
  DB_ARGS="-n"
fi

# Disable SSL by default
SSL_ARGS="-S"
if [[ "${MSF_SSL}" != "false" ]]
then
  SSL_ARGS=""
fi

# Arguments for msfrpcd can be seen with `msfrpcd -h`
/entrypoint.sh msfrpcd -f -U "${MSF_USERNAME}" -P "${MSF_PASSWORD}" "${SSL_ARGS}" -a "${MSF_ADDRESS}" -p "${MSF_PORT}" "${DB_ARGS}"
