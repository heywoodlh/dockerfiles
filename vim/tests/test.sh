#!/usr/bin/env bash

set -ex
vim -n -c "set nomore" -S "/commands.vim" "filespec"
grep testline /tmp/test.txt
