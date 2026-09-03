# Version Baseline

Last verified: 2026-09-03

## Core

- Open5GS: **v2.8.0** — current upstream release at the time of this baseline.
- MongoDB: **8.0** package line, matching the current Open5GS Ubuntu guidance used by the bootstrap.

## RAN / simulation

- UERANSIM: **v3.3.0** — use the tagged release rather than an unpinned development checkout.

## Deployment policy

1. Pin component versions for each deployment.
2. Verify upstream release notes before upgrading.
3. Do not replace a pinned version with a floating `latest` reference without a deliberate compatibility test.
4. Record any version change in this file and in the deployment commit.

## Current external references

- Open5GS v2.8.0 release: https://github.com/open5gs/open5gs/releases/tag/v2.8.0
- Open5GS documentation: https://open5gs.org/open5gs/docs/
- UERANSIM releases: https://github.com/aligungr/UERANSIM/releases
