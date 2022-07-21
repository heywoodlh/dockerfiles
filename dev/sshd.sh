#!/usr/bin/env bash

[[ -e /etc/ssh/ssh_host_rsa_key ]] || ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
[[ -e /etc/ssh/ssh_host_dsa_key ]] || ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config

mkdir -p /run/sshd

/usr/sbin/sshd -D -e
