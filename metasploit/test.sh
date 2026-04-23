#!/usr/bin/env bash

set -ex
msfconsole --version
nix run nixpkgs#hello
