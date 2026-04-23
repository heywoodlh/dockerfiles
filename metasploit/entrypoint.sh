#!/usr/bin/env bash

# If Nix store is empty, copy it over
if [[ ! -e /nix/store ]]
then
  echo "Initializing nix store"
  sudo cp -r /opt/nix/* /nix
  sudo chown -R 1000:1000 /nix
fi

if [[ "$(stat -c '%U' /nix)" != "msf" ]]
then
  echo "Ensuring /nix permissions for msf user"
  sudo chown -R 1000:1000 /nix
fi

# Ensure $HOME ownership
if [[ "$(stat -c '%U' /home/msf)" != "msf" ]]
then
  echo "Ensuring /home/msf correct ownership"
  sudo chown -R 1000:1000 /home/msf
fi

# Ensure own privileges are safe
if [[ ! -e /home/msf/.msf4 ]]
then
  sudo mkdir -p /home/msf/.msf4
  sudo chown -R 1000:1000 /home/msf/.msf4
fi

# Ensure msf4 directory ownership
if [[ "$(stat -c '%U' /home/msf/.msf4)" != "msf" ]]
then
  echo "Ensuring /home/msf correct ownership"
  sudo chown -R 1000:1000 /home/msf/.msf4
fi

# Revoke admin privileges
if [[ ${SUDO} != "true" ]]
then
  sudo rm /etc/sudoers.d/msf
fi

exec "${@:-bash}"
