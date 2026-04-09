
Interrupt is a event raised by software and hardware. 


APIC controller is responsible for processing multiple requests from multiiple devices. 

There are two types of APIC
1. Local APIC : Located on each cpu core
2. I/O APIC : Distribute external interrupts on CPU cores. 

When an interrupt happens, kernel pauses the application. 
Search for the interrupt handler and transfer control. 
After handler completes, it can process can resume execution. 

IRQ Handlers are defined in Interrupt descriptor table. Each interrupt has a vector number which is an index to IDT. 

Kinds of interrupts
1. Hardware generated interrupts
   Handled by Local APIC
2. Software generated interrupts
   Example : syscall, div by zero


Interrupts which are synchronous with proram execution are categorised to three types,
1. Faults : Faulty instruction, if correct, it allow the interrupted program to resume
2. Traps : Trap instruction, also allows interrupted program to resume.
3. Abort : Does not allow program to resume.


Interrupts can also be defined based on mask
1.Maskable interrupts
CPU can ignore or delay the interrupt by setting a bit in interrupt mask register
ex : Keyboard I/O, Disk I/O

2. Non maskable interrupts
CPU cannot ignore or delay the interrupt
Power failure, memory parity errors


IRQ is a number representing hardware interrupts

Two types of interrupts
1. Top Half 
