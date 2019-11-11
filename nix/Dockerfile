FROM archlinux:latest
MAINTAINER heywoodlh

RUN pacman -Sy --noconfirm tar sudo grep
RUN useradd -ms /bin/bash nix
RUN passwd -d nix
RUN mkdir -p /etc/sudoers.d/ && printf 'nix ALL=(ALL) ALL\n' | tee -a /etc/sudoers.d/nix

USER nix
# Install Nix
ENV NIX_PATH="/home/nix/.nix-defexpr/channels"
ENV NIXPKGS_CONFIG="/home/nix/.nix/config.nix"
ENV NIXOS_CONFIG="/home/nix/.nix/os/config.nix"
ENV NIX_LINK="/home/nix/.nix-profile"
ENV NIX_USER_PROFILE_DIR="/nix/var/nix/profiles/per-user/nix"
RUN bash -c 'sh <(curl https://nixos.org/nix/install) --no-daemon'
RUN /home/nix/.nix-profile/bin/nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
RUN /home/nix/.nix-profile/bin/nix-channel --update
RUN echo 'source /home/nix/.nix-profile/etc/profile.d/nix.sh' >> /home/nix/.bash_profile
RUN sudo rm /etc/sudoers.d/nix

WORKDIR /home/nix

CMD ["/bin/bash"]
