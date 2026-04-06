#!/usr/bin/env bash

sudo chown -R 1000:1000 "$HOME" &>/dev/null

# Reinstall Claude if binary isn't present (i.e. if $HOME is a new volume)
if [[ ! -e $HOME/.local/bin/claude ]]
then
  mkdir -p "$HOME/.local/bin"
  echo "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
fi

# Run /nix.sh from docker.io/heywoodlh/nix
/nix.sh true
/usr/local/bin/claude-code-webui --host "${HOST}" "$@"
