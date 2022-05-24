#!/usr/bin/env bash

error='false'

if [[ -n ${USERNAME} ]]
then
	useradd -m -s /bin/bash ${USERNAME}
	if [[ -n ${PASSWORD} ]]
	then
		echo "${USERNAME}:${PASSWORD}" | chpasswd
	fi
	cp /etc/bashrc.template /home/${USERNAME}/.bashrc \
		&& chown -R ${USERNAME} /home/${USERNAME}/.bashrc
	cp /etc/vimrc.template /home/${USERNAME}/.vimrc \
		&& chown -R ${USERNAME} /home/${USERNAME}/.vimrc
else 
	echo 'FATAL: please set $USERNAME'
	error='true'
fi

[[ -z ${PASSWORD} ]] && echo 'FATAL: please set $PASSWORD' && error='true'

if [[ ! -e /etc/ssh/sshd_config ]]
then
	rm -rf /etc/ssh/*
	mkdir -p /etc/ssh
	cp -r /etc/ssh.template/* /etc/ssh
	rm /etc/ssh/ssh_host_*
	dpkg-reconfigure openssh-server
	chmod 600 /etc/ssh/ssh_host_*
fi

if [[ ${error} == 'true' ]]
then
	echo 'FATAL: error encountered -- exiting'	
	exit 5
fi

chown -R ${USERNAME} /data
chown -R ${USERNAME} /app
su -l ${USERNAME} -c 'cd /app && npm run dev'
