#include "blur.hpp"
#include <exception>
#include <iostream>


int* AllocateRandomPixel(int rows, int columns) {
    int *c = new int[rows*columns];
    int value = 0 ;
    for (int i = 0 ; i < rows; i++) {
        for (int j = 0 ; j < columns; j++) {
            c[i*columns+j] = ++value;
        }
    }
    return c;
}

void PrintMatrix(int* channel, int rows, int columns) {
    for (int i = 0 ; i < rows; i++) {
        for (int j = 0 ; j < columns; j++) {
            std::cout << channel[i*columns+j] << " ";  
        }
        std::cout << "\n";
    }
}

int main() {

    constexpr int rows = 3 ;
    constexpr int columns = 3;
    constexpr int npixels = rows * columns;

    int* r = AllocateRandomPixel(rows, columns);
    int* g = AllocateRandomPixel(rows, columns);
    int* b = AllocateRandomPixel(rows, columns);

    try {
        BlurKernelCuda(r, g, b, rows, columns);
    } catch (std::exception &e) {
        std::cerr << "Failed to run kernel : " << e.what() << std::endl;
        std::exit(1);
    }

    std::cout << "Red pixels " << std::endl;
    PrintMatrix(r, rows, columns);

    std::cout << "Green pixels " << std::endl;
    PrintMatrix(g, rows, columns);

    std::cout << "Blue pixels " << std::endl;
    PrintMatrix(b, rows, columns);

    delete[] r;
    delete[] g;
    delete[] b;

    return 0 ;
}