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
    curl \
    weechat \
    weechat-ruby \
    weechat-python \
    weechat-lua \
    weechat-spell \
    && mkdir /weechat \
    && addgroup -g $GID -S weechat \
    && adduser -u $UID -D -S -h /weechat -s /sbin/nologin -G weechat weechat \
    && chown -R weechat:weechat /weechat 

USER weechat

## Wee-slack installation
RUN mkdir -p /weechat/.weechat/python /weechat/.weechat/python/autoload \
    && curl -L https://raw.githubusercontent.com/wee-slack/wee-slack/xoxc-tokens/wee_slack.py -o /weechat/.weechat/python/wee_slack.py \
    && ln -s /weechat/.weechat/python/wee_slack.py /weechat/.weechat/python/autoload/wee_slack.py

USER root
VOLUME /weechat

WORKDIR /weechat

EXPOSE 9001

ENTRYPOINT ["/run.sh"]
CMD ["--dir /weechat"]
