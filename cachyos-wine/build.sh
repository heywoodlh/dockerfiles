#!/usr/bin/env bash
git clone https://github.com/CachyOS/wine-cachyos /opt/wine-cachyos

cd /opt/wine-cachyos

autoconf

./configure --enable-archs=i386,x86_64
