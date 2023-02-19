FROM python:3.10
LABEL MAINTAINER=heywoodlh

RUN git clone https://github.com/ytdl-org/youtube-dl /opt/youtube-dl \
    && cd /opt/youtube-dl \
    && python3 setup.py install

RUN useradd -m -s /bin/bash youtube-dl

USER youtube-dl

ENTRYPOINT ["youtube-dl"]
