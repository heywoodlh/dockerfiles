FROM debian as build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git &&\
	git clone https://github.com/trustedsec/ptf /opt/ptf


FROM debian
LABEL maintainer=heywoodlh

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y python3 python3-pip mlocate git python python-pip \
	&& rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/ptf /opt/ptf
RUN pip3 install -r /opt/ptf/requirements.txt
RUN ln -s /opt/ptf/ptf /usr/local/bin/ptf

WORKDIR /opt/ptf
