# MINI-MOBILE-7 — First synthetic 5G subscriber

## Objective

Prove one complete software-only path before provisioning subscribers 7002–7007:

`UERANSIM UE → UERANSIM gNB → Open5GS AMF/SMF/UPF → UE data session`

This stage does not transmit RF and does not connect an ordinary Android handset.

## Fixed lab parameters

| Parameter | Value |
|---|---|
| Open5GS | v2.8.0 |
| UERANSIM | v3.3.0 |
| PLMN | 001/01 |
| TAC | 1 |
| S-NSSAI | SST 1 |
| DNN/APN | internet |
| Core example | 10.10.0.5 |
| gNB example | 10.10.0.6 |
| UE pool | 10.20.0.0/24 |
| Subscriber | 7001 / IMSI 001010000000001 |

## Subscriber provisioning

Create subscriber 7001 in Open5GS using the supported subscriber-management path. Authentication material must be generated for the lab and stored only on the deployment host.

The subscriber database and local UERANSIM configuration must use matching authentication parameters, IMSI/SUPI, DNN/APN and slice policy.

Never commit subscriber authentication material, passwords or API keys.

## Configuration order

1. Install MongoDB and the pinned Open5GS v2.8.0 release.
2. Confirm the required 5GC services are healthy.
3. Configure the PLMN and TAC in NRF/AMF.
4. Configure the SMF/UPF user-plane subnet as `10.20.0.0/24` and align the UPF TUN interface with the project firewall script.
5. Confirm the AMF NGAP endpoint is reachable from the UERANSIM gNB.
6. Build UERANSIM v3.3.0.
7. Copy the gNB example to a local, untracked configuration and adjust IPs to the actual host topology.
8. Copy the UE example to a local, untracked configuration and insert the locally generated subscriber authentication values.
9. Start the gNB, then the UE.
10. Verify AMF registration, PDU session establishment and the UE TUN interface.
11. Verify controlled Internet/NAT only after the PDU session is stable.

## Acceptance gate

7001 is accepted only when all of the following are observed:

- gNB establishes NGAP connectivity to AMF;
- UE registers successfully;
- authentication succeeds;
- the `internet` PDU session is established;
- UE receives an address from `10.20.0.0/24`;
- traffic passes through the UPF;
- no RF transmission is involved;
- no secrets are present in the repository.

Only after this gate passes should 7002–7007 be provisioned.

## Troubleshooting order

1. PLMN/TAC/S-NSSAI mismatch;
2. AMF NGAP IP reachability and SCTP;
3. subscriber identity/authentication mismatch;
4. NRF/SBA service health;
5. DNN and slice mismatch;
6. SMF/UPF PFCP connectivity;
7. UE pool/TUN configuration;
8. forwarding/NAT rules.
