
When the work is scheduled, the a block is scheduled to an Streaming multiprocessor. 
A group of 32 threads makes up 1 warp


The maximum number of threads in a block is 1024.
Warp : A set of 32 threads that execute the same instruction
Block: An entity that is executed by a streaming multiprocessor (SM)


General Architecture

- SM is similar to CPU cores
- 1 kernel is launched to 1 grid
- A grid is composed of cluster of blocks 
- A cluster of blocks is composed of blocks
- Note: In old architecture, a grid is composed of blocks
- A block has multiple threads and a subgroup of 32 thread with in block makes up a warp.

In short,
Grid of Work -> Cluster of Blocks -> Blocks of Thread -> Thread

Streaming Multiprocessor

Cores per SM = Total cores / SMs
Per Core Register Memory = Register File Size / Cores per SM 