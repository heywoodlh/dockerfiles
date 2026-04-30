FROM docker.io/nousresearch/hermes-agent:latest AS hermes_src

# Cannot use Alpine base due to hermes-agent python dependencies only supporting glibc systems
FROM docker.io/heywoodlh/nix:determinate AS base

USER root
# Rename /entrypoint.sh from base image to /nix.sh, install dependencies
RUN mv /entrypoint.sh /nix.sh \
    && apt update && apt install -y npm ttyd podman supervisor \
    && echo nix:10000:5000 > /etc/subuid \
    && echo nix:10000:5000 > /etc/subgid \
    && mkdir -p /usr/local/bin /opt/hermes \
    && ln -s /usr/bin/podman /usr/local/bin/docker \
    && npx playwright install --with-deps chromium --only-shell \
    && chown -R nix /opt/hermes /etc/supervisor \
    && rm -rf /var/lib/apt/lists/*

COPY --from=hermes_src --chown=nix:nix /opt/hermes /opt/hermes
COPY --from=hermes_src /usr/local/bin/uv /usr/local/bin/uvx /usr/local/bin/

USER nix

# Run Hermes agent install as unprivileged user
ENV PATH="/opt/hermes/.venv/bin:$PATH"

WORKDIR /opt/hermes
RUN uv pip install --no-cache-dir -e ".[all]"

# Address to bind to
ENV HOST="0.0.0.0"

# Optional basic auth
ENV HTTP_AUTH_USERNAME="admin"
ENV HTTP_AUTH_PASSWORD=""

COPY ttyd.sh /ttyd.sh
COPY entrypoint.sh /entrypoint.sh
COPY supervisord.conf /etc/supervisor/supervisord.conf
EXPOSE 8080
VOLUME /home/nix
VOLUME /nix
VOLUME /etc/supervisor/conf.d
ENTRYPOINT [ "/entrypoint.sh" ]

# Unused stage just to test
FROM base AS test
RUN /opt/hermes/.venv/bin/hermes --version

# Default target
FROM base
WORKDIR /home/nix
