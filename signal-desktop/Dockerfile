FROM ubuntu:bionic
MAINTAINER heywoodlh

USER root

RUN apt-get update && apt-get install -y curl sudo gnupg apt-transport-https apt-utils
RUN useradd -ms /bin/bash signal
RUN passwd -d signal
RUN mkdir -p /etc/sudoers.d/ && printf 'signal ALL=(ALL) ALL\n' | tee -a /etc/sudoers.d/signal

USER signal
# Install Signal
RUN curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add - &&\
	echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list &&\
	sudo apt update && sudo apt install -y signal-desktop
RUN mkdir -p /home/signal/.config/Signal && chown -R signal:signal /home/signal/.config/Signal
RUN sudo chown -R root:root /opt/Signal/chrome-sandbox &&\
	sudo chmod 4755 /opt/Signal/chrome-sandbox

# Clean up
RUN sudo rm /etc/sudoers.d/signal
WORKDIR /home/signal

ENTRYPOINT ["/usr/bin/signal-desktop"]
