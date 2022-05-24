FROM debian:buster
LABEL maintainer=heywoodlh

ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get install -y wget postfix gnupg &&\
	wget -q -O - https://www.atomicorp.com/RPM-GPG-KEY.atomicorp.txt  | apt-key add - && \
	echo "deb https://updates.atomicorp.com/channels/atomic/debian buster main" >>  /etc/apt/sources.list.d/atomic.list &&\
	apt-get update && apt-get install -y ossec-hids-server && \
	rm -rf /var/lib/apt/lists/*

ADD default_agent /var/ossec/default_agent
ADD ossec.conf /var/ossec/etc/
ADD data_dirs.env /data_dirs.env
ADD init.sh /init.sh
ADD ossec-server.sh /ossec-server.sh


RUN chmod 755 /ossec-server.sh && \
	chmod 755 /init.sh && \
  	sync && /init.sh &&\
  	sync && rm /init.sh

VOLUME ["/var/ossec/data"]
EXPOSE 1514/udp 1515/tcp

ENTRYPOINT ["/ossec-server.sh"]
