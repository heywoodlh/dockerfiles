#!/usr/bin/env bash

# Ensure $HOME ownership
if [[ "$(stat -c '%U' /home/nix)" != "nix" ]]
then
  echo "Ensuring /home/nix correct ownership"
  sudo chown -R 1000:1000 /home/nix
fi

# Default profile directory
if [[ ! -e /nix/var/nix ]]
then
  sudo mkdir -p /nix/var/nix
  sudo chown -R 1000:1000 /nix/var/nix
fi

# Remove own sudo privileges
sudo rm /etc/sudoers.d/nix

exec "${@:-bash}"
