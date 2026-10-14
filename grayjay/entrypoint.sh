#!/bin/bash
set -euo pipefail

mkdir -p /data
cd /data
cp -rf /opt/grayjay/* .
rm -f port

Xvfb :99 -screen 0 1280x1024x24 -nolisten tcp &
xvfb_pid=$!
export DISPLAY=:99

./Grayjay --headless --ignore-security --no-sandbox &
grayjay_pid=$!

for _ in $(seq 1 60); do
  if [[ -s port ]]; then
    port=$(<port)
    if [[ "$port" =~ ^[0-9]+$ ]]; then
      node /usr/local/bin/reverse-proxy.js "$port" &
      proxy_pid=$!
      wait "$grayjay_pid"
      exit_code=$?
      kill "$proxy_pid" "$xvfb_pid" 2>/dev/null || true
      exit "$exit_code"
    fi
  fi
  if ! kill -0 "$grayjay_pid" 2>/dev/null; then
    wait "$grayjay_pid"
  fi
  sleep 1
done

kill "$grayjay_pid" "$xvfb_pid" 2>/dev/null || true
exit 1
