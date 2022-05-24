#!/usr/bin/env bash

if [[ -n "$WEBSITE_ORIGIN" ]]
then
	echo "website_origin = \"$WEBSITE_ORIGIN\"" > /opt/second/configuration.py 
fi

cd /opt/second
python3 index.py
