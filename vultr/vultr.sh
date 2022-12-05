#!/usr/bin/env bash
## Basic interactive shell script for interacting with Vultr VPS'

process_pid="$$"

actions='instance-create\ninstance-destroy\ninstance-list\ninstance-start\ninstance-reboot\ninstance-shutdown'

if [[ -n $1 ]]
then
	action="$1"
	if [[ ${action} == '--help' ]]
	then
		printf "$0 [instance-create instance-destroy instance-list instance-start instance-reboot instance-shutdown]"
	fi
else
	action="$(printf ${actions} | fzf)"
fi

trap "exit" INT

if [[ ${action} == 'instance-create' ]]
then
	extra_args=""
	plans_list="$(vultr-cli plans list | grep -vE '^ID' | sed -n '/^===/q;p')"
	regions_list="$(vultr-cli regions list | grep -vE '^ID' | sed -n '/^===/q;p')"
	regions_list="$(printf "${regions_list}" | grep 'Los Angeles' && printf "${regions_list}" | grep 'US' | grep -v 'Los Angeles' && printf "${regions_list}" | grep -v 'US')"
	os_list="$(vultr-cli os list | grep -vE '^ID' | grep -E 'Arch Linux|Ubuntu 22.04' | sed -n '/^===/q;p')"
	os_list="$(printf "${os_list}" | grep -E 'Ubuntu' && printf "${os_list}" | grep -vE 'Ubuntu')"

	until [[ -n ${hostname} ]]
	do
		echo 'New instance hostname: '
		read hostname
	done

	os_id="$(printf "${os_list}" | fzf --prompt="OS:" | awk '{print $1}')"
	if [[ -z ${os_id} ]]
	then
		os_id=$(vultr-cli os list | grep 'Ubuntu' | head -1 | awk '{print $1}')
	fi

	plan_id="$(printf "${plans_list}" | fzf | awk '{print $1}')"
	if [[ -z ${plan_id} ]]
	then
		plan_id='vc2-1c-1gb'
	fi

	region_id="$(printf "${regions_list}" | fzf | awk '{print $1}')"
	if [[ -z ${region_id} ]]
	then
		region_id='lax'
	fi

	private_network="$(printf "false\ntrue" | fzf --prompt="Enable Private Network:" )"
	if [[ -z ${private_network} ]]
	then
		private_network='false'
	fi

	ddos_protection="$(printf "false\ntrue" | fzf --prompt="Enable DDOS protection:" )"
	if [[ -z ${ddos_protection} ]]
	then
		ddos_protection='false'
	fi

	enable_ipv6="$(printf "false\ntrue" | fzf --prompt="Enable IPv6:" )"
	if [[ -z ${enable_ipv6} ]]
	then
		enable_ipv6='false'
	fi

	use_ssh_keys="$(printf "true\nfalse" | fzf --prompt="Use SSH key:" )"
	if [[ -z ${use_ssh_keys} ]]
	then
		use_ssh_keys="false"
	fi

	if [[ ${use_ssh_keys} == "true" ]]
	then
		ssh_key_list=$(vultr-cli ssh-key list | grep -vE '^ID' | sed -n '/^===/q;p')
		ssh_key_id="$(printf "${ssh_key_list}" | fzf | awk '{print $1}')"

		extra_args+="--ssh-keys ${ssh_key_id} "
	fi

	use_script="$(printf "true\nfalse" | fzf --prompt="Run script:" )"
	if [[ -z ${use_script} ]]
	then
		use_script='false'
	fi

	if [[ ${use_script} == "true" ]]
	then
		script_list=$(vultr-cli script list | grep -vE '^ID' | sed -n '/^===/q;p')
		script_id="$(printf "${script_list}" | fzf | awk '{print $1}')"

		extra_args+="--script-id ${script_id} "
	fi

	use_firewall_group="$(printf "true\nfalse" | fzf --prompt="Add to firewall group:" )"
	if [[ -z ${use_firewall_group} ]]
	then
		use_firewall_group='false'
	fi

	if [[ ${use_firewall_group} == "true" ]]
	then
		firewall_list=$(vultr-cli firewall group list | grep -vE '^ID' | sed -n '/^===/q;p')
		firewall_id="$(printf "${firewall_list}" | fzf | awk '{print $1}')"

		extra_args+="--firewall-group ${firewall_id} "
	fi

	printf "\n\nCreate instance with following parameters: \nvultr-cli instance create \\ \n    --host ${hostname} \\ \n    --label ${hostname} \\ \n    --os ${os_id} \\ \n    --plan ${plan_id} \\ \n    --private-network ${private_network} \\ \n    --region ${region_id} \\ \n    --ipv6 ${enable_ipv6} \\ \n    --ddos ${ddos_protection} \\ \n    --notify false \\ \n    ${extra_args} \n\n"
	echo "Type YES to create instance"
	read input

	if [[ ${input} == 'YES' ]]
	then
        	vultr-cli instance create \
        		--host ${hostname} \
        		--label ${hostname} \
        		--os ${os_id} \
        		--plan ${plan_id} \
        		--private-network ${private_network} \
        		--region ${region_id} \
        		--ipv6 ${enable_ipv6} \
        		--ddos ${ddos_protection} \
        		--notify false \
        		${extra_args}
	fi

fi

if [[ ${action} == 'instance-list' ]]
then
	vultr-cli instance list | sed -n '/^===/q;p'	
fi

if [[ ${action} == 'instance-destroy' ]]
then
	instance_list=$(vultr-cli instance list | grep -vE '^ID' | sed -n '/^===/q;p')
	instance="$(printf "${instance_list}" | fzf --prompt="Instance to delete:")"

	echo "Delete instance: ${instance}"
	echo "Type YES"
	read input

	instance_id="$(printf "${instance}" | awk '{print $1}')"

	[[ ${input} == 'YES' ]] && vultr-cli instance delete ${instance_id}
fi

if [[ ${action} == 'instance-reboot' ]]
then
	instance_list=$(vultr-cli instance list | grep -vE '^ID' | sed -n '/^===/q;p')
	instance="$(printf "${instance_list}" | fzf --prompt="Instance to reboot:")"
	instance_id="$(printf "${instance}" | awk '{print $1}')"

	[[ -n ${instance_id} ]] && vultr-cli instance restart ${instance_id}
fi

if [[ ${action} == 'instance-shutdown' ]]
then
	instance_list=$(vultr-cli instance list | grep -vE '^ID' | sed -n '/^===/q;p')
	instance="$(printf "${instance_list}" | fzf --prompt="Instance to shutdown:")"
	instance_id="$(printf "${instance}" | awk '{print $1}')"

	[[ -n ${instance_id} ]] && vultr-cli instance stop ${instance_id}
fi

if [[ ${action} == 'instance-start' ]]
then
	instance_list=$(vultr-cli instance list | grep -vE '^ID' | sed -n '/^===/q;p')
	instance="$(printf "${instance_list}" | fzf --prompt="Instance to start:")"
	instance_id="$(printf "${instance}" | awk '{print $1}')"

	[[ -n ${instance_id} ]] && vultr-cli instance start ${instance_id}
fi

