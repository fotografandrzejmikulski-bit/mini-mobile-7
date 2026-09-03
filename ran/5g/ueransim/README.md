# UERANSIM software-only lab

UERANSIM is the no-RF validation layer for MINI-MOBILE-7. It is used to validate the Core/RAN signaling path before any physical radio is introduced.

## Required values

The lab operator must substitute the actual private VM/container IP addresses for:
- AMF NGAP endpoint
- UPF/GTP-U endpoint
- gNB local NGAP/GTP-U endpoints

Subscriber authentication values are deployment secrets and must never be committed.

## Sequence

1. Start MongoDB/Open5GS.
2. Provision one synthetic subscriber with external secret values.
3. Start the simulated gNB.
4. Start the simulated UE.
5. Confirm registration and PDU session.
6. Confirm UE-side connectivity.
7. Repeat for subscribers 2–7.

Do not interpret a successful UERANSIM run as proof that a physical handset can attach; hardware RAN, USIM and regulatory gates remain separate.
