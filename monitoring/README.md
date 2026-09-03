# Monitoring

Recommended operational metrics for later implementation:

- Open5GS service up/down state
- AMF registration/UE counts
- SMF PDU session counts
- UPF packet counters
- RAN NGAP/S1 connectivity state
- IMS registration and call-session counters
- host CPU/RAM/disk
- interface packet loss and errors
- database availability

Keep dashboards behind the management/VPN plane. Add Prometheus/Grafana only after the core lab is stable.

## Minimum operational acceptance

For each of the seven controlled subscribers, record:
- registration success;
- PDU session success;
- assigned UE address;
- reachability test;
- IMS registration where enabled;
- internal call test where enabled;
- last successful health-check timestamp.
