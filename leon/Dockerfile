FROM node:17.4.0-alpine3.15 as app
LABEL maintainer=heywoodlh

WORKDIR /app
RUN apk add --no-cache python3 py3-pip git \
	&& pip3 install pipenv 

## Build leon
RUN git clone -b master https://github.com/leon-ai/leon.git /app \
	&& npm install \
	&& npm run build

COPY run.sh /run.sh

ENV LEON_HOST="http://0.0.0.0"

EXPOSE 1337
ENTRYPOINT "/run.sh"
