

# Tensor

```c++
class Storage {
    // Store ptr and device type
    at::DataPtr data;
    c10::SymInt size;
};


class TensorImpl {
    // 192 bytes in gcc11
    c10::Storage storage;
    // and more....

};
class TensorBase {
    c10::iptr impl_;
}; 

class Tensor : public TensorBase {};

```



# Dispatching
1. When we call an operation like embedding, it uses a static handle to Operator has a method called call. The call method will pass the arguments to Dispatcher with the first argument being the operator handle itself. 
2. The dispatcher uses DispatchKeyExtractor to extract DispatchKey. 
3. Based on the dispatch key, it looks up the kernel from the operator handle.  


# Aten

In python_torch_functions_manual.cpp, it registers various native methods to the python modules.


# Autograd
```c++

// Has a fwd decl in aten and it is defined in torch/csrc
class Node {};
class GraphRoot : public Node {};
class Error : public Node {};
class CopyBackwards : public Node {};




```

# Torch distributed

torch distributed
https://github.com/pytorch/pytorch/issues/241
