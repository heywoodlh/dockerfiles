FROM debian AS build

RUN apt-get update && apt-get install -y --no-install-recommends gnupg git ruby-dev

RUN git clone https://github.com/rapid7/metasploit-omnibus.git /opt/metasploit-omnibus &&\
	chmod +x /opt/metasploit-omnibus/config/templates/metasploit-framework-wrappers/msfupdate.erb &&\
	/opt/metasploit-omnibus/config/templates/metasploit-framework-wrappers/msfupdate.erb

FROM debian
COPY --from=build /opt/metasploit-framework/ /opt/metasploit-framework/
RUN ln -s /opt/metasploit-framework/bin/* /usr/bin/

RUN apt-get update && apt-get install -y pwgen \
	&& rm -rf /var/lib/apt/lists/*

RUN passwd -l root
RUN useradd -ms /bin/bash metasploit
RUN passwd -l metasploit

USER metasploit
RUN msfdb init --no-msf-data-service --use-defaults || : 

CMD ["/bin/bash"]
