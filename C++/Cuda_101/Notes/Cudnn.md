
# General Steps
1. Create cuDNN handle 
2. Create tensor descriptor 
3. Get data
4. Configure activation mode (sigmoid, relu)
5. Configure activation descriptor
6. Run neural nework with activation direction on input data
7. Output results


### Code example
```c++
cudnnDataType_t dtype = CUDNN_DATA_FLOAT ;
cudnnTensorFormat_t format = CUDNN_TENSOR_NCHW ; 
int n = 1, c = 1, h = 1, w = 10; 
int NUM_ELEMENTS = n*c*h*w ;
cudnnTensorDescriptor_t x_desc; 
cudnnCreateTensorDescriptor(&x_desc); 
cudnnSetTensor4dDescriptor(x_desc, format, ftype, n, c, h, w);
```

```c++
float alpha[1] = {1} ;
float beta[1] = {0.0};
cudnnActivationDescriptor_t sigmoid_activation ; 
cudnnActivationMode_t mode = CUDNN_ACTIVATION_SIGMOID ;
cudNNNanPropogation_t prop = CUDNN_NOT_PROPAGATE_NAN;
cudnnCreateActivationDescriptor(&sigmoid_activation);
cudnnSetActivationDescriptor(sigmoid_activation, mode, prop, 0.0f);
cudnnActivationForward(handle_, sigmoid_activation, alpha, x_desc, x, beta, x_desc, x);
```

# General CuTensor Steps
1. Create cutensor handle
2. Create plan cache 
3. Read cutensor cache file (optional)
4. Create 1 or more cutesnor descriptors from cache and for contraction
5. determine algorithm 
6. Query worksapce and create contraction plan 
7. Get data 
8. Perform contraction 
9. Output results


```c++
cutensorHandle_t handle; 
HANDLE_ERROR(cutensorInit(&handle));

constexpr int32_t numCachelines = 1024; 
size_t sizeCache = numCachelines * sizeof(numCachelines);
cutensorPlanCacheline_t* cachelines = (cutensorPlanCacheline_t*) malloc(sizeCache);
cutensorHandleAttachPlanCachelines(&handle, cachelines, numCachelines);

const char[] cacheFilename[] = "./cache.bin" ;
uint32_t numCachlinesRead = 0 ; 
cutensorStatus_t status = cutensorHandeReadCacheFromFile(&handle, cacheFilename, &numCachelinesRead);


cutesnorTensorDescriptor_t descA ; 
cutesnorInitTesnorDescriptor(&handle, &descA, nmodeA, extentA.data(),  NULL, /*stride*/ typeA,  CUTENSOR_OP_IDENTITY);

uint32_t aligmentRequirementA; 
cutensorGetAligmentRequirement(&handle, A_d, &descA, aligmentRequirementA); 
```
