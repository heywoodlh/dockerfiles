FROM ubuntu:xenial
MAINTAINER heywoodlh

# Install drobo-utils and firewire libraries
RUN apt-get update && apt-get install -y drobo-utils libdc1394-22 libdc1394-22-dev

RUN useradd -ms /bin/bash drobo
RUN passwd -d drobo
 
USER drobo
WORKDIR /home/drobo

CMD ["/bin/bash"]
