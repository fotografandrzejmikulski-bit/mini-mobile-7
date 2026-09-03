# Android-only administration

The repository and deployment can be managed from an Android phone, but the phone itself is not the Linux host and is not a cellular base station.

## Recommended workflow

1. Use GitHub in the Android browser/app for repository changes and review.
2. Provision a Linux VPS/VM with Ubuntu 22.04.
3. Connect to that server from Android with an SSH client.
4. Run `bash scripts/bootstrap-ubuntu22.sh` on the server.
5. Run `bash scripts/validate-host.sh`.
6. Continue the software-only Open5GS/UERANSIM lab.
7. Keep physical RAN work disabled until the legal/RF gate is satisfied.

## Do not do from the phone

- Do not treat Android hotspot/radio hardware as the private LTE/5G RAN.
- Do not store USIM authentication secrets in screenshots, chat messages or Git.
- Do not expose the server's MongoDB or management UI publicly just to make phone access easier.
