#pragma once

#define FILE_STRING std::string(__FILE__)

#define FILE_AND_LINE FILE_STRING + ":" + std::to_string(__LINE__)

#define CUDA_CHECK(x, reason)                                                  \
  if (x != cudaSuccess) {                                                      \
    throw std::runtime_error((reason));                                        \
  }