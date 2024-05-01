#!/usr/bin/env bash

export NIX_INSTALLED="true"
[[ -e /nix/store ]] || export NIX_INSTALLED="false"

if [[ ${NIX_INSTALLED} == "false" ]]
then
  echo "Nix store absent, copying from original store"
  cp -rn /nix-orig/* /nix/
  chown -R 1000 /nix
else
  echo "Nix is already installed."
fi

export PROFILE_INSTALLED="true"
[[ -e /etc/profile.d/nix.sh ]] || export PROFILE_INSTALLED="false"

if [[ ${PROFILE_INSTALLED} == "false" ]]
then
  echo "/etc/profile.d/nix.sh absent, copying original profile"
  mkdir -p /etc/profile.d
  cp -rn /etc/profile.d-orig/* /etc/profile.d/
else
  echo "Shell profile is already installed."
fi

