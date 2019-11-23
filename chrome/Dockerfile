FROM phillipkhne/trizen-docker


RUN trizen -Sy --noconfirm google-chrome

USER root
RUN userdel builduser

RUN useradd -ms /bin/bash chrome
RUN passwd -d chrome

USER chrome
ENTRYPOINT "/usr/sbin/google-chrome-stable"
