
## API

```c++

// Init nccl comm
ncclUniqueId id;
if (my_rank == 0) {
    ncclGetUniqueId(&id)
}

MPI_Bcast(&id, sizeof(id), MPI_BYTE, 0, MPI_COMM_WORLD)

// Init comm
ncclComm_t comm;
ncclCommInitRank(&comm, nRanks, id, my_rank);

```

## All Reduce

GPU 0 : A  B  C 
GPU 1 : D  E  F
GPU 2 : G  H  I


