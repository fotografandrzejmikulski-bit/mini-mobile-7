#!/usr/bin/env bash
set -euo pipefail

# MINI-MOBILE-7 controlled UE data-plane setup.
# Applies only to the documented lab UE network. Review the host firewall before use.

UE_CIDR="${UE_CIDR:-10.20.0.0/24}"
UE_TUN_ADDR="${UE_TUN_ADDR:-10.20.0.1/24}"
TUN_DEV="${TUN_DEV:-ogstun}"
WAN_IF="${WAN_IF:-}"

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Run as root (or with sudo)." >&2
  exit 1
fi

if [[ -z "$WAN_IF" ]]; then
  WAN_IF="$(ip route show default | awk 'NR==1 {print $5}')"
fi

if [[ -z "$WAN_IF" ]]; then
  echo "Cannot determine WAN interface; set WAN_IF explicitly." >&2
  exit 1
fi

if ! ip link show "$TUN_DEV" >/dev/null 2>&1; then
  ip tuntap add name "$TUN_DEV" mode tun
fi

ip addr replace "$UE_TUN_ADDR" dev "$TUN_DEV"
ip link set "$TUN_DEV" up

sysctl -w net.ipv4.ip_forward=1 >/dev/null

# Permit forwarding only between the controlled UE TUN and the selected WAN path.
iptables -C FORWARD -i "$TUN_DEV" -o "$WAN_IF" -s "$UE_CIDR" -j ACCEPT 2>/dev/null || \
  iptables -A FORWARD -i "$TUN_DEV" -o "$WAN_IF" -s "$UE_CIDR" -j ACCEPT
iptables -C FORWARD -i "$WAN_IF" -o "$TUN_DEV" -d "$UE_CIDR" -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT 2>/dev/null || \
  iptables -A FORWARD -i "$WAN_IF" -o "$TUN_DEV" -d "$UE_CIDR" -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -t nat -C POSTROUTING -s "$UE_CIDR" ! -o "$TUN_DEV" -j MASQUERADE 2>/dev/null || \
  iptables -t nat -A POSTROUTING -s "$UE_CIDR" ! -o "$TUN_DEV" -j MASQUERADE

printf 'UE network configured: %s via %s, WAN=%s\n' "$UE_CIDR" "$TUN_DEV" "$WAN_IF"
