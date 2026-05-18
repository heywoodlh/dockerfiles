#!/usr/bin/env bash

if [[ $(id -u) != 0 ]]
then
  XDG_RUNTIME_DIR=/run/user/1000 dockerd-rootless.sh
else
  dockerd --storage-driver=fuse-overlayfs
fi
