# Firewall Baseline

## Management

Allow administrative access only from the management plane/VPN. Deny unsolicited Internet access to MongoDB, Open5GS internal interfaces and IMS administration services.

## Segmentation

- Management: `10.30.0.0/24`
- Core: `10.10.0.0/24`
- UE: `10.20.0.0/24`
- IMS: `10.40.0.0/24`

Use default-deny policies where practical and allow only required service-to-service flows.

## Exposure rules

- MongoDB: private only.
- SSH: VPN/management only.
- Open5GS WebUI: VPN/management only.
- Prometheus/Grafana: VPN/management only unless a hardened external access pattern is intentionally deployed.
- SIP/RTP: private and authenticated; expose externally only for a separate, documented interconnect design.
- GTP/SCTP: permit only between the specific RAN/Core interfaces required by the selected architecture.

## Host controls

Enable OS firewalling, security groups, unattended security updates where appropriate, log review and rate limiting. Back up configurations without copying secrets into the backup repository.
