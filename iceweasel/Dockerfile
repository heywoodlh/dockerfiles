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
RUN passwd -d iceweasel

RUN mkdir -p /home/iceweasel/.mozilla/firefox/
ADD https://github.com/heywoodlh/dockerfiles/blob/master/files/default.profile.tar.gz?raw=true /tmp/default.profile.tar.gz
RUN tar xzf /tmp/default.profile.tar.gz --directory /home/iceweasel/.mozilla/firefox/
ADD https://raw.githubusercontent.com/heywoodlh/dockerfiles/master/iceweasel/user.js /home/iceweasel/.mozilla/firefox/default.profile/user.js
ADD https://raw.githubusercontent.com/heywoodlh/dockerfiles/master/files/profiles.ini /home/iceweasel/.mozilla/firefox/profiles.ini
RUN chown -R iceweasel:iceweasel /home/iceweasel/.mozilla/

USER iceweasel
RUN chown -R iceweasel:iceweasel /home/iceweasel/.mozilla/
WORKDIR /home/iceweasel

COPY entrypoint.sh /usr/bin/startfirefox

CMD ["/usr/bin/startfirefox"]
