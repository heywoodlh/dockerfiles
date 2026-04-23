ARG alpine_version=3.22
ARG ruby_version=3.3.8-alpine${alpine_version} # see https://github.com/rapid7/metasploit-framework/blob/master/Dockerfile
ARG ubuntu_version=24.04

FROM docker.io/ruby:${ruby_version} AS build

RUN apk add --no-cache \
      autoconf \
      bash \
      bison \
      build-base \
      curl \
      ruby-dev \
      openssl-dev \
      readline-dev \
      sqlite-dev \
      postgresql-dev \
      libffi-dev \
      libpcap-dev \
      libxml2-dev \
      libxslt-dev \
      yaml-dev \
      zlib-dev \
      ncurses-dev \
      git \
      jq

# Checkout latest tag
RUN git clone --depth=1 https://github.com/rapid7/metasploit-framework /opt/metasploit-framework

WORKDIR /opt/metasploit-framework
RUN git remote update \
    && export latest_tag="$(git describe --tags $(git rev-list --tags --max-count=1))" \
    && git checkout $latest_tag

# Build metasploit
RUN echo "gem: --no-document" > /etc/gemrc \
    && gem update --system \
    && bundle config $BUNDLER_CONFIG_ARGS \
    && bundle install --jobs=8 \
    && if [ "${BUNDLER_FORCE_CLEAN}" == "true" ]; then \
         bundle clean --force; \
       fi \
    # temp fix for https://github.com/bundler/bundler/issues/6680
    && rm -rf /usr/local/bundle/cache

FROM docker.io/ruby:${ruby_version} AS base

COPY --from=build /opt/metasploit-framework/ /opt/metasploit-framework/
COPY --from=build /usr/local/bundle/ /usr/local/bundle/
ENV PATH=/opt/metasploit-framework/bin:/nix/var/nix/profiles/default/bin:/home/msf/.nix-profile/bin:$PATH

# Metasploit additional deps
RUN apk add --no-cache \
    bash \
    curl \
    nmap \
    nmap-scripts \
    nmap-nselibs \
    postgresql-libs \
    python3 \
    py3-pip \
    py3-impacket \
    py3-requests \
    ncurses \
    ca-certificates \
    shadow \
    coreutils \
    findutils \
    libcap \
    su-exec \
    alpine-sdk \
    openssl-dev nasm \
    sudo

RUN\
    if arch | grep -q aarch64;\
	then apk add --no-cache gcc musl-dev python3-dev libffi-dev gcompat;\
    else apk add --no-cache mingw-w64-gcc;\
    fi

COPY --from=docker.io/heywoodlh/nix:latest /opt/nix /opt/nix
COPY --from=docker.io/heywoodlh/nix:latest /etc/nix /etc/nix

# Symlinks for Metasploit executables
RUN mkdir -p /opt/metasploit-framework/bin \
    && find /opt/metasploit-framework -maxdepth 1 -type f -executable -print | grep -v Rakefile | xargs -I {} ln -s {} /opt/metasploit-framework/bin

# Create non-root msf user
RUN groupadd --gid 1000 msf \
    && addgroup nixbld \
    && adduser --uid 1000 --gecos "" --disabled-password --home /home/msf --shell /bin/bash --ingroup msf msf \
    && mkdir -p /etc/sudoers.d \
    && echo "msf ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/msf

# Set up initial nix store for msf user
RUN mkdir -p /nix \
    && cp -r /opt/nix/* /nix \
    && chown -R 1000:1000 /nix /opt/nix /opt/metasploit-framework

USER msf
WORKDIR /home/msf

# Disable admin privileges by default
ENV SUDO=false

VOLUME /nix

COPY ./entrypoint.sh /entrypoint.sh

FROM base AS test
COPY ./test.sh /test.sh
CMD ["/test.sh"]

FROM base
LABEL maintainer=heywoodlh
VOLUME /home/msf/.msf4

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "/bin/bash" ]
