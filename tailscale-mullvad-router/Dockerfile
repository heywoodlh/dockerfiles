FROM docker.io/tailscale/tailscale:latest

# Install Wireguard
RUN apk --no-cache add -U wireguard-tools

# Environment vars
ENV TS_AUTH_ONCE="true"
ENV TS_STATE_DIR="/var/lib/tailscale"
ENV TS_ROUTES="10.64.0.1/32"
ENV TS_HOSTNAME="mullvad-socks-router"

# Tailscale volumes
VOLUME /var/lib/tailscale
VOLUME /dev/net/tun

COPY start.sh /start.sh
CMD ["/start.sh"]
