#!/usr/bin/env bash
if [[ -e /dev/snd ]]; then
	exec apulse firefox -P default.profile $@
else
	exec firefox -P default.profile $@
fi
