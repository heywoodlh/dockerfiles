#!/usr/bin/env bash

until docker info &>/dev/null 2>&1
do
  echo "waiting for dockerd..."
  sleep 2
done

exec spindle
