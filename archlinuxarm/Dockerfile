FROM --platform=$BUILDPLATFORM scratch AS build
ADD ArchLinuxARM-%carch%-latest.tar.gz /

COPY qemu-%qemu_arch%-static /usr/bin/qemu-%qemu_arch%-static
COPY locale.nopurge /etc/locale.nopurge

RUN set -xe \
    && pacman-key --init \
    && pacman-key --populate archlinuxarm \
    && pacman -Syu --noconfirm --needed file gawk grep gzip licenses pacman procps-ng sed tar localepurge \
    && localepurge \
    && rm -rf /etc/locale.nopurge* \
    && cd /usr/share/i18n/locales && ls | grep -vE 'en|iso|i18n|translit' | xargs -I {} rm -rf {} \
    && pacman -Rdd systemd localepurge --noconfirm \
    && rm -rf /usr/share/man \
    && pacman -D --noconfirm --asdeps $(pacman -Qqn) \
    && pacman -D --noconfirm --asexplicit file gawk grep gzip licenses pacman procps-ng sed tar \
    && while PKGS=$(pacman -Qdtq); do \
        pacman -Rsnu --noconfirm $PKGS; \
    done \
    && pacman-db-upgrade \
    && update-ca-trust \
    && pacman -Scc --noconfirm \
    && rm /var/lib/pacman/sync/*


FROM --platform=$BUILDPLATFORM scratch
LABEL maintainer=heywoodlh

COPY --from=build / /

ENV LANG=en_US.UTF-8

RUN pacman-key --init
RUN pacman-key --populate archlinuxarm

CMD ["/bin/bash"]
