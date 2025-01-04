

add_library(matrix matrix.cu)
target_compile_features(matrix PUBLIC cxx_std_11)
set_target_properties(matrix PROPERTIES CUDA_SEPARABLE_COMPILATION ON)


add_executable(cuda_example cuda_example.cpp)
target_link_libraries(cuda_example matrix)

