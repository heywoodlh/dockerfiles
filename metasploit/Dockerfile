FROM debian:unstable AS build
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	gnupg \
	git \
	ruby-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/rapid7/metasploit-omnibus.git /opt/metasploit-omnibus &&\
	chmod +x /opt/metasploit-omnibus/config/templates/metasploit-framework-wrappers/msfupdate.erb &&\
	/opt/metasploit-omnibus/config/templates/metasploit-framework-wrappers/msfupdate.erb

FROM debian:unstable AS base

ENV DEBIAN_FRONTEND=noninteractive

COPY --from=build /opt/metasploit-framework/ /opt/metasploit-framework/
RUN ln -s /opt/metasploit-framework/bin/* /usr/bin/

RUN apt-get update && apt-get install -y pwgen nmap iproute2 telnet netcat-openbsd net-tools iputils-ping dnsutils \
	&& rm -rf /var/lib/apt/lists/*

FROM base AS test 
CMD ["msfconsole", "--version"]

FROM base
LABEL maintainer=heywoodlh
VOLUME /root/.msf4

CMD ["/bin/bash"]
