#!/usr/bin/env bash

if [[ -n ${USER} ]]
then
	[[ -z ${PASSWORD} ]] && export PASSWORD='attacker'
	[[ -z ${UUID} ]] && export UUID=1020
	[[ -z ${GUID} ]] && export GUID=1020

	# Create the user account
	groupadd --gid ${GUID} ${USER}
	useradd --shell /bin/bash --uid ${UUID} --gid ${GUID} --password $(openssl passwd ${PASSWORD}) --create-home --home-dir /home/${USER} ${USER}
	echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER}
	
	## Setup shell files
	cp /etc/bashrc /home/${USER}/.bashrc
	cp /etc/bashrc /root/.bashrc
	touch /home/${USER}/.hushlogin
	touch /root/.hushlogin
	
	## Desktop settings
	mkdir -p /home/${USER}/.config
	tar -C /home/${USER}/.config -xf /opt/xfce4.tar.gz
	chown -R ${USER} /home/${USER}/.config
fi	
