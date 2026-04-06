FROM docker.io/heywoodlh/nix:latest AS base

USER root
# Rename /entrypoint.sh from base image to /nix.sh, install dependencies
RUN mv /entrypoint.sh /nix.sh \
    && apt update && apt install -y ripgrep npm \
    && npm install -g claude-code-webui \
    && rm -rf /var/lib/apt/lists/*

USER nix

# Run Claude Code install as unprivileged user
ENV PATH="/home/nix/.local/bin:$PATH"
RUN curl -fsSL https://claude.ai/install.sh | bash
# Address to bind to
ENV HOST="0.0.0.0"

COPY entrypoint.sh /entrypoint.sh
EXPOSE 8080
VOLUME /home/nix
VOLUME /nix
ENTRYPOINT [ "/entrypoint.sh" ]

# Unused stage just to test
FROM base AS test
RUN /entrypoint.sh --version

# Default target
FROM base
