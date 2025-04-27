#include "blur.hpp"
#include "cuda_util.h"
#include <driver_types.h>
#include <stdexcept>
#include <string>

__constant__ int d_rows;
__constant__ int d_columns;


__device__ int get1DIdxRowMajor(int x, int y, int rows, int columns) {
  return y*columns + x;
} 


template<int blockSize>
__global__ void BlurKernel(int* r, int *g, int *b) {

    int x = (blockIdx.x * blockDim.x) + threadIdx.x;
    int y = (blockIdx.y * blockDim.y) + threadIdx.y;

    if (x >= d_columns || y > d_rows) {
        return ;
    }

    __shared__ int data_r[blockSize*blockSize]; 
    __shared__ int data_g[blockSize*blockSize]; 
    __shared__ int data_b[blockSize*blockSize]; 

    int block1DIdx = 0; // Complete
    int idx = get1DIdxRowMajor(x, y, d_rows, d_columns);
    data_r[block1DIdx] = r[idx]; 

    // Sync all threads in block
    __syncthreads();




}


void BlurKernelCuda(int *r, int *g, int *b, int rows, int columns) {
  constexpr int BlockSize =3;

  int npixels = rows * columns;
  int *d_r_image, *d_g_image, *d_b_image;

  CUDA_CHECK(cudaMalloc(&d_r_image, npixels), 
    "Failed to allocate for memory for Red pixels");
  CUDA_CHECK(cudaMalloc(&d_g_image, npixels), 
    "Failed to allocate for memory for Green pixels");
  CUDA_CHECK(cudaMalloc(&d_b_image, npixels), 
    "Failed to allocate for memory for Blue pixels");

  CUDA_CHECK(cudaMemcpy(d_r_image, r, npixels, cudaMemcpyHostToDevice),
    "Failed to copy red pixels to device");
  CUDA_CHECK(cudaMemcpy(d_g_image, g, npixels, cudaMemcpyHostToDevice),
    "Failed to copy green pixels to device");
  CUDA_CHECK(cudaMemcpy(d_b_image, b, npixels, cudaMemcpyHostToDevice),
    "Failed to copy blue pixels to device");

  // Copy symbols

  CUDA_CHECK(cudaMemcpyToSymbol(d_rows, &rows, 1), "Failed to copy rows");
  CUDA_CHECK(cudaMemcpyToSymbol(d_columns, &columns, 1),
             "Failed to copy columns");

  dim3 gridDim(std::ceil(columns / BlockSize), std::ceil(rows / BlockSize));
  dim3 blockDim(3, 3);

  int Gx = std::ceil(columns / 3.0);
  int Gy = std::ceil(rows / 3.0);

  BlurKernel<3><<<gridDim, blockDim>>>(d_r_image, d_g_image, d_b_image);

  CUDA_CHECK(cudaMemcpy(r, d_r_image, npixels, cudaMemcpyDeviceToHost),
    "Failed to copy red pixels from device");
  CUDA_CHECK(cudaMemcpy(g, d_g_image, npixels, cudaMemcpyDeviceToHost),
    "Failed to copy green pixels from device");
  CUDA_CHECK(cudaMemcpy(b, d_b_image, npixels, cudaMemcpyDeviceToHost),
    "Failed to copy blue pixels from device");

  CUDA_CHECK(cudaFree(d_r_image), "Failed to deallocate red pixels from device memory");
  CUDA_CHECK(cudaFree(d_g_image), "Failed to deallocate green pixels from device memory");
  CUDA_CHECK(cudaFree(d_b_image), "Failed to deallocate blue pixels from device memory");

}