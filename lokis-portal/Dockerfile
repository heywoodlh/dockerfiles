FROM debian AS build

RUN apt-get update && apt-get install -y git

WORKDIR /opt
RUN git clone https://github.com/heywoodlh/lokis-portal.git /opt/lokis-portal

FROM php:apache-buster
MAINTAINER heywoodlh

ENV APACHE_RUN_USER=loki
ENV APACHE_RUN_GROUP=loki

RUN apt-get update && apt-get install -y tree \
	&& rm -rf /var/lib/apt/lists/*

RUN groupadd loki --gid 1000 &&\
	useradd -ms /bin/bash --uid 1000 --gid 1000 loki
RUN passwd -l root
RUN passwd -l loki

RUN rm -rf /var/www/html
COPY --from=build /opt/lokis-portal /var/www/html
RUN chown -R loki:loki /var/www/html

RUN echo "ServerName 0.0.0.0" >> /etc/apache2/apache2.conf

USER loki
WORKDIR /var/www/html

RUN tree -H '.' -L 1 --noreport -I creds.html --charset utf-8 > index.html
