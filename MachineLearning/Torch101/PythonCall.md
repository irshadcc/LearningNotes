

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

```c++
// python_variable.cpp
static PyTypeObject THPVariableType = {
    PyVarObject_HEAD_INIT(&THPVariableMetaType, 0)
    "torch._C.TensorBase", /* tp_name */
    sizeof(THPVariable), /* tp_basicsize */
    .....
}

```

# Slicing and Indexing

1. The call starts from TensorIndexing.h::get_item()
2. Based on slicing or indexing, 
    -   indexing dispatches select.int
    -   slicing dispatches slice_Tensor (wrapper_CompositeExplicitAutograd_Tensor_slice)

    



# Dispatching
1. When we call an operation like embedding, it uses a static handle to Operator has a method called call. The call method will pass the arguments to Dispatcher with the first argument being the operator handle itself. 
	
	Source code : 
	a. ATen/Operators4.cpp 
	b. ATen/Dispatcher.cpp - TypedOperatorHandle::call

2. The dispatcher uses DispatchKeyExtractor from the operator to extract DispatchKey. Based on the dispatch key, it looks up the kernel from the operator handle.  
	Source code : 
	a. ATen/Dispatcher.cpp:call
	b. ATen/OperatorEntry.h:lookup


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


# Torch slicing

select_int::call

at::native::select_symint
