#!/usr/bin/env bash
set -euo pipefail

# MINI-MOBILE-7 bootstrap for a clean Ubuntu 22.04 (amd64/arm64) lab host.
# Run on the server as a user with sudo. Review before execution.

if [[ "$(. /etc/os-release && echo "$VERSION_ID")" != "22.04" ]]; then
  echo "This bootstrap targets Ubuntu 22.04 only." >&2
  exit 1
fi

sudo apt update
sudo apt install -y ca-certificates curl gnupg software-properties-common git iproute2 iptables

# MongoDB 8.0 repository, following the current Open5GS Ubuntu guidance.
curl -fsSL https://pgp.mongodb.com/server-8.0.asc \
  | sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/8.0 multiverse" \
  | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list >/dev/null

sudo apt update
sudo apt install -y mongodb-org
sudo systemctl enable --now mongod

sudo add-apt-repository -y ppa:open5gs/latest
sudo apt update
sudo apt install -y open5gs

# Create the lab TUN interface used for UE traffic.
if ! ip link show ogstun >/dev/null 2>&1; then
  sudo ip tuntap add name ogstun mode tun
fi
sudo ip addr replace 10.45.0.1/16 dev ogstun
sudo ip link set ogstun up

# Enable IPv4 forwarding for later controlled UE->WAN NAT configuration.
echo 'net.ipv4.ip_forward=1' | sudo tee /etc/sysctl.d/99-mini-mobile-7.conf >/dev/null
sudo sysctl --system >/dev/null

printf '\nBootstrap complete. Next: configure Open5GS, provision one synthetic subscriber, and validate UERANSIM before any physical RF.\n'
