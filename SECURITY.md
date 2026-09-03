# Security Policy

## Never commit secrets

Do not store any of the following in this repository:
- OpenAI or other API keys
- USIM Ki / OPc / OP / SQN secrets
- SIP passwords
- VPN private keys
- SSH private keys
- database passwords
- cloud credentials
- provisioning tokens

Use environment variables, a secret manager, encrypted local storage, or the deployment platform's secret store.

## Management

Administrative access should be restricted to a VPN or another authenticated management plane. Do not expose MongoDB, Open5GS management APIs, SSH, Grafana, or internal SIP infrastructure directly to the public Internet unless there is a documented and hardened reason.

## Network isolation

Recommended separation:
- Management: `10.30.0.0/24`
- Core: `10.10.0.0/24`
- UE: `10.20.0.0/24`
- IMS: `10.40.0.0/24`

Permit only required flows between segments.

## Incident rule

If a secret is ever pasted into ChatGPT, GitHub, a log, or any other uncontrolled location, treat it as compromised: revoke/rotate it and replace all dependent configuration references with the new secret stored outside the repository.

## RF safety and authorization

Software configuration does not grant permission to transmit. Physical RAN operation must remain disabled until applicable Polish regulatory and equipment requirements have been confirmed.
