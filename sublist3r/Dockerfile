FROM heywoodlh/kali-minimal:latest
LABEL maintainer=heywoodlh

RUN apt-get update && apt-get install -y sublist3r \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["sublist3r"]
