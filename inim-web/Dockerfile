FROM heywoodlh/nim

RUN useradd -m -s /usr/local/bin/inim inim \
	&& echo 'inim:inim' | chpasswd \
	&& mkdir -p /app \
	&& chown -R inim:inim /app

RUN echo '/usr/local/bin/inim' >> /etc/shells

RUN apt-get update && apt-get install -y shellinabox \
	&& rm -rf /var/lib/apt/lists/*

RUN ln -s /app/bin/inim /usr/local/bin/inim

COPY run.sh /run.sh
RUN chmod +x /run.sh

USER inim
EXPOSE 4200

RUN nimble install inim -y --nimbleDir:/app

ENTRYPOINT ["/run.sh"]
