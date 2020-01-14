#!/usr/bin/env bash

set -m

torify transmission-daemon --auth --username transmission --password transmission --port 9091 --allowed "127.0.0.1" --foreground
