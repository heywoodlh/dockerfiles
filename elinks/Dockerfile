FROM debian:stretch as build

RUN apt-get update \
	&& apt-get install -y curl libmozjs185-dev gcc make autoconf make sparse pkg-config libssl-dev

## Build elinks
RUN curl -L 'http://elinks.cz/download/elinks-0.11.7.tar.gz' -o /tmp/elinks.tar.gz \
	&& cd /opt \
	&& tar xzvf /tmp/elinks.tar.gz \
	&& mv elinks* elinks \
	&& cd /opt/elinks \
	&& ./configure --build=$(uname)-unknown-linux-gnu \
	&& make -j8

FROM debian:stretch 
LABEL maintainer=heywoodlh

COPY --from=build /opt/elinks /opt/elinks

RUN apt-get update \
	&& apt-get install -y ca-certificates libmozjs185-dev \
	&& rm -rf /var/lib/apt/lists/* 

RUN ln -s /opt/elinks/src/elinks /usr/bin/elinks 

RUN useradd -ms /bin/bash elinks

USER elinks
WORKDIR /home/elinks
ENTRYPOINT ["/usr/bin/elinks"]
