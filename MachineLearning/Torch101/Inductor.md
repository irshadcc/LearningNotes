

## Decompositions 
1. Doesn't need to implement lowring for every ATen operator, many operations can be decomposed

```python

log2_scale = 1 / math.log(2)
@register_decomposition(torch.ops.aten.log2)
def log2(x):
    return torch.log(x) * log2_scale
```

## Lowerings

1. Convert FX Graph to Define by Run IR. 

In the below example, the IR is defined in a python function
```python
def lower_relu(reader, writer):
    # This 'index' is part of the define-by-run loop logic
    def loop_body(index):
        x = reader.load(index)
        # The logic is defined by standard Python/PyTorch-like syntax
        result = ops.maximum(x, 0)
        writer.store(index, result)
    
    return loop_body
```


1. inner_fn_buf0 is a Python function that defines how to compute a single element of the tensor buf0 in terms of primitive ops.* namespace
2. The function takes a list of SymPy [28] symbols (i0 and i1) representing the symbolic coordinates of the element to be computed.
3. SymPy symbols s0 and s1 represent the sizes of the tensor to be computed and are used for both sizes and strides. 
4. These size symbols are captured in a Python closure and registered on the graph object.
5. TensorBox and StorageBox are abstraction for Tensor, Storage to handle view, aliasing, mutation 
6. TensorBox and StorageBox are abstractions that match PyTorch torch.Tensor and torch.Storage objects and allow the handling of views, aliasing, and mutation during the lowering process 
7. Pointwise represents that the ComputedBuffer is a data parallel pointwise computation. 
8. The IR also supports Reduction and Scatter for handling other types of operators.

```python
def inner_fn_buf0(index):
    i0, i1 = index
    tmp0 = ops.load("arg0_1", i0 * s1 + i1)
    tmp1 = ops.log(tmp0)
    tmp2 = ops.constant(1.4426950408889634, torch.float32)
    tmp3 = ops.mul(tmp1, tmp2)
    return tmp3

buf0_ir = TensorBox(
    StorageBox(
        ComputedBuffer(
            name='buf0',
            layout=FixedLayout(
            'cuda', 
            torch.float32,
            size=[s0, s1], 
            stride=[s1, 1]
        ),
        data=Pointwise(inner_fn=inner_fn_buf0,
        ranges=[s0, s1], ...))
    )
)



