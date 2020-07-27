FROM debian
MAINTAINER "heywoodlh"

RUN apt-get update && apt-get install -y links ca-certificates --no-install-recommends

RUN useradd -ms /bin/bash links
RUN passwd -d links

USER links
WORKDIR /home/links
ENTRYPOINT ["/usr/bin/links"]
