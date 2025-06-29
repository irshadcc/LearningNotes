
## x86_TSO


x86-TSO is the hardware memory model implemented by x86 processors. It is a relatively strong memory model compared to weaker models like those found in ARM

Writes are globally ordered: All processors agree on a single, total order of writes to shared memory.
Reads can be reordered after writes: A processor can read a value before its own previously issued write to a different address becomes globally visible. This is primarily due to the presence of write buffers.
Reads are satisfied from the most recent buffered write: A processor will read its own most recent buffered write to an address before fetching from shared memory.


std::memory_order_seq_cst provides the strongest guarantees, ensuring a single total order of all sequentially consistent atomic operations across all threads. While x86-TSO is strong, achieving full sequential consistency may still require compiler-inserted fences or specific instructions to enforce the global ordering of operations.

Even on x86, std::memory_order_relaxed allows the compiler to reorder operations more freely than stronger memory orders, potentially leading to performance benefits if strict ordering is not required.

The store buffers are FIFO and a reading thread must read its most recent buffered write, if there is one, to that address; otherwise reads are satisfied from shared memory.
An MFENCE instruction flushes the store buffer of that thread.
To execute a LOCK’d instruction, a thread must first obtain the global lock. At the end of the instruction, it flushes its store buffer and relinquishes the lock. While the lock is held by one thread, no other thread can read.
A buffered write from a thread can propagate to the shared memory at any time except when some other thread holds the lock.
