FROM docker.io/kasmweb/core-ubuntu-noble:1.16.1
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

RUN add-apt-repository ppa:pipewire-debian/pipewire-upstream \
    && apt update \
    && apt install -f libxcb-randr0 libxdo3 gstreamer1.0-pipewire -y \
    && LATESTURL="$(curl -f -L https://github.com/rustdesk/rustdesk/releases/latest | grep -Eo 'https://[a-zA-Z0-9#~.*,/!?=+&_%:-]*-'$(arch)'.deb')" \
    && curl -L -o /rustdesk.deb $LATESTURL \
    && dpkg -i /rustdesk.deb \
    && apt install -f -y \
    && rm -rf /rustdesk.deb /var/lib/apt/lists/*

RUN mkdir -p $HOME/.local/share/applications

COPY rustdesk.desktop /rustdesk.desktop
COPY rustdesk.png /rustdesk.png
COPY wallpaper.png /usr/share/backgrounds/bg_default.png

RUN mkdir -p $HOME/.local/share/applications $HOME/Desktop $HOME/.config/autostart \
    && ln -s /rustdesk.desktop $HOME/Desktop/rustdesk.desktop \
    && ln -s /rustdesk.desktop $HOME/.local/share/applications/rustdesk.desktop \
    && ln -s /rustdesk.desktop $HOME/.config/autostart/rustdesk.desktop

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
