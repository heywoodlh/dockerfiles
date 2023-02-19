FROM heywoodlh/rdp-kali-linux
LABEL maintainer="heywoodlh"

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        maltego \
        && rm -rf /var/lib/apt/lists/*

COPY maltego.desktop /usr/share/applications/maltego.desktop
COPY user-setup.sh /startup/user-setup.sh
