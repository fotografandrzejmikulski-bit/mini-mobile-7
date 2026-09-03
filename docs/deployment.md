# Deployment Runbook

## 0. Preconditions

- Private GitHub repository available.
- Linux VM/VPS with administrative access.
- Firewall/security-group control.
- No credentials committed to the repository.
- For physical RF: confirmed regulatory path, compatible RAN hardware and controlled USIMs.

## 1. Core lab

Install the chosen Open5GS release and MongoDB using the official Open5GS documentation for the selected Linux distribution. Keep the Core interfaces on the private management/network segments.

Validate service health before adding RAN.

## 2. Subscriber lab

Create exactly one synthetic test subscriber first. Use a generated IMSI and synthetic authentication material kept outside Git. Confirm registration before adding subscribers 2–7.

## 3. UERANSIM lab

Use UERANSIM to validate AMF/SMF/UPF registration and a PDU session without transmitting RF. Verify the subscriber receives the expected UE-side address and can reach the intended test network.

## 4. Internet/NAT

Enable controlled forwarding/NAT only after the PDU session is stable. Apply egress filtering appropriate to the deployment.

## 5. IMS

Add Kamailio/IMS only after basic registration and data connectivity are stable. Keep SIP/RTP signaling private and authenticated.

## 6. Seven subscribers

Provision 7 controlled subscribers from templates. Do not duplicate authentication secrets accidentally. Test registration and data per device.

## 7. Physical RAN gate

Before connecting a real handset, verify:
- lawful frequency use and required UKE authorization;
- compliant radio equipment;
- configured location, bandwidth, power and antenna conditions;
- compatible USIM and handset support;
- isolation from public operator networks unless a separate lawful interconnect exists.

## 8. Operations

Add monitoring, logs, backups and documented rollback. Test recovery with the lab first.

## 9. Public telephony

Public +48 numbering, PSTN/mobile interconnect, emergency-service obligations and related operator requirements are outside the closed private-network lab and require an appropriate lawful telecommunications arrangement.
