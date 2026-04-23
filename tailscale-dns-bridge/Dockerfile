FROM docker.io/tailscale/tailscale:latest

# Environment vars
ENV TS_AUTH_ONCE="true"
ENV TS_STATE_DIR="/var/lib/tailscale"
ENV TS_HOSTNAME="tailscale-dns-bridge"

RUN apk add --no-cache coredns supervisor bind-tools
COPY Corefile /etc/coredns/Corefile
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Tailscale volumes
VOLUME /var/lib/tailscale
VOLUME /dev/net/tun

VOLUME /etc/coredns

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
