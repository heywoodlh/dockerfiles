#!/usr/bin/env bash

uri="$1"
token="$2"

usage="$0 'ws://gotify-url:8000' 'gotify-token'"

[[ -z ${uri} ]] && echo "usage: ${usage}" && exit 1
[[ -z ${token} ]] && echo "usage: ${usage}" && exit 1

[[ ! -f /etc/ntfy/ntfy.yml ]] && echo "config file /etc/ntfy/ntfy.yml not found" && exit 1

while read line
do
	message="$(echo ${line} | jq -r '.message')"
	echo "Message: ${message}"
        ntfy -c /etc/ntfy/ntfy.yml send "${message}"
done < <(websocat -H "X-Gotify-Key: ${token}" -t "${uri}")
