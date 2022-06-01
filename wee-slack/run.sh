#!/usr/bin/env bash

usermod -o -u "$UID" weechat > /dev/null
groupmod -o -g "$GID" weechat > /dev/null

chown -R weechat:weechat /weechat > /dev/null

[[ -e /weechat/.local/share/weechat/python/autoload/wee_slack.py ]] || mkdir -p /weechat/.local/share/weechat/python/autoload && ln -s /usr/share/weechat/python/wee_slack.py /weechat/.local/share/weechat/python/autoload/

exec su-exec weechat /usr/bin/weechat "$@"
