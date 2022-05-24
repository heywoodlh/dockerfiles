FROM archlinux:latest

RUN pacman -Sy --noconfirm nodejs npm git
RUN git clone https://github.com/Michsior14/tidal-desktop /opt/tidal-desktop

WORKDIR /opt/tidal-desktop
RUN npm install &&\
	npm run build

ENTRYPOINT ["/opt/tidal-desktop/build/tidal-linux-x64/tidal"]
