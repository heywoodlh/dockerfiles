FROM debian:stable
LABEL maintainer=heywoodlh

ADD https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb /tmp/packages-microsoft-prod.deb

RUN apt-get update \
	&& apt-get install -y ca-certificates

RUN dpkg -i /tmp/packages-microsoft-prod.deb \
	&& rm /tmp/packages-microsoft-prod.deb

RUN apt-get update \
	&& apt-get install -y powershell \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/usr/bin/pwsh" ]
