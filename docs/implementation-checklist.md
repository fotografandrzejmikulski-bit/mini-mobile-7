# MINI-MOBILE-7 Implementation Checklist

Last reviewed: 2026-09-03

## Gate 0 — repository and security

- [x] Private GitHub repository exists.
- [x] Secret-handling policy documented.
- [x] `.env` excluded from Git.
- [x] No Ki/OP/OPc/API keys/private keys stored in repository.
- [x] Component versions pinned in `docs/version.md`.

## Gate 1 — Linux host

- [ ] Ubuntu 22.04 host provisioned.
- [ ] SSH access works from the administration device.
- [ ] Host validation returns no missing prerequisites.
- [ ] MongoDB starts automatically.
- [ ] Open5GS packages installed.
- [ ] `ogstun` exists and uses the documented UE network.
- [ ] IPv4 forwarding enabled.

## Gate 2 — Open5GS core

- [ ] AMF/MME and required 5GC/EPC network functions start without persistent errors.
- [ ] Subscriber database is reachable only from the intended management/core paths.
- [ ] PLMN/TAC/S-NSSAI values match the selected lab mode.
- [ ] One synthetic subscriber is provisioned.
- [ ] Authentication succeeds in the software-only lab.

## Gate 3 — UERANSIM software lab

- [ ] UERANSIM v3.3.0 is built from the tagged release.
- [ ] gNB configuration matches the Open5GS AMF.
- [ ] UE configuration matches the provisioned synthetic subscriber.
- [ ] Registration succeeds.
- [ ] PDU session establishes.
- [ ] UE receives an address from the configured pool.
- [ ] Controlled UE-to-WAN connectivity works.

## Gate 4 — seven controlled subscribers

- [ ] Seven test identities generated outside Git.
- [ ] Seven subscriber records provisioned.
- [ ] Each UE receives a unique address/session.
- [ ] No subscriber can access management interfaces outside the intended policy.

## Gate 5 — IMS / voice

- [ ] IMS addressing and routing verified.
- [ ] Kamailio IMS configuration deployed.
- [ ] SIP registration succeeds in the lab.
- [ ] Voice path tested before introducing physical RF.

## Gate 6 — physical radio

- [ ] Compatible RAN hardware selected.
- [ ] Compatible USIMs obtained and provisioned securely.
- [ ] Current Polish radio authorization/frequency conditions verified with UKE.
- [ ] RF configuration approved for the selected deployment.
- [ ] First physical handset tested.
- [ ] Only after successful first handset: expand to seven devices.

## Gate 7 — production-like hardening

- [ ] Management access restricted through VPN/firewall.
- [ ] Backups and recovery procedure tested.
- [ ] Monitoring and alerting enabled.
- [ ] Configuration and software versions recorded.
- [ ] Public numbering/interconnect remains disabled unless a lawful operator/MVNO arrangement exists.

## Acceptance rule

A gate is not marked complete because configuration files exist. It is complete only after the corresponding runtime test has passed on the actual deployment host and, where applicable, the physical radio environment.
