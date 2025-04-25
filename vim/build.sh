#!/usr/bin/env bash

docker build -t base -f Dockerfile.base --target=base .
docker build -t vim -f Dockerfile.base --target=vim .
docker build -t neovim -f Dockerfile.base --target=neovim .

plugin_managers=("pathogen" "vim-plug" "vundle")

set -ex
for manager in "${plugin_managers[@]}"; do
    docker build -t "docker.io/heywoodlh/vim:${manager}-vim" -f "Dockerfile.${manager}" --target="${manager}-vim" .
    docker build -t "docker.io/heywoodlh/vim:${manager}-vim-test" -f "Dockerfile.${manager}" --target="vim-test" .
    docker build -t "docker.io/heywoodlh/vim:${manager}-neovim" -f "Dockerfile.${manager}" --target="${manager}-neovim" .
    docker build -t "docker.io/heywoodlh/vim:${manager}-neovim-test" -f "Dockerfile.${manager}" --target="neovim-test" .
done
