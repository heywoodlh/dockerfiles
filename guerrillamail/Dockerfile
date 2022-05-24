FROM python:3-alpine
LABEL maintainer=heywoodlh

RUN pip install python-guerrillamail

VOLUME /root/.guerrillamail

ENTRYPOINT ["guerrillamail"]
