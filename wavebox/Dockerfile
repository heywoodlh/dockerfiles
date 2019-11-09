FROM phillipkhne/trizen-docker
MAINTAINER heywoodlh

USER root

RUN useradd -ms /bin/bash wavebox
RUN passwd -d wavebox
RUN printf 'wavebox ALL=(ALL) ALL\n' | tee -a /etc/sudoers.d/wavebox

USER wavebox
# Install Wavebox AUR package and Microsoft fonts
RUN trizen --noconfirm -Sy wavebox-bin ttf-ms-fonts libnotify gvfs
RUN sudo rm /etc/sudoers.d/wavebox
WORKDIR /home/wavebox

CMD ["wavebox"]
