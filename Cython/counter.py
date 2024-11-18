import ctypes

counter = ctypes.cdll.LoadLibrary("./libcounter.so")


counter = counter.make_counter()

counter.print()