FROM alpine:latest

RUN apk --no-cache add ffmpeg findutils bash sed

COPY convert-mp3.sh /convert-mp3.sh
COPY entrypoint.sh /entrypoint.sh

VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["/entrypoint.sh"]
