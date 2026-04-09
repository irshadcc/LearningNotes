# Bank Conflict 
In GPUs, there are 32 banks, each bank is 4 bytes wide, and consecutive words of 32 bits (not 64 bits; GPUs were designed with 32-bit floats and integers in mind) map to consecutive banks.



1. Tn access index n 

Warp Lanes:  | T0 | T1 | T2 | T3 | ... | T31 |
Banks:       | B0 | B1 | B2 | B3 | ... | B31 |
              (32-way parallelism - 1 Cycle)

2. 2-Way Conflict (Stride 2)

Each thread access indices with a stride of 2
Example : T0 access 0, T1 access 2, T2 access 4

Warp Lanes:  | T0 | T1 | T2 | ... | T16 | ... | T31 |
Indices:     | 0  | 2  | 4  | ... | 32  | ... | 62  |
Banks:       | B0 | B2 | B4 | ... | B0  | ... | B30 |
               ^                     ^
               |____ CONFLICT _______| (2 Cycles)

3. Scenario C: 32-Way Conflict (Stride 32)

Warp Lanes:  | T0 | T1 | T2 | ... | T31 |
Indices:     | 0  | 32 | 64 | ... | 992 |
Banks:       | B0 | B0 | B0 | ... | B0  |
               (Full Serialization - 32 Cycles)