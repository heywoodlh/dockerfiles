FROM ubuntu
LABEL maintainer="heywoodlh"

ENV DEBIAN_FRONTEND=noninteractive \
	SQUID_CACHE_DIR=/var/spool/squid \
	SQUID_LOG_DIR=/var/log/squid \
	SQUID_USER=proxy

RUN apt-get update \
	&&  apt-get install -y squid \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
