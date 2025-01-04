

#include "cuda.h"

__global__ void matrixMultiply(int* matrixA, int m, int n, int* matrixB, int p,
                               int q, int* matrixB);
