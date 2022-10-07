#!/usr/bin/env bash

# Start xrdp sesman service
killall -9 xrdp-sesman
rm -f /var/run/xrdp/xrdp-sesman.pid
/usr/sbin/xrdp-sesman

# Run xrdp in foreground if no commands specified
if [ -z "$1" ]; then
        /usr/sbin/xrdp --nodaemon
    else
	    /usr/sbin/xrdp
	        exec "$@"
fi

