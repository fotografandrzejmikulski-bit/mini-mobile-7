# LTE RAN

Physical LTE RAN configuration belongs here after the legal/RF gate is complete.

For the software-only stage, use UERANSIM or another non-RF simulator. Do not use these templates to transmit on public cellular spectrum.

Recommended workflow:
1. validate Core with simulated UE/RAN;
2. choose compatible eNB/small-cell hardware;
3. verify RF authorization and equipment conformity;
4. configure the eNB against the Open5GS interfaces;
5. attach one controlled handset;
6. add the remaining six only after stable operation.
