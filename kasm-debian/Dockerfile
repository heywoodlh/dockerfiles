FROM docker.io/heywoodlh/nix:latest AS ld-builder

RUN mkdir -p /opt/glibc && nix build -o /opt/glibc nixpkgs#glibc

FROM docker.io/kasmweb/core-debian-bookworm:1.15.0-rolling
LABEL maintainer=heywoodlh

USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

COPY --from=ld-builder /opt/glibc /opt/glibc

ENV LD_LIBRARY_PATH=/opt/glibc/lib
ENV NIX_CONFIG="filter-syscalls = false"

RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --init none --no-confirm --nix-build-group-id 31000 \
  && cp -r /nix /nix-orig \
  && cp -r /etc/profile.d /etc/profile.d-orig \
  && chown -R 1000:1000 /nix /nix-orig

VOLUME /nix
VOLUME /etc/profile.d

COPY copy-nix.bash /copy-nix.bash
RUN echo 'source /etc/profile >> /home/kasm-user/.bashrc'

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
