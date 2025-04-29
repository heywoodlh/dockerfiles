ARG UBUNTU_VERSION=24.04
FROM docker.io/ubuntu:${UBUNTU_VERSION} AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    git make automake gcc \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/sleinen/samplicator /samplicator

WORKDIR /samplicator

RUN autoreconf --install \
    && ./configure --prefix /usr/local \
    && make && make install

FROM docker.io/ubuntu:${UBUNTU_VERSION} AS test

COPY --from=builder /usr/local /usr/local

RUN printf "127.0.0.1/32:2000 127.0.0.1/32" > /etc/samplicator.conf \
    && timeout 3s /usr/local/bin/samplicate -c /etc/samplicator.conf -S -p 2000 -d 0 -m /samplicate.pid \
    || test -e /samplicate.pid \
    && printf "/samplicate.pid was created and samplicate command did not exit prematurely! :)"

FROM docker.io/ubuntu:${UBUNTU_VERSION}

COPY --from=builder /usr/local /usr/local

ENTRYPOINT [ "/usr/local/bin/samplicate" ]

CMD [ "-p", "2000", "-c", "/etc/samplicator.conf", "-S", "-d", "0" ]
