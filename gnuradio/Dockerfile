FROM ubuntu:bionic
MAINTAINER heywoodlh

# Install gnuradio
ENV LANG="en_US.UTF-8"
RUN apt-get update && apt-get install -y gnuradio 

# Install sudo
RUN apt-get install -y sudo

RUN useradd -ms /bin/bash gnuradio
RUN passwd -d gnuradio
RUN passwd -d root
RUN mkdir -p /etc/sudoers.d/ && printf 'gnuradio ALL=(ALL) ALL\n' | tee -a /etc/sudoers.d/gnuradio

USER gnuradio
# Install gr-gsm module
RUN sudo apt-get install -y git \
	gnuradio-dev \
	cmake \
	autoconf \
	libtool \
	pkg-config \
	build-essential \
	python-docutils \
	libcppunit-dev \
	swig \
	doxygen \
	liblog4cpp5-dev \
	python-scipy \
	python-gtk2 \
	gnuradio-dev \
	gr-osmosdr \
	libosmocore-dev


RUN mkdir -p /home/gnuradio/.gnuradio /home/gnuradio/.grc_gnuradio
RUN git clone https://git.osmocom.org/gr-gsm /tmp/gr-gsm &&\
	cd /tmp/gr-gsm &&\
	mkdir build && cd build &&\
	cmake .. &&\
	make && sudo make install && sudo ldconfig 

ADD https://raw.githubusercontent.com/keenerd/rtl-sdr/master/rtl-sdr.rules /etc/udev/rules.d/rtlsdr.rules

RUN sudo rm /etc/sudoers.d/gnuradio

WORKDIR /home/gnuradio

ENTRYPOINT ["gnuradio-companion"]
