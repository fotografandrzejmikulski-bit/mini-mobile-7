# Project Status

| Stage | Status | Completion condition |
|---|---|---|
| Repository | DONE | Private repository initialized |
| Security baseline | DONE | Secret-handling and firewall rules documented |
| Architecture | DONE | Core/RAN/IMS topology documented |
| Addressing | DONE | Management/Core/UE/IMS ranges documented |
| Ubuntu bootstrap | READY | Run on the actual Linux host |
| Open5GS Core | READY | Requires actual Linux host and installation |
| UERANSIM lab | READY | Requires actual Linux host and simulator installation |
| One subscriber | READY | Requires actual Core database and generated test credentials |
| UE Internet | READY | Requires actual host routing/NAT configuration |
| IMS/Kamailio | SCAFFOLD | Requires stable Core/data plane |
| Seven subscribers | READY | Requires actual subscriber provisioning |
| Physical USIM | BLOCKED | Requires physical compatible USIMs and provisioning process |
| Physical LTE/5G RAN | BLOCKED | Requires RAN hardware and lawful RF authorization |
| First physical handset | BLOCKED | Depends on RAN + USIM + regulatory gate |
| Seven physical handsets | BLOCKED | Depends on successful first-handset test |
| Public +48 telephony | OUT OF SCOPE | Requires lawful numbering/interconnect/operator arrangement |
| Monitoring | SCAFFOLD | Implement after Core/RAN stability |

## What is actually complete now

The private GitHub project is initialized, structured and protected against accidental secret commits. The software-only deployment path is documented and includes a host bootstrap and validation script.

## What cannot be completed from this chat alone

A real cellular network cannot be claimed as operational without an actual Linux execution environment, physical radio hardware, compatible USIMs and the required legal authorization for radio transmission. Those are external dependencies, not missing repository files.
