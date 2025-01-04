

## Forward

We define a one hot vector $ x $ and Embedding matrix $ E $ of shape $ 2\times{3} $, 
$$
x = 
\begin{bmatrix}
    0 & 1
\end{bmatrix}

$$



$$
E = 
\begin{bmatrix}
    e_{00}  & e_{01}  & e_{02} \\
    e_{10}  & e_{11}  & e_{12} \\
\end{bmatrix}
$$


We obtain the embedding by multiplying the matrix $x$ and $E$

$$
e = xE

\begin{bmatrix}
    (e_{00}*0 + e_{10}*1)     &    (e_{01}*0 + e_{11} * 1)    &       (e_{02}*0  + e_{12} * 1) 
\end{bmatrix}
=

\begin{bmatrix}
    e_{10} & e_{11} & e_{12}
\end{bmatrix}

$$


We define our loss function as function $f$ which accepts the vector $e$
For demo purpose, we just sum up the elements in the matrix and consider it as loss.

$$
L = f(e) = e_{10} + e_{11} +  e_{12}

$$

## Backward

The gradient of Loss $L$ with respect to $ E $ 


$$
\frac{\partial{L}}{\partial{E}} = 

\frac{\partial{L}}{\partial{f}} *  \frac{\partial{f}}{\partial{E}}  

= 
\begin{bmatrix}
    \frac{\partial{L}}{\partial{e_{00}}}&    
    \frac{\partial{L}}{\partial{e_{01}}}&     
    \frac{\partial{L}}{\partial{e_{02}}}& 
\\
\\
    \frac{\partial{L}}{\partial{e_{10}}}&
    \frac{\partial{L}}{\partial{e_{11}}}&
    \frac{\partial{L}}{\partial{e_{12}}}&
\end{bmatrix}
$$

Please note that the chain rule need to be applied if the embedding goes through embedding goes through a set of functions before reaching the loss. Since the our function is a simple sum function, we can directly obtain by taking the derivate of the loss equation we obtained above. 

The gradient of the first row will be 0, because loss function equation does not depend on $e_{0j}$ where $ 0 < j < d$


$$
\frac{\partial{L}}{\partial{E}} = 
\begin{bmatrix}
0 & 0 & 0
\\
1 & 1 & 1
\end{bmatrix}
$$


## Pytorch Code

```python
import torch

input = torch.tensor([[1]], requires_grad=False)

embedding_weight = torch.tensor([
    [1,2,3],
    [4,5,6]
], dtype=torch.float32, requires_grad=True)

e = torch.nn.functional.embedding(input, embedding_weight)
l = e.sum()
l.backward()
print(embedding_weight.grad)

```

* Output *
> tensor([[[4., 5., 6.]]], grad_fn=EmbeddingBackward0)