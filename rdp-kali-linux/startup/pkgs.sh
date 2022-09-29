#!/usr/bin/env bash

PKGS=''

if [[ ${MSF_ENABLE} == 'true' ]]
then
	PKGS+='metasploit-framework '
fi

if [[ -n ${PKGS} ]]
then
	apt-get update
	apt-get install -y ${PKGS}
	apt-get autoremove -y &&\
		apt-get clean &&\
		rm -rf /var/lib/apt/lists/*
fi

if [[ ${MSF_ENABLE} == 'true' ]]
then
	service postgresql start
	msfdb init
fi
