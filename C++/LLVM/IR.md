# IR Introduction

LLVM IR (Intermediate Representation) is the "glue" of the LLVM compiler, acting as a low-level, RISC-like language. 

1. Module Structure: Global variables, functions, and metadata.
2. Registers: Virtual registers start with % (local) or @ (global).
3. Instructions: Common ones include add, sub, load, store, br (branch), and icmp (integer comparison).
4. Types: i32 (32-bit integer), double, ptr (pointer), and arrays/structs.

Write down a LLVM IR example for the above

```text
; --- Module Structure ---
@global_var = global i32 100                 ; Global variable (@)
%struct.Point = type { i32, double }         ; Struct type

define i32 @example_func(i32 %0) {           ; Function definition
entry:
  ; --- Types and Registers ---
  %ptr = alloca i32                          ; Local register (%) and pointer type
  
  ; --- Instructions ---
  store i32 %0, ptr %ptr                     ; store
  %val = load i32, ptr %ptr                  ; load
  
  %is_equal = icmp eq i32 %val, 100          ; icmp (comparison)
  br i1 %is_equal, label %calc, label %exit  ; br (branch)

calc:
  %sum = add i32 %val, 50                    ; add
  %diff = sub i32 %sum, 10                   ; sub
  ret i32 %diff

exit:
  ret i32 0
}

!llvm.module.flags = !{!0}                   ; Metadata section
!0 = !{i32 1, !"wchar_size", i32 4}
```

### Phi Nodes

Syntax: %result = phi <type> [ <val1>, <label1> ], [ <val2>, <label2> ]

```text
; --- Module Structure ---
@start_val = global i32 0

define i32 @sum_example(i32 %n) {
entry:
  br label %loop

loop:
  ; --- Phi Node: selects value based on preceding block ---
  %i = phi i32 [ 0, %entry ], [ %next_i, %body ]
  %sum = phi i32 [ 0, %entry ], [ %next_sum, %body ]

  ; --- Instructions & Types ---
  %cond = icmp slt i32 %i, %n          ; icmp (comparison)
  br i1 %cond, label %body, label %exit

body:
  %next_sum = add i32 %sum, %i         ; add instruction
  %next_i = add i32 %i, 1
  br label %loop

exit:
  ret i32 %sum
}
```