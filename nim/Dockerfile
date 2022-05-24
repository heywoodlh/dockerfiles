FROM debian
LABEL maintainer=heywoodlh

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	nim  mingw-w64 \
	&& rm -rf /var/lib/apt/lists/* 

WORKDIR /app
CMD ["nim"]
