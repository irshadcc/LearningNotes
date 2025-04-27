
# Tensor





### Strides 


1. Continous
	strides[i] = 1 if i == (dims.size()-1)
	strides[i] = dims[i]  * strides[i+1] , if i < (dims.size()-1)

2. Channel Last

3. Channel First
