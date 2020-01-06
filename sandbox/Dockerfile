FROM archlinux:latest

MAINTAINER heywoodlh

RUN pacman -Syu --noconfirm &&\
	pacman -S --noconfirm python python-pip tor torsocks iptables supervisor git vim sudo bind-tools fish curl wget nmap inetutils firefox iputils
RUN useradd -ms /usr/bin/fish sandbox
RUN passwd -l root
RUN passwd -l sandbox
RUN mkdir -p /etc/sudoers.d/ && printf 'sandbox ALL=(ALL) NOPASSWD:ALL\n' | tee -a /etc/sudoers.d/sandbox

ADD https://raw.githubusercontent.com/heywoodlh/dockerfiles/master/files/sandbox/torrc.default /etc/tor/torrc.default

RUN chown -R tor /etc/tor/

USER sandbox
RUN mkdir -p /home/sandbox/.config/fish/functions/ &&\
	echo "set fish_greeting ''" >> /home/sandbox/.config/fish/config.fish
CMD ["tor", "-f", "/etc/tor/torrc.default"]
