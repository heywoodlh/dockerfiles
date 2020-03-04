#!/usr/bin/env ash

if [[ ! -f /opt/moroz/ssl/server.crt ]] || [[ ! -f /opt/moroz/ssl/server.key ]]
then
	echo 'generating new CA'
	openssl genrsa -out /opt/moroz/ssl/serverCA.key 4096
	openssl req -x509 -new -nodes -key /opt/moroz/ssl/serverCA.key -sha256 -days 1825 -out /opt/moroz/ssl/serverCA.crt -subj "/CN=santa"

	echo 'generating self-signed certificates'
	openssl genrsa -out /opt/moroz/ssl/server.key 4096
	openssl rsa -in /opt/moroz/ssl/server.key -out /opt/moroz/ssl/server.key
	openssl req -sha256 -new -key /opt/moroz/ssl/server.key -out /opt/moroz/ssl/server.csr -subj "/CN=santa"
	openssl x509 -req -sha256 -days 365 -in /opt/moroz/ssl/server.csr -signkey /opt/moroz/ssl/server.key -out /opt/moroz/ssl/server.crt -CA /opt/moroz/ssl/serverCA.crt -CAkey /opt/moroz/ssl/serverCA.key -CAcreateserial
	rm /opt/moroz/ssl/server.csr
fi

if [[ ! -f /opt/moroz/configs/global.toml ]]
then
	cp /opt/moroz/configs.orig/global.toml /opt/moroz/configs/
fi

echo 'starting moroz'
moroz --configs /opt/moroz/configs --tls-cert /opt/moroz/ssl/server.crt --tls-key /opt/moroz/ssl/server.key
