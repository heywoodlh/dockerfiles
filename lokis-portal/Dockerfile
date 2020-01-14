FROM php:7-apache-buster

RUN apt-get update &&\
	apt-get install git tree -y

WORKDIR /opt

RUN rm -rf /var/www/html &&\
	git clone https://github.com/heywoodlh/lokis-portal.git /opt/lokis-portal &&\
	ln -s /opt/lokis-portal /var/www/html &&\
	chown -R www-data:www-data /opt/lokis-portal &&\
	chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html
RUN tree -H '.' -L 1 --noreport -I creds.html --charset utf-8 > index.html &&\
	chown www-data:www-data index.html
