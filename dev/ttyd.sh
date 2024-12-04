#!/usr/bin/env bash

TTYD_ARGS=""

if [ -n "${TTYD_USER}" ] && [ -n "${TTYD_PASS}" ];
then
    TTYD_ARGS="${TTYD_ARGS} --credential ${TTYD_USER}:${TTYD_PASS}"
fi

COMMAND="/bin/bash"
[[ -e /home/heywoodlh/.nix-profile/bin/tmux ]] && COMMAND="/home/heywoodlh/.nix-profile/bin/tmux"

if [[ -e /home/heywoodlh/.nix-profile/bin/ttyd ]]
then
    /home/heywoodlh/.nix-profile/bin/ttyd -W -t fontSize=16 -t fontFamily="JetBrains" -p 80 --uid 1000 --gid 1000 -w /home/heywoodlh --writable ${TTYD_ARGS} ${COMMAND}
else
    /usr/bin/ttyd -W -t fontSize=16 -t fontFamily="JetBrains" -p 80 --uid 1000 --gid 1000 -w /home/heywoodlh --writable ${TTYD_ARGS} ${COMMAND}
fi
