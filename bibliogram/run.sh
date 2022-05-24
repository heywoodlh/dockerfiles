#!/usr/bin/env bash

if [[ ! -e /app/config.js ]]
then
	if [[ -z ${WEBSITE_ORIGIN} ]]
	then
		WEBSITE_ORIGIN="http://localhost:10407"
	fi

	if [[ -z ${TOR_ENABLED} ]]
	then
		TOR_ENABLED="true"
	fi

	if [[ -z ${FEEDS_ENABLED} ]]
	then
		FEEDS_ENABLED="true"
	fi

	if [[ -z ${DEFAULT_THEME} ]]
	then
		DEFAULT_THEME="classic"	
	fi

	if [[ -z ${REWRITE_YOUTUBE} ]]
	then
		REWRITE_YOUTUBE_ENABLED="false"
		REWRITE_YOUTUBE=""
	else
		REWRITE_YOUTUBE_ENABLED="true"
	fi

	if [[ -z ${REWRITE_TWITTER} ]]
	then
		REWRITE_TWITTER_ENABLED="false"
		REWRITE_TWITTER=""
	else
		REWRITE_TWITTER_ENABLED="true"
	fi

	cat <<EOF > /app/config.js
module.exports = {
	website_origin: "${WEBSITE_ORIGIN}",
	tor: {
		enabled: "${TOR_ENABLED}"
	},
	feeds: {
		enabled: "${FEEDS_ENABLED}" 
	},
	themes: {
		default: "${DEFAULT_THEME}"
	},
	default_user_settings: {
		rewrite_youtube: "${REWRITE_YOUTUBE}",
		rewrite_twitter: "${REWRITE_TWITTER}"
	}

}
EOF
fi

cd /app
npm start
