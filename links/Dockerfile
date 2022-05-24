FROM alpine 
LABEL maintainer=heywoodlh

RUN apk --no-cache add ca-certificates links  

RUN mkdir -p /home/links \
	&& addgroup -g 1000 -S links \
	&& adduser -u 1000 -D -S -h /home/links -G links links

USER links
WORKDIR /home/links
ENTRYPOINT ["/usr/bin/links"]
