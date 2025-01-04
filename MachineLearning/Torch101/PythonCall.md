

In python_torch_functions_manual.cpp, it registers various native methods to the python modules.


Python modules calls various ops func in A10. The A10 will use dispatcher to find the kernel based on the dispatcher key of the tensor and then pass the arguments to kernel.


torch distributed
https://github.com/pytorch/pytorch/issues/241
