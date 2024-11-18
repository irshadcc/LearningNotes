
#include <cuda.h>

__global__ void matrixMultiply(int** matrixA, int m, int n, int** matrixB,
                               int p, int q, int** matrixC) {
  int xIdx = blockIdx.x * blockDim.x + threadIdx.x;
  int yIdx = blockIdx.y * blockDim.y + threadIdx.y;
  matrixC[xIdx][yIdx] = matrixA[xIdx][yIdx] + matrixB[xIdx][yIdx];
}