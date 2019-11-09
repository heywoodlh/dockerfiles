#!/usr/bin/execlineb -P

cd /
umask 022
fdclose 0

if { echo "* init stage 1" }
fdclose 1 fdclose 2


if { rm -f /service/s6-svscan-log/fifo }
if { mkfifo -m0600 /service/s6-svscan-log/fifo }
redirfd -r 0 /dev/null
redirfd -wnb 1 /service/s6-svscan-log/fifo # (black magic: doesn't block)
fdmove -c 2 1

s6-envdir /service/.s6-env
s6-svscan -t0 /service
