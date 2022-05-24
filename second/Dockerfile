FROM debian as build

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y git &&\
	git clone https://git.sr.ht/~cadence/NewLeaf /opt/second

FROM python:buster
LABEL maintainer=heywoodlh

ENV UID="1000"
ENV GID="1000"
ENV WEBSITE_ORIGIN="http://second:3000"

COPY --from=build /opt/second /opt/second

RUN pip3 install -r /opt/second/requirements.txt &&\
	echo "website_origin = \"$WEBSITE_ORIGIN\"" > /opt/second/configuration.py

RUN addgroup --gid $GID second &&\
        adduser --uid $UID --gecos "" --disabled-password --home /opt/second --shell /sbin/nologin --ingroup second second &&\
        chown -R second:second /opt/second

COPY run.sh /opt/run.sh
RUN chmod +x /opt/run.sh

EXPOSE 3000

USER second
ENTRYPOINT /opt/run.sh
