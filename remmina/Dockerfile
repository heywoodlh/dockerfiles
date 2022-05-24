FROM archlinux
MAINTAINER heywoodlh

# Install remmina
RUN pacman -Sy --noconfirm remmina

RUN useradd -ms /bin/bash remmina
RUN passwd -l remmina

USER remmina
RUN mkdir -p /home/remmina/.remmina/
WORKDIR /home/remmina

ENTRYPOINT ["remmina"]
