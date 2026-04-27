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

# Provide `/rpc-client.sh`
COPY ./rpc-client.sh /rpc-client.sh
# Disable remote SSL by default
ENV MSF_SSL="false"

FROM base AS test
COPY ./test.sh /test.sh
CMD ["/test.sh"]

# Client msfrpc container
FROM base AS msfrpc
LABEL maintainer=heywoodlh
VOLUME /home/msf/.msf4

ENV MSF_USERNAME="msf"
ENV MSF_PASSWORD="msf"
ENV MSF_ADDRESS=127.0.0.1
ENV MSF_PORT=55553
# for some reason, `msfrpc` requires root privs
ENV SUDO="true"

USER root
RUN apk --no-cache add netcat-openbsd
USER msf

ENTRYPOINT [ "/entrypoint.sh", "/rpc-client.sh" ]

FROM base AS server
LABEL maintainer=heywoodlh

# Force users to be explicit about using DB vars, disabled by default
# Set `DB_ENABLE` to anything but "false" to enable
ENV DB_ENABLE="false"
ENV DB_ADAPTER="postgresql"
ENV DB_NAME="msf"
ENV DB_USERNAME="msf"
ENV DB_PASSWORD="msf"
ENV DB_PORT="5432"
ENV DB_HOST="db"

COPY db.sh /db.sh

VOLUME /home/msf/.msf4

# msfrpcd
FROM server AS msfrpcd

ENV MSF_USERNAME="msf"
ENV MSF_PASSWORD="msf"
ENV MSF_ADDRESS=0.0.0.0
ENV MSF_PORT=55553

COPY rpc.sh /rpc.sh

ENTRYPOINT [ "/rpc.sh" ]

# msfd target
FROM server AS msfd
LABEL maintainer=heywoodlh
VOLUME /home/msf/.msf4

ENV MSFD_PORT="55554"
# for some reason, `msfd` requires root privs
ENV SUDO="true"

COPY msfd.sh /msfd.sh

ENTRYPOINT [ "/msfd.sh" ]

# netcat client for connecting to remote msfd
FROM docker.io/alpine:${alpine_version} AS msfd-client
LABEL maintainer=heywoodlh

ENV MSFD_HOST="127.0.0.1"
ENV MSFD_PORT="55554"

RUN apk --no-cache add netcat-openbsd
COPY msfd-client.sh /msfd-client.sh

ENTRYPOINT [ "/msfd-client.sh" ]

# Default target
# Note to self: MUST BE THE LAST TARGET IN THE DOCKERFILE FOR `docker-compose.yml`
FROM base
LABEL maintainer=heywoodlh
VOLUME /home/msf/.msf4

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/bin/bash" ]

