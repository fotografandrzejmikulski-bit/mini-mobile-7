# IMS / Kamailio Scaffold

The IMS layer is added only after Core registration and data sessions are stable.

## Design

- Keep SIP signaling on the private IMS segment (`10.40.0.0/24`).
- Keep management interfaces separate.
- Store SIP subscriber credentials outside Git.
- Treat RTP/media transport as a controlled private flow.

## Validation sequence

1. Confirm UE registration to Core.
2. Confirm IP connectivity.
3. Introduce IMS registration.
4. Validate one internal test call.
5. Scale to the remaining six controlled subscribers.

Public PSTN/mobile interconnect is intentionally outside this repository's closed private-network baseline.
