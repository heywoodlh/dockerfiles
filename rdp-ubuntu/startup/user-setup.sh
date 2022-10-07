#!/usr/bin/env bash

if [[ -n ${USER} ]]
then
	[[ -z ${PASSWORD} ]] && export PASSWORD='ubuntu'
	[[ -z ${UUID} ]] && export UUID=1020
	[[ -z ${GUID} ]] && export GUID=1020

	# Create the user account
	groupadd --gid ${GUID} ${USER}
	useradd --shell /bin/bash --uid ${UUID} --gid ${GUID} --password $(openssl passwd ${PASSWORD}) --create-home --home-dir /home/${USER} ${USER}
	echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER}
fi	
