FROM debian:unstable
LABEL maintainer=heywoodlh

RUN apt-get update \
	&& apt-get install -y iperf3 \
	&& rm -rf /var/lib/apt/lists/*

USER iperf3

EXPOSE 5201
ENTRYPOINT ["iperf3"]
