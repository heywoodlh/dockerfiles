FROM python:3.10
LABEL MAINTAINER=heywoodlh

RUN pip3 install --upgrade youtube-dl

RUN useradd -m -s /bin/bash youtube-dl

USER youtube-dl

ENTRYPOINT ["/usr/local/bin/youtube-dl"]
