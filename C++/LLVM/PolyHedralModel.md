

### Affine and Non Affine Loops 

```c++
// This is affine loops, because index access is linear function of loop index i 
for (i = 4; i < 50; i++) {
    a[i+6] = a[i-2];
}

// this is non-affine loops
for (i = 2; i < 20; i++) {
    a[b[i]] = a[c[i]] + a[d[i]];
}

```


The polyhedral model (also known as the polytope method) is a powerful mathematical framework used in optimizing compilers to perform complex loop transformations. Unlike traditional compilers that rely on a fixed set of transformation primitives (like loop unrolling or fusion), polyhedral compilation provides a unified, algebraic representation of programs, allowing compilers to reason about individual array elements, iterations, and hardware resources simultaneously

1. Algebraic Program Representation
    To apply polyhedral optimizations, compilers first isolate specific regions of code known as Static Control Parts (SCoPs). A SCoP is a maximal set of consecutive instructions where control structures (like for loops and if conditionals), loop bounds, and array subscripts are strictly affine functions of the surrounding loop iterators and global parameters.
    Within a SCoP, the program is abstracted into three core mathematical components

    - Iteration Domains (Polytopes): Every statement nested inside a loop is represented by an iteration domain, which is a mathematical polyhedron (or polytope) defined by a system of affine inequalities
    Each integer point (coordinate) within this shape corresponds to a specific execution of that statement, known as a statement instance
    - Access Relations: These map statement instances to the specific array elements they read or write
    - Data Dependences: A dependence occurs when two statement instances access the same memory location, at least one access is a write operation, and one executes before the other.In the polyhedral model, exact sets of instances in a dependence relation (Read-After-Write, Write-After-Read, Write-After-Write) are mathematically captured as subsets of the Cartesian product of iteration domains

2. Polyhedral Scheduling
    A schedule maps each statement instance to a logical execution date or timestamp, dictating the order in which instances will execute
    Multi-Dimensional Affine Schedules: To handle nested loops, execution dates are often represented as vectors. Statement instances are executed following the lexicographical order of these logical dates. For example, an execution date of (0, 1) strictly precedes (1, 0)
    The Legal Transformation Space: To ensure that a program transformation is valid (i.e., it preserves the original semantics), the new schedule must respect all data dependences
    The polyhedral model leverages the affine form of Farkas' Lemma to convert dependence constraints into an Integer Linear Programming (ILP) problem
    This mathematically guarantees that the search space of possible schedules contains only legal, redundancy-free transformations
    Optimization Objectives: Compilers iteratively solve these ILP problems to find optimal schedule functions based on specific performance goals
    Parallelism: If the dependence distance between instances is zero, they can be executed in parallel
    Locality: Minimizing the dependence distance improves temporal and spatial cache locality
    Tiling: Ensuring that dependences have non-negative distances along consecutive dimensions enables loop tiling (blocking), a critical transformation for coarse-grained parallelism and memory hierarchy utilization

3. Code Generation
    After the iteration domains are transformed by the new schedule, the compiler must convert the mathematical polytopes back into imperative code (like C, FORTRAN, or LLVM IR).
    This process involves polyhedra scanning, which computes loop bounds and generates control flow to traverse every integral point within the scheduled domains
    Because generating this code can introduce massive control overhead, specialized code generators are designed to eliminate single-iteration loops, remove redundant guards, and rewrite array access subscripts efficiently

4. Key Frameworks and Tooling

    The polyhedral compilation ecosystem consists of several interconnected tools and libraries:
    ISL (Integer Set Library): A foundational C library for manipulating sets and relations of integer points bounded by linear constraints. It includes an ILP solver and is heavily used for dependence analysis and schedule computation
    CLooG (Chunky Loop Generator): A widely-used backend code generator that scans Z-polyhedra to produce highly efficient, compilable loop nests
    PLuTo: An automatic polyhedral parallelizer and locality optimizer. It is particularly known for its model-driven approach to automatically tiling imperfectly nested affine loops
    PENCIL: A rigorously defined subset of C99 designed to be a "static analysis-friendly" intermediate language. It enforces pointer restrictions and provides pragmas (like __pencil_assume and the independent directive) to help polyhedral compilers auto-parallelize domain-specific code for hardware accelerators like GPUs
    MLIR (Multi-Level Intermediate Representation): A modern compiler infrastructure heavily influenced by polyhedral techniques. MLIR includes an affine dialect that provides a simplified polyhedral form natively within the IR, making it easier to analyze, transform, and map deep learning workloads to custom accelerators