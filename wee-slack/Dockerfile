FROM alpine
LABEL MAINTAINER=heywoodlh

ENV TERM=screen-256color
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
    pass \
    shadow \
    ca-certificates \
    su-exec \
    curl \
    weechat \
    weechat-ruby \
    weechat-python \
    weechat-lua \
    weechat-spell \
    weechat-perl \
    weechat-matrix \
    && mkdir /weechat \
    && mkdir -p /usr/share/weechat/python \
    && addgroup -g $GID -S weechat \
    && adduser -u $UID -D -S -h /weechat -s /sbin/nologin -G weechat weechat \
    && chown -R weechat:weechat /weechat 

## Wee-slack installation
RUN mkdir -p /usr/share/weechat/python/ /weechat/.local/share/weechat/python /weechat/.local/share/weechat/python/autoload \
    && curl -L https://raw.githubusercontent.com/wee-slack/wee-slack/xoxc-tokens/wee_slack.py -o /usr/share/weechat/python/wee_slack.py 

RUN pip3 install websocket-client

USER root
VOLUME /weechat

WORKDIR /weechat

EXPOSE 9001

ENTRYPOINT ["/run.sh"]
CMD ["--dir /weechat"]
