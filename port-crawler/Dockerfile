FROM heywoodlh/telnet
LABEL maintainer="heywoodlh"

ADD https://raw.githubusercontent.com/heywoodlh/port-crawler/master/port-crawler.sh /usr/local/bin/port-crawler

RUN chmod +x /usr/local/bin/port-crawler 

RUN apt-get update && apt-get install -y python3 python3-pip \
	&& pip3 install jsonpyes \
	&& rm -rf /var/lib/apt/lists/*

CMD "/usr/local/bin/port-crawler"
