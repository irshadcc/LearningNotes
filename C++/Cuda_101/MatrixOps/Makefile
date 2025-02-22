
CC=gcc
NVCC=nvcc

# NVCCFLAGS = -std=c++17 -Xcompiler -Wall -Xcompiler -Wextra -O2
LDFLAGS= -lcudart
CUDA_SOURCES = blur.cu
HOST_SOURCES = main.cpp
SOURCES = $(CUDA_SOURCES) $(HOST_SOURCES)

CUDA_OBJECTS = $(CUDA_SOURCES:.cu=.o)
HOST_OBJECTS = $(HOST_SOURCES:.cpp=.o)
OBJECTS = $(CUDA_OBJECTS) $(HOST_OBJECTS)

EXECUTABLE = ./main

all : $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(NVCC) $(LDFLAGS) $(OBJECTS) -o $(EXECUTABLE)

%.o: %.cu
	$(NVCC) $(NVCCFLAGS) -c $< -o $@

%.o: %.cpp
	$(CC) -c $< -o $@

clean:
	rm -f $(OBJECTS) $(EXECUTABLE)

run: $(EXECUTABLE)
	./$(EXECUTABLE)

.PHONY: all clean run