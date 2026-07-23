#!/usr/bin/env bash

# nix shell shebang fails to git clone spindle-run
# using `nix run` commands instead

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ "$(uname -m)" == "aarch64" && "$(uname -s)" == "Linux" ]]
then
  echo "ARM64 Linux is not supported: docker buildx fails to load libldap under QEMU emulation."
  exit 1
fi

export NIXPKGS_ALLOW_UNFREE=1

# Check if logged in
if ! nix run --impure nixpkgs#_1password-cli -- account list | grep -iq my
then
  echo "Not logged into 1Password. Exiting."
  exit 1
fi

eval "$(nix run --impure nixpkgs#_1password-cli -- signin)"

nix run "git+https://tangled.org/heywoodlh.io/spindle-run" -- -e DOCKER_TOKEN="$(op item get 'ggfjrj2xocsf2f37lxnjomxtya' --fields 'personal-access-token' --reveal)" "${SCRIPT_DIR}/../.tangled/workflows/spindle.yml"
