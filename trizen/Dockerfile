FROM heywoodlh/archlinux AS base

RUN pacman -Sy --noconfirm sudo shadow binutils fakeroot git pacutils perl-libwww perl-term-ui perl-json perl-data-dump perl-lwp-protocol-https perl-term-readline-gnu

RUN mkdir -p /etc/sudoers.d/ \
	&& echo 'trizen ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/trizen

RUN useradd -ms /bin/bash trizen \
	&& passwd -l trizen

RUN git clone https://aur.archlinux.org/trizen.git /opt/trizen
WORKDIR /opt/trizen
USER trizen
RUN sudo chown -R trizen /opt/trizen \
	&& makepkg -si --noconfirm

WORKDIR /home/trizen

RUN sudo pacman -Scc --noconfirm \
	&& sudo rm -rf /opt/trizen

## This stage isn't used unless you run testing commands
## Testing commands:
## docker build -t heywoodlh/trizen-test --target=test .
## docker run -it --rm heywoodlh/trizen-test
## These packages are just random ones I selected
FROM base AS test 
CMD ["trizen", "-Sy", "--noconfirm", "curl", "vim-coc-bin"]

## Final stage
FROM base
LABEL MAINTAINER=heywoodlh
