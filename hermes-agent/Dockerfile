# Cannot use Alpine base due to hermes-agent python dependencies only supporting glibc systems
FROM docker.io/heywoodlh/nix:determinate AS base

ENV DEBIAN_FRONTEND=noninteractive

USER root
# Rename /entrypoint.sh from base image to /nix.sh, install dependencies
RUN mv /entrypoint.sh /nix.sh \
    && apt update && apt install -y npm ttyd podman supervisor \
    && echo nix:10000:5000 > /etc/subuid \
    && echo nix:10000:5000 > /etc/subgid \
    && mkdir -p /usr/local/bin /opt/hermes \
    && ln -s /usr/bin/podman /usr/local/bin/docker \
    && npx playwright install --with-deps chromium --only-shell \
    && chown -R nix /opt/ /etc/supervisor \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

USER nix

# Run Hermes agent install as unprivileged user
ENV PATH="/opt/hermes/.venv/bin:$PATH"

WORKDIR /opt/hermes
# Use Python 3.13 until issue 58699 is merged
ENV UV_CACHE_DIR=/opt/uv/cache
ENV UV_PYTHON_CACHE_DIR=/opt/uv/python-cache
ENV UV_PYTHON_INSTALL_DIR=/opt/uv/python
ENV UV_PYTHON_BIN_DIR=/opt/uv/python-bin
ENV UV_TOOL_DIR=/opt/uv/tools
ENV UV_TOOL_BIN_DIR=/opt/uv/tool-bin
RUN git clone --depth=1 https://github.com/NousResearch/hermes-agent /opt/hermes \
    && uv venv --python=3.13 /opt/hermes/.venv \
    && uv pip install --no-cache-dir -e ".[all]"

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
