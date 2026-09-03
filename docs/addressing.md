# Addressing Plan

| Segment | CIDR | Example purpose |
|---|---|---|
| Core | 10.10.0.0/24 | Open5GS services |
| UE | 10.20.0.0/24 | Subscriber data |
| Management | 10.30.0.0/24 | SSH/VPN/admin |
| IMS | 10.40.0.0/24 | SIP/IMS |

## Controlled subscribers

| Slot | Internal ID | Example UE IP |
|---:|---:|---:|
| 1 | 7001 | 10.20.0.11 |
| 2 | 7002 | 10.20.0.12 |
| 3 | 7003 | 10.20.0.13 |
| 4 | 7004 | 10.20.0.14 |
| 5 | 7005 | 10.20.0.15 |
| 6 | 7006 | 10.20.0.16 |
| 7 | 7007 | 10.20.0.17 |

The example UE addresses are logical planning values. Actual allocation depends on the Open5GS PDU/session configuration.

The identifiers 7001–7007 are internal test identities and must not be presented as public Polish mobile numbers.
