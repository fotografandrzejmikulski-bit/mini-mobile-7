# MINI-MOBILE-7 — Runtime Infrastructure Specification

## 1. Purpose

This document defines the minimum infrastructure required to execute the laboratory network. It does not authorize radio transmission and does not replace Polish frequency/communications authorization requirements.

## 2. Phase A — software-only lab

The first executable target is a 5G SA software lab:

```text
UERANSIM UE  ── RLS/UDP ── UERANSIM gNB ── SCTP/NGAP ── Open5GS AMF
                                      │
                                      └── GTP-U ── Open5GS UPF ── ogstun ── Internet
```

UERANSIM is software-only and does not provide a physical 5G NR radio interface. Therefore this phase does not connect an ordinary Android handset to the network. citeturn0search5

## 3. Recommended single-host lab

For the first runtime gate, one Linux VM is sufficient.

| Resource | Minimum | Recommended |
|---|---:|---:|
| OS | Ubuntu 22.04 LTS amd64 | Ubuntu 22.04 LTS amd64 |
| CPU | 2 vCPU | 4 vCPU |
| RAM | 4 GB | 8 GB |
| Storage | 30 GB SSD | 60 GB SSD |
| Network | 1 interface | 1 interface + private management path |
| Public inbound | none | none |

Open5GS officially documents package installation on Ubuntu/Debian and MongoDB 8.0 on Ubuntu 22.04. The current Open5GS release baseline for this project is v2.8.0. citeturn0search1turn0search4

## 4. Logical addressing

- Core: `10.10.0.0/24`
- UERANSIM/gNB lab host: `10.10.0.6`
- Core/AMF lab address: `10.10.0.5`
- UE pool: `10.20.0.0/24`
- UE tunnel gateway: `10.20.0.1`
- IMS: `10.40.0.0/24`
- Management: `10.30.0.0/24`

The addresses above are laboratory examples. They must not collide with the provider/VPS network.

## 5. Required traffic paths

For the software-only lab, permit only the traffic required between the lab components:

| Protocol | Port | Purpose | Exposure |
|---|---:|---|---|
| SCTP | 38412 | gNB → AMF NGAP | private lab network only |
| UDP | 2152 | gNB ↔ UPF GTP-U | private lab network only |
| TCP | 27017 | MongoDB | loopback/private only |
| TCP | 9999 | Open5GS WebUI, if enabled | management/VPN only |
| SSH | 22 | administration | VPN/allowlisted management source only |

No core control-plane or database port should be exposed to the public Internet.

## 6. Deployment order

1. Provision Ubuntu 22.04 VM.
2. Apply host firewall/security-group policy before exposing management services.
3. Run `scripts/bootstrap-ubuntu22.sh`.
4. Run `scripts/validate-host.sh`.
5. Run `scripts/configure-ue-network.sh`.
6. Build UERANSIM v3.3.0 with `scripts/build-ueransim.sh`.
7. Configure Open5GS PLMN/TAC/DNN consistently with the lab configuration.
8. Provision subscriber 7001 using deployment-local authentication material.
9. Start Open5GS services.
10. Start UERANSIM gNB.
11. Start UERANSIM UE.
12. Verify registration and PDU-session establishment.
13. Verify UE Internet routing through `ogstun`.
14. Only after 7001 passes, repeat the subscriber test for 7002–7007.

## 7. Version policy

The repository pins the initial validation baseline to:

- Open5GS `v2.8.0`
- MongoDB `8.0`
- UERANSIM `v3.3.0`

Do not silently substitute a floating `latest` version during acceptance testing. UERANSIM v3.3.0 is the current tagged release used by this project baseline. citeturn0search0

## 8. Security boundary

Never place the following in Git:

- Ki
- OP
- OPc
- SQN
- VPN private keys
- SSH private keys
- API keys
- passwords
- production credentials

Deployment secrets belong on the runtime host or in a dedicated secrets manager.

## 9. Physical-RAN transition

The physical phase is a separate gate. It requires compatible radio hardware, compatible USIMs, a lawful frequency basis/authorization applicable to the deployment, and an RF configuration that complies with the applicable conditions. A successful UERANSIM test is not evidence that a physical handset can attach.

## 10. Cost and authorization boundary

This repository specification does not purchase infrastructure, allocate spectrum, order USIMs, or initiate radio transmission. Any paid cloud/VPS resource must be explicitly authorized before acquisition.
