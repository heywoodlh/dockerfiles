FROM ubuntu:bionic
MAINTAINER heywoodlh

# Install firefox
RUN apt-get update && apt-get install -y firefox \
	apulse \
	ca-certificates \
	ffmpeg \
	hicolor-icon-theme \
	libasound2 \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpulse0 \
	fonts-noto \
	fonts-noto-cjk \
	fonts-noto-color-emoji \
	--no-install-recommends &&\
	rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash iceweasel
RUN passwd -d iceweasel &&\
	passwd -d root
RUN usermod -aG audio iceweasel

RUN mkdir -p /home/iceweasel/.mozilla/firefox/
COPY default.profile.tar.gz /tmp/default.profile.tar.gz
RUN tar xzf /tmp/default.profile.tar.gz --directory /home/iceweasel/.mozilla/firefox/

COPY user.js /home/iceweasel/.mozilla/firefox/default.profile/user.js
COPY profiles.ini /home/iceweasel/.mozilla/firefox/profiles.ini
RUN chown -R iceweasel:iceweasel /home/iceweasel/.mozilla/


COPY entrypoint.sh /usr/bin/startfirefox

USER iceweasel
RUN chown -R iceweasel:iceweasel /home/iceweasel/.mozilla/
WORKDIR /home/iceweasel
ENTRYPOINT ["/usr/bin/startfirefox"]
