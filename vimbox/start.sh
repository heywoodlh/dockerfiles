#!/usr/bin/env bash

if [[ -n ${VIM_PASSWORD} ]]
then
	echo "vim:${VIM_PASSWORD}" | chpasswd 
fi	
