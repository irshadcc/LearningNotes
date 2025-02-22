#include "blur.hpp"
#include "cuda_util.h"
#include <stdexcept>
#include <string>


__constant__ int d_rows ; 
__constant__ int d_columns;

__global__ void BlurKernel(int* image_in, int* image_out, int rows, int columns) {

    image_out[0] = 0;

}

int* BlurKernelCuda(int *image, int rows, int columns) {

    int npixels = rows*columns;
    int *d_image_in, *d_image_out;

    int *blurred_image = new int[npixels];

    CUDA_CHECK(cudaMalloc(&d_image_in, npixels), 
        "Failed to allocate memory for image");
    CUDA_CHECK(cudaMalloc(&d_image_out, npixels), 
        "Failed to allocate memory for image");

    CUDA_CHECK(cudaMemcpy(d_image_in, image, npixels, cudaMemcpyHostToDevice), 
        "Failed to copy image to device");

    CUDA_CHECK(cudaMemcpyToSymbol(d_rows, &rows, 1), 
        "Failed to copy rows");
    CUDA_CHECK(cudaMemcpyToSymbol(d_columns, &columns, 1), 
        "Failed to copy columns");
    
    dim3 gridDim(
        std::ceil(columns/3.0),
        std::ceil(rows/3.0)
    );
    dim3 blockDim(1, 3, 3);

    int Gx = std::ceil(columns/3.0);
    int Gy = std::ceil(rows/3.0);

    BlurKernel<<<gridDim, blockDim>>>(d_image_in, d_image_out, rows, columns);
    CUDA_CHECK(cudaMemcpy(blurred_image, d_image_out, npixels, cudaMemcpyDeviceToHost), 
        "Failed to copy image from device to host");
    return blurred_image;
}