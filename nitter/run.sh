#!/usr/bin/env ash

if [[ ! -e /src/nitter.conf ]]
then
	if [[ -z ${NITTER_TITLE} ]]
	then
		NITTER_TITLE="nitter"
	fi

	if [[ -z ${NITTER_HOSTNAME} ]]
	then
		NITTER_HOSTNAME="nitter.net"
	fi

	if [[ -z ${REDIS_HOST} ]]
	then
		REDIS_HOST="localhost"	
	fi

	if [[ -z ${REDIS_PORT} ]]
	then
		REDIS_PORT="6379"	
	fi

	if [[ -z ${REDIS_PASSWORD} ]]
	then
		REDIS_PASSWORD=""
	fi

	if [[ -z ${HMACKEY} ]]
	then
		HMACKEY=""
	fi

	if [[ -z ${ENABLE_RSS} ]]
	then
		ENABLE_RSS="true"
	fi
	
	if [[ -z ${NITTER_THEME} ]]
	then
		NITTER_THEME="Nitter"
	fi

	if [[ -z ${REPLACE_TWITTER} ]]
	then
		REPLACE_TWITTER="nitter.net"
	fi

	if [[ -z ${REPLACE_YOUTUBE} ]]
	then
		REPLACE_YOUTUBE="piped.kavin.rocks"
	fi

	if [[ -z ${REPLACE_REDDIT} ]]
	then
		REPLACE_REDDIT="teddit.net"
	fi

	if [[ -z ${REPLACE_INSTAGRAM} ]]
	then
		REPLACE_INSTAGRAM="bibliogram.art"
	fi

	if [[ -z ${HLS_PLAYBACK} ]]
	then
		HLS_PLAYBACK="false"
	fi

	if [[ -z ${INFINITE_SCROLL} ]]
	then
		INFINITE_SCROLL="false"
	fi

	cat <<EOF > /src/nitter.conf
[Server]
address = "0.0.0.0"
port = 8080
https = false  # disable to enable cookies when not using https
httpMaxConnections = 100
staticDir = "./public"
title = "${NITTER_TITLE}"
hostname = "${NITTER_HOSTNAME}"
[Cache]
listMinutes = 240  # how long to cache list info (not the tweets, so keep it high)
rssMinutes = 10  # how long to cache rss queries
redisHost = "${REDIS_HOST}"  # Change to "redis" if using docker-compose
redisPort = "${REDIS_PORT}"
redisPassword = "${REDIS_PASSWORD}"
redisConnections = 20  # connection pool size
redisMaxConnections = 30
[Config]
hmacKey = "${HMACKEY}"  # random key for cryptographic signing of video urls
base64Media = false  # use base64 encoding for proxied media urls
enableRSS = "${ENABLE_RSS}"  # set this to false to disable RSS feeds
enableDebug = false  # enable request logs and debug endpoints
proxy = ""  # http/https url, SOCKS proxies are not supported
proxyAuth = ""
tokenCount = 10
[Preferences]
theme = "${NITTER_THEME}"
replaceTwitter = "${REPLACE_TWITTER}"
replaceYouTube = "${REPLACE_YOUTUBE}"
replaceReddit = "${REPLACE_REDDIT}"
replaceInstagram = "${REPLACE_INSTAGRAM}"
proxyVideos = true
hlsPlayback = "${HLS_PLAYBACK}" 
infiniteScroll = "${INFINITE_SCROLL}" 
EOF
fi

cat /src/nitter.conf

cd /src
./nitter
