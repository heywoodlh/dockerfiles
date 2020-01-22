FROM archlinux

MAINTAINER heywoodlh

ENV cli_version="0.6.5"

RUN pacman -Sy --noconfirm jre-openjdk python python-pip git python-gobject curl &&\
	pip install git+https://github.com/jwoglom/npyscreen pydbus vext vext.gi pyqrcode

#RUN curl -L "https://github.com/AsamK/signal-cli/releases/download/v$cli_version/signal-cli-$cli_version.tar.gz" -o /tmp/signal-cli.tar.gz &&\
#	tar xf /tmp/signal-cli.tar.gz -C /opt/ &&\
#	rm /tmp/signal-cli.tar.gz &&\
#	ln -sf /opt/signal-cli-"$cli_version"/bin/signal-cli /usr/bin/

RUN useradd -ms /bin/bash signal-curses
RUN passwd -d signal-curses

RUN git clone https://github.com/jwoglom/signal-curses /opt/signal-curses &&\
	git clone https://aur.archlinux.org/libmatthew-unix-java.git /opt/libmatthew-unix-java &&\
	git clone https://aur.archlinux.org/signal-cli.git /opt/signal-cli &&\
	chown -R signal-curses:signal-curses /opt/signal-curses /opt/libmatthew-unix-java /opt/signal-cli


RUN pacman -Su --noconfirm archlinux-keyring sudo fakeroot binutils make
RUN mkdir -p /etc/sudoers.d/ && printf 'signal-curses ALL=(ALL) NOPASSWD:ALL\n' | tee -a /etc/sudoers.d/signal-curses

USER signal-curses
RUN mkdir -p /home/signal-curses/.local/share/signal-cli/data
ENV PATH="$PATH:/usr/lib/jvm/default/bin"
ENV JAVA_HOME="/usr/lib/jvm/default/"


WORKDIR /opt/libmatthew-unix-java
RUN makepkg -s -i -c --noconfirm

WORKDIR /opt/signal-cli
RUN gpg --recv-keys FA10826A74907F9EC6BBB7FC2BA2CD21B5B09570 &&\
	makepkg -s -i -c --noconfirm

RUN sudo pacman -R --noconfirm git fakeroot make &&\
	 sudo rm /etc/sudoers.d/signal-curses


WORKDIR /opt/signal-curses
ENTRYPOINT ["/usr/bin/python3", "/opt/signal-curses/main.py"]
