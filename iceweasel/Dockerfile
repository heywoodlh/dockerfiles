FROM debian:stable
MAINTAINER heywoodlh

# Install iceweasel
RUN apt-get update && apt-get install -y iceweasel libgl1-mesa-dri libgl1-mesa-glx


RUN useradd -ms /bin/bash iceweasel
RUN passwd -d iceweasel
USER iceweasel
WORKDIR /home/iceweasel
RUN mkdir -p /home/iceweasel/.mozilla/firefox && chown -R iceweasel:iceweasel /home/iceweasel/.mozilla

CMD ["firefox"]
