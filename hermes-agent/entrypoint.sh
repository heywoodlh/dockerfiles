#!/usr/bin/env bash

sudo chown -R 1000:1000 "$HOME" &>/dev/null

# Run /nix.sh from docker.io/heywoodlh/nix
/nix.sh true

# Run services
exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
