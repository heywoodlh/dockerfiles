#!/usr/bin/env bash

# Disable database unless user explicitly enables it
if [[ "${DB_ENABLE}" != "false" ]]
then
  printf "Database configuration enabled, creating database.yml"
  mkdir -p "${HOME}"/.msf4
  # Do not overwrite existing config if provided
  if [[ ! -e "${HOME}"/.msf4/database.yml ]]
  then
cat <<EOF > "${HOME}"/.msf4/database.yml
production:
adapter: "$DB_ADAPTER"
database: "$DB_NAME"
username: "$DB_USERNAME"
password: "$DB_PASSWORD"
port: $DB_PORT
host: "$DB_HOST"
pool: 256
timeout: 5
EOF
  fi
fi
