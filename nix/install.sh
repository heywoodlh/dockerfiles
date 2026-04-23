#!/usr/bin/env bash

userdel -r ubuntu &>/dev/null || true

# Create non-root user
groupadd --gid 1000 nix \
  && adduser --uid 1000 --gecos "" --disabled-password --home /home/nix --shell /bin/bash --ingroup nix nix \
  && mkdir -p /etc/sudoers.d \
  && echo "nix ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nix \
  && mkdir -p /opt/nix \
  && chown -R 1000:1000 /opt/nix

# Install Nix as non-root user
sudo -u nix /nix.sh "$1" && rm /nix.sh
