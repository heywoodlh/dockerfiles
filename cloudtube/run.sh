#!/usr/bin/env bash

if [[ ! -e /opt/cloudtube/config/config.js ]]
then
	if [[ -z $INSTANCE_URI ]]
	then
		INSTANCE_URI="http://second:3000"	
	fi

	if [[ -z $SAVE_HISTORY ]]
	then
		SAVE_HISTORY="false"
	fi

	if [[ -z ${LOCAL} ]]
	then
		LOCAL="false"
	fi

	if [[ -z ${QUALITY} ]]
	then
		QUALITY="0"
	fi

	if [[ -z ${RECOMMENDED_MODE} ]]
	then
		RECOMMENDED_MODE="0"
	fi

	cat <<EOF > /opt/cloudtube/config/config.js
	module.exports = {
		user_settings: {
			instance: {
				default: "${INSTANCE_URI}"
			},
			save_history: {
				type: "boolean",
				default: ${SAVE_HISTORY}
			},
			local: {
				type: "boolean",
				default: ${LOCAL}
			},
			quality: {
				type: "integer",
				default: ${QUALITY}
			},
			recommended_mode: {
				type: "integer",
				default: ${RECOMMENDED_MODE}
			}
		}
	}
EOF
fi

cd /opt/cloudtube
npm start
