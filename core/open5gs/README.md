# Open5GS Core Scaffold

This directory is the deployment anchor for the Open5GS Core.

## Target

Use Open5GS 5GC/EPC according to the selected lab architecture. The upstream project currently lists v2.7.7 as its latest tagged release. Pin the version during deployment rather than silently tracking `latest`.

## Required services for the first lab

- MongoDB
- Open5GS Core network functions required by the chosen 5GC/EPC mode
- Optional WebUI, restricted to management access

## Configuration rules

- Keep database access on a private network.
- Keep management UI behind VPN/firewall.
- Put subscriber authentication material outside Git.
- Start with one synthetic subscriber, then scale to seven.

## Deployment reference

Use the upstream Open5GS documentation and repository Docker examples as the authoritative implementation reference for the exact release selected at deployment time.

## Completion gate

The Core stage is accepted when the services start cleanly, logs show no persistent configuration errors, and the lab subscriber can complete registration through the chosen simulated RAN path.
