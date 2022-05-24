FROM python:3-alpine3.15
LABEL maintainer=heywoodlh

RUN apk --no-cache add bash websocat gcc jq 
RUN pip3 install ntfy
RUN mkdir -p /app \
	&& mkdir -p /etc/ntfy

COPY run.sh /app/run.sh
COPY entrypoint.sh /app/entrypoint.sh
COPY VERSION /app/VERSION

ENV GOTIFY_URI=''
ENV GOTIFY_TOKEN=''

VOLUME /etc/ntfy/ntfy.yml

ENTRYPOINT "/app/entrypoint.sh"
