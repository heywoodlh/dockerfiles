FROM alpine:latest

ENV uid="1000"
ENV gid="1000"

RUN apk --no-cache add bash coreutils vim git openssh gnupg pass python3 py3-pip py3-wheel go sudo curl pinentry mosh-client nodejs npm &&\
	ln -s /usr/bin/pinentry-curses /usr/local/bin/pinentry-curses &&\
	pip3 install pyinstaller

RUN addgroup -g $gid -S dev &&\
	mkdir -p /home/dev &&\
	adduser --uid $uid --gecos "" --disabled-password --home /home/dev --shell /bin/bash --ingroup dev dev &&\
	chown -R dev:dev /home/dev
	
RUN mkdir -p /etc/sudoers.d &&\
	echo "dev ALL=NOPASSWD: ALL" | tee -a "/etc/sudoers.d/dev"

USER dev

RUN git clone https://github.com/heywoodlh/conf /home/dev/conf
WORKDIR /home/dev/conf

RUN ./setup.sh
RUN echo '. /home/dev/.bash_profile' >> /home/dev/.bashrc &&\
	echo 'export PS1="(dev) \W :: "' >> /home/dev/.bash_profile &&\
	rm /home/dev/.bash.d/docker

USER root
RUN rm /etc/sudoers.d/dev &&\
	apk del sudo

USER dev
WORKDIR /home/dev
ENTRYPOINT [ "/bin/bash" ]
