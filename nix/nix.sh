#!/usr/bin/env bash

# Should be invoked by `install.sh`
INSTALL="$1"

sudo chown -R 1000:1000 /nix

if [[ -z "$INSTALL" ]]
then
  echo "Unset INSTALL environment variable -- exiting."
  exit 1
fi

if [[ "$INSTALL" == "default" ]]
then
  if arch | grep aarch64
  then
    export NIX_INSTALLER_EXTRA_CONF="filter-syscalls = false"
  fi
  curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install linux --enable-flakes --init none --no-confirm
fi

if [[ "$INSTALL" == "determinate" ]]
then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux \
    --extra-conf "sandbox = false" \
    --init none \
    --no-confirm \
    --extra-conf='filter-syscalls = false'
fi

# Backup nix for entrypoint
sudo cp -r /nix/* /opt/nix/

sudo mkdir -p /nix
sudo chown -R 1000:1000 /nix \
