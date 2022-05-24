FROM nginx:stable

RUN apt-get update && apt-get install -y nginx-full \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm /etc/nginx/conf.d/default.conf \
	&& rm /etc/nginx/sites-enabled/default

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/sites-enabled /etc/nginx/sites-enabled
