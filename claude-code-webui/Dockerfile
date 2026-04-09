FROM docker.io/heywoodlh/nix:latest AS base

USER root
# Rename /entrypoint.sh from base image to /nix.sh, install dependencies
RUN mv /entrypoint.sh /nix.sh \
    && apt update && apt install -y ripgrep npm podman nginx apache2-utils supervisor \
    && npm install -g claude-code-webui \
    && rm -rf /var/lib/apt/lists/* \
    && echo nix:10000:5000 > /etc/subuid \
    && echo nix:10000:5000 > /etc/subgid \
    && mkdir -p /usr/local/bin \
    && ln -s /usr/bin/podman /usr/local/bin/docker \
    # Allow nix user to run nginx (needs write access to log/run dirs)
    && mkdir -p /opt/nginx /var/log/nginx /var/lib/nginx/body /run/nginx /opt/claude \
    && chown -R nix:nix /opt/nginx /var/log/nginx /var/lib/nginx /run/nginx /opt/claude

USER nix

# Run Claude Code install as unprivileged user
ENV PATH="/home/nix/.local/bin:$PATH"
RUN curl -fsSL https://claude.ai/install.sh | bash \
    && cp -r /home/nix/.claude.json /home/nix/.local/* /opt/claude/
# Address to bind to
ENV HOST="0.0.0.0"

COPY entrypoint.sh /entrypoint.sh
COPY nginx.conf /opt/nginx/nginx.conf
COPY supervisord.conf /opt/supervisord.conf
EXPOSE 8080
VOLUME /home/nix
VOLUME /nix
ENTRYPOINT [ "/entrypoint.sh" ]

# Unused stage just to test
FROM base AS test
RUN /entrypoint.sh --version

# Default target
FROM base
