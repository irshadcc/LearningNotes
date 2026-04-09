# Introduction 

### Tensor
- Tensor = { data_ptr : T* = x, layout : Layout = {Shape : Tuple, Stride : Tuple }}

### Row Major 
- Layout(Matrix) = { Shape=(M, N), Stride=(N, 1) }
- It can be written Layout = (M,N) : (N,1)
- offset(matrix[i][j]) = np.dot(index_vec, stride_vec) = (i*n + j)
```
    Example:

    2-D matrix Shape=(2, 3) and Stride = (3, 1)      
    ---> i                 ------------->
    | 0 1 2                 0 1 2 3 4 5 6
    | 3 4 5     
    v
    j   
    
    To get the next row (j+1, i), we need to add 3 to the current offset 
```


### Tiling 
- Tensor t1 = { Shape = (A,B,C) }
    - TileTensor t2 = { Shape = (a,b,c)}
    - Outer Tensor Shape = (A/a , B/b, C/c)
    - Inner Tensor(tile shape) = (a, b, c)
    - We can also tile selected dimension
        - TileTensor t2 = { Shape = (a, B, c) }
        - OuterTensor = (A/a, B, C/c)
        - TileTenosr = (a, 1, c)
- Tiling operator
    - Layout tile_op Shape = TiledLayout ( InnerLayout, OuterLayout)
    - (M, N) : (1, M) tile_op (m, n)  = 
        InnerLayout = (m,n) : (1, M),   
        OuterLayout = (M/m, N/n) : (m, Mn)
    - (M, N, K) : (1, M, MN) tile_op (m, n, k)  = 
        InnerLayout = (m,n,k) : (1, M, MN),   
        OuterLayout = (M/m, N/n, K/k) : (m, Mn, MNk)



- Example
```
    T
    _ _ _ _ _ _ _ _ _ _ 
    |                   |
    |   t _ _ _         |
    |    |     |        |
    |    |_ _ _|        |
    |                   |
    |_ _ _ _ _ _ _ _ _ _ 

    Layout(T) = { shape : (6, 9), stride = (9, 1)}
    Layout(t) = { shape : (2, 3), stride = (9, 1)}
```

### Nested Layout 

- For example
    - Nested Layout ((3,4), 2) : ((1,3), 12)
    - Flattened Layout (3,4,2) : (1,3,12)

### Integer Semi Module 
In the context of CuTe (part of NVIDIA's CUTLASS) and tensor layout theory, an integer semimodule is a mathematical structure used to describe the space of memory offsets.Specifically, it refers to a set of integers that is closed under addition and multiplication by non-negative integer scalars (natural numbers).
For instance, any two layouts with integer strides may be concatenated, but the layouts 4 : 2 and 3 : e0 cannot be concatenated

## Compatibility : Poset of Shapes

If Shape A is compatible with Shape B, then all coordinate lists of A are also coordinate lists of B and coordinate of A can be used as coordinate of B. 

```
                36
        /  |      |                  \
    (36) (1,36) ... (6,6)  ... (2,2,3,3)
                    / | \
   ((1,6), 6) ... (6, (6,1)) ... (6,(2,3))

```

## Concatenation 

By mode operations
A op <B,C> = (A0, A1) op <B,C> = (A0 op B, A1 op C)


## Layout Composition 

- The composition f of layouts A and B produces layout R 
    A o B -> R
    with B being shape compatible with R.




# References 
1. https://developer.nvidia.com/blog/cutlass-linear-algebra-cuda/


