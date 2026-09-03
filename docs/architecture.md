# Architecture

## Target topology

```text
                 INTERNET
                    |
               [ROUTER/FW]
                    |
              [PRIVATE CORE]
                Open5GS
                    |
              [IMS / VOICE]
                Kamailio
                    |
              [PHYSICAL RAN]
              LTE / 5G small cell
                    |
        +-----------+-----------+
        |           |           |
       UE1         UE2         UE3 ... UE7
```

## Logical segments

- Core: `10.10.0.0/24`
- UE data: `10.20.0.0/24`
- Management: `10.30.0.0/24`
- IMS: `10.40.0.0/24`

## Recommended initial server

- Ubuntu 22.04 LTS
- 4 vCPU or better
- 8 GB RAM or better
- 60 GB SSD or better
- public IPv4 for controlled administration/deployment use
- firewall/security-group control
- Docker or native package installation

These are starting values, not hard capacity guarantees.

## Components

### Open5GS
Provides the mobile Core functions for the LTE/EPC and 5G Core lab and private-network stages.

### MongoDB
Stores Open5GS subscriber/configuration data where required by the selected Open5GS deployment.

### UERANSIM
Used for software-only LTE/5G lab validation without RF. It validates signaling, registration and data sessions before hardware is introduced.

### Kamailio IMS
Used for IMS/SIP experimentation and private voice service integration after data connectivity is stable.

### Physical RAN
A compatible LTE/5G radio system connects real handsets. This requires suitable RF hardware, compatible USIMs and lawful spectrum authorization.

## Design principles

1. Lab before RF.
2. Separate management, core, UE and IMS traffic.
3. Keep secrets outside Git.
4. Restrict management through VPN or equivalent authenticated access.
5. Treat public telephony and public numbering as a separate operator/interconnect stage.
6. Keep all experimental radio use behind an explicit legal gate.
