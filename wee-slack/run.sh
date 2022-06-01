#!/usr/bin/env bash

usermod -o -u "$UID" weechat
groupmod -o -g "$GID" weechat

chown -R weechat:weechat /weechat

[[ -e /weechat/.local/share/weechat/autoload/wee_slack.py ]] || mkdir -p /weechat/.local/share/weechat/autoload && ln -s /usr/share/weechat/python/wee_slack.py /weechat/.local/share/weechat/autoload/

exec su-exec weechat /usr/bin/weechat "$@"
