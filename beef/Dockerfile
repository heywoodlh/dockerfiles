FROM archlinux:latest

MAINTAINER heywoodlh

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TERM=xterm-256color
ENV Distro=Arch

RUN pacman -Sy --noconfirm git ruby ruby-bundler make gcc awk
RUN useradd -ms /bin/bash beef
RUN passwd -l root
RUN passwd -l beef

RUN git clone https://github.com/beefproject/beef /opt/beef
RUN sed -i 's/passwd: "beef"/passwd: "genius"/g' /opt/beef/config.yaml
WORKDIR /opt/beef
RUN bundle install
RUN chown -R beef:beef /opt/beef

USER beef
EXPOSE 3000

ENTRYPOINT ["/opt/beef/beef"]
