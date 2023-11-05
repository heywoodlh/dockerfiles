FROM debian:unstable as build

RUN apt-get update \
	&& apt-get install -y curl gcc make autoconf make sparse pkg-config libssl-dev

## Build elinks
RUN curl -L 'http://elinks.cz/download/elinks-current-0.13.tar.gz' -o /tmp/elinks.tar.gz \
	&& cd /opt \
	&& tar xzvf /tmp/elinks.tar.gz \
	&& mv elinks* elinks \
	&& cd /opt/elinks \
	&& ./configure --build=$(uname)-unknown-linux-gnu \
	&& make -j8

FROM debian:unstable
LABEL maintainer=heywoodlh

COPY --from=build /opt/elinks /opt/elinks

RUN apt-get update \
	&& apt-get install -y ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

RUN ln -s /opt/elinks/src/elinks /usr/bin/elinks

RUN useradd -ms /bin/bash elinks

USER elinks
WORKDIR /home/elinks
ENTRYPOINT ["/usr/bin/elinks"]
