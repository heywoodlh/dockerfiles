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
    && mkdir /weechat \
    && addgroup -g $GID -S weechat \
    && adduser -u $UID -D -S -h /weechat -s /sbin/nologin -G weechat weechat

VOLUME /weechat

WORKDIR /weechat

EXPOSE 9001

ENTRYPOINT ["/run.sh"]
CMD ["--dir /weechat"]
