#!/usr/bin/env bash

if [[ ${SSHD_ENABLE} == 'true' ]]
then
	/usr/sbin/sshd -D -e
fi
