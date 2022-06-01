#!/bin/sh

usermod -o -u "$UID" weechat
groupmod -o -g "$GID" weechat

chown -R weechat:weechat /weechat

exec su-exec weechat /usr/bin/weechat "$@"
