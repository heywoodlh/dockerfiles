#!/usr/bin/env bash

TTYD_ARGS=""

if [ -n "${TTYD_USER}" ] && [ -n "${TTYD_PASS}" ];
then
    TTYD_ARGS="${TTYD_ARGS} --credential ${TTYD_USER}:${TTYD_PASS}"
fi

ttyd -p 80 --uid 1000 --gid 1000 -w /home/heywoodlh --writable ${TTYD_ARGS} /home/heywoodlh/.nix-profile/bin/tmux
