FROM ubuntu:24.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

# Dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    ca-certificates \
    libnss3 \
    libx11-xcb1 \
    libxcb-dri3-0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libdrm2 \
    libgbm1 \
    libxrandr2 \
    libasound2t64 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libpango-1.0-0 \
    libxshmfence1 \
    fonts-liberation && \
    rm -rf /var/lib/apt/lists/* && \
    printf '#!/bin/sh\nprintf "xdg-open stub (no GUI): %s\\n" "$*" >&2\nexit 0\n' >/usr/local/bin/xdg-open && \
    chmod +x /usr/local/bin/xdg-open

WORKDIR /opt/grayjay

ADD https://updater.grayjay.app/Apps/Grayjay.Desktop/Grayjay.Desktop-linux-x64.zip /opt/grayjay/grayjay.zip
RUN unzip grayjay.zip && \
    rm grayjay.zip && \
    mv Grayjay.Desktop-linux-x64-*/* . && \
    rm -rf Grayjay.Desktop-linux-x64-*

ENV \
  DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 \
  ASPNETCORE_URLS=http://0.0.0.0:11338 \
  GRAYJAY_HTTP_PROXY_PORT=11339 \
  GRAYJAY_CASTING_PORT=11340 \
  XDG_DATA_HOME=/data/grayjay

RUN mkdir -p /data/grayjay
VOLUME /data

RUN rm -rf /home/ubuntu && userdel ubuntu \
    && groupadd --gid 1000 grayjay \
    && adduser --uid 1000 --gecos "" --disabled-password --home /data --shell /bin/bash --ingroup grayjay grayjay \
    && chown -R 1000:1000 /opt/grayjay /data

USER grayjay
WORKDIR /data

# Test target
FROM base AS test
RUN timeout 3s /opt/grayjay/Grayjay --server --ignore-security

# Default/final target
FROM base

# Web UI port and Sync port
EXPOSE 11338 12315

# GrayJay expects assets to live in invoked directory
# Workaround it by just copying everything to /data
ENTRYPOINT ["/bin/bash", "-c", "mkdir -p /data; cd /data; cp -rf /opt/grayjay/* .; ./Grayjay --server --ignore-security"]
