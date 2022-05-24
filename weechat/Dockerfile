FROM alpine as build

RUN apk --no-cache add git &&\
    git clone https://github.com/poljar/weechat-matrix /opt/weechat-matrix

FROM alpine

ENV TERM=screen-256color
ENV LANG=C.UTF-8
ENV UID=1000
ENV GID=1000

ADD run.sh /

RUN apk --no-cache add \
    gettext \
    gnutls \
    ncurses \
    libgcrypt \
    python3 \
    py3-pip \
    su-exec \
    perl \
    curl \
    shadow \
    ca-certificates \
    weechat \
    weechat-ruby \
    weechat-python \
    weechat-lua \
    weechat-spell \
    olm-dev \
    make \
    gcc \
    python3-dev \
    musl-dev \
    libffi-dev \
    py3-wheel \
    py3-cryptography \
    && mkdir /weechat \
    && addgroup -g $GID -S weechat \
    && adduser -u $UID -D -S -h /weechat -s /sbin/nologin -G weechat weechat

COPY --from=build /opt/weechat-matrix /opt/weechat-matrix
RUN pip3 install -r /opt/weechat-matrix/requirements.txt

USER weechat
WORKDIR /opt/weechat-matrix
RUN make install

USER root
VOLUME /weechat

WORKDIR /weechat

EXPOSE 9001

ENTRYPOINT ["/run.sh"]
CMD ["--dir /weechat"]
