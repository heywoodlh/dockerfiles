FROM debian:stable
MAINTAINER heywoodlh

# Install iceweasel
RUN apt-get update && apt-get install -y iceweasel libgl1-mesa-dri libgl1-mesa-glx


RUN useradd -ms /bin/bash iceweasel
RUN passwd -d iceweasel
USER iceweasel
WORKDIR /home/iceweasel
RUN mkdir -p /home/iceweasel/.mozilla/firefox/ && chown -R iceweasel:iceweasel /home/iceweasel/.mozilla/
RUN firefox -CreateProfile "Default /home/iceweasel/.mozilla/firefox/default.profile"
ADD https://gist.githubusercontent.com/heywoodlh/19f61ecd5e6d767d41c8a3433e01864f/raw/ab4d4650781eb0138e0a2f635ffd1d45d989cf50/user.js /home/iceweasel/.mozilla/firefox/default.profile/user.js

CMD ["firefox", "-P", "Default"]
