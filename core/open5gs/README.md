# Open5GS Core Scaffold

This directory is the deployment anchor for the Open5GS Core.

## Target

Use Open5GS 5GC/EPC according to the selected lab architecture. The current upstream release is **v2.8.0** (Release 19). Pin the version during deployment rather than silently tracking `latest`.

The project should prefer v2.8.0 for the initial deployment because it is the current upstream release and includes security and protocol updates over v2.7.7.

## Required services for the first lab

- MongoDB
- Open5GS Core network functions required by the chosen 5GC/EPC mode
- Optional WebUI, restricted to management access

## Configuration rules

- Keep database access on a private network.
- Keep management UI behind VPN/firewall.
- Put subscriber authentication material outside Git.
- Start with one synthetic subscriber, then scale to seven.
- Keep the UE address pool aligned with the addressing plan in `docs/addressing.md`.

## Deployment reference

Use the upstream Open5GS documentation and repository release/tag as the authoritative implementation reference for v2.8.0. Verify release notes before every production-like deployment.

## Completion gate

The Core stage is accepted when the services start cleanly, logs show no persistent configuration errors, and the lab subscriber can complete registration through the chosen simulated RAN path.
