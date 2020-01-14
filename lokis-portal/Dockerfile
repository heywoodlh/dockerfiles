FROM php:apache-buster
MAINTAINER heywoodlh

ENV APACHE_RUN_USER=loki
ENV APACHE_RUN_GROUP=loki

RUN apt-get update && apt-get install -y git tree

RUN groupadd loki --gid 1000 &&\
	useradd -ms /bin/bash --uid 1000 --gid 1000 loki
RUN passwd -l root
RUN passwd -l loki

WORKDIR /opt
RUN rm -rf /var/www/html &&\
	git clone https://github.com/heywoodlh/lokis-portal.git /opt/lokis-portal &&\
	ln -s /opt/lokis-portal /var/www/html &&\
	chown -R loki:loki /var/www/html &&\
	chown -R loki:loki /opt/lokis-portal

USER loki
WORKDIR /var/www/html

RUN tree -H '.' -L 1 --noreport -I creds.html --charset utf-8 > index.html
