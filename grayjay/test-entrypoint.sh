#!/usr/bin/env bash
set -euo pipefail

image="${1:?usage: $0 IMAGE}"
first=grayjay-cef-lock-first
second=grayjay-cef-lock-second
volume=grayjay-cef-lock-test-data
first_port=11362
second_port=11363

cleanup() {
  docker rm -f "$first" "$second" >/dev/null 2>&1 || true
  docker volume rm -f "$volume" >/dev/null 2>&1 || true
}
trap cleanup EXIT

cleanup
docker volume create "$volume" >/dev/null
docker run -d --name "$first" -v "$volume":/data -p 127.0.0.1:"$first_port":11338 "$image" >/dev/null
for _ in $(seq 1 90); do
  if curl -fsS --max-time 2 "http://127.0.0.1:$first_port/" >/dev/null; then
    break
  fi
  sleep 1
done
curl -fsS --max-time 2 "http://127.0.0.1:$first_port/" >/dev/null

docker kill "$first" >/dev/null
docker rm "$first" >/dev/null
docker run -d --name "$second" -v "$volume":/data -p 127.0.0.1:"$second_port":11338 "$image" >/dev/null
for _ in $(seq 1 90); do
  if curl -fsS --max-time 2 "http://127.0.0.1:$second_port/" >/dev/null; then
    exit 0
  fi
  if [[ $(docker inspect -f '{{.State.Running}}' "$second") != true ]]; then
    docker logs "$second" >&2
    exit 1
  fi
  sleep 1
done

docker logs "$second" >&2
exit 1
