#!/usr/bin/env bash
set -euo pipefail

fail=0

pass() { printf '[PASS] %s\n' "$1"; }
warn() { printf '[CHECK] %s\n' "$1"; }

if [[ "$(id -u)" -eq 0 ]]; then
  pass 'running as root'
else
  warn 'run with sudo for complete checks'
fi

if command -v lsb_release >/dev/null 2>&1; then
  distro="$(lsb_release -ds)"
  printf 'OS: %s\n' "$distro"
  if lsb_release -is 2>/dev/null | grep -qi '^Ubuntu$' && lsb_release -rs 2>/dev/null | grep -q '^22\.04$'; then
    pass 'Ubuntu 22.04 detected'
  else
    warn 'Ubuntu 22.04 was not detected'
    fail=1
  fi
else
  warn 'lsb_release is missing'
  fail=1
fi

for cmd in ip ss systemctl iptables sysctl; do
  if command -v "$cmd" >/dev/null 2>&1; then
    pass "command available: $cmd"
  else
    warn "missing command: $cmd"
    fail=1
  fi
done

if command -v mongod >/dev/null 2>&1; then
  pass 'MongoDB binary available'
else
  warn 'MongoDB binary missing'
  fail=1
fi

for svc in open5gs-amfd open5gs-smfd open5gs-upfd; do
  if systemctl list-unit-files "${svc}.service" --no-legend 2>/dev/null | grep -q "${svc}.service"; then
    pass "Open5GS service unit present: $svc"
  else
    warn "Open5GS service unit missing: $svc"
    fail=1
  fi
done

if ip link show ogstun >/dev/null 2>&1; then
  pass 'ogstun interface exists'
  if ip addr show ogstun | grep -q '10\.20\.0\.1/24'; then
    pass 'ogstun has expected 10.20.0.1/24 address'
  else
    warn 'ogstun does not have expected 10.20.0.1/24 address'
    fail=1
  fi
else
  warn 'ogstun interface missing'
  fail=1
fi

if [[ "$(sysctl -n net.ipv4.ip_forward 2>/dev/null || echo 0)" == '1' ]]; then
  pass 'IPv4 forwarding enabled'
else
  warn 'IPv4 forwarding disabled'
  fail=1
fi

printf '\nListening sockets relevant to the lab:\n'
ss -lntup 2>/dev/null | grep -E '(:38412|:2152|:27017|:9999|:22)[[:space:]]' || true

printf '\nInterface summary:\n'
ip -br addr || true

if [[ "$fail" -eq 0 ]]; then
  printf '\nPreflight result: PASS\n'
else
  printf '\nPreflight result: CHECK/FAIL\n'
fi

exit "$fail"
