#!/usr/bin/env bash

# If Nix store is empty, copy it over
if [[ ! -e /nix/store ]]
then
  echo "Initializing nix store"
  sudo cp -r /opt/nix/* /nix
  sudo chown -R 1000:1000 /nix
fi

# If single-user install happened, copy single-user files if they don't exist
if [[ -e /opt/nix-home ]]
then
  if [[ ! -e /home/nix/.nix-profile/bin/nix ]]
  then
    echo "Initializing single-user profile"
    sudo cp -r /opt/nix-home/.* /home/nix/
    sudo chown -R 1000:1000 /home/nix
  fi
fi

# Ensure $HOME ownership
if [[ "$(stat -c '%U' /home/nix)" != "nix" ]]
then
  echo "Ensuring /home/nix correct ownership"
  sudo chown -R 1000:1000 /home/nix
fi

# Remove own sudo privileges
sudo rm /etc/sudoers.d/nix

exec "${@:-bash}"
