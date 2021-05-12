FROM heywoodlh/telnet
LABEL maintainer="heywoodlh"

ADD https://raw.githubusercontent.com/heywoodlh/port-crawler/master/port-crawler.sh /usr/local/bin/port-crawler

RUN chmod +x /usr/local/bin/port-crawler 

RUN apk --no-cache add bash grep sed python3 py3-pip &&\
	pip3 install jsonpyes

CMD "/usr/local/bin/port-crawler"
