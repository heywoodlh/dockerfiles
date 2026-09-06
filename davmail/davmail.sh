#!/usr/bin/env bash

# Script to continuously re-open davmail if it is closed
while true
do
  if ! ps aux | grep -q "[d]avmail.DavGateway"
  then
    echo "DavMail not running. Re-opening."
    davmail &
  fi
  sleep 5
done
