# MINI-MOBILE-7 — First Runtime Runbook

## Scope

This runbook executes Gate 1–3 on a Linux host using Open5GS + UERANSIM. It is intentionally limited to a software-only 5G SA laboratory. No RF transmission occurs.

## 0. Preconditions

Required:

- Ubuntu 22.04 LTS amd64 host
- sudo access
- outbound Internet access for package/source retrieval
- private management path preferred
- no public exposure of MongoDB, Open5GS control-plane ports, or WebUI

Pinned baseline:

- Open5GS v2.8.0
- MongoDB 8.0
- UERANSIM v3.3.0

## 1. Obtain the repository

```bash
git clone https://github.com/fotografandrzejmikulski-bit/mini-mobile-7.git
cd mini-mobile-7
```

## 2. Bootstrap the host

```bash
sudo ./scripts/bootstrap-ubuntu22.sh
sudo ./scripts/validate-host.sh
```

The bootstrap installs the documented MongoDB/Open5GS prerequisites and prepares `ogstun` on the project UE subnet. Open5GS officially documents Ubuntu package installation and MongoDB 8.0 on Ubuntu 22.04. citeturn0search1

## 3. Configure UE routing

```bash
sudo ./scripts/configure-ue-network.sh
```

Then inspect:

```bash
ip addr show ogstun
ip route
sysctl net.ipv4.ip_forward
sudo iptables -S
sudo iptables -t nat -S
```

Expected tunnel gateway:

```text
10.20.0.1/24
```

## 4. Build UERANSIM

```bash
./scripts/build-ueransim.sh
```

Verify the build:

```bash
./UERANSIM/build/nr-gnb --help
./UERANSIM/build/nr-ue --help
```

UERANSIM provides a software implementation for UE/gNB testing but does not provide a complete physical 5G-NR radio layer. citeturn0search5

## 5. Prepare local configuration

Create a local-only directory:

```bash
mkdir -p local/ueransim
```

Copy the repository examples into `local/` and edit them there. Do not edit the tracked examples with real authentication material.

```bash
cp ran/5g/ueransim/gnb.yaml.example local/ueransim/gnb.yaml
cp ran/5g/ueransim/ue-7001.yaml.example local/ueransim/ue-7001.yaml
```

The local UE configuration must contain the subscriber authentication values provisioned in the Open5GS database. Those values are deployment secrets and must never be committed.

## 6. Network consistency check

Before starting UERANSIM, confirm that the following values agree across the core, gNB, and UE configuration:

| Parameter | Lab value |
|---|---|
| MCC | `001` |
| MNC | `01` |
| TAC | `1` |
| SST | `1` |
| DNN | `internet` |
| AMF lab address | `10.10.0.5` |
| gNB lab address | `10.10.0.6` |
| UE subnet | `10.20.0.0/24` |
| First subscriber | `7001` / IMSI `001010000000001` |

These are synthetic laboratory identities, not public Polish mobile identities.

## 7. Start order

### Terminal A — Open5GS

```bash
sudo systemctl status mongod --no-pager
sudo systemctl status open5gs-amfd --no-pager
sudo systemctl status open5gs-smfd --no-pager
sudo systemctl status open5gs-upfd --no-pager
```

Start required services if necessary:

```bash
sudo systemctl start mongod
sudo systemctl start open5gs-amfd
sudo systemctl start open5gs-smfd
sudo systemctl start open5gs-upfd
```

### Terminal B — gNB

```bash
./UERANSIM/build/nr-gnb -c local/ueransim/gnb.yaml
```

### Terminal C — UE

```bash
sudo ./UERANSIM/build/nr-ue -c local/ueransim/ue-7001.yaml
```

## 8. Gate 3 acceptance

Gate 3 is PASS only when all of the following are demonstrated on the actual runtime host:

- gNB establishes NGAP/SCTP connectivity to AMF.
- UE registers successfully.
- UE establishes a PDU session for `internet`.
- A UE tunnel interface is created.
- UE receives an address from `10.20.0.0/24`.
- Traffic can traverse the UPF/`ogstun` path.
- Host logs show no unresolved fatal core/RAN errors.

A configuration file existing in Git is not evidence of a passing gate.

## 9. Troubleshooting order

If registration fails, check in this order:

1. `ip addr` and routing on the host.
2. AMF service state.
3. AMF NGAP address and SCTP reachability.
4. gNB configuration PLMN/TAC/slice values.
5. UE SUPI/IMSI and authentication values.
6. Subscriber record in Open5GS.
7. SMF/UPF service state.
8. DNN and session configuration.
9. `ogstun` address and forwarding/NAT.
10. UERANSIM logs.

Useful commands:

```bash
sudo journalctl -u open5gs-amfd -n 100 --no-pager
sudo journalctl -u open5gs-smfd -n 100 --no-pager
sudo journalctl -u open5gs-upfd -n 100 --no-pager
ss -lntup
ip -br addr
ip route
```

## 10. Seven-subscriber expansion

Do not add 7002–7007 to the acceptance test until 7001 passes end-to-end.

After 7001 passes:

1. provision 7002;
2. test registration/session;
3. repeat through 7007;
4. record each result;
5. then move to IMS/voice.

## 11. Physical handset boundary

Do not attempt to attach a normal Android handset to this software-only lab. A physical handset requires a real RAN/radio path, compatible USIM credentials, and a lawful RF deployment. Physical RAN is a later gate.

## 12. Stop conditions

Stop the deployment and investigate if:

- an authentication secret is about to enter Git;
- a core service is exposed publicly without an explicit security requirement;
- the configured RF plan has not been legally verified for the intended physical deployment;
- a test result is being marked PASS without execution evidence.
