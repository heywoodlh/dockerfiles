#!/usr/bin/env bash

tor -f /etc/tor/torrc.default &

transmission-daemon --auth --username "$TR_USER" --password "$PASSWORD" --port 9091 --allowed "127.0.0.1"
