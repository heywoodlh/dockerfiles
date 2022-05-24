FROM node:17.3.0-alpine as build
RUN apk --no-cache add git python3 make g++ \
	&& git clone https://git.sr.ht/~cadence/bibliogram /app
WORKDIR /app
RUN npm install --no-optional

FROM node:17.3.0-alpine as app
COPY --from=build /app /app
WORKDIR /app
RUN apk add --no-cache graphicsmagick bash \
	&& rm /app/config.js 

COPY run.sh /run.sh

EXPOSE 10407
ENTRYPOINT "/run.sh"
