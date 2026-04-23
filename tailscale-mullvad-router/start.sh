#!/bin/ash

export error="false"
# Check for required environment variables
[[ -z ${WIREGUARD_ADDRESS} ]] && echo "Wireguard address not set." && export error="true"
[[ -z ${WIREGUARD_PRIVKEY} ]] && echo "Wireguard key not set." && export error="true"
[[ -z ${WIREGUARD_ENDPOINT} ]] && echo "Wireguard endpoint not set." && export error="true"
[[ -z ${WIREGUARD_ENDPOINT_PUBKEY} ]] && echo "Wireguard endpoint public key not set." && export error="true"
[[ -z ${TS_AUTHKEY} ]] && echo "Tailscale auth key not set. Exiting." && export error="true"

# If error encountered, exit
[[ "${error}" == "true" ]] && echo "Error encountered. Exiting." && exit 3

# Configure Mullvad Wireguard
mkdir -p /etc/wireguard
cat >/etc/wireguard/mullvad.conf <<EOL
[Interface]
PrivateKey = ${WIREGUARD_PRIVKEY}
Address = ${WIREGUARD_ADDRESS}

[Peer]
PublicKey = ${WIREGUARD_ENDPOINT_PUBKEY}
AllowedIPs = 10.64.0.1
Endpoint = ${WIREGUARD_ENDPOINT}
EOL

# Bring Mullvad tunnel online
if wg-quick up mullvad
then
  echo "Brought up Mullvad tunnel"
else
  echo "Failed to bring up Mullvad tunnel. Exiting."
  exit 3
fi

set -ex
# Bring Tailscale up
/usr/local/bin/containerboot
