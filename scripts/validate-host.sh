#!/usr/bin/env bash
set -euo pipefail

fail=0
check_cmd() {
  if command -v "$1" >/dev/null 2>&1; then
    printf 'OK   %s\n' "$1"
  else
    printf 'MISS %s\n' "$1"
    fail=1
  fi
}

printf '%s\n' '== MINI-MOBILE-7 host validation =='

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  printf 'OS   %s %s\n' "${NAME:-unknown}" "${VERSION_ID:-unknown}"
fi

check_cmd ip
check_cmd systemctl
check_cmd curl
check_cmd gpg
check_cmd iptables

if systemctl is-active --quiet mongod; then
  echo 'OK   mongod active'
else
  echo 'WARN mongod inactive'
fi

if command -v open5gs-amfd >/dev/null 2>&1 || [[ -d /etc/open5gs ]]; then
  echo 'OK   Open5GS installed/config path present'
else
  echo 'WARN Open5GS not detected'
fi

if ip link show ogstun >/dev/null 2>&1; then
  echo 'OK   ogstun present'
else
  echo 'WARN ogstun missing'
fi

if sysctl -n net.ipv4.ip_forward 2>/dev/null | grep -qx '1'; then
  echo 'OK   IPv4 forwarding enabled'
else
  echo 'WARN IPv4 forwarding disabled'
fi

printf 'RESULT %s\n' "$([[ $fail -eq 0 ]] && echo PASS || echo CHECK)"
exit "$fail"
