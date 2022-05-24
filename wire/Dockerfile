FROM ubuntu:latest
MAINTAINER heywoodlh


USER root


RUN apt-get update && apt-get install -y curl xz-utils sudo fontconfig
RUN useradd -ms /bin/bash wire
RUN passwd -d wire
RUN mkdir -p /etc/sudoers.d/ && printf 'wire ALL=(ALL) ALL\n' | tee -a /etc/sudoers.d/wire

USER wire
# Install Nix
ENV NIX_PATH="/home/wire/.nix-defexpr/channels"
ENV NIXPKGS_CONFIG="/home/wire/.nix/config.nix"
ENV NIXOS_CONFIG="/home/wire/.nix/os/config.nix"
ENV NIX_LINK="/home/wire/.nix-profile"
ENV NIX_USER_PROFILE_DIR="/nix/var/nix/profiles/per-user/wire"
RUN bash -c 'sh <(curl https://nixos.org/nix/install) --no-daemon'
RUN /home/wire/.nix-profile/bin/nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
RUN /home/wire/.nix-profile/bin/nix-channel --update


# Install Wire
RUN /home/wire/.nix-profile/bin/nix-env --install wire-desktop
RUN mkdir -p /home/wire/.config/Wire && chown -R wire:wire /home/wire/.config/Wire
RUN sudo rm /etc/sudoers.d/wire
WORKDIR /home/wire

CMD ["/home/wire/.nix-profile/bin/wire-desktop"]
