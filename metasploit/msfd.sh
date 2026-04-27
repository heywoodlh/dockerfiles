#!/usr/bin/env bash

# database configuration
/db.sh

# Disable SSL by default
SSL_ARGS=""
if [[ "${MSF_SSL}" != "false" ]]
then
  SSL_ARGS="-s"
fi

# Keep looping
while true
do
  # Arguments for msfrpcd can be seen with `msfrpcd -h`
  /entrypoint.sh msfd -f -a 0.0.0.0 -p "${MSFD_PORT}" "${SSL_ARGS}"
done
