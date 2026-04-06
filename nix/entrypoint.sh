#!/usr/bin/env bash

# If Nix store is empty, copy it over
if [[ ! -e /nix/store ]]
then
  echo "Initializing nix store"
  sudo cp -r /opt/nix/* /nix
  sudo chown -R 1000:1000 /nix
fi

# Ensure $HOME ownership
sudo chown -R 1000:1000 /home/nix

# Remove own sudo privileges
sudo rm /etc/sudoers.d/nix

exec "${@:-bash}"
