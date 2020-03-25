FROM ubuntu:xenial
MAINTAINER heywoodlh

RUN apt-get update &&\
	apt-get install -y python git &&\
	rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/volatilityfoundation/volatility.git /opt/volatility &&\
	chmod +x /opt/volatility/vol.py

WORKDIR /opt/volatility
ENTRYPOINT ["/opt/volatility/vol.py"]
