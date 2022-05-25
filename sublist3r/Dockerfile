FROM kalilinux/kali-rolling:latest
LABEL maintainer=heywoodlh

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y sublist3r \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["sublist3r"]
