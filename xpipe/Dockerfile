FROM ghcr.io/xpipe-io/xpipe-webtop:latest
LABEL maintainer=heywoodlh

ARG MOONLIGHT_VERSION="v6.1.0"
ARG RUSTDESK_VERSION="1.4.5"

# Install runtime dependencies
RUN apt update \
    && apt install -y gnome-keyring seahorse curl jq libsecret-tools \
    && apt autoclean \
    && rm -rf /var/lib/apt/lists/*

# Install Nix
RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
    sh -s -- install linux --init none --no-confirm
VOLUME /nix
VOLUME /etc/nix

COPY desktop/icon.png /desktop/icon.png
COPY desktop/gnome-keyring.desktop /etc/xdg/autostart/gnome-keyring.desktop

ENV GNOME_KEYRING_PASSWORD=""

# Install moonlight
# Reference: https://hub.docker.com/r/jordanplayz158/moonlight-qt
RUN apt update \
   && apt install -y git build-essential libegl1-mesa-dev libgl1-mesa-dev libopus-dev libqt5svg5-dev libsdl2-dev libsdl2-ttf-dev libssl-dev libavcodec-dev libva-dev libvdpau-dev libxkbcommon-dev qtwayland5 qt5-qmake qtbase5-dev qtdeclarative5-dev qtquickcontrols2-5-dev wayland-protocols qml-module-qtquick-controls2 qml-module-qtquick-layouts qml-module-qtquick-window2 qml-module-qtquick2 libswscale-dev \
   && rm -rf /var/lib/apt/lists/* \
   && git clone https://github.com/moonlight-stream/moonlight-qt /moonlight-qt \
   && cd /moonlight-qt \
   && git checkout ${MOONLIGHT_VERSION} && git submodule update --init --recursive \
   && qmake moonlight-qt.pro && bash -c "make -j$(nproc) release" \
   && mv /moonlight-qt/app /usr/local/moonlight \
   && ln -s /usr/local/moonlight/moonlight /usr/local/bin/moonlight \
   && apt remove -y git build-essential libegl1-mesa-dev libgl1-mesa-dev libopus-dev libqt5svg5-dev libsdl2-dev libsdl2-ttf-dev libssl-dev libavcodec-dev libva-dev libvdpau-dev libxkbcommon-dev qt5-qmake qtbase5-dev qtdeclarative5-dev qtquickcontrols2-5-dev libswscale-dev \
   && cd / && rm -rf /moonlight-qt

COPY desktop/moonlight.png /desktop/moonlight.png
COPY desktop/moonlight.desktop /usr/share/applications/moonlight.desktop

# Install rustdesk
RUN curl -L https://github.com/rustdesk/rustdesk/releases/download/${RUSTDESK_VERSION}/rustdesk-${RUSTDESK_VERSION}-$(arch).deb -o /tmp/rustdesk.deb \
    && apt update \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:pipewire-debian/pipewire-upstream \
    && apt update \
    && apt-get install -y -f /tmp/rustdesk.deb \
    && rm -rf /var/lib/apt/lists/*

COPY gnome-keyring.sh /gnome-keyring.sh
