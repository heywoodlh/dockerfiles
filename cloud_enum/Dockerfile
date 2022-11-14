FROM python:3.10-alpine
LABEL MAINTAINER=heywoodlh

RUN apk --no-cache add git 

RUN git clone --depth=1 https://github.com/initstring/cloud_enum /opt/cloud_enum

WORKDIR /opt/cloud_enum
RUN pip3 install -r requirements.txt

ENTRYPOINT ["/opt/cloud_enum/cloud_enum.py"]
