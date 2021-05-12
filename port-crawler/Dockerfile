FROM heywoodlh/telnet
LABEL maintainer="heywoodlh"

ADD https://raw.githubusercontent.com/heywoodlh/port-crawler/master/port-crawler.sh /usr/local/bin/port-crawler

RUN chmod +x /usr/local/bin/port-crawler 

RUN apk --no-cache add python3 py3-pip sed &&\
	pip3 install jsonpyes

ENTRYPOINT "/usr/local/bin/port-crawler"
