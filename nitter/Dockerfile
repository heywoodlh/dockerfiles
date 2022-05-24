FROM zedeus/nitter:latest
LABEL maintainer=heywoodlh

RUN rm /src/nitter.conf
COPY run.sh /run.sh
ENTRYPOINT "/run.sh"
