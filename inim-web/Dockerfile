FROM heywoodlh/inim

RUN echo '/app/bin/inim' >> /etc/shells

RUN useradd -m -s /app/bin/inim inim

RUN apt-get update && apt-get install -y shellinabox \
	&& rm -rf /var/lib/apt/lists/*

USER inim

EXPOSE 4200

ENTRYPOINT ["/usr/bin/shellinaboxd", "--css='/etc/shellinabox/options-available/00_White On Black.css'", "--disable-ssl"]
