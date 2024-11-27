#!/usr/bin/env bash

# If tmux not installed, then assume flake not setup
if [[ ! -e /home/heywoodlh/.nix-profile/bin/tmux ]]
then
    curl -H 'Cache-Control: no-cache' -L https://files.heywoodlh.io/scripts/linux.sh | bash -s -- server \
        && rm -rf /home/heywoodlh/.cache/nix/

    ## kill ttyd after tmux install
    [[ -e /home/heywoodlh/.nix-profile/bin/tmux ]] && sudo pkill -9 ttyd
fi
