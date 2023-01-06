FROM heywoodlh/rdp-kali-linux

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        kali-linux-headless \
        rm -rf /var/lib/apt/lists/*
